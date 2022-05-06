import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication_controller.dart';

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
final firebaseAuthProvider = StateNotifierProvider(
  (ref) => FirebaseAuthController(ref: ref),
);
