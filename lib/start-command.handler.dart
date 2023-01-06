import 'package:get_it/get_it.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/handler-base.dart';
import 'package:vpn_telegram_bot/main-menu.page.dart';
import 'package:vpn_telegram_bot/pages/start.page.dart';

class StartCommandHandler extends BaseHandler {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource => GetIt.I<DialogDataSourceInterface>();

  @override
  String get command => 'start';

  @override
  void register() {
    teledart.onCommand(command).listen((message) {
      // ignore: dead_code
      if (false /* check, are user in first aga */ ) {
        final startPage = GetIt.I<StartPage>(); 
        startPage.render(chatId: message.chat.id, renderMethod: startPage.add);
      }
      // ignore: dead_code
      else {
        final mainMenuPage = GetIt.I<MainMenuPage>(); 
        mainMenuPage.render(chatId: message.chat.id, renderMethod: mainMenuPage.add);
      }
    });
  }
}
