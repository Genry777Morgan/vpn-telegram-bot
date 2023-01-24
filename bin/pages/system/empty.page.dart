import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';

late final MyGigaPage empty = MyGigaPage(
  text: MyGigaText.string('Эта страница находиться в разработке'),
  renderMethod: MyGigaPage.edit,
);

void emptyKeyboard() {
  empty.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'Ок', key: mainMenu.getKey())]
  ]));
}
