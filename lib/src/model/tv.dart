import 'package:nature_remo/src/model/button.dart';

class Tv {
  final TvState state;
  final List<Button> buttons;

  Tv({
    required this.state,
    required this.buttons,
  });

  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
      state: TvState.fromJson(json['state']),
      buttons: List<Button>.from(
          (json['buttons'] as Iterable).map((e) => Button.fromJson(e))),
    );
  }
}

class TvState {
  final TvInputType inputType;

  TvState({required this.inputType});

  factory TvState.fromJson(Map<String, dynamic> json) {
    return TvState(inputType: TvInputTypeExt.fromString(json['input']));
  }
}

enum TvInputType { t, bs, cs }

extension TvInputTypeExt on TvInputType {
  String get text => toString().split('.').last;

  static TvInputType fromString(String text) {
    return TvInputType.values.firstWhere((e) => e.text == text);
  }
}
