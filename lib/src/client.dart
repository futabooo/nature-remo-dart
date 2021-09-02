import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nature_remo/src/model/device.dart';
import 'package:nature_remo/src/model/user.dart';

class Client {
  static const String _host = 'api.nature.global';
  static const String _apiVersion = '1';

  final String _accessToken;

  final http.Client _httpClient;

  Client({required String accessToken, http.Client? httpClient})
      : _accessToken = accessToken,
        _httpClient = httpClient ?? http.Client();

  Future<User> getMe() async {
    final uri = Uri.https(_host, '/$_apiVersion/users/me');
    final response = await _httpClient.get(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    final user = User.fromJson(jsonDecode(response.body));
    return user;
  }

  Future<User> updateMe(String nickname) async {
    final uri = Uri.https(_host, '/$_apiVersion/users/me', {'nickname': nickname});
    final response = await _httpClient.post(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    final user = User.fromJson(jsonDecode(response.body));
    return user;
  }

  Future<List<Device>> getDevices() async {
    final uri = Uri.https(_host, '/$_apiVersion/devices');
    final response = await _httpClient.get(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    final json = jsonDecode(response.body) as Iterable;
    final devices = List<Device>.from(json.map((e) => Device.fromJson(e)));
    return devices;
  }
}
