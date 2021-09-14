import 'package:nature_remo/src/model/image.dart';

class Signal {
  final String id;
  final String name;
  final Image image;

  Signal({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Signal.fromJson(Map<String, dynamic> json) {
    return Signal(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
