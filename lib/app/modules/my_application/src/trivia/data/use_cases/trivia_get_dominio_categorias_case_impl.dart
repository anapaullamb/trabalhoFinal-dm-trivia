
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_get_dominio_categorias_case_contract.dart';

import '../../domain/services_interfaces/trivia_service_contract.dart';

class TriviaGetDominioCategoriasCaseImpl implements ITriviaGetDominioCategoriasCase {
  final ITriviaService _triviaService;

  TriviaGetDominioCategoriasCaseImpl(this._triviaService);

  @override
  Future<List<Categoria>> call() async {
    var result = await _triviaService.getDominioCategorias();
    return result;
  }
}
