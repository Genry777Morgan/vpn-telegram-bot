import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/pages/interfaces/page.interface.dart';

class MainMenuPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  String get separator => dialogDataSource.separator;
  @override
  String get name => PageEnum.main_menu.name;
  @override
  String get path =>
      'main_menu';
  @override
   InlineKeyboardMarkup get inlineKeyboardMarkup => InlineKeyboardMarkup(inline_keyboard: [
    [
      InlineKeyboardButton(
          text:
              dialogDataSource.getButtonText(path, 'subscriptions', LayoutEnum.ru),
          callback_data:
              CallbackData(pg: PageEnum.sub_pay.name, prms: [Param(n: 'pp', v: name)]) // pp = previous page
                  .toJson()),
      InlineKeyboardButton(
          text:
              dialogDataSource.getButtonText(path, 'support', LayoutEnum.ru),
          callback_data:
              CallbackData(pg: PageEnum.support.name).toJson()) // TODO
    ]
  ]);

  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {
      final page =
          CallbackData.fromJson(event.data ?? "pg: unknown")
              .pg;

      if (page == name) {
        render(
            chatId: event.message?.chat.id,
            renderMethod: (int chatId, String text) {
              edit(chatId, text, event.message?.message_id);
            });
      }
    });
  }
}
