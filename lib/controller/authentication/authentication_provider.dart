import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'authentication_controller.dart';

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
