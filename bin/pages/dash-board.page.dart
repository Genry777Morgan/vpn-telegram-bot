import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'main.page.dart';

var dashBoard = MyGigaPage(
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
  keyboard: MyGigaKeybord.list([
    [
      MyGigaButton.openPage(text: 'Связаться с поддержкой', page: mainMenu)
    ], // TODO
    [
      MyGigaButton.openPage(text: 'Сменить сервер VPNstera', page: mainMenu)
    ], // TODO
    [
      MyGigaButton.openPage(text: 'Выслать конфиг повторно', page: mainMenu)
    ], // TODO
    [MyGigaButton.openPage(text: 'Назад', page: mainMenu)]
  ]),
);
