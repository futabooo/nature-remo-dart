import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:nature_remo/src/model/aircon.dart';
import 'package:nature_remo/src/model/appliance.dart';
import 'package:nature_remo/src/model/appliance_model_and_param.dart';
import 'package:nature_remo/src/model/button.dart';
import 'package:nature_remo/src/model/device.dart';
import 'package:nature_remo/src/model/infrared_signal.dart';
import 'package:nature_remo/src/model/light.dart';
import 'package:nature_remo/src/model/nature_remo_exception.dart';
import 'package:nature_remo/src/model/rate_limit.dart';
import 'package:nature_remo/src/model/image.dart';
import 'package:nature_remo/src/model/signal.dart';
import 'package:nature_remo/src/model/tv.dart';
import 'package:nature_remo/src/model/user.dart';

typedef Json = Map<String, dynamic>;

class Client {
  static const String _host = 'api.nature.global';
  static const String _apiVersion = '1';

  final String _accessToken;

  final http.Client _httpClient;

  RateLimit? _lastRateLimit;
  RateLimit? get lastRateLimit => _lastRateLimit;

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

  Future<Appliance> registerAppliance({
    required String nickname,
    required ApplianceType type,
    required Device device,
    required String image,
    String? model,
  }) async {
    final requestData = {
      'nickname': nickname,
      'model_type': type.text,
      'device': device.deviceCore.id,
      'image': image,
    };
    if (model != null) {
      requestData.addAll({'model': model});
    }
    final response = await _post(
      'appliances',
      data: requestData,
    );
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final appliance = Appliance.fromJson(json);
    return appliance;
  }

  Future<List<ApplianceModelAndParam>> detectAppliance({
    required InfraredSignal infraredSignal,
  }) async {
    final requestData = {'message': jsonEncode(infraredSignal)};
    final response = await _post('detectappliance', data: requestData);
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final applianceModelAndParams =
        List<ApplianceModelAndParam>.from(json.map((e) => ApplianceModelAndParam.fromJson(e)));
    return applianceModelAndParams;
  }

  /// Reorder appliances
  Future<List<Appliance>> applianceOrders({
    required List<Appliance> appliances,
  }) async {
    final requestData = {'appliances': appliances.map((appliance) => appliance.id)};
    final response = await _post('appliance_orders', data: requestData);
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final reOrderdAppliances = List<Appliance>.from(json.map((e) => Appliance.fromJson(e)));
    return reOrderdAppliances;
  }

  Future deleteAppliance({
    required Appliance appliance,
  }) async {
    await _post('appliances/${appliance.id}/delete');
  }

  Future<Appliance> updateAppliance({
    required Appliance appliance,
    required Image image,
    required String nickname,
  }) async {
    final requestData = {'image': image, 'nickname': nickname};
    final response = await _post('appliances/${appliance.id}', data: requestData);
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final updated = Appliance.fromJson(json);
    return updated;
  }

  Future<AirConSetting> updateAirConSettings({
    required Appliance appliance,
    required AirConSetting airConSetting,
  }) async {
    final requestDate = {
      'temperature': airConSetting.temperature,
      'operation_mode': airConSetting.mode.text,
      'air_volume': airConSetting.airVolume.text,
      'air_direction': airConSetting.airDirection.text,
      'button': airConSetting.acButton.text,
    };
    final response = await _post(
      'appliances/${appliance.id}/aircon_settings',
      data: requestDate,
    );
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final updated = AirConSetting.fromJson(json);
    return updated;
  }

  Future<TvState> sendTvInfraredSignal({
    required Appliance appliance,
    required Button button,
  }) async {
    final requestData = {'button': button.name};
    final response = await _post('appliances/${appliance.id}/tv', data: requestData);
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final tvState = TvState.fromJson(json);
    return tvState;
  }

  Future<LightState> sendLightInfraredSignal({
    required Appliance appliance,
    required Button button,
  }) async {
    final requestData = {'button': button.name};
    final response = await _post('appliances/${appliance.id}/light', data: requestData);
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final lightState = LightState.fromJson(json);
    return lightState;
  }

  Future<List<Signal>> getSignals({
    required Appliance appliance,
  }) async {
    final response = await _get('appliances/${appliance.id}/signals');
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final signals = List<Signal>.from(json.map((e) => Signal.fromJson(e)));
    return signals;
  }

  Future<http.Response> _get(String path) async {
    final uri = Uri.https(_host, '/$_apiVersion/$path');
    final response = await _httpClient.get(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    _lastRateLimit = _rateLimitFromHeader(response.headers);
    if (!(response.statusCode >= HttpStatus.ok && response.statusCode < HttpStatus.multipleChoices)) {
      throw NatureRemoException(httpStatusCode: response.statusCode, message: response.body);
    }
    return response;
  }

  Future<http.Response> _post(String path, {Json? data}) async {
    final uri = Uri.https(_host, '/$_apiVersion/$path', data);
    final response = await _httpClient.post(uri, headers: {'Authorization': 'Bearer $_accessToken'});
    _lastRateLimit = _rateLimitFromHeader(response.headers);
    if (!(response.statusCode >= HttpStatus.ok && response.statusCode < HttpStatus.multipleChoices)) {
      throw NatureRemoException(httpStatusCode: response.statusCode, message: response.body);
    }
    return response;
  }

  RateLimit _rateLimitFromHeader(Map<String, String> headers) {
    final limitString = headers['x-rate-limit-limit'] ?? '';
    if (limitString.isEmpty) {
      throw Exception('Invalid headers, x-rate-limit-limit is not exists');
    }

    final resetString = headers['x-rate-limit-reset'] ?? '';
    if (resetString.isEmpty) {
      throw Exception('Invalid headers, x-rate-limit-reset is not exists');
    }

    final remainingString = headers['x-rate-limit-remaining'] ?? '';
    if (remainingString.isEmpty) {
      throw Exception('Invalid headers, x-rate-limit-remaining is not exists');
    }

    return RateLimit(
      limit: int.parse(limitString),
      reset: DateTime.fromMillisecondsSinceEpoch(int.parse(resetString) * 1000, isUtc: true),
      remaining: int.parse(remainingString),
    );
  }
}
