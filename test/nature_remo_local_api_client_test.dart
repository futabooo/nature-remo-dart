import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nature_remo/nature_remo.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  late NatureRemoLocalApiClient natureRemoClient;

  setUp(() async {
    final mockClient = MockClient((request) async {
      File? file;
      switch (request.url.path) {
        case '/messages':
          file = File('test/data/infrared_signal.json');
          break;
        default:
          AssertionError();
      }
      final json = await file!.readAsString();
      return http.Response(json, HttpStatus.ok);
    });
    natureRemoClient = NatureRemoLocalApiClient(
      address: 'address',
      httpClient: mockClient,
    );
  });

  test('getMessage', () async {
    final infraredSignal = InfraredSignal(
      freq: 0,
      data: [0],
      format: 'string',
    );
    final response = await natureRemoClient.getMessages();
    expect(response.freq, infraredSignal.freq);
    expect(response.data, infraredSignal.data);
    expect(response.format, infraredSignal.format);
  });
}
