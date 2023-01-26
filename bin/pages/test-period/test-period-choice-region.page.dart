import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../../configurations.dart';
import '../main.page.dart';
import 'test-period-instruction.page.dart';

late final testPeriodChoiceRegion = Page(
  text: Text.string('''Какой регион желаете?'''),
  renderMethod: Page.edit,
);

void testPeriodChoiceRegionKeyboard() {
  testPeriodChoiceRegion.changeKeyboard(
    Keyboard.function((pageMessage, user) async {
      var response =
          await get(Uri.http(Configurations.backendHost, "/regions"));

      var responseBody = jsonDecode(response.body);
      List<List<Button>> arr = [];
      for (var i in responseBody) {
        arr.add([
          Button.openPage(
              text: (i['regionName'] == 'russia' ? 'Русский' : 'Германия'),
              key: testPeriodInstruction.getKey())
        ]);
      }
      arr.add([Button.openPage(text: 'Назад', key: mainMenu.getKey())]);

      return arr;
    }),
  );
}
