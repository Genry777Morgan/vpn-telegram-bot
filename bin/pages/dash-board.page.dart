import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/loger.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/text.hectic-tg.dart';

import '../configurations.dart';
import 'main.page.dart';
import 'system/empty.page.dart';
import 'region/instruction.message.dart';

late final dashBoardText = Text.function((pageMessage, user) async {
  var response =
      await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

  var responseBody = jsonDecode(response.body);
  final username = responseBody['username'];
  final balance = responseBody['balance'];

  return '''$username, это Ваш личный кабинет.
Баланс: $balance''';
});

late final dashBoard = Page(
  text: dashBoardText,
  renderMethod: Page.edit,
);

final respawnInstruction = Page(
  name: 'main-menu',
  text: dashBoardText,
  renderMethod: ((teleDart, message, user, text, markup) async {
    var teledart = GetIt.I<TeleDart>(); // TODO
    await teledart.deleteMessage(message.chat.id, message.message_id);
    await instruction.render(message, user);

    Page.send(teleDart, message, user, text, markup);
  }),
);

final respawnConfix = Page(
  name: 'main-menu',
  text: dashBoardText,
  renderMethod: ((teleDart, message, user, text, markup) async {
    var response = await patch(Uri.http(
        Configurations.backendHost, "/users/${user.id}/useFreePeriod"));

    var teledart = GetIt.I<TeleDart>(); // TODO
    await teledart.editMessageReplyMarkup(
        chat_id: message.chat.id,
        message_id: message.message_id,
        reply_markup: null);

    await teledart.deleteMessage(message.chat.id, message.message_id);

    try {
      response = await get(
          Uri.http(Configurations.backendHost, "/users/${user.id}/qrCode"));

      final photo = File('qr.png');
      photo.writeAsBytesSync(response.body.codeUnits);

      await Page.sendPhoto(teleDart, message.chat.id, photo);
    } catch (exception, stacktrace) {
      Loger.log('TestPeriodactivate',
          userId: user.id.toString(),
          body: '${exception.toString()}\n${stacktrace.toString()}');
    }

    try {
      response = await get(
          Uri.http(Configurations.backendHost, "/users/${user.id}/config"));

      var configFileBody = jsonDecode(response.body)['configFile'];

      final file = File('config.conf');
      file.writeAsStringSync(configFileBody);

      await Page.sendFile(teleDart, message.chat.id, file);
    } catch (exception, stacktrace) {
      Loger.log('TestPeriodactivate',
          userId: user.id.toString(),
          body: '${exception.toString()}\n${stacktrace.toString()}');
    }

    Page.send(teleDart, message, user, text, markup);
  }),
);

void dashBoardKeyboard() {
  var a = Keyboard.list([
    [
      Button.openPage(text: 'Связаться с поддержкой', key: empty.getKey())
    ], // TODO
    [
      Button.openPage(text: 'Сменить сервер VPNstera', key: empty.getKey())
    ], // TODO
    [
      Button.openPage(
          text: 'Выслать инструкцию повторно', key: respawnInstruction.getKey())
    ], // TODO
    [
      Button.openPage(
          text: 'Выслать конфиг повторно', key: respawnConfix.getKey())
    ],
    [Button.openPage(text: 'Назад', key: mainMenuEdit.getKey())]
  ]);

  dashBoard.changeKeyboard(a);
  respawnConfix.changeKeyboard(a);
  respawnInstruction.changeKeyboard(a);
}
