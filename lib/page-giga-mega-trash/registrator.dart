import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:uuid/uuid.dart';

class Registrator {
  static final stack = Map();
  static void registrate(String key, Function(Message, User) action) {
    assert(
        stack[key] == null); // если ключ не уникальный - перевыствывай, додик

    stack[key] = action;
  }

  static void regCommand(String command, Function action) {
    final teleDart = GetIt.I<TeleDart>();

    teleDart.onCommand(command).listen((message) {
      action(message, message.from);
    });
  }

  static bool lisenerExist = false;
  static void createLisener() {
    assert(lisenerExist == false); // TODO сров норм ошибки с лписанием

    final teleDart = GetIt.I<TeleDart>();
    teleDart.onCallbackQuery().listen((event) {
      final action = stack[event.data];
      if (action != null) {
        action(event.message, event.from);
      }
    });
  }
}
