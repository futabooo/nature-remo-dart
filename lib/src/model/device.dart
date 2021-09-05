import 'package:nature_remo/src/model/sensor.dart';

class Device {
  final DeviceCore deviceCore;
  final Map<SensorType, SensorValue> newestEvents;

  Device({
    required this.deviceCore,
    required this.newestEvents,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      deviceCore: DeviceCore.fromJson(json),
      newestEvents: (json['newest_events'] as Map<String, dynamic>)
          .map((key, value) => MapEntry<SensorType, SensorValue>(key, SensorValue.fromJson(value))),
    );
  }

  Map<String, dynamic> toJson() {
    final json = deviceCore.toJson();
    json.addAll({
      'newest_events': newestEvents.toString(),
    });
    return json;
  }
}

class DeviceCore {
  final String id;
  final String name;
  final int temperatureOffset;
  final int humidityOffset;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String firmwareVersion;
  final String macAddress;
  final String serialNumber;

  DeviceCore({
    required this.id,
    required this.name,
    required this.temperatureOffset,
    required this.humidityOffset,
    required this.createdAt,
    required this.updatedAt,
    required this.firmwareVersion,
    required this.macAddress,
    required this.serialNumber,
  });

  factory DeviceCore.fromJson(Map<String, dynamic> json) {
    return DeviceCore(
      id: json['id'] as String,
      name: json['name'] as String,
      temperatureOffset: json['temperature_offset'] as int,
      humidityOffset: json['humidity_offset'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      firmwareVersion: json['firmware_version'] as String,
      macAddress: json['mac_address'] as String,
      serialNumber: json['serial_number'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'temperature_offset': temperatureOffset,
      'humidity_offset': humidityOffset,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString(),
      'firmware_version': firmwareVersion,
      'mac_address': macAddress,
      'serial_number': serialNumber,
    };
  }
}
