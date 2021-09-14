import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nature_remo/src/model/appliance.dart';
import 'package:nature_remo/src/model/device.dart';
import 'package:nature_remo/src/model/user.dart';

typedef Json = Map<String, dynamic>;

class Client {
  static const String _host = 'api.nature.global';
  static const String _apiVersion = '1';

  final String _accessToken;

  final http.Client _httpClient;

  Client({required String accessToken, http.Client? httpClient})
      : _accessToken = accessToken,
        _httpClient = httpClient ?? http.Client();

  Future<User> getMe() async {
    final response = await _get('users/me');
    final user = User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return user;
  }

  Future<User> updateMe(String nickname) async {
    final response = await _post('users/me', data: {'nickname': nickname});
    final user = User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return user;
  }

  Future<List<Device>> getDevices() async {
    final response = await _get('devices');
    final json = jsonDecode(utf8.decode(response.bodyBytes)) as Iterable;
    final devices = List<Device>.from(json.map((e) => Device.fromJson(e)));
    return devices;
  }

  Future<Device> updateDevice(DeviceCore deviceCore) async {
    final response = await _post('devices/${deviceCore.id}', data: {'name': deviceCore.name});
    final updated = Device.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return updated;
  }

  Future deleteDevice(DeviceCore deviceCore) async {
    await _post('devices/${deviceCore.id}/delete');
  }

  Future<Device> updateDeviceTemperatureOffset(DeviceCore deviceCore) async {
    final response = await _post(
      'devices/${deviceCore.id}/temperature_offset',
      data: {'offset': deviceCore.temperatureOffset.toString()},
    );
    final updated = Device.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return updated;
  }

  Future<Device> updateDeviceHumidityOffset(DeviceCore deviceCore) async {
    final response = await _post(
      'devices/${deviceCore.id}/humidity_offset',
      data: {'offset': deviceCore.humidityOffset.toString()},
    );
    final updated = Device.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
    return updated;
  }

  Future<List<Appliance>> getAppliances() async {
    final response = await _get('appliances');
    final json = jsonDecode(utf8.decode(response.bodyBytes)) as Iterable;
    final appliances = List<Appliance>.from(json.map((e) => Appliance.fromJson(e)));
    return appliances;
  }

  Future<http.Response> _get(String path) async {
    final uri = Uri.https(_host, '/$_apiVersion/$path');
    final response = await _httpClient.get(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    // TODO: add error handling
    return response;
  }

  Future<http.Response> _post(String path, {Json? data}) async {
    final uri = Uri.https(_host, '/$_apiVersion/$path', data);
    final response = await _httpClient.post(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    // TODO: add error handling
    return response;
  }
}
