class SmartMeter {
  final List<EchonetLiteProperty> echonetLiteProperties;

  SmartMeter({required this.echonetLiteProperties});

  factory SmartMeter.fromJson(Map<String, dynamic> json) {
    return SmartMeter(
        echonetLiteProperties: List<EchonetLiteProperty>.from(
            (json['echonetlite_properties'] as Iterable)
                .map((e) => EchonetLiteProperty.fromJson(e))));
  }
}

class EchonetLiteProperty {
  final String name;
  final int epc;
  final String val;
  final DateTime updatedAt;

  EchonetLiteProperty({
    required this.name,
    required this.epc,
    required this.val,
    required this.updatedAt,
  });

  factory EchonetLiteProperty.fromJson(Map<String, dynamic> json) {
    return EchonetLiteProperty(
      name: json['name'] as String,
      epc: json['epc'] as int,
      val: json['val'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }
}
