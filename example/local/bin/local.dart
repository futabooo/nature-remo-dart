import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:multicast_dns/multicast_dns.dart';
import 'package:nature_remo/nature_remo.dart';

Future<void> main(List<String> arguments) async {
  exitCode = 0; // presume success
  final runner = CommandRunner(
    'nature_remo',
    'A Nature Remo Local API Client that uses Nature API 1.0.0.',
  )
    ..addCommand(FetchCommand())
    ..addCommand(EmitCommand());

  runner.run(arguments).catchError((error) {
    print(error);
    exitCode = 2;
  });
}

class FetchCommand extends Command with RemoFinder {
  @override
  final name = 'fetch';

  @override
  final description = 'Fetch the newest received IR signal';

  FetchCommand() {}

  @override
  void run() async {
    final address = await searchNatureRemo();
    if (address == null) {
      stderr.write('Nature Remo is not found');
      exitCode = 2;
      return;
    }
    print(address);
    final client = NatureRemoLocalApiClient(address: address);
    final infraredSignal = await client.getMessages();
    print('newest received IR signal ${infraredSignal.toJson()}');
    exitCode = 1;
  }
}

class EmitCommand extends Command with RemoFinder {
  @override
  String get description => 'emit';

  @override
  String get name => 'Emit IR signals provided by request body';

  EmitCommand() {
    argParser.addOption('signal', abbr: 's', help: 'Infrared Signal');
  }
  @override
  void run() async {
    final args = argResults;
    if (args == null) {
      stderr.write('signal option is required');
      exitCode = 2;
      return;
    }
    final infraredSignal = args['signal'];
    final address = await searchNatureRemo();
    if (address == null) {
      stderr.write('Nature Remo is not found');
      exitCode = 2;
      return;
    }
    final client = NatureRemoLocalApiClient(address: address);
    client.postMessages(infraredSignal: infraredSignal);
    exitCode = 1;
  }
}

mixin RemoFinder {
  Future<String?> searchNatureRemo() async {
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
      await for (final SrvResourceRecord srv
          in client.lookup<SrvResourceRecord>(
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
    return address;
  }
}
