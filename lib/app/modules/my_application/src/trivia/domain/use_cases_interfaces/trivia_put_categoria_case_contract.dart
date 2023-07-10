import '../categoria_entity.dart';

abstract class ITriviaPutCategoriaCase {
  Future<void> call(String userId,String categoriaId, Categoria categoriaNova);
}
