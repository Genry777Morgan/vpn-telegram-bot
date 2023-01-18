import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:vpn_telegram_bot/constans.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/handler/handler-base.dart';
import 'package:vpn_telegram_bot/page/main-menu.page.dart';

class StartCommandHandler extends BaseHandler {
  @override
  TeleDart get teledart => GetIt.I<TeleDart>();
  @override
  DialogDataSourceInterface get dialogDataSource =>
      GetIt.I<DialogDataSourceInterface>();

  @override
  String get command => 'start';

  @override
  void register () {
    /* teledart.onCommand(command).listen((message) async { */
    /*   if (message.from == null) { */
    /*     return; // TODO */
    /*   } */
    /**/
    /*   var response = await http.post(Uri.http(host, "/users"), */
    /*       body: jsonEncode({ */
    /*         "telegramId": message.from?.id.toString(), */
    /*         "username": message.from?.username */
    /*       })); */
    /**/
    /*   print(response.body); */
    /**/
    /*   var mainMenu = GetIt.I<MainMenuPage>(); */
    /*   mainMenu.render(chatId: message.chat.id, renderMethod: mainMenu.send); */
    /* }); */
  }
}
