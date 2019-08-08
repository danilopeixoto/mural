import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationService {
  static final AuthenticationService instance = AuthenticationService();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _authentication = FirebaseAuth.instance;
  final Firestore _database = Firestore.instance;

  Observable<FirebaseUser> user;
  PublishSubject loading = PublishSubject();

  AuthenticationService() {
    user = Observable(_authentication.onAuthStateChanged);
  }
  
  Future<FirebaseUser> signIn() async {
    loading.add(true);
    
    GoogleSignInAccount account = await _googleSignIn.signIn();
    FirebaseUser user;

    if (account != null) {
      GoogleSignInAuthentication auth = await account.authentication;
      
      user = await _authentication.signInWithGoogle(
        accessToken: auth.accessToken,
        idToken: auth.idToken
      );
      
      updateUserData(user);
    }
    
    loading.add(false);

    return user;
  }

  void signOut() async {
    await _authentication.signOut();
    await _googleSignIn.disconnect();
  }

  void deleteAccount() async {
    loading.add(true);

    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication auth = await account.authentication;

    await _authentication.reauthenticateWithGoogleCredential(
      accessToken: auth.accessToken,
      idToken: auth.idToken
    );
    
    FirebaseUser user = await _authentication.currentUser();

    deleteUserData(user);

    await user.delete();
    signOut();

    loading.add(false);
  }

  void updateUserData(FirebaseUser user) async {
    DocumentReference document = _database.collection('users').document(user.uid);

    return document.setData({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'photoURL': user.photoUrl
      },
      merge: true
    );
  }

  void deleteUserData(FirebaseUser user) async {
    DocumentReference document = _database.collection('users').document(user.uid);
    return document.delete();
  }
}