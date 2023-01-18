import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';

class BeterTeledart extends TeleDart {
  final Event _event;
  BeterTeledart(String token, this._event, {AbstractUpdateFetcher? fetcher})
      : super(token, _event);

  void start() async {
    await fetcher
      ..start()
      ..onUpdate().listen((_updatesHandler));
  }

  void _updatesHandler(Update update) {
    try {
      _event.emitUpdate(update);
    } on TeleDartEventException catch (e) {
      print(e);
      _updatesHandler(update);
    }
  }
}

