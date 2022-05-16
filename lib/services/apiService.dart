import 'dart:convert';

import 'package:app/constants/urls.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class APIService {
  static Future<http.Response> login(String email, String password) async {
    String hashedpassword = md5.convert(utf8.encode(password)).toString();
    String url = URLS.restServer + '/mobile/protected/login';

    Map data = {"email": email, "hashedpassword": hashedpassword};
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> introspect(String token) async {
    String url = URLS.restServer + '/mobile/protected/introspect';

    Map data = {"token": token};
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> listElders(String token) async {
    String url = URLS.restServer + '/mobile/private/listelders';

    Map data = {"token": token};
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> editElder(Map eldermap) async {
    String url = URLS.restServer + '/mobile/private/editelder';

    Map data = eldermap;
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> addElder(Map eldermap) async {
    String url = URLS.restServer + '/mobile/private/addelder';

    Map data = eldermap;
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> deleteElder(String nic, String token) async {
    String url = URLS.restServer + '/mobile/private/deleteelder';

    Map data = {"token": token, "nic": nic};
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> myAccount(String token) async {
    String url = URLS.restServer + '/mobile/private/me';

    Map data = {"token": token};
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> onMapLoad(String token) async {
    String url = URLS.restServer + '/mobile/private/elderonmap';

    Map data = {"token": token};
    //encode Map to JSON
    var body = json.encode(data);

    return await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
  }

  static Future<http.Response> getMACs() async {
    String url = URLS.restServer + '/iot/protected/getmacs';

    //Map data = {"token": token};
    //encode Map to JSON
    //var body = json.encode(data);

    return await http.get(Uri.parse(url));
  }
}
