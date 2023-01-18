import 'package:get_it/get_it.dart';
import 'dart:io' as ia;
import 'package:http/http.dart' as http;
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/constans.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/page/interfaces/base-page.dart';

class ChoiceConfigPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.choiceConfig.name;
  @override
  String get path => 'choiceConfig';
  @override
  InlineKeyboardMarkup get inlineKeyboardMarkup =>
      InlineKeyboardMarkup(inline_keyboard: [
        [
          InlineKeyboardButton(
              text: dialogDataSource.getButtonText(
                  path, 'getText', LayoutEnum.ru),
              callback_data: CallbackData(
                  pg: PageEnum.config.name,
                  prms: [Param(n: 't', v: 'config')]).toJson()),
        ],
        [
          InlineKeyboardButton(
              text:
                  dialogDataSource.getButtonText(path, 'getQr', LayoutEnum.ru),
              callback_data: CallbackData(
                  pg: PageEnum.config.name,
                  prms: [Param(n: 't', v: 'qr')]).toJson()),
        ],
        [
          InlineKeyboardButton(
              text: dialogDataSource.getButtonText(path, 'back', LayoutEnum.ru),
              callback_data:
                  CallbackData(pg: PageEnum.dashBoard.name).toJson()),
        ],
      ]);

  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {
      Exeptor.tryCatch(() async {
        final data = CallbackData.fromJson(event.data ?? "pg: unknown");
        final page = data.pg;

        // Если колбек дата соотвеьсвует этой странице
        if (page == name) {
          Logey.loger(name, userId: event.from.id.toString(), body: 'opened');

          render(
              chatId: event.message?.chat.id,
              renderMethod: (int chatId, String text) async {
                edit(chatId, text, event.message?.message_id);
              });
        }
      });
    });
  }
}
