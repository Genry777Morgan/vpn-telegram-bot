import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/pages/interfaces/page.interface.dart';

class FirstMenuPage extends BasePage {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  String get separator => dialogDataSource.separator;
  @override
  String get name => PageEnum.first_menu.name;
  @override
  String get path =>
      'intro${separator}start${separator}terms_of_use${separator}first_menu';
  @override
  void register() {
    // Ожидание колбека
    teledart.onCallbackQuery().listen((event) {
      final data = CallbackData.fromJson(event.data ?? "pg: unknown");
      final page = data.pg;

      // Если колбек дата сооьвеьсвует этой странице
      if (page == name) {
        if (data.prms == null) {
          // TODO throw
          return;
        }

        final Param? region =
            data.prms?.firstWhere((element) => element.n == 'region');
        if (data.prms == null) {
          // TODO throw
          return;
        }

        // Клавиатура
        inlineKeyboardMarkup = InlineKeyboardMarkup(inline_keyboard: [
          [
            InlineKeyboardButton(
                text:
                    dialogDataSource.getButtonText(path, 'test', LayoutEnum.ru),
                callback_data:
                    CallbackData(pg: PageEnum.test.name, prms: [region as Param]) // pp = previous page
                        .toJson()),
            InlineKeyboardButton(
                text:
                    dialogDataSource.getButtonText(path, 'pay', LayoutEnum.ru),
                callback_data:
                    CallbackData(pg: PageEnum.sub_pay.name, prms: [Param(n: 'pp', v: PageEnum.region_selection.name)]).toJson()) // pp = previous page
         ],
          [
            InlineKeyboardButton(
                text:
                    dialogDataSource.getButtonText(path, 'back', LayoutEnum.ru),
                callback_data:
                    CallbackData(pg: PageEnum.terms_of_use.name, prms: [region]).toJson())
          ]
        ]);

        // Отправка сообщения пользователю
        render(
            chatId: event.message?.chat.id,
            renderMethod: (int chatId, String text) {
              edit(chatId, text, event.message?.message_id);
            },
            textValues: [region.v]);
      }
    });
  }
}
