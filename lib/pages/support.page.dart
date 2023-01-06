import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/pages/interfaces/page.interface.dart';

class SupportPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  String get separator => dialogDataSource.separator;
  @override
  String get name => PageEnum.support.name;
  @override
  String get path => 'main_menu${separator}support';

  @override
  void register() {
    teledart.onCallbackQuery().listen((event) {
      final data = CallbackData.fromJson(event.data ?? "pg: unknown");
      final page = data.pg;

      if (page == name) {
        // Собираем сетку клавиатуры
        inlineKeyboardMarkup = InlineKeyboardMarkup(inline_keyboard: [
          [
            InlineKeyboardButton(
                text: dialogDataSource.getButtonText(
                    path, 'back', LayoutEnum.ru),
                callback_data: CallbackData(
                    pg: PageEnum.main_menu.name).toJson())
          ]
        ]);

        // Отправляет ответ пользователю
        render(
            chatId: event.message?.chat.id,
            renderMethod: (int chatId, String text) {
              edit(chatId, text, event.message?.message_id);
            });
      }
    });
  }
}
