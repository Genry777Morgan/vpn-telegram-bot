import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/pages/interfaces/page.interface.dart';

class StartPage extends PageInterface {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource => GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.start.name;
  @override
  String get path => 'intro${dialogDataSource.separator}start';
  @override
  InlineKeyboardMarkup get inlineKeyboardMarkup => InlineKeyboardMarkup(inline_keyboard: [
    [
      InlineKeyboardButton(
          text: dialogDataSource.getButtonText(
              path, 'continue', LayoutEnum.ru),
          callback_data:
              CallbackData(page: PageEnum.region_selection.name).toJson())
    ]
  ]);

  @override
  void register() {
    teledart.onCommand('start').listen((message) => render(message.chat.id, add));
  }
}
