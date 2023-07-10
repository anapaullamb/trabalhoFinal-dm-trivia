import 'package:flutter_triple/flutter_triple.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_get_categorias_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_get_dominio_categorias_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_put_categoria_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_get_ranking_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/user_ranking_entity.dart';

import '../../domain/use_cases_interfaces/trivia_add_categoria_case_contract.dart';
import '../../domain/use_cases_interfaces/trivia_del_categoria_case_contract.dart';
import '../../domain/categoria_entity.dart';

class TriviaStore extends Store<List<Categoria>?> {
  late final ITriviaGetCategoriasCase _getCategorias;
  late final ITriviaGetDominioCategoriasCase _getDominioCategorias;
  late final ITriviaAddCategoriaCase _addCategoria;
  late final ITriviaDelCategoriaCase _delCategoria;
  late final ITriviaPutCategoriaCase _putCategoria;
  late final ITriviaGetRankingCase _getRanking;


  TriviaStore({
    required ITriviaGetCategoriasCase getCategorias,
    required ITriviaAddCategoriaCase addCategoria,
    required ITriviaDelCategoriaCase delCategoria,
    required ITriviaPutCategoriaCase putCategoria,
    required ITriviaGetRankingCase getRanking,
    required ITriviaGetDominioCategoriasCase getDominioCategoriasCase,
  }) : super(null) {
    _getCategorias = getCategorias;
    _addCategoria = addCategoria;
    _delCategoria = delCategoria;
    _putCategoria = putCategoria;
    _getRanking = getRanking;
    _getDominioCategorias = getDominioCategoriasCase;
  }


  Future<List<Categoria>> getDominioCategorias({required String userId}) async {
    print("getCategoriasDisponiveis");
    var list= await _getDominioCategorias();
    var listUsuario = await _getCategorias( userId);

    List<Categoria> response = list.where((categoria) {
      return !listUsuario.any((categoriaUsuario) => categoriaUsuario.value == categoria.value);
    }).toList();

    return response;
  }
  Future<List<Categoria>> getCategorias({required String userId}) async {
     var result = await _getCategorias( userId);
     update(result);
     return result;
  }
  Future<void> limpaCategoria() async {
    update(null, force: true);
  }
  Future<void> addCategoria({required String userId,required Categoria categoria}) async {
   await _addCategoria(userId,categoria);
  }

  Future<void> delCategoria({required String userId,required String categoriaId}) async {
    await _delCategoria(userId,categoriaId);

  }
  Future<void> putCategoria({required String userId,required String categoriaId,required Categoria categoriaNova}) async {
    await _putCategoria(userId,categoriaId,categoriaNova);
  }

  Future<List<UserRanking>> getRanking() async {
    return await _getRanking();
  }
}
