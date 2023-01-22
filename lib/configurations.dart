import 'dart:io';

import 'package:vpn_telegram_bot/constants.dart';
import 'package:yaml/yaml.dart';

class Configurations {
  static final Map config = _load();

  static Map _load() {
    String path = configurationPath;
    File file = File(path);
    String yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  }
}
