import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/configurations.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/yaml_dialog.data_source.dart';
import 'package:vpn_telegram_bot/empty.page.dart';
import 'package:vpn_telegram_bot/extension/teledart.extension.dart';
import 'package:vpn_telegram_bot/handler/start-command.handler.dart';
import 'package:vpn_telegram_bot/page/dash-board.page.dart';
import 'package:vpn_telegram_bot/page/interfaces/base-page.dart';
import 'package:vpn_telegram_bot/page/interfaces/chose-config/choi%D1%81e-config.page%20copy.dart';
import 'package:vpn_telegram_bot/page/interfaces/chose-config/get-config.page.dart';
import 'package:vpn_telegram_bot/page/main-menu.page.dart';
import 'package:vpn_telegram_bot/page/start.page.dart';
import 'package:vpn_telegram_bot/page/test-period/activate.page.dart';
import 'package:vpn_telegram_bot/page/test-period/os.page.dart';
import 'package:vpn_telegram_bot/page/test-period/os/android.page.dart';
import 'package:vpn_telegram_bot/page/test-period/os/ios.page.dart';
import 'package:vpn_telegram_bot/page/test-period/region.page.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'controlers/event_contoller.dart';

Future<void> main() async {
  var botToken = Configurations.config['ApiToken'];
  final username = (await Telegram(botToken).getMe()).username;

  final router = Router();
  EventController(router: router).addHandlers();

  final ip = InternetAddress.anyIPv4;
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8081');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  Logey.loger('Program starting..');

  // region setup teledart
  GetIt.I.registerSingleton<TeleDart>(TeleDart(botToken, Event(username!)));

  final teledart = GetIt.I<TeleDart>();
  //endregion

  //region setup DI

  GetIt.I.registerSingleton<DialogDataSourceInterface>(YamlDialogDataSource());

  GetIt.I.registerSingleton<EmptyPage>(EmptyPage());
  GetIt.I.registerSingleton<StartPage>(StartPage());
  GetIt.I.registerSingleton<MainMenuPage>(MainMenuPage());
  GetIt.I.registerSingleton<DashBoardPage>(DashBoardPage());
  GetIt.I.registerSingleton<TpRegionPage>(TpRegionPage());
  GetIt.I.registerSingleton<TpOsPage>(TpOsPage());
  GetIt.I.registerSingleton<TpAndroidPage>(TpAndroidPage());
  GetIt.I.registerSingleton<TpActivatePage>(TpActivatePage());
  GetIt.I.registerSingleton<TpIosPage>(TpIosPage());
  GetIt.I.registerSingleton<ChoiceConfigPage>(ChoiceConfigPage());
  GetIt.I.registerSingleton<ConfigPage>(ConfigPage());

  //endregion

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

  Logey.loger('Ok');
}
