import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:nb_utils/nb_utils.dart';

import 'authentication_state.dart';

final firebaseProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateChangesProvider = StreamProvider<User>(
  (ref) => ref.watch(firebaseProvider).authStateChanges(),
);

final getCurrentUserProvider = Provider<User>(
  (ref) => ref.watch(firebaseProvider).currentUser,
);

final firebaseAuthProvider = StateNotifierProvider(
  (ref) => FirebaseAuthController(ref: ref),
);

class FirebaseAuthController extends StateNotifier<FirebaseAuthState> {
  final Ref ref;

  FirebaseAuthController({this.ref}) : super(FirebaseAuthInitialState());

  User user;

  Future signIn({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();

      await ref.read(firebaseProvider).signInWithEmailAndPassword(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      state = FirebaseAuthErrorState(message: e.message);

      return e.message;
    }
  }

  Future signUp({String email, password}) async {
    try {
      state = FirebaseAuthLoadingState();
      await ref.read(firebaseProvider).createUserWithEmailAndPassword(email: email, password: password);
      authStateChangeStatus();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      print(e.message);
      state = FirebaseAuthErrorState(message: e.message);
    }
  }

  authStateChangeStatus() {
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

  Future signOut() async => await ref.read(firebaseProvider).signOut();
}
