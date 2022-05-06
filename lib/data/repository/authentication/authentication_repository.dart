import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final firebaseProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final authStateChangesProvider = StreamProvider<User>(
  (ref) => ref.watch(firebaseProvider).authStateChanges(),
);

final getCurrentUserProvider = Provider<User>(
  (ref) => ref.watch(firebaseProvider).currentUser,
);

final authenticationRepositoryProvider =
    Provider((ref) => _AuthenticationRepository(ref: ref));

class _AuthenticationRepository {
  final Ref ref;
  var _firebase;
  _AuthenticationRepository({this.ref}) {
    _firebase = ref.read(firebaseProvider);
  }

  User user;

  Future signIn({String email, password}) async {
    await _firebase.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signUp({String email, password}) async {
    await _firebase.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signInWithGoogle() async {
    if (kIsWeb) {
      final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      await _firebase.signInWithRedirect(googleAuthProvider);
    } else {
      final GoogleSignInAccount googleUser =
          await ref.read(googleSignInProvider).signIn();

      final GoogleSignInAuthentication googleSignInAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );

      await _firebase.signInWithCredential(credential);
    }
  }

  Future<void> signOut() async {
    await ref.read(googleSignInProvider).signOut();
    await _firebase.signOut();
  }
}
