import 'package:teledart/model.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/base-page.dart';

class MyGigaButton {
  final String text;
  late final String callbackData;
  MyGigaButton.openPage({required this.text, required Page page}) {
    callbackData = page.getKey();
  }
  MyGigaButton.handle({required this.text}) {
// TODO
    callbackData = '';
  }

  InlineKeyboardButton convertToTeegram() {
    return InlineKeyboardButton(text: text, callback_data: callbackData);
  }
}
