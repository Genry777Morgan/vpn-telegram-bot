import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_keyboard.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_text.dart';

import 'test-period-choice-region.page.dart';
import 'test-period-instruction.page.dart';

late final testPeriodChoiceOs = MyGigaPage(
    text: MyGigaText.string('''Попробуй сервис, прежде чем покупать! 
Выберите операционную систему, где будете использовать VPN. От этого зависит инструкция, которую я вам вышлю. 

 - Запоминаем TG ID юзера;
 - Проверям, есть ли такой юзер в БД VPN сервера. Если нет, то делаем по тексту ниже;
 - Создаём юзера на сервере WG;
 - Даём на следующем экране инструкцию по подключению;
 - Каждый день до окончания тестового периода шлём уведомление, по окончанию тестового периода отключаем юзера от сервера (выключаем учётку?) и шлём уведомление в телегу, чтобы подключался за деньги.

Если после проверки TG ID понимаем, что юзер уже есть - шлём его на страницу "Получить VPN" с сообщением, что тестовый период закончился.'''),
    renderMethod: MyGigaPage.edit);

void testPeriodChoiceOsKeyboard() {
  testPeriodChoiceOs.changeKeyboard(
    MyGigaKeybord.list([
      [
        MyGigaButton.openPage(
            text: 'Windows', key: testPeriodInstruction.getKey())
      ],
      [
        MyGigaButton.openPage(
            text: 'MacOS', key: testPeriodInstruction.getKey())
      ],
      [
        MyGigaButton.openPage(
            text: 'Android', key: testPeriodInstruction.getKey())
      ],
      [MyGigaButton.openPage(text: 'iOS', key: testPeriodInstruction.getKey())],
      [
        MyGigaButton.openPage(
            text: 'Назад', key: testPeriodChoiceRegion.getKey())
      ]
    ]),
  );
}
