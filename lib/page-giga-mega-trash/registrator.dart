import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:uuid/uuid.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/base-page.dart';

class Registrator {
  static final stack = Map();
  static void registrate(String key, Function(Message, User) action) {
    assert(
        stack[key] == null); // если ключ не уникальный - перевыствывай, додик

    stack[key] = action;
  }

  /// isMustRemove удаляет сообщение с комндой отправленное юзером
  static void regCommand(String command, Function action,
      {bool isMustRemove = false}) {
    final teleDart = GetIt.I<TeleDart>();

    teleDart.onCommand(command).listen((message) {
      JustGay.loger(command,
          userId: message.from?.id.toString(), body: 'called');

      if (isMustRemove) {
        teleDart.deleteMessage(message.chat.id, message.message_id);
      }

      action(message, message.from);
    });
  }

  static bool lisenerExist = false;
  static void createLisener() {
    assert(lisenerExist == false); // TODO сров норм ошибки с описанием

    final teleDart = GetIt.I<TeleDart>();
    teleDart.onCallbackQuery().listen((event) {
      if (event.data == null) return;

      final action = stack[event.data];
      if (action != null) {
        JustGay.loger(event.data!,
            userId: event.from.id.toString(), body: 'called');
        action(event.message, event.from);
      }
    });
  }
}
