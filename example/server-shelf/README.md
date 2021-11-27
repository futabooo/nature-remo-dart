A server app built using [Shelf](https://pub.dev/packages/shelf),
configured to enable running with [Docker](https://www.docker.com/).

This sample code handles HTTP GET requests to `/` and `/echo/<message>`

# Running the sample

## Running with the Dart SDK

You can run the example with the [Dart SDK](https://dart.dev/get-dart)
like this:

```
$ NATURE_REMO_ACCESS_TOKEN=<Your Access Token> dart run bin/server.dart
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080/users/me
{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","nickname": "string"}
```

## Running with Docker

If you have [Docker Desktop](https://www.docker.com/get-started) installed, you
can build and run with the `docker` command:

```
$ docker build . -t nature-remo-server-shelf
$ docker run -it -p 8080:8080 -e NATURE_REMO_ACCESS_TOKEN=<Your Access Token> nature-remo-server-shelf
Server listening on port 8080
```

And then from a second terminal:
```
$ curl http://0.0.0.0:8080/users/me
{"id":"3fa85f64-5717-4562-b3fc-2c963f66afa6","nickname": "string"}
```

You should see the logging printed in the first terminal:
```
2021-11-27T23:27:16.008387  0:00:00.760751 GET     [200] /users/me
```
