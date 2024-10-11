import 'dart:convert';
import 'dart:io';

import 'package:marvel/models/user_model.dart';
import 'package:marvel/providers/base_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider {
  bool isAuthed = false;
  UserModel? user;

  initializeAuthProvider() async {
    setIsLoading(true);
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("token");
    print("THE TOKEN  $token");
    isAuthed = (token != null);

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
      pref.setString("token", jsonEncode(jsonDecode(res.body)['access_token']));
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

  Future<bool> logout() async {
    final res = await api.post("https://lati.kudo.ly/api/logout", {});

    print(res.body);
    print(res.headers);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();

    return true;
  }

  reNewToken() {}
  Future<UserModel?> getMe() async {
    setIsLoading(true);
    print(55555555);
    final res = await api.get(
      "https://lati.kudo.ly/api/user",
    );

    if (res.statusCode == 200) {
      user = UserModel.fromJson(jsonDecode(res.body)['data']);
      print(user == null ? null : user!.toJson());
      setIsLoading(false);
      return user;
    } else {
      setIsLoading(false);
      print(res.body);
      return null;
    }
  }

  Future<bool> updateUser(Map body) async {
    setIsLoading(true);
    final res = await api.put("https://lati.kudo.ly/api/users/update", body);

    if (res.statusCode == 200) {
      print(555555555555555);
      print(res.body);
      setIsLoading(false);
      getMe();
      return true;
    } else {
      print(44444444444);
      print(res.body);
      setIsLoading(false);
      return false;
    }
  }

  updateUserPhoto(File file) async {
    await api.upload(file, "https://lati.kudo.ly/api/uploader").then((res) {
      if (res.statusCode == 200) {
        UserModel newUM = user!;
        newUM.avatarUrl = jsonDecode(res.body)['image_name'];
        updateUser({'avatar_url': newUM.avatarUrl.toString()});
      }
    });
  }
}
