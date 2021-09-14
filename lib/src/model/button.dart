import 'package:nature_remo/src/model/image.dart';

class Button {
  final String name;
  final Image image;
  final String label;

  Button({
    required this.name,
    required this.image,
    required this.label,
  });

  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      name: json['name'],
      image: json['image'],
      label: json['label'],
    );
  }
}
