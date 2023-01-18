import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/constans.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/page/interfaces/base-page.dart';

class StartPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.start.name;
  @override
  String get path => 'start';

  @override
  void register() {
    teledart.onCommand('start').listen((message) {
      Exeptor.tryCatch(() async {
        assert(message.from != null); // Создаем ошибки

        Logey.loger(name, userId: message.from?.id.toString(), body: 'opened');

        var response = await http.post(Uri.http(host, "/users"),
            body: jsonEncode({
              "telegramId": message.from?.id.toString(),
              "username": message.from?.username
            }));

        response = await http.get(Uri.http(host, "/users/${message.from?.id}"));

        print(response.body);
        var responseBody = jsonDecode(response.body);

        final continueButton = InlineKeyboardButton(
            text:
                dialogDataSource.getButtonText(path, 'continue', LayoutEnum.ru),
            callback_data: CallbackData(pg: PageEnum.mainMenu.name, prms: [
              Param(n: 'fpu', v: responseBody['freePeriodUsed'].toString())
            ]).toJson()); // TODO
        inlineKeyboardMarkup = InlineKeyboardMarkup(inline_keyboard: [
          [continueButton]
        ]);

        // Отправка сообщения пользователю
        render(chatId: message.chat.id, renderMethod: send);
      });
    });
  }
}
