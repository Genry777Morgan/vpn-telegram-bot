import 'package:get_it/get_it.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:vpn_telegram_bot/callback_data.dart';
import 'package:vpn_telegram_bot/configurations.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:vpn_telegram_bot/data/yaml_dialog.data_source.dart';
import 'package:vpn_telegram_bot/pages/start.page.dart';

Future<void> main() async {
  var botToken = Configurations.config['ApiToken'];
  final username = (await Telegram(botToken).getMe()).username;

  // region registrations

  GetIt.I.registerSingleton<TeleDart>(TeleDart(botToken, Event(username!)));
  GetIt.I.registerSingleton<DialogDataSourceInterface>(YamlDialogDataSource());

  //endregion

  final teledart = GetIt.I<TeleDart>();

  teledart
      .onMessage(keyword: 'test')
      .listen((message) => message.reply('true'));

  GetIt.I.registerSingleton<StartPage>(StartPage());

  // yaml test
  CallbackData call = CallbackData(page: "yam_call_back");

  print(call.toYaml());
  
  teledart.onCommand('yaml')
    .listen((message) => message.reply('click to button to make call back data',
      reply_markup: InlineKeyboardMarkup(inline_keyboard: [[InlineKeyboardButton(text: 'send call back', callback_data: call.toYaml())]])));

  // Tests
  teledart.onCommand('main_keyboard')
    .listen((message) => message.reply('to something!', reply_markup: ReplyKeyboardMarkup(keyboard: [[KeyboardButton(text: 'text')]])));

  teledart.onCommand('inline_keyboard')
    .listen((message) => message.reply('to something!', reply_markup: InlineKeyboardMarkup(inline_keyboard: [[InlineKeyboardButton(text: 'text', callback_data: 'data')]])));
  
  teledart.start();
}