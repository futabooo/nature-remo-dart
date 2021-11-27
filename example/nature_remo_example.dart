import 'dart:io';

import 'package:nature_remo/nature_remo.dart';

void main() async {
  final accessToken = Platform.environment['NATUREREMO_ACCESS_TOKEN'];
  if (accessToken == null || accessToken.isEmpty) {
    throw Exception('Env: NATUREREMO_ACCESS_TOKEN does not exist');
  }

  final natureRemoClient = NatureRemoCloudApiClient(accessToken: accessToken);
  final me = await natureRemoClient.getMe();
  print('nickname=${me.nickname}');

  final updatedMe = await natureRemoClient.updateMe('updated');
  print('nickname=${updatedMe.nickname}');
}
