import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/page-giga-mega-trash/base-page.dart';

class CommandItem {
  final Function(Message, User) action;
  final bool isMustRemove;

  CommandItem(this.action, this.isMustRemove);
}

class Registrator {
  static final callbackDataStack = Map();
  static final commandStack = Map();

  static void registrateButton(String key, Function(Message, User) action) {
    assert(callbackDataStack[key] ==
        null); // если ключ не уникальный - перевыствывай, додик

    callbackDataStack[key] = action;
  }

  /// isMustRemove удаляет сообщение с комндой отправленное юзером
  static void registrateCommand(String command, Function(Message, User) action,
      [bool isMustRemove = false]) {
    assert(commandStack['/$command'] ==
        null); // если ключ не уникальный - перевыствывай, додик

    commandStack['/$command'] = CommandItem(action, isMustRemove);
  }

  static void removeAllMessages() {
    final teleDart = GetIt.I<TeleDart>();

    teleDart.onMessage().listen((message) {
      teleDart.deleteMessage(message.chat.id, message.message_id);
    });
  }

  static void listenCommands({bool isRemoveUseless = false}) {
    final teleDart = GetIt.I<TeleDart>();

    teleDart.onCommand().listen((message) {
      final CommandItem? item = commandStack[message.text];
      if (item != null) {
        JustGay.loger(message.text as String,
            userId: message.from?.id.toString(), body: 'called');

        if (item.isMustRemove) {
          teleDart.deleteMessage(message.chat.id, message.message_id);
        }

        item.action(message, message.from as User);
      } else if (isRemoveUseless) {
        teleDart.deleteMessage(message.chat.id, message.message_id);
      }
    });
  }

  static bool lisenerExist = false;
  static void listenCallbacks([Function(Message, User)? defaultAction = null]) {
    assert(lisenerExist == false); // TODO сров норм ошибки с описанием

    final teleDart = GetIt.I<TeleDart>();
    teleDart.onCallbackQuery().listen((event) {
      if (event.data == null) return;

      final action = callbackDataStack[event.data];
      if (action != null) {
        JustGay.loger(event.data!,
            userId: event.from.id.toString(), body: 'called');

        action(event.message, event.from);
      } else if (defaultAction != null) {
        defaultAction(event.message as Message, event.from);
      }
    });
  }
}
