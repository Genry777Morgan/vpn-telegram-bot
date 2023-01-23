import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/constants.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'main.page.dart';

var priceForDay = 10;

Future<Response> iokassaReques(int userId, int messageId, int price) async {
  var response =
      await post(Uri.https('api.yookassa.ru', "/v3/payments"), headers: {
    'Idempotence-Key': uuid.v1().toString(),
    'Content-Type': 'application/json',
    'Authorization':
        'Basic ${base64.encode(utf8.encode('606187:test_rfWl9R66FvKB3QyzwGlid8deH9YiPcReTgv3r-KFSsA'))}'
  }, body: '''{
          "amount": {
            "value": "100.00",
            "currency": "RUB"
          },
          "capture": true,
          "confirmation": {
            "type": "redirect",
            "return_url": "http://${Configurations.botHost}/iokassa/$userId/$messageId"
          },
          "description": "Оплата бота"
        }''');
  return response;
}

var payFor1Day = MyGigaPage(
  name: 'Страница оплаты на 1 день',
  text: MyGigaText.function((pageMessage, user) async {
    var days = 1;

    var responseBody = jsonDecode((await iokassaReques(
            user.id, pageMessage.message_id, days * priceForDay))
        .body);

    return 'Оплатите по сылке ${responseBody['confirmation']['confirmation_url']}';
  }),
  renderMethod: MyGigaPage.edit,
  keyboard: MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'В меню', page: mainMenu)]
  ]),
);

var payFor1Week = MyGigaPage(
  name: 'Страница оплаты на 1 неделя',
  text: MyGigaText.function((pageMessage, user) async {
    var days = 1;

    var responseBody = jsonDecode((await iokassaReques(
            user.id, pageMessage.message_id, days * priceForDay))
        .body);

    return 'Оплатите по сылке ${responseBody['confirmation']['confirmation_url']}';
  }),
  renderMethod: MyGigaPage.edit,
  keyboard: MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'В меню', page: mainMenu)]
  ]),
);

var payFor1Month = MyGigaPage(
  name: 'Страница оплаты на 1 месяц',
  text: MyGigaText.function((pageMessage, user) async {
    var days = 1;

    var responseBody = jsonDecode((await iokassaReques(
            user.id, pageMessage.message_id, days * priceForDay))
        .body);

    return 'Оплатите по сылке ${responseBody['confirmation']['confirmation_url']}';
  }),
  renderMethod: MyGigaPage.edit,
  keyboard: MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'В меню', page: mainMenu)]
  ]),
);

var payFor1Year = MyGigaPage(
  name: 'Страница оплаты на 1 год',
  text: MyGigaText.function((pageMessage, user) async {
    var days = 1;

    var responseBody = jsonDecode((await iokassaReques(
            user.id, pageMessage.message_id, days * priceForDay))
        .body);

    return 'Оплатите по сылке ${responseBody['confirmation']['confirmation_url']}';
  }),
  renderMethod: MyGigaPage.edit,
  keyboard: MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'В меню', page: mainMenu)]
  ]),
);
