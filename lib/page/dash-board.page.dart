import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/constans.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/page/interfaces/base-page.dart';

class DashBoardPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.dashBoard.name;
  @override
  String get path => 'dashBoard';
  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {
      Exeptor.tryCatch(() async {
        final data = CallbackData.fromJson(event.data ?? "pg: unknown");
        final page = data.pg;

        // Если колбек дата сооьвеьсвует этой странице
        if (page == name) {
          print("$name regisration inside");

          inlineKeyboardMarkup = InlineKeyboardMarkup(inline_keyboard: [
            [
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'referralSystem', LayoutEnum.ru),
                  callback_data: CallbackData(
                      pg: PageEnum.empty.name,
                      prms: [Param(n: 'pp', v: name)]).toJson()), // TODO
            ],
            [
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'enterPromoCode', LayoutEnum.ru),
                  callback_data: CallbackData(
                      pg: PageEnum.empty.name,
                      prms: [Param(n: 'pp', v: name)]).toJson()), // TODO
            ],
            [
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'changeRegion', LayoutEnum.ru),
                  callback_data: CallbackData(
                      pg: PageEnum.empty.name,
                      prms: [Param(n: 'pp', v: name)]).toJson()), // TODO
            ],
            [
              // get config
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'get', LayoutEnum.ru),
                  callback_data: CallbackData(pg: PageEnum.choiceConfig.name)
                      .toJson()), // TODO
            ],
            [
              InlineKeyboardButton(
                  text: dialogDataSource.getButtonText(
                      path, 'back', LayoutEnum.ru),
                  callback_data:
                      CallbackData(pg: PageEnum.mainMenu.name).toJson())
            ]
          ]);

          var response =
              await http.get(Uri.http(host, "/users/${event.from.id}"));

          print(response.body);
          var responseBody = jsonDecode(response.body);

          // Отправка сообщения пользователю
          render(
              chatId: event.message?.chat.id,
              renderMethod: (int chatId, String text) {
                edit(chatId, text, event.message?.message_id);
              },
              textValues: [
                responseBody['username'],
                responseBody['balance'].toString()
              ]);
        }
      });
    });
  }
}
