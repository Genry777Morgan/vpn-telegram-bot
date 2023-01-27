import 'dart:convert';

import 'package:http/http.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/text.hectic-tg.dart';

import '../../configurations.dart';
import '../main.page.dart';
import 'change-region.action.dart';
import 'instruction.message.dart';

late final regionChoiceEdit = Page(
  text: Text.string('''Какой регион желаете?'''),
  renderMethod: Page.edit,
);

late final regionChoiceReplace = Page(
  text: Text.string('''Какой регион желаете?'''),
  renderMethod: (teleDart, message, user, text, markup) async {
    Page.replase(teleDart, message.chat.id, text, markup, message.message_id);
  },
);

void testPeriodChoiceRegionKeyboard() {
  var keyboard = Keyboard.function((pageMessage, user) async {
    var response = await get(Uri.http(Configurations.backendHost, "/regions"));

    var responseBody = jsonDecode(response.body);
    List<List<Button>> arr = [];
    for (var i in responseBody) {
      arr.add([
        Button.openPage(
            text: (i['regionName'] == 'russia' ? 'Русский' : 'Германия'),
            key: (i['regionName'] == 'russia'
                ? changeRegionRussia.getKey()
                : changeRegionGermany.getKey()))
      ]);
    }
    arr.add([Button.openPage(text: 'Назад', key: mainMenuEdit.getKey())]);

    return arr;
  });
  regionChoiceEdit.changeKeyboard(keyboard);
  regionChoiceReplace.changeKeyboard(keyboard);
}
