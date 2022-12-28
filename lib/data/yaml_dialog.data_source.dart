import 'dart:io';

import 'package:vpn_telegram_bot/configurations.dart';
import 'package:vpn_telegram_bot/data/interfaces/dialog.data_source.interface.dart';
import 'package:vpn_telegram_bot/data/layout.enum.dart';
import 'package:yaml/yaml.dart';

class YamlDialogDataSource extends DialogDataSourceInterface {
  static final _data = _load();
  String get separator => '/';
  
 static Map _load() {
    String path = Configurations.config['layoutsPath'];
    File file = File(path);
    String yamlString = file.readAsStringSync();
    return loadYaml(yamlString);
  }
  
  /// Указывать путь через '/', допустим
  /// А лучше использовать YamlDialogDataSource.separatorSymbol
  // TODO нуждаеться в милионе дороботок и пероверок
  @override
  String getMessage(String path, LayoutEnum layout) {
   
    var layoutData = _data[layout.name];
    
    final pathArr = path.split(separator);
    for (var item in pathArr) {
      layoutData = layoutData[item];
    }
    
    return layoutData['message'];
  }
  
  @override
  String getButtonText(String path, String name, LayoutEnum layout) {

    var layoutData = _data[layout.name];
    
    final pathArr = path.split(separator);
    for (var item in pathArr) {
      layoutData = layoutData[item];
    }
    
    return layoutData['buttons'][name];
  }
}