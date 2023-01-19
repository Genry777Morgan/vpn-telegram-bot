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

  var timedcostil = Page(text: Text.string('a'));

  var firstPage =
      Page(name: 'main-menu', text: Text.string('some text'), markup: [
    [
      MyGigaButton.openPage(
          text: 'далее',
          page: Page(
              name: 'second-page',
              text: Text.function((pageMessage, user) => 'Твой id ${user.id}'),
              renderMethod: timedcostil.edit))
    ]
  ]);

  Registrator.regCommand('start', firstPage.render);

  Registrator.createLisener();
  teledart.start();
}
