import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skk_test/src/model/User.dart';

String _baseUrl = 'restapi.adequateshop.com';

class ApiClient{
  Future<dynamic> login(String email, String password) async {
    try {
      var url = Uri.http(_baseUrl, "/api/authaccount/login");
      final response = await http.post(url, body: jsonEncode({
        'email': email,
        'password': password
      }), headers: {
        "Content-Type": "application/json"
      });

      return jsonDecode(response.body);
    } catch(e) {
      log("catch: " + e.toString());
      return e.toString();
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    try {
      var url = Uri.http(_baseUrl, "/api/authaccount/registration");
      final response = await http.post(url, body: jsonEncode({
        'name': name,
        'email': email,
        'password': password
      }), headers: {
        "Content-Type": "application/json"
      });

      return jsonDecode(response.body);
    } catch(e) {
      log("catch: " + e.toString());
      return e.toString();
    }
  }

  Future<List<User>> getAllUsers(String token) async {
    try {
      var url = Uri.http(_baseUrl, "/api/users", {"page": 1}.map((key, value) => MapEntry(key, value.toString())));
      final response = await http.get(url, headers: {
        "Authorization": "Bearer $token"
      });

      dynamic respBody = jsonDecode(response.body);
      if(response.statusCode == 200) {
        final parsed = respBody["data"].cast<Map<String, dynamic>>();
        return parsed.map<User>((json) => User.fromJson(json)).toList();
      } else {
        log(response.statusCode.toString() + ": " + response.reasonPhrase.toString());
        throw Exception(response.reasonPhrase);
      }
    } catch(e) {
      log("Exception: ");
      throw Exception(e.toString());
    }
  }

  // ApiResponse _getResponses(status, body) {
  //   var _response;
  //
  //   switch(status) {
  //     case 200 :
  //       return body;
  //       // _response = ApiResponse.fromJson(jsonDecode(body));
  //       break;
  //     case 401 :
  //       return body;
  //       // _response.ApiError = ApiError.fromJson(jsonDecode(body));
  //       break;
  //     default :
  //       log("msg: " + body);
  //       // _response.ApiError = ApiError.fromJson(jsonDecode(body));
  //       break;
  //   }
  //
  //   return _response;
  // }
}