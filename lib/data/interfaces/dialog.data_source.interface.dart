import 'package:vpn_telegram_bot/data/layout.enum.dart';

abstract class DialogDataSourceInterface {
  String get separator;

  /// Возвращает сообщение пользователю
  String getMessage(String path, LayoutEnum layout); // Возможно не path а key 

  /// Возвращает текст кнопки пользователю
  String getButtonText(String path, String name, LayoutEnum layout); // Возможно не path а key 

}
