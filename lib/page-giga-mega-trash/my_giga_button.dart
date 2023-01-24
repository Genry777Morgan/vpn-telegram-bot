import 'package:teledart/model.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_page.dart';

class MyGigaButton {
  final String text;
  late final String callbackData;

  MyGigaButton.openPage({required this.text, required String key}) {
    callbackData = key;
  }
  MyGigaButton.handle({required this.text}) {
// TODO
    callbackData = '';
  }

  InlineKeyboardButton convertToTeegram() {
    return InlineKeyboardButton(text: text, callback_data: callbackData);
  }
}
