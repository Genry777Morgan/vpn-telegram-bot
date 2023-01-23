import 'package:vpn_telegram_bot/loger.dart';

class Exeptor {
  static void tryCatch(Function() funk) async {
    try {
      funk();
    } catch (exception, stacktrace) {
      Loger.log('Ecxeption',
          body: '${exception.toString()}\n${stacktrace.toString()}');
    }
  }
}
