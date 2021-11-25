import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:listify/constant/shared_preference_key.dart';
import 'package:listify/views/screens/home_screen.dart';
import 'package:listify/views/screens/startup/welcome_screen.dart';
import 'package:listify/views/widgets/snack_bar.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthenticationController extends GetxController {
  final firebaseInstance = FirebaseAuth.instance;

  Rx<User> firebaseUser;
  bool isLoading = false;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx(firebaseInstance.currentUser);
    firebaseUser.bindStream(firebaseInstance.authStateChanges());
    ever(firebaseUser, (User user) {
      if (user != null) {
        /// TODO: Replace setValue(key, value) with GetStroage
        setValue(USER_UID, user.uid);
        Get.offAll(() => HomeScreen());
      } else
        Get.offAll(() => WelcomeScreen());
    });
  }

  Future signUp({String email, password}) async {
    try {
      _updateLodingState(true);
      await firebaseInstance.createUserWithEmailAndPassword(email: email, password: password);
      _updateLodingState(false);
    } on FirebaseAuthException catch (e) {
      _updateLodingState(false);
      kSnackBar('Firbease Exception Code: ${e.code}', e.message);
    }
  }

  Future signIn({String email, password}) async {
    try {
      _updateLodingState(true);
      await firebaseInstance.signInWithEmailAndPassword(email: email, password: password);
      _updateLodingState(false);
    } on FirebaseAuthException catch (e) {
      _updateLodingState(false);
      kSnackBar('Firbease Exception Code: ${e.code}', e.message);
    }
  }

  Future signOut() async {
    await firebaseInstance.signOut();
  }

  void _updateLodingState(bool _isLoading) {
    isLoading = _isLoading;
    update();
  }
}
