import 'package:serverpod/serverpod.dart';

class ExampleEndpoint extends Endpoint {
  Future<String> greet(Session session, String name) async {
    return 'Hello, $name.';
  }

  Future<String> abuse(Session session, String name) async {
    return 'Fuck you, $name.';
  }
   Future<String> love(Session session, String name) async {
    return 'Love you, $name.';
  }
}
