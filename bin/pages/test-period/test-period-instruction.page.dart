import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import '../main.page.dart';
import 'test-period-choice-os.page.dart';
import 'test-period-choice-region.page.dart';

late final testPeriodInstruction = MyGigaPage(
  text: MyGigaText.string('''Инструкция по подключению к VPNster

Представьте, что здесь висит ролик на ютуб с видеоинструкцией, а пока текстовое описание такое:

Шаг 1. Скачайте WireGuard;
Шаг 2. Отсканируйте QR код или загрузите файл с конфигурацией из бота в ваш WireGuard;
Шаг 3. Наслаждайтесь вашим VPNster.'''),
  renderMethod: MyGigaPage.edit,
);

late final testPeriodInstructionSend = MyGigaPage(
  text: MyGigaText.string('''Инструкция по подключению к VPNster

Представьте, что здесь висит ролик на ютуб с видеоинструкцией, а пока текстовое описание такое:

Шаг 1. Скачайте WireGuard;
Шаг 2. Отсканируйте QR код или загрузите файл с конфигурацией из бота в ваш WireGuard;
Шаг 3. Наслаждайтесь вашим VPNster.'''),
  renderMethod: MyGigaPage.send,
);

void testPeriodInstructionKeyboard() {
  testPeriodInstruction.changeKeyboard(
    MyGigaKeybord.list([
      [
        MyGigaButton.openPage(
            text: 'Активировать', key: testPeriodActivate.getKey())
      ],
      [
        MyGigaButton.openPage(
            text: 'Назад', key: testPeriodChoiceRegion.getKey())
      ]
    ]),
  );
}
