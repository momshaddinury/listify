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
  final String message;
  const FirebaseAuthErrorState({this.message});
}
