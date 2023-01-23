import 'dart:io' as io;

class Loger {
  static String path = 'logs.log';
  static void log(String head, {String? userId, String? body}) {
    body ??= '';
    userId == null ? userId = '' : userId = '/$userId/';

    final text = '${DateTime.now()} $userId [$head] $body\n';

    final file = io.File(path);
    file.writeAsStringSync(text, mode: io.FileMode.append);

    print(text);
  }
}
