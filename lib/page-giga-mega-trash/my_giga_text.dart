import 'package:teledart/model.dart';

class MyGigaText {
  MyGigaText.string(String string) {
    getContent = (pageMessage, user) async {
      return string;
    };
  }

  MyGigaText.function(
      Future<String> Function(Message pageMessage, User user) function) {
    getContent = function;
  }

  late final Future<String> Function(Message pageMessage, User user) getContent;
}
