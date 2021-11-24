# Nature Remo API Client for Dart

## Usage

```dart
import 'dart:io';

import 'package:nature_remo/nature_remo.dart';

void main() async {
  final accessToken = Platform.environment['NATUREREMO_ACCESS_TOKEN'];
  if (accessToken == null || accessToken.isEmpty) {
    throw Exception('Env: NATUREREMO_ACCESS_TOKEN does not exist');
  }

  final natureRemoClient = Client(accessToken: accessToken);
  final me = await natureRemoClient.getMe();
  print('nickname=${me.nickname}');

  final updatedMe = await natureRemoClient.updateMe('updated');
  print('nickname=${updatedMe.nickname}');
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

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/futabooo/nature-remo-dart/issues