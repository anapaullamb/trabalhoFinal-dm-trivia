
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_get_categorias_case_contract.dart';

import '../../domain/services_interfaces/trivia_service_contract.dart';
import '../../domain/use_cases_interfaces/trivia_add_categoria_case_contract.dart';

class TriviaGetCategoriasCaseImpl implements ITriviaGetCategoriasCase {
  final ITriviaService _triviaService;

  TriviaGetCategoriasCaseImpl(this._triviaService);

  @override
  Future<List<Categoria>> call(String userId) async {
    var result = await _triviaService.getCategorias(userId);
    return result;
  }
}
