import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';

late final Page empty = Page(
  text: Text.string('Эта страница находиться в разработке'),
  renderMethod: Page.edit,
);

void emptyKeyboard() {
  empty.changeKeyboard(Keyboard.list([
    [Button.openPage(text: 'Ок', key: mainMenu.getKey())]
  ]));
}
