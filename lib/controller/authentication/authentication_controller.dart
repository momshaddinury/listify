import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authentication_state.dart';

final firebaseProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User>(
  (ref) => ref.watch(firebaseProvider).authStateChanges(),
);

final firebaseAuthProvider = StateNotifierProvider(
  (ref) => FirebaseAuthController(ref: ref),
);

class FirebaseAuthController extends StateNotifier<FirebaseAuthState> {
  final ProviderReference ref;
  FirebaseAuthController({this.ref}) : super(FirebaseAuthInitialState());

  User user;

  Future signIn({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();

      await ref.read(firebaseProvider).signInWithEmailAndPassword(email: email, password: password);
      ref.read(authStateChangesProvider).whenData(
        (user) {
          if (user != null) this.user = user;
          return user != null ? state = FirebaseAuthSuccessState() : state = FirebaseAuthErrorState();
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      state = FirebaseAuthErrorState();

      return e.message;
    }
  }

  Future signUp({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();

      await ref.read(firebaseProvider).createUserWithEmailAndPassword(email: email, password: password);
      ref.read(authStateChangesProvider).whenData(
        (user) {
          if (user != null) this.user = user;
          return user != null ? state = FirebaseAuthSuccessState() : state = FirebaseAuthErrorState();
        },
      );
    } on FirebaseAuthException catch (e) {
      state = FirebaseAuthErrorState();
      return e.message;
    }
  }

  Future signOut() async {
    state = FirebaseAuthLoadingState();

    await ref.read(firebaseProvider).signOut();
    state = FirebaseAuthSuccessState();
  }
}
