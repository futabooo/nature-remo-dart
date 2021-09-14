import 'package:nature_remo/src/model/aircon.dart';
import 'package:nature_remo/src/model/device.dart';
import 'package:nature_remo/src/model/image.dart';
import 'package:nature_remo/src/model/light.dart';
import 'package:nature_remo/src/model/signal.dart';
import 'package:nature_remo/src/model/smart_meter.dart';
import 'package:nature_remo/src/model/tv.dart';

class Appliance {
  final String id;
  final DeviceCore device;
  final ApplianceModel model;
  final String nickname;
  final Image image;
  final ApplianceType type;
  final AirConSetting airConSetting;
  final AirCon airCon;
  final List<Signal> signals;
  final Tv tv;
  final Light light;
  final SmartMeter smartMeter;

  Appliance({
    required this.id,
    required this.device,
    required this.model,
    required this.nickname,
    required this.image,
    required this.type,
    required this.airConSetting,
    required this.airCon,
    required this.signals,
    required this.tv,
    required this.light,
    required this.smartMeter,
  });

  factory Appliance.fromJson(Map<String, dynamic> json) {
    return Appliance(
        id: json['id'] as String,
        device: DeviceCore.fromJson(json['device']),
        model: ApplianceModel.fromJson(json['model']),
        nickname: json['nickname'] as String,
        image: json['image'] as Image,
        type: ApplianceTypeExt.fromText(json['type']),
        airConSetting: AirConSetting.fromJson(json['settings']),
        airCon: AirCon.fromJson(json['aircon']),
        signals: List.from((json['signals'] as Iterable).map((e) => Signal.fromJson(e))),
        tv: Tv.fromJson(json['tv']),
        light: Light.fromJson(json['light']),
        smartMeter: SmartMeter.fromJson(
          json['smart_meter'],
        ));
  }
}

class ApplianceModel {
  final String id;
  final String manufacturer;
  final String remoteName;
  final String name;
  final Image image;

  ApplianceModel({
    required this.id,
    required this.manufacturer,
    required this.remoteName,
    required this.name,
    required this.image,
  });

  factory ApplianceModel.fromJson(Map<String, dynamic> json) {
    return ApplianceModel(
        id: json['id'],
        manufacturer: json['manufacturer'],
        remoteName: json['remote_name'],
        name: json['name'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'manufacturer': manufacturer,
      'remoteName': remoteName,
      'name': name,
      'image': image,
    };
  }
}

enum ApplianceType {
  ac,
  tv,
  light,
  ir,
}

extension ApplianceTypeExt on ApplianceType {
  String get text => toString().split('.').last.toUpperCase();

  static ApplianceType fromText(String text) {
    switch (text) {
      case 'AC':
        return ApplianceType.ac;
      case 'TV':
        return ApplianceType.tv;
      case 'LIGHT':
        return ApplianceType.light;
      case 'IR':
        return ApplianceType.ir;
      default:
        return throw Exception();
    }
  }
}
