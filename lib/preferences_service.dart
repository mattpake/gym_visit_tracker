import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  savePickedAddresses(List<String> pickedAddresses) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList('pickedAddresses', pickedAddresses);
  }

  Future<List<String>?> getPickedAddresses() async {
    final preferences = await SharedPreferences.getInstance();
    final pickedAddresses = preferences.getStringList('pickedAddresses');
    return pickedAddresses;
  }
}
