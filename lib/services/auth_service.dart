import 'package:brillo_connectz_assessment/helper/helper_function.dart';
import 'package:brillo_connectz_assessment/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }


  //signin
  Future signupWithEmailandPassword(
      String fullName, String email, String password, String phoneNumber, String interest)
  async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user!;

      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email, phoneNumber, interest);
        return true;
      }

    }on FirebaseAuthException catch (e){
      return e.message;
    }
  }


  //signout
  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await HelperFunctions.saveUserPhoneSF("");
      await HelperFunctions.saveUserInterestSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}