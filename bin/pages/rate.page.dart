import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'main.page.dart';
import 'pay.page.dart';

late final rate = MyGigaPage(
  text: MyGigaText.function((pageMessage, user) async {
    var response =
        await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

    var responseBody = jsonDecode(response.body);
    final balance = responseBody['balance'];
    return 'Ваш баланс $balance денег';
  }),
  renderMethod: MyGigaPage.edit,
);

void rateKeyboard() {
  rate.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: '1 день', key: payFor1Day.getKey())],
    [MyGigaButton.openPage(text: '1 неделя', key: payFor1Week.getKey())],
    [MyGigaButton.openPage(text: '1 месяц', key: payFor1Month.getKey())],
    [MyGigaButton.openPage(text: '1 год', key: payFor1Year.getKey())],
    [MyGigaButton.openPage(text: 'Назад', key: mainMenu.getKey())]
  ]));
}
