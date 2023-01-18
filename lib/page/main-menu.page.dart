import 'dart:convert';
import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/extension/string.extension.dart';
import 'package:vpn_telegram_bot/constans.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/page/interfaces/base-page.dart';

class MainMenuPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.mainMenu.name;
  @override
  String get path => 'mainMenu';

  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {
      Exeptor.tryCatch(() async {
        final data = CallbackData.fromJson(event.data ?? "pg: unknown");
        final page = data.pg;

        // Если колбек дата сооьвеьсвует этой странице
        if (page == name) {
          Logey.loger(name, userId: event.from.id.toString(), body: 'opened');

          final freePeriodUsedString =
              getParam(data.prms, 'fpu'); // fpu - free pweiod used

          bool freePeriodUsed = true;
          if (freePeriodUsedString != null) {
            freePeriodUsed = freePeriodUsedString.parseBool();
          } else {
            var response = await http
                .get(Uri.http(host, "/users/${event.message?.from?.id}"));

            print(response.body);
            var responseBody = jsonDecode(response.body)['freePeriodUsed'];
          }

          final buttonGet = InlineKeyboardButton(
              text: dialogDataSource.getButtonText(path, 'get', LayoutEnum.ru),
              callback_data: CallbackData(
                  pg: PageEnum.empty.name,
                  prms: [Param(n: 'pp', v: name)]).toJson()); // TODO
          final buttonTest = InlineKeyboardButton(
              text: dialogDataSource.getButtonText(path, 'test', LayoutEnum.ru),
              callback_data: CallbackData(pg: PageEnum.tpRegion.name).toJson());
          inlineKeyboardMarkup = InlineKeyboardMarkup(inline_keyboard: [
            freePeriodUsed ? [buttonGet] : [buttonGet, buttonTest],
            [
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'rates', LayoutEnum.ru),
                  callback_data: CallbackData(
                      pg: PageEnum.empty.name,
                      prms: [Param(n: 'pp', v: name)]).toJson()), // TODO
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'dashBoard', LayoutEnum.ru),
                  callback_data:
                      CallbackData(pg: PageEnum.dashBoard.name).toJson())
            ]
          ]);

          // Отправка сообщения пользователю
          render(
              chatId: event.message?.chat.id,
              renderMethod: (int chatId, String text) {
                edit(chatId, text, event.message?.message_id);
              });
        }
      });
    });
  }
}
