import 'package:get_it/get_it.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/handler-base.dart';
import 'package:vpn_telegram_bot/main-menu.page.dart';

class UsualEntryTestCommandHandler extends BaseHandler {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource => GetIt.I<DialogDataSourceInterface>();

  @override
  String get command => 'usual_entry_test';

  @override
  void register() {
    teledart.onCommand(command).listen((message) {
        final mainMenuPage = GetIt.I<MainMenuPage>(); 
        mainMenuPage.render(chatId: message.chat.id, renderMethod: mainMenuPage.add);
    });
  }
}
