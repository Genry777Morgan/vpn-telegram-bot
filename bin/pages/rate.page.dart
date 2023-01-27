import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/text.hectic-tg.dart';

import '../configurations.dart';
import 'main.page.dart';
import '../pay/pay-instruction.page.dart';

late final rate = Page(
  text: Text.function((pageMessage, user) async {
    var response =
        await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

    var responseBody = jsonDecode(response.body);
    final balance = responseBody['balance'];
    return 'Ваш баланс $balance денег';
  }),
  renderMethod: Page.edit,
);

void rateKeyboard() {
  rate.changeKeyboard(Keyboard.list([
    [Button.openPage(text: '1 день', key: payFor1Day.getKey())],
    [Button.openPage(text: '1 неделя', key: payFor1Week.getKey())],
    [Button.openPage(text: '1 месяц', key: payFor1Month.getKey())],
    [Button.openPage(text: '1 год', key: payFor1Year.getKey())],
    [Button.openPage(text: 'Назад', key: mainMenuEdit.getKey())]
  ]));
}
