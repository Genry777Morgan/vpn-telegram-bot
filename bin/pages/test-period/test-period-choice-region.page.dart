import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';
import 'test-period-choice-os.page.dart';

var testPeriodChoiceRegion = MyGigaPage(
    text: MyGigaText.string('''Какой регион желаете?'''),
    renderMethod: MyGigaPage.edit,
    keyboard: MyGigaKeybord.list([
      [MyGigaButton.openPage(text: 'Россия', page: testPeriodChoiceOs)],
      [MyGigaButton.openPage(text: 'Назад', page: mainMenu)]
    ]));
