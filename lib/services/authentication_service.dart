import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  Future signIn({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();

      await ref.read(firebaseProvider).signInWithEmailAndPassword(email: email, password: password);
      ref.read(authStateChangesProvider).whenData(
            (user) => user != null ? state = FirebaseAuthSuccessState() : state = FirebaseAuthErrorState(),
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
            (user) => user != null ? state = FirebaseAuthSuccessState() : state = FirebaseAuthErrorState(),
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

abstract class FirebaseAuthState {
  const FirebaseAuthState();
}

class FirebaseAuthInitialState extends FirebaseAuthState {
  const FirebaseAuthInitialState();
}

class FirebaseAuthLoadingState extends FirebaseAuthState {
  const FirebaseAuthLoadingState();
}

class FirebaseAuthSuccessState extends FirebaseAuthState {
  const FirebaseAuthSuccessState();
}

class FirebaseAuthErrorState extends FirebaseAuthState {
  const FirebaseAuthErrorState();
}
