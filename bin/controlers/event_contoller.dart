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
    router.post('/testSubscribe', _testSubscribe);
    return this;
  }

  Future<Response> _testSubscribe(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);

    final page = Page(text: MyGigaText.string('Molodez'));
    final teleDart = GetIt.I<TeleDart>();

    teleDart.sendMessage(postData['telegramId'], 'molodez');

    return Response.ok('Notified');
  }
}
