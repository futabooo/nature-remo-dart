import 'package:nature_remo/src/model/aircon.dart';
import 'package:nature_remo/src/model/appliance.dart';

class ApplianceModelAndParam {
  final ApplianceModel model;
  final AirConSetting params;

  ApplianceModelAndParam({
    required this.model,
    required this.params,
  });

  factory ApplianceModelAndParam.fromJson(Map<String, dynamic> json) {
    return ApplianceModelAndParam(
      model: ApplianceModel.fromJson(json['model']),
      params: AirConSetting.fromJson(json['params']),
    );
  }
}
