import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:nb_utils/nb_utils.dart';

import 'authentication_provider.dart';
import 'authentication_state.dart';

class FirebaseAuthController extends StateNotifier<FirebaseAuthState> {
  final Ref ref;

  FirebaseAuthController({this.ref}) : super(FirebaseAuthInitialState());

  User user;

  Future<void> signIn({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();
      await ref
          .read(firebaseProvider)
          .signInWithEmailAndPassword(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      state = FirebaseAuthErrorState(message: e.message);
    }
  }

  Future<void> signUp({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();
      await ref
          .read(firebaseProvider)
          .createUserWithEmailAndPassword(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      state = FirebaseAuthErrorState(message: e.message);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = FirebaseAuthLoadingState();
      if (kIsWeb) {
        final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        await ref.read(firebaseProvider).signInWithRedirect(googleAuthProvider);
      } else {
        final GoogleSignInAccount googleUser =
            await ref.read(googleSignInProvider).signIn();

        final GoogleSignInAuthentication googleSignInAuth =
            await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );

        await ref.read(firebaseProvider).signInWithCredential(credential);
      }
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      state = FirebaseAuthErrorState(message: e.message);
    } catch (e, stackTrace) {
      print(e.toString());
      print(stackTrace);
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
            print(e);
            print(stackTrace);
          }
          return state = FirebaseAuthSuccessState();
        } else {
          return state = FirebaseAuthErrorState();
        }
      },
    );
  }

  Future<void> signOut() async {
    await ref.read(googleSignInProvider).signOut();
    await ref.read(firebaseProvider).signOut();
  }
}
