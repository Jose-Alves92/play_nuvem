import 'package:shared_preferences/shared_preferences.dart';

import 'i_local_storage_service.dart';

class LocalStorageServiceImp implements ILocalStorageService {
 
  
  @override
  Future<bool> saveString(String key, String value) async {
    final sharedPreferences  = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(key, value);
  }
  @override
  Future<String> getString(String key, [String defaultValue = '']) async {
    final sharedPreferences  = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? defaultValue;
  } 
  @override
  Future<bool> remove(String key) async {
    final sharedPreferences  = await SharedPreferences.getInstance();
    return sharedPreferences.remove(key);
  }
}