import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/loger.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../configurations.dart';
import 'dash-board.page.dart';
import 'rate.page.dart';
import 'test-period/test-period-choice-region.page.dart';

final mainMenuText = Text.string('''Привет!
VPNster в телеграм!
Простой в использовании VPN сервис.''');

final startMenu = Page.withoutRegistration(
  name: 'main-menu',
  text: mainMenuText,
  renderMethod: (teleDart, pageMessage, user, text, markup) async {
    var response = await post(Uri.http(Configurations.backendHost, "/users"),
        body: jsonEncode({
          "telegramId": user.id.toString(),
          "username": user.username,
          "regionId": '4f4abb0b-063b-4a91-b944-acfbf68c3a1b'
        }));

    Loger.log('main-menu',
        userId: user.id.toString(),
        body: '/users status: ${response.statusCode}');

    Page.send(teleDart, pageMessage, user, text, markup);
  },
);

final mainMenu = Page(
  name: 'main-menu',
  text: mainMenuText,
  renderMethod: Page.edit,
);

final testPeriodActivate = Page(
  name: 'main-menu',
  text: mainMenuText,
  renderMethod: ((teleDart, message, user, text, markup) async {
    var response = await patch(Uri.http(
        Configurations.backendHost, "/users/${user.id}/useFreePeriod"));

    var teledart = GetIt.I<TeleDart>(); // TODO
    await teledart.editMessageReplyMarkup(
        chat_id: message.chat.id,
        message_id: message.message_id,
        reply_markup: null);

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

final mainMenuFirsTry = [
  [Button.openPage(text: 'Получить ВПН', key: testPeriodChoiceRegion.getKey())],
  [Button.openPage(text: 'Тарифы', key: rate.getKey())],
  [
    Button.openPage(text: 'Личный кабинет', key: dashBoard.getKey()),
  ]
];

final mainMenuUsualEntry = [
  [Button.openPage(text: 'Тарифы', key: rate.getKey())],
  [Button.openPage(text: 'Личный кабинет', key: dashBoard.getKey())]
];

late final mainMenuKeyboard = Keyboard.function(((pageMessage, user) async {
  var response =
      await get(Uri.http(Configurations.backendHost, "/users/${user.id}"));

  var responseBody = jsonDecode(response.body);
  final freePeriodUsed = responseBody['freePeriodUsed'].toString();

  return freePeriodUsed == 'true' ? mainMenuUsualEntry : mainMenuFirsTry;
}));

void mainKeyboard() {
  startMenu.changeKeyboard(mainMenuKeyboard);
  mainMenu.changeKeyboard(mainMenuKeyboard);
  testPeriodActivate.changeKeyboard(Keyboard.list(mainMenuUsualEntry));
}
