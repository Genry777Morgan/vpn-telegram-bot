import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';

import 'controller_interface.dart';

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router.post('/testSubscribe', _testSubscribe);
    return this;
  }

  Future<Response> _testSubscribe(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    print(postData);
    return Response.ok('Notified');
  }
}
