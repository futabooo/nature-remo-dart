import 'dart:io';

import 'package:http/testing.dart';
import 'package:nature_remo/nature_remo.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  late Client natureRemoClient;

  group('devices', () {
    test('getDevices', () async {
      final devices = [
        Device(
            id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
            name: 'string',
            temperatureOffset: 0,
            humidityOffset: 0,
            createdAt: DateTime.parse('2021-09-04T00:19:23.979Z'),
            updatedAt: DateTime.parse('2021-09-04T00:19:23.979Z'),
            firmwareVersion: 'string',
            macAddress: 'string',
            serialNumber: 'string',
            newestEvents: <SensorType, SensorValue>{
              temperature: SensorValue(value: 0, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
              humidity: SensorValue(value: 0, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
              illumination: SensorValue(value: 0, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
              movement: SensorValue(value: 1, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
            })
      ];
      Future<http.Response> requestHandler(http.Request request) async {
        final json = await File('test/data/devices.json').readAsString();
        return http.Response(json, HttpStatus.ok, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      natureRemoClient = Client(
        accessToken: 'accessToken',
        httpClient: MockClient(requestHandler),
      );

      final response = await natureRemoClient.getDevices();
      expect(response.length, devices.length);

      final actualDevice = response.first;
      final device = devices.first;
      expect(actualDevice.id, device.id);
      expect(actualDevice.temperatureOffset, device.temperatureOffset);
      expect(actualDevice.humidityOffset, device.humidityOffset);
      expect(actualDevice.createdAt, device.createdAt);
      expect(actualDevice.updatedAt, device.updatedAt);
      expect(actualDevice.firmwareVersion, device.firmwareVersion);
      expect(actualDevice.macAddress, device.macAddress);
      expect(actualDevice.serialNumber, device.serialNumber);

      final actualEvents = actualDevice.newestEvents;
      final events = device.newestEvents;
      expect(actualEvents.length, events.length);
      expect(actualEvents[temperature]?.value, events[temperature]?.value);
      expect(actualEvents[temperature]?.createdAt, events[temperature]?.createdAt);
      expect(actualEvents[humidity]?.value, events[humidity]?.value);
      expect(actualEvents[humidity]?.createdAt, events[humidity]?.createdAt);
      expect(actualEvents[illumination]?.value, events[illumination]?.value);
      expect(actualEvents[illumination]?.createdAt, events[illumination]?.createdAt);
      expect(actualEvents[movement]?.value, events[movement]?.value);
      expect(actualEvents[movement]?.createdAt, events[movement]?.createdAt);
    });
  });
}
