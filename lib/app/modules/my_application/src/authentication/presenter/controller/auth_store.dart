import 'package:flutter_triple/flutter_triple.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/use_cases_interfaces/auth_incrementa_pontuacao_user_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/use_cases_interfaces/auth_signup_user_case_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/cache_interfaces/auth_local_cache_contract.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';

import '../../domain/use_cases_interfaces/auth_signin_user_case_contract.dart';
import '../../domain/use_cases_interfaces/auth_signout_user_case_contract.dart';
import '../../domain/user_credencial_entity.dart';

class AuthStore extends Store<UserCredentialApp?> {
  late final IAuthSignInUseCase _userSignIn;
  late final IAuthSignOutUseCase _userSignOut;
  late final IAuthSignUpUseCase _userSignUp;
  late final IAuthLocalCache _localCache;
  late final IAuthIncrementaPontuacaoUseCase _userIncrementaPontuacao;
  late final TriviaStore _triviaStore;

  bool _isAuth = false;

  AuthStore({
    required IAuthSignInUseCase userSignIn,
    required IAuthSignOutUseCase userSignOut,
    required IAuthSignUpUseCase userSignUp,
    required IAuthIncrementaPontuacaoUseCase userIncrementaPontuacao,
    required IAuthLocalCache localCache,
    required TriviaStore triviaStore,
  }) : super(null) {
    _userSignIn = userSignIn;
    _userSignOut = userSignOut;
    _userSignUp = userSignUp;
    _localCache = localCache;
    _triviaStore = triviaStore;
    _userIncrementaPontuacao = userIncrementaPontuacao;
    _userLocalCache();
  }

  bool get isAuth => _isAuth;

  Future<void> userSignIn(
      {required String email, required String password}) async {
    setLoading(true);
    var result = await _userSignIn(email, password);
    //await Future.delayed(const Duration(seconds: 5), () {});
    result.fold(
      (error) => setError(error),
      (userCredential) async {
        await _localCache.save(user: userCredential);
        _isAuth = true;
        update(userCredential);
        await _triviaStore.getCategorias(userId: userCredential!.uId!);
      },
    );
    setLoading(false);
  }

  Future<void> userSignUp(
      {required String email,
      required String password,
      required String name}) async {
    setLoading(true);
    var result = await _userSignUp(email, password, name);
    //await Future.delayed(const Duration(seconds: 5), () {});
    result.fold(
      (error) => setError(error),
      (userCredential) async {
        await _localCache.save(user: userCredential);
        _isAuth = true;
        update(userCredential);
        await _triviaStore.getCategorias(userId: userCredential!.uId!);
      },
    );
    setLoading(false);
  }

  Future<void> userSignOut() async {
    if (_isAuth) {
      _localCache.delete(user: state as UserCredentialApp);
      await _userSignOut.call();
      UserCredentialApp? signOut = null;
      _isAuth = false;
      update(signOut, force: true);
      _triviaStore.limpaCategoria();
    }
  }

  Future<void> userIncrementaPontuacao() async {
    if (_isAuth) {
      UserCredentialApp? user = state;
      user!.pontuacao = await _userIncrementaPontuacao(user!.uId!, user!.pontuacao!);
      await _localCache.save(user: user);
      update(user);
    }
  }


  Future<void> _userLocalCache() async {
    if (_isAuth) {
      return;
    }

    setLoading(true);

    var result = await _localCache.fetch();
    result.fold(
      (error) => setError(error),
      (userCredential) async {
        // var d = DateTime.now().subtract(Duration(hours: 2));
        if ((userCredential.tokenExpireIn == null) ||
            (userCredential.tokenExpireIn!.isBefore(DateTime.now()))) {
          // (d.isBefore(DateTime.now()))) {
          await _localCache.delete(user: userCredential);
          _isAuth = false;
          update(null, force: true);
        } else {
          var resultNew =
              await _userSignIn(userCredential.email, userCredential.password!);
          resultNew.fold(
            (error) async {
              await _localCache.delete(user: userCredential);
              setError(error);
            },
            (userCredentialRenew) {
              _isAuth = true;
              update(userCredentialRenew);
            },
          );
        }
      },
    );
    setLoading(false);
  }
}
