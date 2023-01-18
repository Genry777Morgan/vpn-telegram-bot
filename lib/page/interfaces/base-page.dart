import 'package:teledart/model.dart';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
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

  /// renderMethod by default PageInterface.send(chatId, text)
  /// ты можеш комбинироватт несколько меодов отрисовки с помощью стрелочной функции
  /// или оправить свой
  void render(
      {int? chatId,
      Function(int, String)? renderMethod,
      List<String>? textValues}) {
    renderMethod ??= send;

    // assert(textValues != null);
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
    for (var i = 0; i < textParts.length /* */; i++) {
      if (i < values.length && i != textParts.length - 1) {
        result += textParts[i] + values[i];
      } else {
        result += textParts[i];
      }
    }

    return result;
  }

  ///
  ///
  Future send(int? chatId, String text) async {
    await teledart.sendMessage(chatId, text,
        reply_markup: inlineKeyboardMarkup);
  }

  /// send a photo
  ///
  Future sendPhoto(int? chatId, dynamic photo) async {
    await teledart.sendPhoto(chatId, photo);
  }

  Future sendFile(int? chatId, dynamic file) async {
    await teledart.sendDocument(chatId, file);
  }

  /// удаляет старое сообщкние и отправляет новоре
  /// Для тех случаев когда нужно сместить интерфейс в низ диалога
  void replase(int? chatId, String text, int? messageId) {
    if (messageId == null) {
      // TODO trow error
    } else {
      teledart.deleteMessage(chatId, messageId);
    }

    teledart.sendMessage(chatId, text, reply_markup: inlineKeyboardMarkup);
  }

  ///
  ///
  void edit(int? chatId, String text, int? messageId) {
    if (messageId == null) {
      // TODO trow error
    }

    teledart.editMessageText(
      text,
      chat_id: chatId,
      message_id: messageId,
      reply_markup: inlineKeyboardMarkup,
    );
  }

  void consoleLog(Type className) {
    print('class: $className,\n name: $name,\n path: $path');
  }

  String? getParam(List<Param>? params, String name) {
    if (params == null) {
      return null;
    }

// Достаю регион из параметров
    final Param? param =
        params.firstWhere((element) => element.n == name); // pp = previous page
    return param?.v;
  }
}

class Exeptor {
  static void tryCatch(Function() funk) async {
    try {
      funk();
    } catch (exception, stacktrace) {
      Logey.loger('Ecxeption',
          body: '${exception.toString()}\n${stacktrace.toString()}');
    }
  }
}

class Logey {
  static String path = 'logs.log';
  static void loger(String head, {String? userId, String? body}) {
    body ??= '';
    userId == null ? userId = '' : userId = '/$userId/';

    final text = '${DateTime.now()} $userId [$head] $body\n';

    final file = io.File(path);
    file.writeAsStringSync(text, mode: io.FileMode.append);

    print(text);
  }
}
