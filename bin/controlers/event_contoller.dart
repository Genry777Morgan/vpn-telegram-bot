import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:shelf/shelf.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_telegram_bot/loger.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';
import '../configurations.dart';

import '../pages/main.page.dart';
import 'controller_interface.dart';

class EventController extends IController {
  EventController({required super.router});

  @override
  EventController addHandlers() {
    router
      ..post('/testSubscribe', _testSubscribe)
      ..get('/iokassa/<userId>/<messageId>/<days>', _iokassa);
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
      Request req, String userId, String messageId, String days) async {
    var body = await req.readAsString();
    Loger.log('iokassa', body: 'userId: $userId');

    final teleDart = GetIt.I<TeleDart>();

    // var keyboard = MyGigaKeybord.list([
    //   [MyGigaButton.openPage(text: 'Ок', key: mainMenu.getKey())]
    // ]);

    teleDart.editMessageText('Успешная оплата',
        message_id: int.parse(messageId),
        chat_id: userId,
        reply_markup: InlineKeyboardMarkup(inline_keyboard: [
          [InlineKeyboardButton(text: 'Ок', callback_data: mainMenu.getKey())]
        ]));

    // MyGigaPage(
    //   text: MyGigaText.string('спасибо за оплату'),
    //   renderMethod:
    // );

    var response = await http.patch(Uri.http(
        Configurations.backendHost, "/users/$userId/addToBalance/$days"));
    Loger.log('iokassa event',
        userId: userId, body: 'balance request: $response');
    return Response.ok('Notified');
  }
}
