import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/core/logger.dart';
import 'package:listify/data/repository/authentication/authentication_repository.dart';
import 'package:nb_utils/nb_utils.dart';

import 'authentication_state.dart';

class FirebaseAuthController extends StateNotifier<FirebaseAuthState> {
  final Ref ref;
  FirebaseAuthController({this.ref}) : super(FirebaseAuthInitialState());

  User user;

  Future<void> signIn({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();
      ref
          .read(authenticationRepositoryProvider)
          .signIn(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      state = FirebaseAuthErrorState(message: e.message);
    }
  }

  Future<void> signUp({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();
      await ref
          .read(authenticationRepositoryProvider)
          .signUp(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = FirebaseAuthErrorState(message: e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = FirebaseAuthLoadingState();
      await ref.read(authenticationRepositoryProvider).signInWithGoogle();
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      Log.error(e.code);
      Log.error(e.message);
      state = FirebaseAuthErrorState(message: e.message);
    } catch (e, stackTrace) {
      Log.error(e.toString());
      Log.error(stackTrace.toString());
      state = FirebaseAuthErrorState(message: "Something went wrong");
    }
  }

  void authStateChangeStatus() {
    ref.read(authStateChangesProvider).whenData(
      (user) {
        if (user != null) {
          this.user = user;
          try {
            setValue(USER_UID, this.user.uid);
          } catch (e, stackTrace) {
            Log.error(e);
            Log.error(stackTrace.toString());
          }
          return state = FirebaseAuthSuccessState();
        } else {
          return state = FirebaseAuthErrorState();
        }
      },
    );
  }

  Future<void> signOut() async =>
      await ref.read(authenticationRepositoryProvider).signOut();
}
