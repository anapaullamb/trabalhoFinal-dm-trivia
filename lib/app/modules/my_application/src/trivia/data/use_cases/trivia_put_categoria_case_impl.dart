import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';

import '../../domain/services_interfaces/trivia_service_contract.dart';
import '../../domain/use_cases_interfaces/trivia_put_categoria_case_contract.dart';

class TriviaPutCategoriaCaseImpl implements ITriviaPutCategoriaCase {
  final ITriviaService _triviaService;

  TriviaPutCategoriaCaseImpl(this._triviaService);

  @override
  Future<void> call(String userId, String categoriaId, Categoria categoriaNova) async {
    var result = await _triviaService.putCategoria( userId, categoriaId,categoriaNova);
    return result;
  }
}
