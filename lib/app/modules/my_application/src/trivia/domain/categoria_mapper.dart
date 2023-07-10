import 'dart:convert';

import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';

abstract class CategoriaMapper {
  static Map<String, dynamic> entityToMap(Categoria categoria) {
    return {
      'value': categoria.value
    };
  }

  static String entityToJson(Categoria categoria) {
    var map = entityToMap(categoria);
    return mapToJson(map);
  }

  static Categoria mapToEntity(Map<String, dynamic> map, String id) {
    return Categoria(
      value: map['value'],
      nome: map['nome'],
      id: id,
    );
  }

  static String mapToJson(Map<String, dynamic> map) => json.encode(map);
  static Map<String, dynamic> jsonToMap(String jSon) => json.decode(jSon);
  /*static Categoria jsonToEnsity(String jSon) {
    var map = jsonToMap(jSon);
    return mapToEntity(map);
  }*/
}
