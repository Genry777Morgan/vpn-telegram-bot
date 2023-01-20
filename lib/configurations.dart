import 'dart:io';

import 'package:yaml/yaml.dart';

class Configurations {
  // static final Map config = _load();

  static Map _load() {
    String path = 'config.yaml';
    File file = File(path);
    String yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  }
}
