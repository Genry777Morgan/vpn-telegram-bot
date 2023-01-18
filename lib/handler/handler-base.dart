import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';

abstract class BaseHandler {
  BaseHandler() {
      register();
  }

  TeleDart get teledart;
  DialogDataSourceInterface get dialogDataSource;
  String get command;

  void register();
}
