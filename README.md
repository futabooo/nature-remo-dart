# Nature Remo API Client for Dart
![Dart CI](https://github.com/futabooo/nature-remo-dart/workflows/Dart%20CI/badge.svg)
![Pub Version](https://img.shields.io/pub/v/nature_remo)


## Usage

see [example](https://github.com/futabooo/nature-remo-dart/tree/main/example).

```dart
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
```

## Supported API

### Cloud API

http://swagger.nature.global

|     Status       |                 Endpoint                | HTTP Method |
|:----------------:|-----------------------------------------|:-----------:|
|:heavy_check_mark:|/1/users/me                              | GET         |
|:heavy_check_mark:|/1/users/me                              | POST        |
|:heavy_check_mark:|/1/devices                               | GET         |
|:heavy_check_mark:|/1/devices/{device}                      | POST        |
|:heavy_check_mark:|/1/devices/{device}/delete               | POST        |
|:heavy_check_mark:|/1/devices/{device}/temperature_offset   | POST        |
|:heavy_check_mark:|/1/devices/{device}/humidity_offset      | POST        |
|:heavy_check_mark:|/1/detectappliance                       | POST        |
|:heavy_check_mark:|/1/appliances                            | GET         |
|:heavy_check_mark:|/1/appliances                            | POST        |
|:heavy_check_mark:|/1/appliance_orders                      | POST        |
|:heavy_check_mark:|/1/appliances/{appliance}/delete         | POST        |
|:heavy_check_mark:|/1/appliances/{appliance}                | POST        |
|:heavy_check_mark:|/1/appliances/{appliance}/aircon_settings| POST        |
|:heavy_check_mark:|/1/appliances/{appliance}/tv             | POST        |
|:heavy_check_mark:|/1/appliances/{appliance}/light          | POST        |
|:heavy_check_mark:|/1/appliances/{appliance}/signals        | GET         |
|:heavy_check_mark:|/1/appliances/{appliance}/signals        | POST        |
|:heavy_check_mark:|/1/appliances/{appliance}/signal_orders  | POST        |
|:heavy_check_mark:|/1/signals/{signal}                      | POST        |
|:heavy_check_mark:|/1/signals/{signal}/delete               | POST        |
|:heavy_check_mark:|/1/signals/{signal}/send                 | POST        |

### Local API

http://local.swagger.nature.global/

|     Status       |Endpoint | HTTP Method |
|:----------------:|---------|:-----------:|
|:heavy_check_mark:|/messages| GET         |
|:heavy_check_mark:|/messages| POST        |

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/futabooo/nature-remo-dart/issues