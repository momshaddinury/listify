import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/core/base/base_state.dart';
import 'package:listify/core/logger.dart';
import 'package:listify/data/repository/authentication/authentication_repository.dart';
import 'package:listify/core/dependency/repository.dart';
import 'package:nb_utils/nb_utils.dart';

final authenticationProvider = StateNotifierProvider(
  (ref) => AuthenticationController(ref: ref),
);

class AuthenticationController extends StateNotifier<BaseState> {
  AuthenticationController({this.ref}) : super(InitialState()) {
    _repository = ref.watch(Repository.authentication);
  }

  final Ref ref;
  AuthenticationRepository _repository;
  User user;

  static StateNotifierProvider<AuthenticationController, dynamic>
      get controller => authenticationProvider;

  Future<void> signIn({String email, password}) async {
    try {
      state = LoadingState();
      await _repository.signIn(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      state = ErrorState(message: e.message);
    }
  }

  Future<void> signUp({String email, password}) async {
    try {
      state = LoadingState();
      await _repository.signUp(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = ErrorState(message: e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = LoadingState();
      await _repository.signInWithGoogle();
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = ErrorState(message: e.message);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      state = ErrorState(message: "Something went wrong");
    }
  }

  void authStateChangeStatus() {
    ref.read(authStateChangesProvider).whenData(
      (user) {
        if (user != null) {
          this.user = user;
          try {
            setValue(USER_UID, this.user.uid);
            print(this.user.uid);
          } catch (e, stackTrace) {
            Log.error(e);
            Log.error(stackTrace.toString());
            state = ErrorState(message: e.toString());
          }
          return state = SuccessState();
        } else {
          state = ErrorState(message: "Something went wrong");
        }
      },
    );
  }

  Future<void> signOut() async => await _repository.signOut();
}
