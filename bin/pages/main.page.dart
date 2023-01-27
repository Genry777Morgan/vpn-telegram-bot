import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/loger.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/text.hectic-tg.dart';

import '../configurations.dart';
import '../variables.dart';
import 'dash-board.page.dart';
import 'rate.page.dart';
import 'region/choice-region.page.dart';
import 'region/instruction.message.dart';
import 'test-period/test-period.action.dart';
import 'test-period/test-period.message.dart';

final path = 'main';
final mainMenuText =
    Text.string(dialogDataSource.getMessage(path, LayoutEnum.ru));

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

final mainMenuEdit = Page(
  name: 'main-menu',
  text: mainMenuText,
  renderMethod: Page.edit,
);

final mainMenuSend =
    Page(name: 'main-menu', text: mainMenuText, renderMethod: Page.send);

final mainMenuFirsTry = [
  [
    Button.openPage(
        text: dialogDataSource.getButtonText(path, 'get-vpn', LayoutEnum.ru),
        key: testPeriodAction.getKey())
  ],
  [
    Button.openPage(
        text: dialogDataSource.getButtonText(path, 'rates', LayoutEnum.ru),
        key: rate.getKey())
  ],
  [
    Button.openPage(
        text: dialogDataSource.getButtonText(path, 'dash-board', LayoutEnum.ru),
        key: dashBoard.getKey()),
  ]
];

final mainMenuUsualEntry = [
  [
    Button.openPage(
        text: dialogDataSource.getButtonText(path, 'rates', LayoutEnum.ru),
        key: rate.getKey())
  ],
  [
    Button.openPage(
        text: dialogDataSource.getButtonText(path, 'dash-board', LayoutEnum.ru),
        key: dashBoard.getKey())
  ]
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
  mainMenuEdit.changeKeyboard(mainMenuKeyboard);
  mainMenuSend.changeKeyboard(mainMenuKeyboard);
}
