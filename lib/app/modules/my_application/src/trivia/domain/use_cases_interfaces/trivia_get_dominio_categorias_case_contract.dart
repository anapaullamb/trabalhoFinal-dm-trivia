import '../categoria_entity.dart';

abstract class ITriviaGetDominioCategoriasCase {
  Future<List<Categoria>> call();
}
