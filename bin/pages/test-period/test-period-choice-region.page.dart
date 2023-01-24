import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../../configurations.dart';
import '../main.page.dart';
import 'test-period-instruction.page.dart';

late final testPeriodChoiceRegion = MyGigaPage(
  text: MyGigaText.string('''Какой регион желаете?'''),
  renderMethod: MyGigaPage.edit,
);

void testPeriodChoiceRegionKeyboard() {
  testPeriodChoiceRegion.changeKeyboard(
    MyGigaKeybord.function((pageMessage, user) async {
      var response =
          await get(Uri.http(Configurations.backendHost, "/regions"));

      var responseBody = jsonDecode(response.body);
      List<List<MyGigaButton>> arr = [];
      for (var i in responseBody) {
        arr.add([
          MyGigaButton.openPage(
              text: (i['regionName'] == 'russia' ? 'Русский' : 'Германия'),
              key: testPeriodInstruction.getKey())
        ]);
      }
      arr.add([MyGigaButton.openPage(text: 'Назад', key: mainMenu.getKey())]);

      return arr;
    }),
  );
}
