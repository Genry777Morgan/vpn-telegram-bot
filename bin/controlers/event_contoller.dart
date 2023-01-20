import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/base-page.dart';

import 'controller_interface.dart';

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router
      ..post('/testSubscribe', _testSubscribe)
      ..post('/iokassa/<userId>', _iokassa);
    return this;
  }

  Future<Response> _testSubscribe(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);

    final page = Page(
        text: MyGigaText.string(
            'A ya yasnie dni provoju взламывая твою жопу лошпедюк'));
    final teleDart = GetIt.I<TeleDart>();

    teleDart.sendMessage(postData["User"]['id'], 'event');

    return Response.ok('Notified');
  }

  Future<Response> _iokassa(Request req, String userId) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);
    JustGay.loger('iokassa', body: postData);

    final teleDart = GetIt.I<TeleDart>();

    teleDart.sendMessage(userId, 'thanks for money');

    return Response.ok('Notified');
  }
}
