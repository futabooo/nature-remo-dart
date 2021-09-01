import 'package:nature_remo/nature_remo.dart';
import 'package:nature_remo/src/client.dart';

void main() async {
  final accessToken = '';
  final natureRemoClient = Client(accessToken: accessToken);
  final response = await natureRemoClient.getMe();
  print('id=${response.id}  nickname=${response.nickname}');

  final response2 = await natureRemoClient.updateMe('updated');
  print('id=${response2.id}  nickname=${response2.nickname}');
}
