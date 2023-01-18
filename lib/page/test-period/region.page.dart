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

class TpRegionPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.tpRegion.name;
  @override
  String get path => 'testPeriod${dialogDataSource.separator}region';
  @override
  InlineKeyboardMarkup get inlineKeyboardMarkup =>
      InlineKeyboardMarkup(inline_keyboard: [
        [
          InlineKeyboardButton(
              text:
                  dialogDataSource.getButtonText(path, 'russia', LayoutEnum.ru),
              callback_data: CallbackData(pg: PageEnum.tpOs.name).toJson()),
        ],
        [
          InlineKeyboardButton(
              text: dialogDataSource.getButtonText(path, 'back', LayoutEnum.ru),
              callback_data: CallbackData(pg: PageEnum.mainMenu.name).toJson()),
        ],
      ]);

  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {
      Exeptor.tryCatch(() async {
        final data = CallbackData.fromJson(event.data ?? "pg: unknown");
        final page = data.pg;

        // Если колбек дата сооьвеьсвует этой странице
        if (page == name) {
          print("$name regisration inside");

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
