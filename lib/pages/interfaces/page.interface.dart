import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';

abstract class BasePage {
  BasePage() {
    try {
      register();
    } catch (exception) {
      print(exception);
    }
  }

  TeleDart get teledart;
  DialogDataSourceInterface get dialogDataSource;
  String get name;
  String get path;
  late InlineKeyboardMarkup? inlineKeyboardMarkup;

  void register();

  /// renderMethod by default PageInterface.add(chatId, text)
  void render(
      {int? chatId,
      required Function(int, String) renderMethod,
      List<String>? textValues}) {
    assert(textValues != null);
    try {
      if (chatId == null) {
        // TODO error log
      }

      var text = dialogDataSource.getMessage(path, LayoutEnum.ru);

      if (textValues != null) {
        text = stringf(text, textValues);
      }
      renderMethod(chatId as int, text);
    } catch (exception, stacktrace) {
      // TODO remove send massege
      teledart.sendMessage(
          chatId, '```${exception.toString()}\n${stacktrace.toString()}```',
          parse_mode: 'MarkdownV2');
    }
  }

  String stringf(String text, List<String> values) {
    String result = '';

    List<String> textParts = text.split('%');
    print("text valuest: $textParts");
    for (var i = 0; i < textParts.length /* */; i++){
      if (i < values.length && i != textParts.length - 1) {
        result += textParts[i] + values[i];
      } else {
        result += textParts[i];
      }
    }

    return result;
  }

  void add(int chatId, String text) {
    teledart.sendMessage(chatId, text, reply_markup: inlineKeyboardMarkup);
  }

  void edit(int chatId, String text, int? messageId) {
    if (messageId == null) {
      // TODO trow error
    }
    teledart.editMessageText(text,
        chat_id: chatId,
        message_id: messageId,
        reply_markup: inlineKeyboardMarkup);
  }

  void consoleLog(Type className) {
    print('class: $className,\n name: $name,\n path: $path');
  }
}
