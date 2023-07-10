import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/user_ranking_entity.dart';

import '../categoria_entity.dart';

abstract class ITriviaService {
  Future<List<Categoria>> getDominioCategorias();
  Future<List<Categoria>> getCategorias(String userId);
  Future<List<UserRanking>> getRanking();
  Future<void> addCategoria(String userId, Categoria categoria);
  Future<void> delCategoria(String userId, String categoriaId);
  Future<void> putCategoria(String userId, String categoriaId, Categoria categoriaNova);
}
