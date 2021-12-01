import 'package:multicast_dns/multicast_dns.dart';
import 'package:nature_remo/nature_remo.dart';

Future<void> main(List<String> arguments) async {
  const String serviceType = '_remo._tcp';
  late String target;
  late String address;

  final MDnsClient client = MDnsClient();
  await client.start();

  await for (final PtrResourceRecord ptr in client.lookup<PtrResourceRecord>(
      ResourceRecordQuery.serverPointer(serviceType))) {
    // Use the domainName from the PTR record to get the SRV record,
    // which will have the port and local hostname.
    // Note that duplicate messages may come through, especially if any
    // other mDNS queries are running elsewhere on the machine.
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      print('target instance is${srv.target}');
      target = srv.target;
    }
  }

  await for (final IPAddressResourceRecord record
      in client.lookup<IPAddressResourceRecord>(
          ResourceRecordQuery.addressIPv4(target))) {
    print('Found address (${record.address}).');
    address = record.address.address;
  }
  client.stop();

  final localApiClient = NatureRemoLocalApiClient(address: address);
  final infraredSignal = await localApiClient.getMessages();
  print('newest received IR signal ${infraredSignal.toJson()}');
}
