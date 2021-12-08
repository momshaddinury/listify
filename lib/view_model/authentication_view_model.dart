import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:listify/data/repository/authentication_repository.dart';
import 'package:listify/views/widgets/snack_bar.dart';


class AuthenticationViewModel extends GetxController {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  bool isLoading = false;

  @override
  void onReady() {
    super.onReady();
    _authenticationRepository.checkIfUserIsLoggedIn();
  }

  User getCurrentUser()  => _authenticationRepository.getCurrentUser();

  Future signUp({String email, password}) async {
    try {
      _updateLoadingState(true);
      await _authenticationRepository.signUp(email: email, password: password);
      _updateLoadingState(false);
    } on FirebaseAuthException catch (e) {
      _updateLoadingState(false);
      kSnackBar('Firebase Exception Code: ${e.code}', e.message);
    }
  }

  Future signIn({String email, password}) async {
    try {
      _updateLoadingState(true);
      await _authenticationRepository.signIn(email: email, password: password);
      _updateLoadingState(false);
    } on FirebaseAuthException catch (e) {
      _updateLoadingState(false);
      kSnackBar('Firebase Exception Code: ${e.code}', e.message);
    }
  }

  Future signOut() => _authenticationRepository.signOut();

  void _updateLoadingState(bool _isLoading) {
    isLoading = _isLoading;
    update();
  }
}
