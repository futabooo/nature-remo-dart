import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nature_remo/src/nature_remo_cloud_api_client.dart';
import 'package:nature_remo/src/model/aircon.dart';
import 'package:nature_remo/src/model/appliance.dart';
import 'package:nature_remo/src/model/button.dart';
import 'package:nature_remo/src/model/device.dart';
import 'package:nature_remo/src/model/light.dart';
import 'package:nature_remo/src/model/sensor.dart';
import 'package:nature_remo/src/model/signal.dart';
import 'package:nature_remo/src/model/smart_meter.dart';
import 'package:nature_remo/src/model/tv.dart';
import 'package:nature_remo/src/model/user.dart';
import 'package:test/test.dart';

void main() {
  late NatureRemoCloudApiClient natureRemoClient;

  late Appliance appliance;
  late Device device;
  late Signal signal;

  setUp(() async {
    appliance = Appliance(
      id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
      device: DeviceCore(
          id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
          name: 'string',
          temperatureOffset: 0,
          humidityOffset: 0,
          createdAt: DateTime.parse('2021-09-08T06:10:38.923Z'),
          updatedAt: DateTime.parse('2021-09-08T06:10:38.923Z'),
          firmwareVersion: 'string',
          macAddress: 'string',
          serialNumber: 'string'),
      model: ApplianceModel(
          id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
          manufacturer: 'string',
          remoteName: 'string',
          name: 'string',
          image: 'string'),
      nickname: 'string',
      image: 'string',
      type: ApplianceType.ac,
      airConSetting: AirConSetting(
        temperature: 'string',
        mode: OperationMode.auto,
        airVolume: AirVolume.auto,
        airDirection: AirDirection.auto,
        acButton: ACButton.powerOn,
      ),
      airCon: AirCon(
          range: AirConRange(
            modes: <OperationMode, AirConRangeMode>{
              OperationMode.cool: AirConRangeMode(
                temperature: ['string'],
                airVolume: [AirVolume.auto],
                airDirection: [AirDirection.auto],
              ),
              OperationMode.warm: AirConRangeMode(
                temperature: ['string'],
                airVolume: [AirVolume.auto],
                airDirection: [AirDirection.auto],
              ),
              OperationMode.dry: AirConRangeMode(
                temperature: ['string'],
                airVolume: [AirVolume.auto],
                airDirection: [AirDirection.auto],
              ),
              OperationMode.blow: AirConRangeMode(
                temperature: ['string'],
                airVolume: [AirVolume.auto],
                airDirection: [AirDirection.auto],
              ),
              OperationMode.auto: AirConRangeMode(
                temperature: ['string'],
                airVolume: [AirVolume.auto],
                airDirection: [AirDirection.auto],
              ),
            },
            fixedButtons: [ACButton.powerOn],
          ),
          temperatureUnit: TemperatureUnit.auto),
      signals: [
        Signal(
            id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
            name: 'string',
            image: 'string')
      ],
      tv: Tv(
          state: TvState(inputType: TvInputType.t),
          buttons: [Button(name: 'string', image: 'string', label: 'string')]),
      light: Light(
          state: LightState(
              brightness: 'string', power: Power.on, lastButton: 'string'),
          buttons: [Button(name: 'string', image: 'string', label: 'string')]),
      smartMeter: SmartMeter(echonetLiteProperties: [
        EchonetLiteProperty(
            name: 'string',
            epc: 0,
            val: 'string',
            updatedAt: DateTime.parse('2021-09-08T06:10:38.923Z'))
      ]),
    );
    device = Device(
        deviceCore: DeviceCore(
          id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
          name: 'string',
          temperatureOffset: 0,
          humidityOffset: 0,
          createdAt: DateTime.parse('2021-09-04T00:19:23.979Z'),
          updatedAt: DateTime.parse('2021-09-04T00:19:23.979Z'),
          firmwareVersion: 'string',
          macAddress: 'string',
          serialNumber: 'string',
        ),
        newestEvents: <SensorType, SensorValue>{
          temperature: SensorValue(
              value: 0, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
          humidity: SensorValue(
              value: 0, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
          illumination: SensorValue(
              value: 0, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
          movement: SensorValue(
              value: 1, createdAt: DateTime.parse('2020-09-10T06:03:58.213Z')),
        });
    signal = Signal(
      id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
      name: 'string',
      image: 'string',
    );
    final mockClient = MockClient((request) async {
      File? file;
      switch (request.url.path) {
        case '/1/users/me':
          file = File('test/data/user.json');
          break;
        case '/1/devices':
          file = File('test/data/devices.json');
          break;
        case '/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6':
          file = File('test/data/device.json');
          break;
        case '/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6/temperature_offset':
          file = File('test/data/device.json');
          break;
        case '/1/devices/3fa85f64-5717-4562-b3fc-2c963f66afa6/humidity_offset':
          file = File('test/data/device.json');
          break;
        case '/1/appliances':
          file = File('test/data/appliances.json');
          break;
        case '/1/appliances/3fa85f64-5717-4562-b3fc-2c963f66afa6/signals':
          file = File('test/data/signals.json');
          break;
        default:
          AssertionError();
      }
      final json = await file!.readAsString();
      return http.Response(json, HttpStatus.ok, headers: <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-rate-limit-limit': '30',
        'x-rate-limit-remaining': '29',
        'x-rate-limit-reset': '1631972400',
      });
    });
    natureRemoClient = NatureRemoCloudApiClient(
      accessToken: 'accessToken',
      httpClient: mockClient,
    );
  });
  group('user', () {
    test('getMe', () async {
      final me = User(
        id: '3fa85f64-5717-4562-b3fc-2c963f66afa6',
        nickname: 'string',
      );

      final response = await natureRemoClient.getMe();
      expect(response.id, me.id);
      expect(response.nickname, me.nickname);
    });
  });

  group('device', () {
    test('getDevices', () async {
      final devices = [device];

      final response = await natureRemoClient.getDevices();
      expect(response.length, devices.length);

      final actualDevice = response.first.deviceCore;
      final deviceCore = devices.first.deviceCore;
      expect(actualDevice.id, deviceCore.id);
      expect(actualDevice.temperatureOffset, deviceCore.temperatureOffset);
      expect(actualDevice.humidityOffset, deviceCore.humidityOffset);
      expect(actualDevice.createdAt, deviceCore.createdAt);
      expect(actualDevice.updatedAt, deviceCore.updatedAt);
      expect(actualDevice.firmwareVersion, deviceCore.firmwareVersion);
      expect(actualDevice.macAddress, deviceCore.macAddress);
      expect(actualDevice.serialNumber, deviceCore.serialNumber);

      final actualEvents = response.first.newestEvents;
      final events = devices.first.newestEvents;
      expect(actualEvents.length, events.length);
      expect(actualEvents[temperature]?.value, events[temperature]?.value);
      expect(
          actualEvents[temperature]?.createdAt, events[temperature]?.createdAt);
      expect(actualEvents[humidity]?.value, events[humidity]?.value);
      expect(actualEvents[humidity]?.createdAt, events[humidity]?.createdAt);
      expect(actualEvents[illumination]?.value, events[illumination]?.value);
      expect(actualEvents[illumination]?.createdAt,
          events[illumination]?.createdAt);
      expect(actualEvents[movement]?.value, events[movement]?.value);
      expect(actualEvents[movement]?.createdAt, events[movement]?.createdAt);
    });

    test('updateDevice', () async {
      final response = await natureRemoClient.updateDevice(device.deviceCore);
      expect(response.deviceCore.id, device.deviceCore.id);
      expect(response.deviceCore.name, device.deviceCore.name);
    });

    test('deleteDevice', () async {
      // TODO: implements
    });

    test('updateDeviceTemperatureOffset', () async {
      final response = await natureRemoClient
          .updateDeviceTemperatureOffset(device.deviceCore);
      expect(response.deviceCore.id, device.deviceCore.id);
      expect(response.newestEvents[temperature]?.value,
          device.newestEvents[temperature]?.value);
      expect(response.newestEvents[temperature]?.createdAt,
          device.newestEvents[temperature]?.createdAt);
    });
    test('updateDeviceHumidityOffset', () async {
      final response =
          await natureRemoClient.updateDeviceHumidityOffset(device.deviceCore);
      expect(response.deviceCore.id, device.deviceCore.id);
      expect(response.newestEvents[humidity]?.value,
          device.newestEvents[humidity]?.value);
      expect(response.newestEvents[humidity]?.createdAt,
          device.newestEvents[humidity]?.createdAt);
    });
  });

  group('appliance', () {
    test('getAppliances', () async {
      final appliances = [appliance];
      final response = await natureRemoClient.getAppliances();
      expect(response.length, appliances.length);

      final actualAppliance = response.first;
      final first = appliances.first;
      expect(actualAppliance.id, first.id);
      expect(actualAppliance.nickname, first.nickname);
      expect(actualAppliance.image, first.image);
      expect(actualAppliance.type, first.type);

      final actualDevice = actualAppliance.device;
      final device = first.device;
      expect(actualDevice.id, device.id);
      expect(actualDevice.name, device.name);
      expect(actualDevice.temperatureOffset, device.temperatureOffset);
      expect(actualDevice.humidityOffset, device.humidityOffset);
      expect(actualDevice.createdAt, device.createdAt);
      expect(actualDevice.updatedAt, device.updatedAt);
      expect(actualDevice.firmwareVersion, device.firmwareVersion);
      expect(actualDevice.macAddress, device.macAddress);
      expect(actualDevice.serialNumber, device.serialNumber);

      final actualModel = actualAppliance.model;
      final model = first.model;
      expect(actualModel.id, model.id);
      expect(actualModel.manufacturer, model.manufacturer);
      expect(actualModel.remoteName, model.remoteName);
      expect(actualModel.name, model.name);
      expect(actualModel.image, model.image);

      final actualSetting = actualAppliance.airConSetting;
      final setting = first.airConSetting;
      expect(actualSetting.temperature, setting.temperature);
      expect(actualSetting.mode, setting.mode);
      expect(actualSetting.airVolume, setting.airVolume);
      expect(actualSetting.airDirection, setting.airDirection);
      expect(actualSetting.acButton, setting.acButton);

      final actualAirCon = actualAppliance.airCon;
      final airCon = first.airCon;
      expect(actualAirCon.range.modes[OperationMode.cool.text],
          airCon.range.modes[OperationMode.cool.text]);
      expect(actualAirCon.range.modes[OperationMode.warm.text],
          airCon.range.modes[OperationMode.warm.text]);
      expect(actualAirCon.range.modes[OperationMode.dry.text],
          airCon.range.modes[OperationMode.dry.text]);
      expect(actualAirCon.range.modes[OperationMode.blow.text],
          airCon.range.modes[OperationMode.blow.text]);
      expect(actualAirCon.range.modes[OperationMode.auto.text],
          airCon.range.modes[OperationMode.auto.text]);
      expect(actualAirCon.range.fixedButtons.length,
          airCon.range.fixedButtons.length);
      expect(actualAirCon.range.fixedButtons.first,
          airCon.range.fixedButtons.first);
      expect(actualAirCon.temperatureUnit, airCon.temperatureUnit);

      final actualSignals = actualAppliance.signals;
      final signals = first.signals;
      expect(actualSignals.length, signals.length);
      expect(actualSignals.first.id, signals.first.id);
      expect(actualSignals.first.name, signals.first.name);
      expect(actualSignals.first.image, signals.first.image);

      final actualTv = actualAppliance.tv;
      final tv = first.tv;
      expect(actualTv.state.inputType, tv.state.inputType);
      expect(actualTv.buttons.length, tv.buttons.length);
      expect(actualTv.buttons.first.name, tv.buttons.first.name);
      expect(actualTv.buttons.first.image, tv.buttons.first.image);
      expect(actualTv.buttons.first.label, tv.buttons.first.label);

      final actualLight = actualAppliance.light;
      final light = first.light;
      expect(actualLight.state.brightness, light.state.brightness);
      expect(actualLight.state.power, light.state.power);
      expect(actualLight.state.lastButton, light.state.lastButton);
      expect(actualLight.buttons.first.name, light.buttons.first.name);
      expect(actualLight.buttons.first.image, light.buttons.first.image);
      expect(actualLight.buttons.first.label, light.buttons.first.label);

      final actualSmartMeter = actualAppliance.smartMeter;
      final smartMeter = first.smartMeter;
      expect(actualSmartMeter.echonetLiteProperties.length,
          smartMeter.echonetLiteProperties.length);

      final actualEchonetLiteProperty =
          actualSmartMeter.echonetLiteProperties.first;
      final echonetLiteProperty = smartMeter.echonetLiteProperties.first;
      expect(actualEchonetLiteProperty.name, echonetLiteProperty.name);
      expect(actualEchonetLiteProperty.epc, echonetLiteProperty.epc);
      expect(actualEchonetLiteProperty.val, echonetLiteProperty.val);
      expect(
          actualEchonetLiteProperty.updatedAt, echonetLiteProperty.updatedAt);
    });
    test('registerAppliance', () async {
      // TODO: implements
    });
  });

  group('signal', () {
    test('getSignals', () async {
      final signals = [signal];
      final response = await natureRemoClient.getSignals(appliance: appliance);

      expect(response.length, signals.length);
      expect(response.first.id, signals.first.id);
      expect(response.first.name, signals.first.name);
      expect(response.first.image, signals.first.image);
    });
  });

  group('headers', () {
    test('correct headers', () async {
      expect(natureRemoClient.lastRateLimit?.limit, null);
      expect(natureRemoClient.lastRateLimit?.remaining, null);
      expect(natureRemoClient.lastRateLimit?.reset, null);
      await natureRemoClient.getMe();
      expect(natureRemoClient.lastRateLimit?.limit, 30);
      expect(natureRemoClient.lastRateLimit?.remaining, 29);
      expect(natureRemoClient.lastRateLimit?.reset,
          DateTime.parse('2021-09-18 13:40:00.000Z'));
    });
  });
}
