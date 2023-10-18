// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {FunctionsClient} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/FunctionsClient.sol";
import {ConfirmedOwner} from "@chainlink/contracts/src/v0.8/shared/access/ConfirmedOwner.sol";
import {FunctionsRequest} from "@chainlink/contracts/src/v0.8/functions/dev/v1_0_0/libraries/FunctionsRequest.sol";

contract VoteBackend is FunctionsClient, ConfirmedOwner {
  using FunctionsRequest for FunctionsRequest.Request;

  // POST API METHOD에 쓰임.
  bytes32 public s_lastRequestId;
  bytes public s_lastResponse;
  bytes public s_lastError;

  // POST API METHOD에 쓰임.
  error UnexpectedRequestID(bytes32 requestId);
  event Response(bytes32 indexed requestId, bytes response, bytes err);

  // uuid 생성에 쓰임. random semiprime number with 256 bits.
  uint constant pq = 98686309634733686614376257523655700182914516739573612855898430044873713577331;

  // voteId를 포함한 값. 아래의 mapWalletAddressVoteId에서 쓰인다.
  struct voteIdData {
     string voteId;
     bool isExist;
   }

  // 본인 인증 타입(전화번호, 메타마스크 지갑, 없음)
  enum AuthenticationType {
    phone,
    metamask,
    none
  }

  /// 유저 식별자 -> 지갑 주소 mapping
  mapping(string => address) mapUserIdWalletAddress;
  /// 지갑 주소 -> VoteId mapping
  mapping(address => voteIdData) mapWalletAddressVoteId;

  // 생성자
  constructor(
    address router
  ) FunctionsClient(router) ConfirmedOwner(msg.sender) {}

  /// voteID(uuid 타입) 리턴
  function issueVoteId(address walletId) public returns(string memory) {
    bool isUserVoted = checkUserIsVoted(walletId);

    if(isUserVoted) {
      return mapWalletAddressVoteId[walletId].voteId;
    } else {
      string memory voteId = makeUniqueVoteId(walletId);
      return voteId;
    }
  }

  /// 작동 상태를 확인하기 위한 함수
  function checkContractWorked(address walletId) public pure returns(string memory) {
    bytes memory s = new bytes(40);
    for (uint i = 0; i < 20; i++) {
      bytes1 b = bytes1(uint8(uint(uint160(walletId)) / (2**(8*(19 - i)))));
      bytes1 hi = bytes1(uint8(b) / 16);
      bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
      s[2*i] = char(hi);
      s[2*i+1] = char(lo);
    }
    return string(s);
  }

  function char(bytes1 b) internal pure returns (bytes1 c) {
    if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
    else return bytes1(uint8(b) + 0x57);
  }

  /// 신원검사를 통해 user 식별자를 받아옴.
  /*function getUserIdentification(AuthenticationType _type) private returns(string calldata) {
    if(_type == AuthenticationType.phone) {

    } else if(_type == AuthenticationType.metamask) {

    } else if(_type == AuthenticationType.none) {

    } else {

    }
  }*/

  /// 기존에 투표한 이력이 있는지 검사하는 내부 함수.
  /// user 식별자 -> bool
  function checkUserIsVoted(address walletId) private view returns(bool) {
    return mapWalletAddressVoteId[walletId].isExist;
  }

  /// (투표 이력이 없다면 실행) voteId를 생성한 후 유저에게 제공. 정확히는 아래의 역할을 수행한다.
  /// 1. 중복되지 않는 voteId를 생성한다.
  /// 2. 실제로 중복되지 않는지 검사한다.
  ///    2-1. 문제가 없다면 : 생성된 voteId와 wallet address, user 식별자를 묶어서 저장한다.
  ///    2-2. 문제가 있다면 : 다른 voteId를 생성한다.
  /// 3. voteId를 리턴한다.
  function makeUniqueVoteId(address walletId) private returns(string memory) {
    /// 1. 중복되지 않는 voteId를 생성한다.
    string memory _voteId = _uuid4();

    /// 2. 생성된 voteId와 wallet address, user 식별자를 묶어서 저장한다.
    mapWalletAddressVoteId[walletId].voteId = _voteId;
    mapWalletAddressVoteId[walletId].isExist = true;

    /// 3. voteId를 리턴한다.
    return _voteId;
  }


  /// uuid를 생성하는 내부 함수.
  function _uuid4() private view returns (string memory) {
    return _bytesToString(_uuidGen());
  }

  /// @notice Generate UUID
  /// @return UUID of 16bytes
  function _uuidGen() internal view returns (bytes memory) {
    bytes1[16] memory seventhByteMembers = [bytes1(0x40), bytes1(0x41), bytes1(0x42), bytes1(0x43), bytes1(0x44),bytes1(0x45),bytes1(0x46),bytes1(0x47),bytes1(0x48),bytes1(0x49),bytes1(0x4a),bytes1(0x4b),bytes1(0x4c),bytes1(0x4d),bytes1(0x4e),bytes1(0x4f)];
    bytes16 uuidData = bytes16(
      keccak256(
        abi.encodePacked(
          msg.sender,
          pq ^ (block.timestamp + 16)
        )
      )
    );

    bytes memory uuid = abi.encodePacked(uuidData);
    uuid[6] = seventhByteMembers[(block.timestamp+16)/2%16];
    return uuid;
  }

  function _bytesToString(bytes memory buffer) internal pure returns (string memory) {
    // Fixed buffer size for hexadecimal conversion
    bytes memory converted = new bytes(buffer.length * 2);

    bytes memory _base = "0123456789abcdef";
    uint i = 0;
    uint buffLength = buffer.length;
    for (i; i < buffLength; ++i) {
      converted[i * 2] = _base[uint8(buffer[i]) / _base.length];
      converted[i * 2 + 1] = _base[uint8(buffer[i]) % _base.length];
    }

    return string(abi.encodePacked(converted));
  }





  /**
   * @notice Send a simple request
   * @param source JavaScript source code
   * @param encryptedSecretsUrls Encrypted URLs where to fetch user secrets
   * @param donHostedSecretsSlotID Don hosted secrets slotId
   * @param donHostedSecretsVersion Don hosted secrets version
   * @param args List of arguments accessible from within the source code
   * @param bytesArgs Array of bytes arguments, represented as hex strings
   * @param subscriptionId Billing ID
  */
  function sendRequest(
    string memory source,
    bytes memory encryptedSecretsUrls,
    uint8 donHostedSecretsSlotID,
    uint64 donHostedSecretsVersion,
    string[] memory args,
    bytes[] memory bytesArgs,
    uint64 subscriptionId,
    uint32 gasLimit,
    bytes32 jobId
  ) external onlyOwner returns (bytes32 requestId) {
    FunctionsRequest.Request memory req;
    req.initializeRequestForInlineJavaScript(source);
    if (encryptedSecretsUrls.length > 0)
      req.addSecretsReference(encryptedSecretsUrls);
    else if (donHostedSecretsVersion > 0) {
      req.addDONHostedSecrets(
        donHostedSecretsSlotID,
        donHostedSecretsVersion
      );
    }
    if (args.length > 0) req.setArgs(args);
    if (bytesArgs.length > 0) req.setBytesArgs(bytesArgs);

    // function _sendRequest(bytes data, uint64 subscriptionId, uint32 callbackGasLimit, bytes32 donId) internal returns (bytes32)
    s_lastRequestId = _sendRequest(
      req.encodeCBOR(),
      subscriptionId,
      gasLimit,
      jobId
    );
    return s_lastRequestId;
  }

  /**
   * @notice Send a pre-encoded CBOR request
   * @param request CBOR-encoded request data
   * @param subscriptionId Billing ID
   * @param gasLimit The maximum amount of gas the request can consume
   * @param jobId ID of the job to be invoked
   * @return requestId The ID of the sent request
  */
  function sendRequestCBOR(
    bytes memory request,
    uint64 subscriptionId,
    uint32 gasLimit,
    bytes32 jobId
  ) external onlyOwner returns (bytes32 requestId) {
    // function _sendRequest(bytes data, uint64 subscriptionId, uint32 callbackGasLimit, bytes32 donId) internal returns (bytes32)
    s_lastRequestId = _sendRequest(
      request,
      subscriptionId,
      gasLimit,
      jobId
    );
    return s_lastRequestId;
  }

  /**
   * @notice Store latest result/error
   * @param requestId The request ID, returned by sendRequest()
   * @param response Aggregated response from the user code
   * @param err Aggregated error from the user code or from the execution pipeline
   * Either response or error parameter will be set, but never both
  */
  function fulfillRequest(
    bytes32 requestId,
    bytes memory response,
    bytes memory err
  ) internal override {
    if (s_lastRequestId != requestId) {
      revert UnexpectedRequestID(requestId);
    }
    s_lastResponse = response;
    s_lastError = err;
    emit Response(requestId, s_lastResponse, s_lastError);
  }
}
