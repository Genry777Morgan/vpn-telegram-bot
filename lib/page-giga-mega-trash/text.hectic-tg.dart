import 'package:teledart/model.dart';

class Text {
  Text.string(String string) {
    getContent = (pageMessage, user) async {
      return string;
    };
  }

  Text.function(
      Future<String> Function(Message pageMessage, User user) function) {
    getContent = function;
  }

  late final Future<String> Function(Message pageMessage, User user) getContent;
}
