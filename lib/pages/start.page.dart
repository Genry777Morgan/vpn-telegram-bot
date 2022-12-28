import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/page.enum.dart';
import 'package:vpn_telegram_bot/pages/interfaces/page.interface.dart';

class StartPage implements PageInterface {
  late final _teledart = GetIt.I<TeleDart>();
  late final _dialogDataSource = GetIt.I<DialogDataSourceInterface>();

  @override
  String get name => PageEnum.start.name;

  StartPage() {
    register();
  }

  @override
  void register() {
    // _teledart.onCallbackQuery().listen((event) {
    //   final page = CallBackData.fromYaml(event.data ?? "page: unnown" /* TODO try it */).page;
    //   if (page == name) {
    //     render(event.message?.chat.id);
    //   }
    // });

    _teledart.onCommand('start').listen((message) => render(message.chat.id));
  }

  @override
  void render(int? chatId) {
    if (chatId == null) {
      // TODO error log
    }

    final next = _dialogDataSource.separator;
    final path = 'intro${next}start';

    final text = _dialogDataSource.getMessage(path, LayoutEnum.ru);

    final inlineKeyboardMarkup = InlineKeyboardMarkup(inline_keyboard: [
      [
        InlineKeyboardButton(
            text: _dialogDataSource.getButtonText(
                path, 'continue', LayoutEnum.ru),
            callback_data:
                CallbackData(page: PageEnum.regionChosing.name).toYaml())
      ]
    ]);

    _teledart.sendMessage(chatId, text, reply_markup: inlineKeyboardMarkup);
  }
}
