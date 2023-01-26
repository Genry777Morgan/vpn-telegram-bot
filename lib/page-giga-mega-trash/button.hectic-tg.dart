import 'package:teledart/model.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/page.hectic-tg.dart';

class Button {
  final String text;
  late final String callbackData;

  Button.openPage({required this.text, required String key}) {
    callbackData = key;
  }
  Button.handle({required this.text}) {
// TODO
    callbackData = '';
  }

  InlineKeyboardButton convertToTeegram() {
    return InlineKeyboardButton(text: text, callback_data: callbackData);
  }
}
