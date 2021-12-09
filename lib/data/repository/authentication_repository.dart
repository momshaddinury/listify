import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:listify/data/constant/shared_preference_key.dart';
import 'package:listify/views/screens/home/home_screen.dart';
import 'package:listify/views/screens/startup/welcome_screen.dart';
import '../../main.dart';

class AuthenticationRepository {
  final firebaseInstance = FirebaseAuth.instance;

  Rx<User> firebaseUser;
  bool isLoading = false;

  Future<void> checkIfUserIsLoggedIn() async {
    firebaseUser = Rx(firebaseInstance.currentUser);
    firebaseUser.bindStream(firebaseInstance.authStateChanges());
    ever(firebaseUser, (User user) async {
      if (user != null) {
        await box.write(USER_UID, user.uid);
        Get.offAll(() => HomeScreen());
      } else
        Get.offAll(() => WelcomeScreen());
    });
  }

  User getCurrentUser() => firebaseInstance.currentUser;

  Future<void> signUp({String email, password}) async {
    await firebaseInstance.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signIn({String email, password}) async {
    await firebaseInstance.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await firebaseInstance.signOut();
  }
}
