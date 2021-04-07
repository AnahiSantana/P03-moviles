import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: <String>["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isAlreadyLogged() {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebase() async {
    await _auth.signOut();
  }

  //anonimo
  Future<void> anonymousSignIn() async {
    final anonymousUser = (await _auth.signInAnonymously()).user;
    await anonymousUser.updateProfile(
        displayName: "${anonymousUser.uid.substring(0, 5)}_Invitado");
  }

  Future<void> signInwithGoogle() async {
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser.authentication;

    print("user: ${googleUser.displayName}");
    print("user: ${googleUser.email}");
    print("user: ${googleUser.photoUrl}");

    //credenciales
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //firebase sign in
    final authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;
    final firebaseAuthToken = await user.getIdToken();
    assert(!user.isAnonymous);
    assert(firebaseAuthToken != null);
    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    print("Firebase user auth token: $firebaseAuthToken");
  }
}
