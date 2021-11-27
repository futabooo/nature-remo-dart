import 'dart:convert';
import 'dart:io';

import 'package:nature_remo/nature_remo.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

void main(List<String> args) async {
  final accessToken = Platform.environment['NATURE_REMO_ACCESS_TOKEN'];
  if (accessToken == null || accessToken.isEmpty) {
    throw Exception('Env: NATURE_REMO_ACCESS_TOKEN does not exist');
  }

  final natureRemoCloudApiClient = NatureRemoCloudApiClient(accessToken: accessToken);
  Future<Response> _usersHandler(Request request) async {
    final user = await natureRemoCloudApiClient.getMe();
    return Response.ok(
      jsonEncode(user),
      headers: {
        'content-type': 'application/json',
      },
    );
  }

  final _router = Router()..get('/users/me', _usersHandler);
  final _handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);
  print('Server listening on port ${server.port}');
}
