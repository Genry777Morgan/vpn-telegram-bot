import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/configurations.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/yaml_dialog.data_source.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/base-page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my-giga-button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/registrator.dart';

Future<void> main() async {
  // region setup teledart

  var botToken = Configurations.config['ApiToken'];
  final username = (await Telegram(botToken).getMe()).username;

  GetIt.I.registerSingleton<TeleDart>(TeleDart(botToken, Event(username!)));

  final teledart = GetIt.I<TeleDart>();
  //endregion

  //region setup DI

  GetIt.I.registerSingleton<DialogDataSourceInterface>(YamlDialogDataSource());

  //endregion
  var rate = Page(
      text: Text.function((pageMessage, user) => 'empty'),
      renderMethod: Page.edit);
  var dashBoard = Page(
    text: Text.function((pageMessage, user) => 'empty'),
    renderMethod: Page.edit,
  );

  var mainMenu = Page(name: 'main-menu', text: Text.string('some text'));

  mainMenu.changeKeyboard([
    [
      MyGigaButton.openPage(
          text: 'Далее',
          page: Page(
              name: 'Тест',
              text: Text.function((pageMessage, user) => 'Твой id ${user.id}'),
              renderMethod: Page.edit))
    ],
    [
      MyGigaButton.openPage(
          text: 'Получить ВПН',
          page: Page(
              text: Text.function((pageMessage, user) => ''),
              renderMethod: Page.edit))
    ],
    [
      MyGigaButton.openPage(text: 'Тарифы', page: rate),
      MyGigaButton.openPage(text: 'Личный кабинет', page: dashBoard),
    ]
  ]);

  rate.changeKeyboard([
    [
      MyGigaButton.openPage(
          text: '', page: Page(text: Text.string('Just Page'))),
      MyGigaButton.openPage(text: 'Назад', page: mainMenu)
    ]
  ]);

  dashBoard.changeKeyboard([
    [
      MyGigaButton.openPage(
          text: '', page: Page(text: Text.string('Just Page'))),
      MyGigaButton.openPage(text: 'Назад', page: mainMenu)
    ]
  ]);

  Registrator.regCommand('start', mainMenu.render);

  Registrator.createLisener();
  teledart.start();
}
