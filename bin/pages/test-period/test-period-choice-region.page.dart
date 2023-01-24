import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';
import 'test-period-choice-os.page.dart';

late final testPeriodChoiceRegion = MyGigaPage(
  text: MyGigaText.string('''Какой регион желаете?'''),
  renderMethod: MyGigaPage.edit,
);

void testPeriodChoiceRegionKeyboard() {
  testPeriodChoiceRegion.changeKeyboard(
    MyGigaKeybord.list([
      [MyGigaButton.openPage(text: 'Россия', key: testPeriodChoiceOs.getKey())],
      [MyGigaButton.openPage(text: 'Назад', key: mainMenu.getKey())]
    ]),
  );
}
