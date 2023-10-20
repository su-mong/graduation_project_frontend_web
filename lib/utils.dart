String convertHexToString(String hexString) {
  String hexStringConvert = hexString.substring(2);
  List<String> splitted = [];
  for (int i = 0; i < hexStringConvert.length; i = i + 2) {
    splitted.add(hexStringConvert.substring(i, i + 2));
  }
  String ascii = List.generate(splitted.length, (i) => String.fromCharCode(int.parse(splitted[i], radix: 16))).join();
  return ascii;
}