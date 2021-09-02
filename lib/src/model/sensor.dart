typedef SensorType = String;

const SensorType temperature = 'te';
const SensorType humidity = 'hu';
const SensorType illumination = 'il';
const SensorType movement = 'mo';

class SensorValue {
  final double value;
  final DateTime createdAt;

  SensorValue({
    required this.value,
    required this.createdAt,
  });

  factory SensorValue.fromJson(Map<String, dynamic> json) {
    return SensorValue(
      value: json['val'] + .0, // set to float even with int value
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'val': value,
      'created_at': createdAt.toString(),
    };
  }
}
