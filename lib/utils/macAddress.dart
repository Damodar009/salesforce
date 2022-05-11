import 'package:mac_address/mac_address.dart';

class MacAddress {
  Future<String> getMacAddress() async {
    String macAddress;
    macAddress = await GetMac.macAddress;
    return macAddress;
  }
}
