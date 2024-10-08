import 'dart:convert';

import 'package:marvel/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  bool isAuthed = false;

  initializeAuthProvider() async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("token");
    isAuthed = (token != null);
    if (isAuthed) {
      renewtoken();
    }
    setIsFaild(false);
  }

  Future<bool> signup(Map body) async {
    setIsLoading(true);
    final res = await api.post("https://lati.kudo.ly/api/register", body);
    if (res.statusCode == 200) {
      setIsFaild(false);
      return true;
    } else {
      print("FFFFFFFFF");
      setIsFaild(true);
    }
    print(res.body);

    setIsLoading(false);
    return false;
  }

  Future<bool> login(Map body) async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("BEFORE POST REQ");
    final res = await api.post("https://lati.kudo.ly/api/login", body);
    if (res.statusCode == 200) {
      pref.setString("token", jsonDecode(res.body)['access_token']);
      isAuthed = true;
      print(
          "AFTER POST REQ   TOKEN = ${jsonDecode(res.body)['access_token']} ");
      setIsFaild(false);
      return true;
    } else {
      print("FFFFFFFFF");
      setIsFaild(true);
    }

    setIsLoading(false);
    return false;
  }

  logout() {}
  renewtoken() {}
  getMe() {}
}
