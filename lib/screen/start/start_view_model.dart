import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartViewModel extends GetxController {
  final VoidCallback changeState;

  StartViewModel({required this.changeState});

  void gotoNext() {
    changeState();
  }
}

/*class LoginViewModel extends GetxController {
  final String _rpcUrl = 'http://127.0.0.1:7545/';
  final String _wsUrl = 'ws://127.0.0.1:7545';
  final String _privatekey = '202b9d3e13a004b00c7be08f7dc7168ef355180bfb52999b14d4dc0369bb6f3d';

  late final Contract _contract;

  /*late Web3Client _web3cient;
  late ContractAbi _abiCode;
  late EthereumAddress _contractAddress;
  late EthPrivateKey _creds;

  late DeployedContract _deployedContract;
  late ContractFunction _issueVoteId;
  late ContractFunction _checkContractWorked;*/

  static const operatingChain = 11155111; //4;
  final RxString currentAddress = ''.obs;
  int currentChain = -1;

  final RxBool isEnabled  = false.obs;
  final RxBool isInOperatingChain = false.obs;
  final RxBool isConnected = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    /// Metamask 관련 설정
    if(ethereum != null) {
      isEnabled.value = true;
    }

    /// Metamask 관련 설정
    if (isEnabled.value) {
      ethereum!.onAccountsChanged((accounts) {
        clear();
      });
      ethereum!.onChainChanged((accounts) {
        clear();
      });
    }

    /// web3 관련 설정
    // Use `Provider` for Read-only contract, i.e. Can't call state-changing method.
    // Use `Signer` for Read-write contract. Notice that ABI can be exchangeable.
    final decodedJsonABI = jsonDecode(await rootBundle.loadString('build/contracts/VoteBackend.json'));
    final interfaceABI = jsonEncode(decodedJsonABI['abi']);
    final byteAddress = decodedJsonABI['networks']['5777']['address'];

    // final _web3Provider = Web3Provider;
    final jsonRPCProvider = JsonRpcProvider(_rpcUrl);
    final interface = Interface(interfaceABI);

    _contract = Contract(
      byteAddress, // _rpcUrl,
      interface,
      jsonRPCProvider, // provider!.getSigner(),
    );

    Get.dialog(
      ErrorDialog(message: '${interface.format(FormatTypes.minimal)}'),
    );
    /*_web3cient = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );*/
    /// web3 관련 설정
    // await _getABI();
    // await _getCredentials();
    // await _getDeployedContract();
  }

  Future<void> connect() async {
    if (isEnabled.value) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress.value = 'FROM METAMASK : ${accs.first}';
        currentChain = await ethereum!.getChainId();
        isInOperatingChain.value = (currentChain == operatingChain);
        isConnected.value = isEnabled.value && currentAddress.value.isNotEmpty;

        await checkContractWorked(accs.first);
      }

      /*try {
        final accs = await ethereum!.requestAccount();
        if (accs.isNotEmpty) {
          currentAddress.value = 'FROM METAMASK : ${accs.first}';
          currentChain = await ethereum!.getChainId();
          isInOperatingChain.value = (currentChain == operatingChain);
          isConnected.value = isEnabled.value && currentAddress.value.isNotEmpty;

          await checkContractWorked(accs.first);
        }
      } on EthereumUserRejected {
        Get.dialog(
          ErrorDialog(message: '지갑 연결 도중 유저가 연결을 취소했습니다.'),
        );
      } on Exception catch(e) {
        Get.dialog(
          ErrorDialog(message: '오류가 발생했습니다 : $e'),
        );
      }*/
    }
  }

  void clear() {
    currentAddress.value = '';
    currentChain = -1;

    isInOperatingChain.value = (currentChain == operatingChain);
    isConnected.value = isEnabled.value && currentAddress.value.isNotEmpty;
  }

  /*Future<void> _getABI() async {
    final String abiFile = await rootBundle.loadString('build/contracts/VoteBackend.json');
    final jsonABI = jsonDecode(abiFile);
    _abiCode = ContractAbi.fromJson(jsonEncode(jsonABI['abi']), 'VoteBackend');
    _contractAddress = EthereumAddress.fromHex(jsonABI['networks']['5777']['address']);
  }

  Future<void> _getCredentials() async {
    _creds = EthPrivateKey.fromHex(_privatekey);
  }

  Future<void> _getDeployedContract() async {
    _deployedContract = DeployedContract(_abiCode, _contractAddress);
    _issueVoteId = _deployedContract.function('issueVoteId');
    _checkContractWorked = _deployedContract.function('checkContractWorked');

    /// data fetch가 필요하면 아래 코드 실행
    // await fetchNotes();
  }*/

  Future<void> issueVoteId(String address) async {
    Get.dialog(ErrorDialog(message: '아직 미구현!'));
    /*await _contract.call<String>(method)

    await _web3cient.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _deployedContract,
        function: _issueVoteId,
        parameters: [address],
      ),
    );*/
  }

  Future<void> checkContractWorked(String address) async {
    /*final result = await _contract.call<String>(
      'checkContractWorked',
      [address],
    );*/

    final result = await _contract.send('checkContractWorked', [address]);
    final receipt = await result.wait(); // Wait until transaction complete
    // receipt.from; // 0xthud
    // receipt.to; // 0xe9e7cea3dedca5984780bafc599bd69add087d56 (BUSD Address)

    currentAddress.value = 'FROM CONTRACT : $receipt';

    /*final result = await _web3cient.sendTransaction(
      _creds,
      Transaction.callContract(
        contract: _deployedContract,
        function: _checkContractWorked,
        parameters: [EthereumAddress.fromHex(address)],
      ),
    );*/
  }






  /// Sepolia
  static const apiUrl = 'https://eth-sepolia.g.alchemy.com/v2/14uhTFWuELMv_n2RNPN4hi2jpveFZtP6';
  /// 내 지갑의 비공개 키 -> Metamask에서 가져옴
  static const privateKey = 'd4ae740db0152a0c5247d047e36667a98c352b449a41973c6008ab670eeb13dc';
  /// 스마트 컨트랙트 주소 -> Remix에서 확인
  static const smartContractAddr = '0x953cfdBbCf0bA441898fecaF37c9089fECA7fb43'; // '0xd9145CCE52D386f254917e481eB44e9943F39138';

  final Web3Client _client = Web3Client(apiUrl, Client());
  final EthPrivateKey _credentials = EthPrivateKey.fromHex(privateKey);
  static final EthereumAddress contractAddr = EthereumAddress.fromHex(smartContractAddr);

  DeployedContract? _contract;
  ContractFunction? _initializeFunction;
  ContractFunction? _incrementFunction;
  ContractFunction? _decrementFunction;
  ContractFunction? _getFunction;

  final RxInt _counter = 0.obs;
  int get counter => _counter.value;

  @override
  void onInit() {
    super.onInit();

    _readAbi().then((String value) {
      // ABI를 이용해서 함수 정의
      _contract = DeployedContract(
        ContractAbi.fromJson(value, 'Counter'),
        contractAddr,
      );

      _initializeFunction = _contract?.function('initialize');
      _incrementFunction = _contract?.function('increment');
      _decrementFunction = _contract?.function('decrement');
      _getFunction = _contract?.function('get');

      // 현재값 가져오기
      getCounter();
    });
  }

  Future<String> _readAbi() async {
    return await rootBundle.loadString('assets/abi.json');
  }

  Future<void> getCounter() async {
    await _client.call(
      contract: _contract!,
      function: _getFunction!,
      params: [],
    ).then((List result) {
      _counter.value = result.first.toInt();
    });
  }

  Future<void> decrementCounter() async {
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract!,
        function: _decrementFunction!,
        parameters: [BigInt.from(1)],
        maxFeePerGas: EtherAmount.inWei(BigInt.from(1000000000)),
      ),
      chainId: 11155111,
    ).then((value) {
      print('트랜잭션의 끝 자체는 잘 감지되지만, 해당 트랜잭션이 끝났다고 해서 value가 바뀐 게 바로 반영됨을 의미하지는 않는다. $value');
    });
  }

  Future<void> incrementCounter() async {
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract!,
        function: _incrementFunction!,
        parameters: [BigInt.from(1)],
        maxFeePerGas: EtherAmount.inWei(BigInt.from(1000000000)),
        // maxPriorityFeePerGas:
      ),
      chainId: 11155111,
    ).then((value) {
      print('!!!!!! $value');
    });;
  }

  void startVote() {
    Get.toNamed(AppRoutes.getVoteId);
  }

  Future<void> loginUsingMetamask() async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });

        _session = session;
      } catch (exp) {
        Get.dialog(
          ErrorDialog(message: exp.toString()),
        );
      }
    }
  }
}*/