import 'package:teledart/model.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/my_giga_button.dart';

class MyGigaKeybord {
  MyGigaKeybord.list(List<List<MyGigaButton>> buttons) {
    getMarkup = ((pageMessage, user) async {
      return InlineKeyboardMarkup(
          inline_keyboard: buttons
              .map((e) => e.map((e) => e.convertToTeegram()).toList())
              .toList());
    });
  }

  MyGigaKeybord.function(
      Future<List<List<MyGigaButton>>> Function(Message pageMessage, User user)
          function) {
    getMarkup = ((pageMessage, user) async {
      return InlineKeyboardMarkup(
          inline_keyboard: (await function(pageMessage, user))
              .map((e) => e.map((e) => e.convertToTeegram()).toList())
              .toList());
    });
  }

  late final Future<InlineKeyboardMarkup> Function(
      Message pageMessage, User user) getMarkup;
}
