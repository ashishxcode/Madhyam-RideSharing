import 'package:firebase_auth/firebase_auth.dart';

class Authenticator {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //can be print in console i guess
  Future<UserCredential> getAnonUserSingInResult() async {
    UserCredential result;
    try {
      result = await _auth.signInAnonymously();
      //UserCredential.user type=FireBaseUser
      return result;
    } catch (e) {
      result = null;
    }
  }

  Future<User> getAnonUserData(UserCredential result) async {
    User user;
    try {
      user = await result.user;
      return user;
    } catch (e) {
      user = null;
    }
  }

  Future<User> getCurrentFireBaseUser() async {
    var user = _auth.currentUser;
    return user;
  }

  Future<String> getCurrentFireBaseUserID() async {
    var currentUser = _auth.currentUser;
    String currentUserId = currentUser.uid;
    if (currentUserId == null) {
      return 'NoUserYet';
    } else {
      return currentUser.uid;
    }
  }

  // Sing in with email
  Future signInWithEmailAndPasssword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  // Register with email
  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> getCurrentFireBaseUserPhone() async {
    User currentUser = _auth.currentUser;
    String currentUserPhone = currentUser.phoneNumber;
    if (currentUserPhone == null) {
      return 'NoUserYet';
    } else {
      return currentUser.phoneNumber;
    }
  }

  Future<String> getCurrentFireBaseUserEmail() async {
    User currentUser = _auth.currentUser;
    String currentUserEmail = currentUser.email;
    if (currentUserEmail == null) {
      return 'NoUserYet';
    } else {
      return currentUser.email;
    }
  }

  Future<bool> isUserAuthenticated() async {
    var currentUser = _auth.currentUser;
    if (currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  // Sing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
