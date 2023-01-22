import 'dart:io';

import 'package:vpn_telegram_bot/constants.dart';
import 'package:yaml/yaml.dart';
import 'package:vpn_telegram_bot/configurations.dart' as libConfig;

class Configurations {
  static final botToken = libConfig.Configurations.config['botToken'];
  static final backendHost =
      '${libConfig.Configurations.config['backend']['host']}:${libConfig.Configurations.config['backend']['port']}';
  static final botHost =
      '${libConfig.Configurations.config['bot']['host']}:${libConfig.Configurations.config['bot']['port']}';
}
