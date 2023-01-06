import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/configurations.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/yaml_dialog.data_source.dart';
import 'package:vpn_telegram_bot/first-entry-test-command.handler.dart';
import 'package:vpn_telegram_bot/main-menu.page.dart';
import 'package:vpn_telegram_bot/pages/empty.page.dart';
import 'package:vpn_telegram_bot/pages/region-selection.page.dart';
import 'package:vpn_telegram_bot/pages/first-menu.page.dart';
import 'package:vpn_telegram_bot/pages/start-test.page.dart';
import 'package:vpn_telegram_bot/pages/start.page.dart';
import 'package:vpn_telegram_bot/pages/sub-pay.pagea.dart';
import 'package:vpn_telegram_bot/pages/support.page.dart';
import 'package:vpn_telegram_bot/pages/terms-of-use-denial.page.dart';
import 'package:vpn_telegram_bot/pages/terms-of-use.page.dart';
import 'package:vpn_telegram_bot/pages/test.page.dart';
import 'package:vpn_telegram_bot/start-command.handler.dart';
import 'package:vpn_telegram_bot/usual-entry-test-command.handler.dart';

Future<void> main() async {
  var botToken = Configurations.config['ApiToken'];
  final username = (await Telegram(botToken).getMe()).username;

  // region setup teledart
  GetIt.I.registerSingleton<TeleDart>(TeleDart(botToken, Event(username!)));

  final teledart = GetIt.I<TeleDart>();
  //endregion

  //region setup DI

  GetIt.I.registerSingleton<DialogDataSourceInterface>(YamlDialogDataSource());
  GetIt.I.registerSingleton<StartPage>(StartPage());
  GetIt.I.registerSingleton<RegionSelectionPage>(RegionSelectionPage());
  GetIt.I.registerSingleton<TermsOfUse>(TermsOfUse());
  GetIt.I.registerSingleton<FirstMenuPage>(FirstMenuPage());
  GetIt.I.registerSingleton<TermsOfUseDenial>(TermsOfUseDenial());
  GetIt.I.registerSingleton<MainMenuPage>(MainMenuPage());
  GetIt.I.registerSingleton<SubPayPage>(SubPayPage());
  GetIt.I.registerSingleton<SupportPage>(SupportPage());
  GetIt.I.registerSingleton<EmptyPage>(EmptyPage());
  GetIt.I.registerSingleton<TestPage>(TestPage());
  GetIt.I.registerSingleton<StartTestPage>(StartTestPage());

  GetIt.I.registerSingleton<StartCommandHandler>(StartCommandHandler());
  GetIt.I.registerSingleton<FirstEntryTestCommandHandler>(FirstEntryTestCommandHandler());
  GetIt.I.registerSingleton<UsualEntryTestCommandHandler>(UsualEntryTestCommandHandler());

  //endregion

  // yaml test
  teledart.onCommand('yaml').listen(
      (message) => message.reply('click to button to make call back data',
          reply_markup: InlineKeyboardMarkup(inline_keyboard: [
            [
              InlineKeyboardButton(
                  text: 'send call back',
                  callback_data: CallbackData(pg: "yam_call_back").toJson())
            ]
          ])));

  // Tests
  teledart
      .onCommand('main_keyboard')
      .listen((message) => message.reply('to something!',
          reply_markup: ReplyKeyboardMarkup(keyboard: [
            [KeyboardButton(text: 'text')]
          ])));

  teledart
      .onCommand('inline_keyboard')
      .listen((message) => message.reply('to something!',
          reply_markup: InlineKeyboardMarkup(inline_keyboard: [
            [InlineKeyboardButton(text: 'text', callback_data: 'data')]
          ])));

  teledart.start();
}
