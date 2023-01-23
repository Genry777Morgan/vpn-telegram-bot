import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:teledart/teledart.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_telegram_bot/loger.dart';
import '../configurations.dart';

import 'controller_interface.dart';

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router
      ..post('/testSubscribe', _testSubscribe)
      ..get('/iokassa/<userId>/<messageId>', _iokassa);
    return this;
  }

  Future<Response> _testSubscribe(Request req) async {
    var body = await req.readAsString();
    var postData = jsonDecode(body);

    final teleDart = GetIt.I<TeleDart>();

    teleDart.sendMessage(postData["User"]['id'], 'test notify');

    return Response.ok('Notified');
  }

  Future<Response> _iokassa(
      Request req, String userId, String messageId) async {
    var body = await req.readAsString();
    Loger.log('iokassa', body: 'userId: $userId');

    final teleDart = GetIt.I<TeleDart>();

    teleDart.editMessageText('thanks for money',
        message_id: int.parse(messageId), chat_id: userId);

    var response = await http.patch(
        Uri.http(Configurations.backendHost, "/users/$userId/balance/1"));
    Loger.log('iokassa event',
        userId: userId, body: 'balance request: $response');
    return Response.ok('Notified');
  }
}
