import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_web3/ethereum.dart';
import 'package:flutter_web3/ethers.dart';
import 'package:get/get.dart';

class ContractService extends GetxService {
  static const OPERATING_CHAIN = 80001;

  late final Contract contract;
  String currentAddress = '';
  int currentChain = -1;
  bool wcConnected = false;

  String? voteId;

  bool get isInOperatingChain => currentChain == OPERATING_CHAIN;
  bool get isConnected => Ethereum.isSupported && currentAddress.isNotEmpty;

  @override
  Future<void> onInit() async {
    super.onInit();

    final rpcProvider = JsonRpcProvider('https://rpc-mumbai.maticvigil.com/');
    print('rpcProvider : $rpcProvider');
    print('rpcProvider.network : ${await rpcProvider.getNetwork()}');

    final decodedJsonABI = jsonDecode(await rootBundle.loadString('assets/abi.json'));
    final interfaceABI = jsonEncode(decodedJsonABI);
    final interface = Interface(interfaceABI);
    print('interface : $interface');
    const byteAddress = '0x3a949FAFcA0635806856da7CbFcb1C949A597343';
    print('byteAddress : $byteAddress');

    contract = Contract(
      byteAddress, // _rpcUrl,
      interface,
      provider!.getSigner(),
    );
    print('contract : $contract');
  }

  Future<bool> connectWallet() async {
    if (Ethereum.isSupported) {
      final accs = await ethereum!.requestAccount();

      ethereum!.onAccountsChanged((accs) {
        _clear();
      });

      ethereum!.onChainChanged((chain) {
        _clear();
      });

      if (accs.isNotEmpty) {
        currentAddress = accs.first;
        currentChain = await ethereum!.getChainId();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void _clear() {
    currentAddress = '';
    currentChain = -1;
    wcConnected = false;
    // web3wc = null;
  }
}