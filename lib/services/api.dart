import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Future<Response> get(String url) async {
    final response = await http.get(Uri.parse(url));

    return response;
  }

  Future<Response> post(String url, Map body) async {
    print(body);
    SharedPreferences pref = await SharedPreferences.getInstance();

    
    var token=  pref.getString("token");

    final response = await http.post(Uri.parse(url),
        body: body, headers: {
          "Accept": "application/json",
          "Authorization":"Bearer $token"
        });

    return response;
  }

  Future<Response> put(String url, Map body) async {
    final response = await http.post(Uri.parse(url), body: jsonEncode(body));

    return response;
  }
}
