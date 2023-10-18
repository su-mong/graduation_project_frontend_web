import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  bool get isInOperatingChain => currentChain == OPERATING_CHAIN;

  bool get isConnected => Ethereum.isSupported && currentAddress.isNotEmpty;

  String currentAddress = '';

  int currentChain = -1;

  bool wcConnected = false;

  static const OPERATING_CHAIN = 80001;

  final wc = WalletConnectProvider.binance();

  Web3Provider? web3wc;

  connectProvider() async {
    if (Ethereum.isSupported) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress = accs.first;
        currentChain = await ethereum!.getChainId();
      }

      update();
    }
  }

  connectWC() async {
    await wc.connect();
    if (wc.connected) {
      currentAddress = wc.accounts.first;
      currentChain = 56;
      wcConnected = true;
      web3wc = Web3Provider.fromWalletConnect(wc);
    }

    update();
  }

  clear() {
    currentAddress = '';
    currentChain = -1;
    wcConnected = false;
    web3wc = null;

    update();
  }

  init() {
    if (Ethereum.isSupported) {
      connectProvider();

      ethereum!.onAccountsChanged((accs) {
        clear();
      });

      ethereum!.onChainChanged((chain) {
        clear();
      });
    }
  }

  getLastestBlock() async {
    print(await provider!.getLastestBlock());
    print(await provider!.getLastestBlockWithTransaction());
  }

  testProvider() async {
    // final rpcProvider = JsonRpcProvider('https://bsc-dataseed.binance.org/');
    final rpcProvider = JsonRpcProvider('https://rpc-mumbai.maticvigil.com/');
    print('rpcProvider : $rpcProvider');
    print('rpcProvider.network : ${await rpcProvider.getNetwork()}');

    /*final decodedJsonABI = jsonDecode(await rootBundle.loadString('build/contracts/VoteBackend.json'));
    final interfaceABI = jsonEncode(decodedJsonABI['abi']);
    final interface = Interface(interfaceABI);
    print('interface : $interface');
    final byteAddress = decodedJsonABI['networks']['5777']['address'];
    print('byteAddress : $byteAddress');*/
    final decodedJsonABI = jsonDecode(await rootBundle.loadString('build/contracts/VoteBackendV2.json'));
    final interfaceABI = jsonEncode(decodedJsonABI);
    final interface = Interface(interfaceABI);
    print('interface : $interface');
    const byteAddress = "0x4F60eeC7Fe59a0b908C25a03d19F733fd66aA2B8";
    print('byteAddress : $byteAddress');

    /*final contract = Contract(
      byteAddress, // _rpcUrl,
      interface,
      rpcProvider,
    );*/
    final contract = Contract(
      byteAddress, // _rpcUrl,
      interface,
      provider!.getSigner(),
    );

    print('contract : $contract');

    /*final callResult = await contract.send(
      'issueVoteId',
      [currentAddress, '01022851094'],
    );
    await callResult.wait();
    print('callResult.data : ${callResult.data}');*/
    final callResult = await contract.send(
      'sendVerificationCode',
      [['01022851090']],
    );
    await callResult.wait();
    print('callResult.data : ${callResult.data}');

    // Receive an event when ANY transfer occurs
    contract.on('Response', (requestId, response, err, event) {
      print('     requestId : $requestId');
      print('     response : $response');
      print('     err : $err');
      // Event.fromJS(event); // Event: Transfer Transfer(address,address,uint256) with args [0x0648ff5de80Adf54aAc07EcE2490f50a418Dde23, 0x12c64E61440582793EF4964A36d98020d83490a3, 1015026418461703883891]
    });
    // A filter for when a specific address receives tokens
    // final myAddress = "0x8ba1f109551bD432803012645Ac136ddd64DBA72";
    // final filter = contract.getFilter('Transfer', [null, myAddress]);
    // {
    //   address: '0xe9e7cea3dedca5984780bafc599bd69add087d56',
    //   topics: [
    //     '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef',
    //     null,
    //     '0x0000000000000000000000008ba1f109551bd432803012645ac136ddd64dba72'
    //   ]
    // }

    /*contract.on(filter, (from, to, amount, event) {
      // ...
    });*/
  }

  test() async {}

  testSwitchChain() async {
    await ethereum!.walletSwitchChain(97, () async {
      await ethereum!.walletAddChain(
        chainId: 97,
        chainName: 'Binance Testnet',
        nativeCurrency:
        CurrencyParams(name: 'BNB', symbol: 'BNB', decimals: 18),
        rpcUrls: ['https://data-seed-prebsc-1-s1.binance.org:8545/'],
      );
    });
  }

  @override
  void onInit() {
    init();

    super.onInit();
  }
}

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TestController>(
      init: TestController(),
      builder: (h) => Scaffold(
        body: Center(
          child: Column(children: [
            Container(height: 10),
            Builder(builder: (_) {
              var shown = '';
              if (h.isConnected && h.isInOperatingChain)
                shown = 'You\'re connected!';
              else if (h.isConnected && !h.isInOperatingChain)
                shown = 'Wrong chain! Please connect to BSC. (56)';
              else if (Ethereum.isSupported)
                return OutlinedButton(
                    child: Text('Connect'), onPressed: h.connectProvider);
              else
                shown = 'Your browser is not supported!';

              return Text(shown,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
            }),
            Container(height: 30),
            if (h.isConnected && h.isInOperatingChain) ...[
              TextButton(
                  onPressed: h.getLastestBlock,
                  child: Text('get lastest block')),
              Container(height: 10),
              TextButton(
                  onPressed: h.testProvider,
                  child: Text('test binance rpc provider')),
              Container(height: 10),
              TextButton(onPressed: h.test, child: Text('test')),
              Container(height: 10),
              TextButton(
                  onPressed: h.testSwitchChain,
                  child: Text('test switch chain')),
            ],
            Container(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Wallet Connect connected: ${h.wcConnected}'),
                Container(width: 10),
                OutlinedButton(
                    child: Text('Connect to WC'), onPressed: h.connectWC)
              ],
            ),
            Container(height: 30),
            if (h.wcConnected && h.wc.connected) ...[
              Text(h.wc.walletMeta.toString()),
            ],
          ]),
        ),
      ),
    );
  }
}