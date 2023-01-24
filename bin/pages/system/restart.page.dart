import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';

late final MyGigaPage restart = MyGigaPage(
  text: MyGigaText.string(
      'Из за технических работ бот был перезапущен, вас вернёт в главное меню'),
  renderMethod: MyGigaPage.edit,
);

void restartKeyboard() {
  restart.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'Ок', key: mainMenu.getKey())]
  ]));
}
