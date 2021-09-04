import 'dart:io';

import 'package:http/testing.dart';
import 'package:nature_remo/nature_remo.dart';
import 'package:test/scaffolding.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

void main() {
  late Client natureRemoClient;

  group('users', () {
    test('getMe', () async {
      final me = User(
        id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
        nickname: 'string',
      );

      Future<http.Response> requestHandler(http.Request request) async {
        final json = await File('test/data/user.json').readAsString();
        return http.Response(json, HttpStatus.ok, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      natureRemoClient = Client(
        accessToken: 'accessToken',
        httpClient: MockClient(requestHandler),
      );

      final response = await natureRemoClient.getMe();
      expect(response.id, me.id);
      expect(response.nickname, me.nickname);
    });
  });

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

    test('updateDevice', () async {
      final device = Device(
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
          });

      Future<http.Response> requestHandler(http.Request request) async {
        final json = await File('test/data/device.json').readAsString();
        return http.Response(json, HttpStatus.ok, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      natureRemoClient = Client(
        accessToken: 'accessToken',
        httpClient: MockClient(requestHandler),
      );

      final response = await natureRemoClient.updateDevice(device);
      expect(response.id, device.id);
      expect(response.name, device.name);
    });

    test('deleteDevice', () async {
      // TODO: implements
    });

    test('updateDeviceTemperatureOffset', () async {
      final device = Device(
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
          });

      Future<http.Response> requestHandler(http.Request request) async {
        final json = await File('test/data/device.json').readAsString();
        return http.Response(json, HttpStatus.ok, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      natureRemoClient = Client(
        accessToken: 'accessToken',
        httpClient: MockClient(requestHandler),
      );

      final response = await natureRemoClient.updateDeviceTemperatureOffset(device);
      expect(response.id, device.id);
      expect(response.newestEvents[temperature]?.value, device.newestEvents[temperature]?.value);
      expect(response.newestEvents[temperature]?.createdAt, device.newestEvents[temperature]?.createdAt);
    });
    test('updateDeviceHumidityOffset', () async {
      final device = Device(
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
          });

      Future<http.Response> requestHandler(http.Request request) async {
        final json = await File('test/data/device.json').readAsString();
        return http.Response(json, HttpStatus.ok, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        });
      }

      natureRemoClient = Client(
        accessToken: 'accessToken',
        httpClient: MockClient(requestHandler),
      );

      final response = await natureRemoClient.updateDeviceHumidityOffset(device);
      expect(response.id, device.id);
      expect(response.newestEvents[humidity]?.value, device.newestEvents[humidity]?.value);
      expect(response.newestEvents[humidity]?.createdAt, device.newestEvents[humidity]?.createdAt);
    });
  });
}
