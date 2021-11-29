import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nature_remo/nature_remo.dart';
import 'package:nature_remo/src/model/nature_remo_exception.dart';

class NatureRemoLocalApiClient {
  final String address;

  final http.Client _httpClient;

  NatureRemoLocalApiClient({
    required this.address,
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  Future<InfraredSignal> getMessages() async {
    final response = await _get('messages');
    final json = jsonDecode(utf8.decode(response.bodyBytes));
    final infraredSignal = InfraredSignal.fromJson(json);
    return infraredSignal;
  }

  Future<void> postMessages({
    required InfraredSignal infraredSignal,
  }) async {
    final requestData = infraredSignal.toJson();
    await _post('messages', data: requestData);
  }

  Future<http.Response> _get(String path) async {
    final uri = Uri.http(address, '/$path');
    final response = await _httpClient.get(
      uri,
      headers: {
        'X-Requested-With': 'local',
        'Expect': '',
      },
    );
    if (!(response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices)) {
      throw NatureRemoException(
        httpStatusCode: response.statusCode,
        message: response.body,
      );
    }
    return response;
  }

  Future<http.Response> _post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    final uri = Uri.http(address, '/$path', data);
    final response = await _httpClient.post(
      uri,
      headers: {
        'X-Requested-With': 'local',
        'Expect': '',
      },
    );
    if (!(response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices)) {
      throw NatureRemoException(
          httpStatusCode: response.statusCode, message: response.body);
    }
    return response;
  }
}
