import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/core/base/base_state.dart';
import 'package:listify/core/logger.dart';
import 'package:listify/data/repository/authentication/authentication_repository.dart';
import 'package:nb_utils/nb_utils.dart';

final authenticationProvider = StateNotifierProvider(
  (ref) => _AuthenticationController(ref: ref),
);

class _AuthenticationController extends StateNotifier<BaseState> {
  final Ref ref;
  AuthenticationRepository _repository;

  _AuthenticationController({this.ref}) : super(InitialState()) {
    _repository = ref.watch(authenticationRepositoryProvider);
  }

  User user;

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
