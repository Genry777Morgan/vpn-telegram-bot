import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/keyboard.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/text.hectic-tg.dart';

import '../main.page.dart';
import 'choice-region.page.dart';

late final instruction = Page(
  text: Text.string('''Инструкция по подключению к VPNster

Представьте, что здесь висит ролик на ютуб с видеоинструкцией, а пока текстовое описание такое:

Шаг 1. Скачайте WireGuard;
Шаг 2. Отсканируйте QR код или загрузите файл с конфигурацией из бота в ваш WireGuard;
Шаг 3. Наслаждайтесь вашим VPNster.'''),
  renderMethod: Page.send,
);

void testPeriodInstructionKeyboard() {
  instruction.changeKeyboard(
    Keyboard.list([]),
  );
}
