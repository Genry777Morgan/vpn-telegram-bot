import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';
import 'test-period-choice-os.page.dart';

var testPeriodInstruction = MyGigaPage(
    text: MyGigaText.string(
        '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'''),
    renderMethod: MyGigaPage.edit,
    keyboard: MyGigaKeybord.list([
      [MyGigaButton.openPage(text: 'Активировать', page: testPeriodActivate)],
      [MyGigaButton.openPage(text: 'Назад', page: testPeriodChoiceOs)]
    ]));
