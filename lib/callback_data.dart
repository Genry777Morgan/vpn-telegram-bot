// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

class CallbackData {
  String page;
  List<Param>? params;
  CallbackData({
    required this.page,
    this.params,
  });

  static CallbackData fromYaml(String yaml) {
    return loadYaml(yaml);
  }

  // Converted to yaml string
  String toYaml() {
    var yamlWriter = YAMLWriter();

    var yamlDocString = yamlWriter.write(this.toMap());
    return yamlDocString;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'page': page,
      'params': params?.map((x) => x.toMap()).toList(),
    };
  }

  factory CallbackData.fromMap(Map<String, dynamic> map) {
    return CallbackData(
      page: map['page'] as String,
      params: map['params'] != null ? List<Param>.from((map['params'] as List<int>).map<Param?>((x) => Param.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CallbackData.fromJson(String source) => CallbackData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Param {
  String name;
  String value;
  String? type;

  Param({
    required this.name,
    required this.value,
    this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'type': type,
    };
  }

  factory Param.fromMap(Map<String, dynamic> map) {
    return Param(
      name: map['name'] as String,
      value: map['value'] as String,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Param.fromJson(String source) => Param.fromMap(json.decode(source) as Map<String, dynamic>);
}
