class InfraredSignal {
  final int freq;
  final List<int> data;
  final String format;

  InfraredSignal({
    required this.freq,
    required this.data,
    required this.format,
  });

  factory InfraredSignal.fromJson(Map<String, dynamic> json) {
    return InfraredSignal(
      freq: json['freq'],
      data: json['data'],
      format: json['format'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'freq': freq,
      'data': data,
      'format': format,
    };
  }
}
