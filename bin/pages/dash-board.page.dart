import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/loger.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'main.page.dart';
import 'system/empty.page.dart';
import 'test-period/test-period-instruction.page.dart';

late final dashBoardText = MyGigaText.function((pageMessage, user) async {
  var response =
      await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

  var responseBody = jsonDecode(response.body);
  final username = responseBody['username'];
  final balance = responseBody['balance'];

  return '''$username, это Ваш личный кабинет.
Баланс: $balance''';
});

late final dashBoard = MyGigaPage(
  text: dashBoardText,
  renderMethod: MyGigaPage.edit,
);

final respawnInstruction = MyGigaPage(
  name: 'main-menu',
  text: dashBoardText,
  renderMethod: ((teleDart, message, user, text, markup) async {
    var teledart = GetIt.I<TeleDart>(); // TODO
    await teledart.deleteMessage(message.chat.id, message.message_id);
    await testPeriodInstructionSend.render(message, user);

    MyGigaPage.send(teleDart, message, user, text, markup);
  }),
);

final respawnConfix = MyGigaPage(
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

      await MyGigaPage.sendPhoto(teleDart, message.chat.id, photo);
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

      await MyGigaPage.sendFile(teleDart, message.chat.id, file);
    } catch (exception, stacktrace) {
      Loger.log('TestPeriodactivate',
          userId: user.id.toString(),
          body: '${exception.toString()}\n${stacktrace.toString()}');
    }

    MyGigaPage.send(teleDart, message, user, text, markup);
  }),
);

void dashBoardKeyboard() {
  var a = MyGigaKeybord.list([
    [
      MyGigaButton.openPage(text: 'Связаться с поддержкой', key: empty.getKey())
    ], // TODO
    [
      MyGigaButton.openPage(
          text: 'Сменить сервер VPNstera', key: empty.getKey())
    ], // TODO
    [
      MyGigaButton.openPage(
          text: 'Выслать инструкцию повторно', key: respawnInstruction.getKey())
    ], // TODO
    [
      MyGigaButton.openPage(
          text: 'Выслать конфиг повторно', key: respawnConfix.getKey())
    ],
    [MyGigaButton.openPage(text: 'Назад', key: mainMenu.getKey())]
  ]);

  dashBoard.changeKeyboard(a);
  respawnConfix.changeKeyboard(a);
  respawnInstruction.changeKeyboard(a);
}
