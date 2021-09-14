import 'package:nature_remo/src/model/button.dart';

class Light {
  final LightState state;
  final List<Button> buttons;

  Light({
    required this.state,
    required this.buttons,
  });

  factory Light.fromJson(Map<String, dynamic> json) {
    return Light(
      state: LightState.fromJson(json['state']),
      buttons: List<Button>.from((json['buttons'] as Iterable).map((e) => Button.fromJson(e))),
    );
  }
}

class LightState {
  final String brightness;
  final Power power;
  final String lastButton;

  LightState({
    required this.brightness,
    required this.power,
    required this.lastButton,
  });

  factory LightState.fromJson(Map<String, dynamic> json) {
    return LightState(
      brightness: json['brightness'] as String,
      power: PowerExt.fromString(json['power'] as String),
      lastButton: json['last_button'] as String,
    );
  }
}

enum Power { on, off }

extension PowerExt on Power {
  String get text => toString().split('.').last;
  static Power fromString(String text) {
    return Power.values.firstWhere((e) => e.text == text);
  }
}
