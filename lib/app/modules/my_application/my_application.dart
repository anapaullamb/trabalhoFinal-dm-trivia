import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_incrementa_pontuacao_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_signin_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_signout_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/data/use_cases/auth_signup_user_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/user_credencial_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/external/cache/auth_local_cache_sp_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/external/services/email_auth_service_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/manager/auth_service_manager.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/data/use_cases/trivia_add_categoria_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/data/use_cases/trivia_del_categoria_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/data/use_cases/trivia_get_categorias_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/data/use_cases/trivia_get_dominio_categorias_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/data/use_cases/trivia_put_categoria_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/data/use_cases/trivia_get_ranking_case_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/use_cases_interfaces/trivia_del_categoria_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/external/services/trivia_service_impl.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/home_page.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/page_3.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/page_4.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/signin_view.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/page_1.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/page_2.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/signup_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_guard.dart';

class MyApplication extends Module {
  @override
  List<Bind> binds = [
    Bind.lazySingleton((i) => AuthServiceManager(AuthType.email)),
    Bind.lazySingleton((i) => EmailAuthServiceImpl()),
    Bind.singleton((i) => AuthLocalCacheSharedPrefsImpl()),
    Bind.lazySingleton((i) => AuthSignInUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthSignOutUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthSignUpUserCaseImpl(i())),
    Bind.lazySingleton((i) => AuthIncrementaPontuacaoUserCaseImpl(i())),
    Bind.lazySingleton((i) => TriviaServiceImpl()),
    Bind.lazySingleton((i) => TriviaAddCategoriaCaseImpl(i())),
    Bind.lazySingleton((i) => TriviaGetCategoriasCaseImpl(i())),
    Bind.lazySingleton((i) => TriviaDelCategoriaCaseImpl(i())),
    Bind.lazySingleton((i) => TriviaPutCategoriaCaseImpl(i())),
    Bind.lazySingleton((i) => TriviaGetRankingCaseImpl(i())),
    Bind.lazySingleton((i) => TriviaGetDominioCategoriasCaseImpl(i())),
    Bind.singleton<AuthStore>(
      (i) => AuthStore(
        userSignIn: i(),
        userIncrementaPontuacao: i(),
        userSignOut: i(),
        userSignUp: i(),
        localCache: i(),
        triviaStore: i(),
      ),
      onDispose: (store) => store.destroy,
      selector: (store) => store.state,
    ),
    Bind.singleton<TriviaStore>(
      (i) => TriviaStore(
        getCategorias: i(),
        putCategoria: i(),
        delCategoria: i(),
        addCategoria: i(),
        getDominioCategoriasCase: i(),
        getRanking: i(),
      ),
      onDispose: (store) => store.destroy,
      selector: (store) => store.state,
    ),
  ];

  @override
  List<ModularRoute> routes = [
    ChildRoute('/', child: (ctx, args) => const Home(), guards: [HomeGuard()]),
    ChildRoute(
      '/signin-page',
      child: (context, args) => SignInPage(),
    ),
    ChildRoute(
      '/login-page',
      child: (context, args) => SignInPage(),
    ),
    ChildRoute(
      '/signup-page',
      child: (context, args) => SignUpPage(),
    ),
    ChildRoute(
      '/page1',
      child: (context, args) => Page1(),
    ),
    ChildRoute(
      '/page2',
      child: (context, args) => Page2(),
    ),
    ChildRoute(
      '/page3',
      child: (context, args) => Page3(categoriaEditar: args.data),
    ),
    ChildRoute(
      '/page4',
      child: (context, args) => TelaInicial(),
    ),
  ];
}
