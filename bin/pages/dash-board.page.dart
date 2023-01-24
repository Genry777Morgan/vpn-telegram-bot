import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'main.page.dart';

late final dashBoard = MyGigaPage(
  text: MyGigaText.function((pageMessage, user) async {
    var response =
        await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

    var responseBody = jsonDecode(response.body);
    final username = responseBody['username'];
    final balance = responseBody['balance'];

    return '''$username, это Ваш личный кабинет.
Баланс: $balance''';
  }),
  renderMethod: MyGigaPage.edit,
);

void dashBoardKeyboard() {
  dashBoard.changeKeyboard(
    MyGigaKeybord.list([
      [
        MyGigaButton.openPage(
            text: 'Связаться с поддержкой', key: mainMenu.getKey())
      ], // TODO
      [
        MyGigaButton.openPage(
            text: 'Сменить сервер VPNstera', key: mainMenu.getKey())
      ], // TODO
      [
        MyGigaButton.openPage(
            text: 'Выслать конфиг повторно', key: mainMenu.getKey())
      ], // TODO
      [MyGigaButton.openPage(text: 'Назад', key: mainMenu.getKey())]
    ]),
  );
}
