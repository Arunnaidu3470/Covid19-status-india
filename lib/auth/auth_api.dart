import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthApi {
  Future handleSignIn();
  Future handleSignOut();
}

class FirebaseAuthApi extends AuthApi with ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Status _status = Status.Uninitialized;
  AppUser _user;

  AppUser get user => _user;
  Status get status => _status;

  FirebaseAuthApi.initialize() {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = AppUser.fromFirebaseUser(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  @override
  Future<AppUser> handleSignIn() async {
    //initilize googlesignin
    try {
      _status = Status.Authenticating;
      notifyListeners();

      final GoogleSignInAccount googleUser = await _googleSignIn
          .signIn()
          .catchError((Object obj) => throw new Exception());
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      //create a auth creditional with tokens
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      //return firebase user
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      return AppUser.fromFirebaseUser(user);
    } catch (e) {
      if (e is PlatformException) print('sign in unapproved PlatformExcetion');
      _status = Status.Unauthenticated;
      notifyListeners();
      return null;
    }
    //get auth tokens
  }

  @override
  Future<void> handleSignOut() {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future<void>.delayed(Duration.zero);
  }
}

class AppUser {
  String uid;
  String displayName;
  String email;
  String photoUrl;
  AppUser({this.uid, this.displayName, this.email, this.photoUrl});

  factory AppUser.fromFirebaseUser(FirebaseUser user) {
    if (user == null) return AppUser();
    return AppUser(
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoUrl,
      uid: user.uid,
    );
  }

  void updateValuesWithFirebaseUser(FirebaseUser user) {
    uid = user.uid;
    email = user.email;
    photoUrl = user.photoUrl;
    uid = user.uid;
  }

  void updateValuesWithAppUser(AppUser user) {
    uid = user.uid;
    email = user.email;
    photoUrl = user.photoUrl;
    uid = user.uid;
  }
}

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }
