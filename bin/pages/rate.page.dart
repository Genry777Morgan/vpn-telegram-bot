import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'main.page.dart';
import 'pay.page.dart';

var rate = MyGigaPage(
  text: MyGigaText.function((pageMessage, user) async {
    var response =
        await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

    var responseBody = jsonDecode(response.body);
    final balance = responseBody['balance'];
    return 'Ваш баланс $balance денег';
  }),
  renderMethod: MyGigaPage.edit,
  keyboard: MyGigaKeybord.list([
    [MyGigaButton.openPage(text: '1 день', page: payFor1Day)],
    [MyGigaButton.openPage(text: '1 неделя', page: payFor1Week)],
    [MyGigaButton.openPage(text: '1 месяц', page: payFor1Month)],
    [MyGigaButton.openPage(text: '1 год', page: payFor1Year)],
    [MyGigaButton.openPage(text: 'Назад', page: mainMenu)]
  ]),
);
