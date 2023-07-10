
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';

import '../../domain/services_interfaces/trivia_service_contract.dart';
import '../../domain/use_cases_interfaces/trivia_add_categoria_case_contract.dart';

class TriviaAddCategoriaCaseImpl implements ITriviaAddCategoriaCase {
  final ITriviaService _triviaService;

  TriviaAddCategoriaCaseImpl(this._triviaService);

  @override
  Future<void> call(String userId, Categoria categoria) async {
    var result = await _triviaService.addCategoria(userId,categoria);
    return result;
  }
}
