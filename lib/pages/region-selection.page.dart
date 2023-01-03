import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/pages/interfaces/page.interface.dart';

class RegionSelectionPage extends PageInterface {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  String get separator => dialogDataSource.separator;
  @override
  String get name => PageEnum.region_selection.name;
  @override
  String get path => 'intro${separator}start${separator}region_selection';
  @override
  InlineKeyboardMarkup get inlineKeyboardMarkup =>
      InlineKeyboardMarkup(inline_keyboard: [
        [
          InlineKeyboardButton(
              text:
                  dialogDataSource.getButtonText(path, 'vpn.ru', LayoutEnum.ru),
              callback_data: CallbackData(page: PageEnum.terms_of_use.name, params:  [Param(name: 'region', value: 'ru')] ).toJson()),
          InlineKeyboardButton(
              text:
                  dialogDataSource.getButtonText(path, 'vpn.en', LayoutEnum.ru),
              callback_data: CallbackData(page: PageEnum.terms_of_use.name, params:  [Param(name: 'region', value: 'en')]).toJson())
        ]
      ]);

  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {

      final page =
          CallbackData.fromJson(event.data ?? "page: unnown" /* TODO try it */)
              .page;

      if (page == name) {
        render(event.message?.chat.id, (int chatId, String text) {
          edit(chatId, text, event.message?.message_id);
        });
      }
    });
  }
}
