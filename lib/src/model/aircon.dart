import 'package:collection/collection.dart';

class AirCon {
  final AirConRange range;
  final TemperatureUnit temperatureUnit;

  AirCon({
    required this.range,
    required this.temperatureUnit,
  });

  factory AirCon.fromJson(Map<String, dynamic> json) {
    return AirCon(
      range: AirConRange.fromJson(json['range']),
      temperatureUnit: TemperatureUnitExt.fromString(json['tempUnit']),
    );
  }
}

class AirConRange {
  final Map<OperationMode, AirConRangeMode> modes;
  final List<ACButton> fixedButtons;

  AirConRange({
    required this.modes,
    required this.fixedButtons,
  });

  factory AirConRange.fromJson(Map<String, dynamic> json) {
    return AirConRange(
        modes: (json['modes'] as Map<String, dynamic>).map(
          (key, value) => MapEntry<OperationMode, AirConRangeMode>(
              OperationModeExt.fromString(key),
              AirConRangeMode.fromJson(value)),
        ),
        fixedButtons: List<ACButton>.from((json['fixedButtons'] as Iterable)
            .map((e) => ACButtonExt.fromString(e))));
  }
}

class AirConRangeMode {
  final List<String> temperature;
  final List<AirVolume> airVolume;
  final List<AirDirection> airDirection;

  AirConRangeMode({
    required this.temperature,
    required this.airVolume,
    required this.airDirection,
  });

  factory AirConRangeMode.fromJson(Map<String, dynamic> json) {
    return AirConRangeMode(
      temperature: List<String>.from(json['temp']),
      airVolume: List<AirVolume>.from(
          (json['vol'] as Iterable).map((e) => AirVolumeExt.fromString(e))),
      airDirection: List<AirDirection>.from(
          (json['dir'] as Iterable).map((e) => AirDirectionExt.fromString(e))),
    );
  }

  @override
  bool operator ==(covariant AirConRangeMode other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.temperature, temperature) &&
        listEquals(other.airVolume, airVolume) &&
        listEquals(other.airDirection, airDirection);
  }

  @override
  int get hashCode =>
      temperature.hashCode ^ airVolume.hashCode ^ airDirection.hashCode;
}

class AirConSetting {
  final String temperature;
  final OperationMode mode;
  final AirVolume airVolume;
  final AirDirection airDirection;
  final ACButton acButton;

  AirConSetting({
    required this.temperature,
    required this.mode,
    required this.airVolume,
    required this.airDirection,
    required this.acButton,
  });

  factory AirConSetting.fromJson(Map<String, dynamic> json) {
    return AirConSetting(
      temperature: json['temp'],
      mode: OperationModeExt.fromString(json['mode']),
      airVolume: AirVolumeExt.fromString(json['vol']),
      airDirection: AirDirectionExt.fromString(json['dir']),
      acButton: ACButtonExt.fromString(json['button']),
    );
  }
}

enum ACButton {
  powerOn,
  powerOff,
}

enum OperationMode {
  cool,
  warm,
  dry,
  blow,
  auto,
}

enum TemperatureUnit {
  auto,
  celsius,
  fahrenheit,
}

enum AirVolume {
  auto,
  one,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
}

enum AirDirection {
  auto,
}

extension ACButtonExt on ACButton {
  String get text {
    switch (this) {
      case ACButton.powerOn:
        return '';
      case ACButton.powerOff:
        return 'power-off';
    }
  }

  static ACButton fromString(String name) {
    switch (name) {
      case '':
        return ACButton.powerOn;
      case 'power-off':
        return ACButton.powerOff;
      default:
        return throw Exception();
    }
  }
}

extension OperationModeExt on OperationMode {
  String get text => toString().split('.').last;
  static OperationMode fromString(String text) {
    return OperationMode.values
        .firstWhere((e) => e.text == text, orElse: () => OperationMode.auto);
  }
}

extension TemperatureUnitExt on TemperatureUnit {
  String get text {
    switch (this) {
      case TemperatureUnit.auto:
        return '';
      case TemperatureUnit.celsius:
        return 'c';
      case TemperatureUnit.fahrenheit:
        return 'f';
    }
  }

  static TemperatureUnit fromString(String text) {
    return TemperatureUnit.values
        .firstWhere((e) => e.text == text, orElse: () => TemperatureUnit.auto);
  }
}

extension AirVolumeExt on AirVolume {
  String get text {
    switch (this) {
      case AirVolume.auto:
        return 'auto';
      case AirVolume.one:
        return '1';
      case AirVolume.two:
        return '2';
      case AirVolume.three:
        return '3';
      case AirVolume.four:
        return '4';
      case AirVolume.five:
        return '5';
      case AirVolume.six:
        return '6';
      case AirVolume.seven:
        return '7';
      case AirVolume.eight:
        return '8';
      case AirVolume.nine:
        return '9';
      case AirVolume.ten:
        return '10';
    }
  }

  static AirVolume fromString(String text) {
    return AirVolume.values
        .firstWhere((e) => e.text == text, orElse: () => AirVolume.auto);
  }
}

extension AirDirectionExt on AirDirection {
  String get text {
    switch (this) {
      case AirDirection.auto:
        return '';
    }
  }

  static AirDirection fromString(String text) {
    return AirDirection.values.firstWhere((e) => e.text == text);
  }
}
