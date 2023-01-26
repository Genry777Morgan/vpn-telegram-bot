import 'package:teledart/model.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/button.hectic-tg.dart';

class Keyboard {
  Keyboard.list(List<List<Button>> buttons) {
    getMarkup = ((pageMessage, user) async {
      return InlineKeyboardMarkup(
          inline_keyboard: buttons
              .map((e) => e.map((e) => e.convertToTeegram()).toList())
              .toList());
    });
  }

  Keyboard.function(
      Future<List<List<Button>>> Function(Message pageMessage, User user)
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
