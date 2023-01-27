import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/text.hectic-tg.dart';

import '../../variables.dart';
import '../main.page.dart';

final Page restart = Page(
  text: Text.string(dialogDataSource.getMessage(
      'system${dialogDataSource.separator}restart', LayoutEnum.ru)),
  renderMethod: Page.edit,
);

void restartKeyboard() {
  restart.changeKeyboard(Keyboard.list([
    [
      Button.openPage(
          text: dialogDataSource.getButtonText(
              'system${dialogDataSource.separator}restart',
              'ok',
              LayoutEnum.ru),
          key: mainMenuEdit.getKey())
    ]
  ]));
}
