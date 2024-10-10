import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Response> get(String url) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("token") ?? "");

    final response = await http.get(Uri.parse(url), headers: {
      "Authorization": "Bearer $token",
      "Accept": "application/json",
    });

    if (response.statusCode == 401) {
      refreshToken().then((refreshed) {
        if (refreshed) {
          get(url);
        }
      });
    }

    return response;
  }

  Future<Response> post(String url, Map body) async {
    print(body);
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = pref.getString("token");

    final response = await http.post(Uri.parse(url), body: body, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 401) {
      refreshToken().then((refreshed) {
        if (refreshed) {
          post(url, body);
        }
      });
    }

    return response;
  }

  Future<Response> put(String url, Map body) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    var token = jsonDecode(pref.getString("token") ?? "");
    final response = await http.put(Uri.parse(url), body: body, headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 401) {
      refreshToken().then((refreshed) {
        if (refreshed) {
          put(url, body);
        }
      });
    }

    return response;
  }

  Future<bool> refreshToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var oldToken = pref.getString('token');
    final response = await http
        .post(Uri.parse("https://lati.kudo.ly/api/refresh"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $oldToken",
    });
    if (response.statusCode == 200) {
      pref.setString('token', jsonDecode(response.body)['access_token']);
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}
