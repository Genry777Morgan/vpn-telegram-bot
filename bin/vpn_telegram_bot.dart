import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:teledart/model.dart';
import 'package:http/http.dart' as http;
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/configurations.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/yaml_dialog.data_source.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/base-page.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my-giga-button.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/registrator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

import 'constants.dart';
import 'controlers/event_contoller.dart';

Future<void> main() async {
  final router = Router();
  EventController(router: router).addHandlers();

  final ip = InternetAddress.anyIPv4;
  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8085');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');

  JustGay.loger('Program starting..');
  // region setup teledart

  var botToken = 't1456257916:AAFXlGP9xZgWEwZzkgtTr03a9M4vZPZ-r2I';
  final username = (await Telegram(botToken).getMe()).username;

  GetIt.I.registerSingleton<TeleDart>(TeleDart(botToken, Event(username!)));

  final teledart = GetIt.I<TeleDart>();
  //endregion

  //region setup DI

  // GetIt.I.registerSingleton<DialogDataSourceInterface>(YamlDialogDataSource());

  var mainMenuText = MyGigaText.string('''Привет!
VPNster в телеграм!
Простой в использовании VPN сервис.''');

  var startMenu = Page.withoutRegistration(
      name: 'main-menu',
      text: mainMenuText,
      renderMethod: (teleDart, pageMessage, user, text, markup) async {
        var response = await http.post(Uri.http(host, "/users"),
            body: jsonEncode(
                {"telegramId": user.id.toString(), "username": user.username}));
        Page.send(teleDart, pageMessage, user, text, markup);
      });

  var mainMenu =
      Page(name: 'main-menu', text: mainMenuText, renderMethod: Page.edit);

  var testPeriodActivate = Page(
      name: 'main-menu',
      text: mainMenuText,
      renderMethod: ((teleDart, message, user, text, markup) async {
        var response =
            await http.patch(Uri.http(host, "/users/${user.id}/useFreePeriod"));

        await teledart.editMessageReplyMarkup(
            chat_id: message.chat.id,
            message_id: message.message_id,
            reply_markup: null);

        try {
          response = await http.get(Uri.http(host, "/users/${user.id}/qrCode"));

          final photo = io.File('qr.png');
          photo.writeAsBytesSync(response.body.codeUnits);

          await Page.sendPhoto(teleDart, message.chat.id, photo);
        } catch (exception, stacktrace) {
          JustGay.loger('TestPeriodactivate',
              userId: user.id.toString(),
              body: '${exception.toString()}\n${stacktrace.toString()}');
        }

        try {
          response = await http.get(Uri.http(host, "/users/${user.id}/config"));

          var configFileBody = jsonDecode(response.body)['configFile'];

          final file = io.File('config.conf');
          file.writeAsStringSync(configFileBody);

          await Page.sendFile(teleDart, message.chat.id, file);
        } catch (e) {}

        Page.send(teleDart, message, user, text, markup);
      }));

  //endregion
  var rate = Page(
      text: MyGigaText.function((pageMessage, user) async {
        var response = await http.get(Uri.http(host, "/users/${user.id}"));

        var responseBody = jsonDecode(response.body);
        final balance = responseBody['balance'];
        return 'Ваш баланс $balance денег';
      }),
      renderMethod: Page.edit);

  var dashBoard = Page(
    text: MyGigaText.function((pageMessage, user) async {
      var response = await http.get(Uri.http(host, "/users/${user.id}"));

      var responseBody = jsonDecode(response.body);
      final username = responseBody['username'];
      final balance = responseBody['balance'];

      return '''$username, это Ваш личный кабинет.
Баланс: $balance''';
    }),
    renderMethod: Page.edit,
  );

  var testPeriodChoiceRegion = Page(
      text: MyGigaText.string('''Какой регион желаете?'''),
      renderMethod: Page.edit);

  var testPeriodChoiceOs = Page(
      text: MyGigaText.string('''Попробуй сервис, прежде чем покупать! 
Выберите операционную систему, где будете использовать VPN. От этого зависит инструкция, которую я вам вышлю. 

 - Запоминаем TG ID юзера;
 - Проверям, есть ли такой юзер в БД VPN сервера. Если нет, то делаем по тексту ниже;
 - Создаём юзера на сервере WG;
 - Даём на следующем экране инструкцию по подключению;
 - Каждый день до окончания тестового периода шлём уведомление, по окончанию тестового периода отключаем юзера от сервера (выключаем учётку?) и шлём уведомление в телегу, чтобы подключался за деньги.

Если после проверки TG ID понимаем, что юзер уже есть - шлём его на страницу "Получить VPN" с сообщением, что тестовый период закончился.'''),
      renderMethod: Page.edit);

  var testPeriodInstruction = Page(
      text: MyGigaText.string(
          '''Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'''),
      renderMethod: Page.edit);

  final mainMenuFirsTry = [
    [MyGigaButton.openPage(text: 'Получить ВПН', page: testPeriodChoiceRegion)],
    [
      MyGigaButton.openPage(text: 'Тарифы', page: rate),
      MyGigaButton.openPage(text: 'Личный кабинет', page: dashBoard),
    ]
  ];

  final mainMenuUsualEntry = [
    [MyGigaButton.openPage(text: 'Тарифы', page: rate)],
    [MyGigaButton.openPage(text: 'Личный кабинет', page: dashBoard)]
  ];

  final mainMenuKeyboard = MyGigaKeybord.function(((pageMessage, user) async {
    var response = await http.get(Uri.http(host, "/users/${user.id}"));

    var responseBody = jsonDecode(response.body);
    final freePeriodUsed = responseBody['freePeriodUsed'].toString();

    return freePeriodUsed == 'true' ? mainMenuUsualEntry : mainMenuFirsTry;
  }));

  startMenu.changeKeyboard(mainMenuKeyboard);
  mainMenu.changeKeyboard(mainMenuKeyboard);
  testPeriodActivate.changeKeyboard(MyGigaKeybord.list(mainMenuUsualEntry));

  testPeriodInstruction.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'Акстивировать', page: testPeriodActivate)],
    [MyGigaButton.openPage(text: 'Назад', page: testPeriodChoiceOs)]
  ]));

  testPeriodChoiceOs.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'Windows', page: testPeriodInstruction)],
    [MyGigaButton.openPage(text: 'MacOS', page: testPeriodInstruction)],
    [MyGigaButton.openPage(text: 'Android', page: testPeriodInstruction)],
    [MyGigaButton.openPage(text: 'iOS', page: testPeriodInstruction)],
    [MyGigaButton.openPage(text: 'Назад', page: testPeriodChoiceRegion)]
  ]));

  testPeriodChoiceRegion.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'Россия', page: testPeriodChoiceOs)],
    [MyGigaButton.openPage(text: 'Назад', page: mainMenu)]
  ]));

  rate.changeKeyboard(MyGigaKeybord.list([
    [MyGigaButton.openPage(text: 'Оплатить на день', page: mainMenu)],
    [MyGigaButton.openPage(text: 'Оплатить на месяц', page: mainMenu)],
    [MyGigaButton.openPage(text: 'Назад', page: mainMenu)]
  ]));

  dashBoard.changeKeyboard(MyGigaKeybord.list([
    // [MyGigaButton.openPage(text: 'Получить конфин', page: null)]
    [MyGigaButton.openPage(text: 'Назад', page: mainMenu)]
  ]));

  Registrator.regCommand('start', startMenu.render);

  Registrator.createLisener();
  teledart.start();
}
