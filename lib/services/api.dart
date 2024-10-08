import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Api {
  Future<Response> get(String url) async {
    final response = await http.get(Uri.parse(url));

    return response;
  }

  Future<Response> post(String url, Map body) async {
    print(body);
    final response = await http.post(Uri.parse(url),
        body: body, headers: {"Accept": "application/json"});

    return response;
  }

  Future<Response> put(String url, Map body) async {
    final response = await http.post(Uri.parse(url), body: jsonEncode(body));

    return response;
  }
}
