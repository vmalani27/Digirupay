import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of FirebaseAuth

  final FirebaseAuth _auth= FirebaseAuth.instance;
  final FirebaseFirestore _firestore= FirebaseFirestore.instance;

  //get current user
  User? getcurrentuser(){
    return _auth.currentUser;
  }
  
  // Sign in with email and password
  Future<UserCredential> signinWithEmailPassword(String email, String password,) async {
    try {
      // Sign in the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'lastSignIn': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true), // Avoid overwriting existing data
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // Re-throw the error with a meaningful message
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  // Register with email and password
  Future<UserCredential> registerWithEmailPassword(String email, String password, String full_name) async {
    try {
      // Create a new user
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user data in Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'full name' : full_name,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code); // Re-throw the Firebase-specific error
    } catch (e) {
      throw Exception("An unexpected error occurred: $e");
    }
  }

  // Get user details by UID
  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection("Users").doc(uid).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Failed to fetch user details: $e");
    }
  }
  //get user full name
  Future<String?> getUserFullName() async {
  User? user = _auth.currentUser;
  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("users").doc(user.uid).get();

    if (snapshot.exists) {
      return snapshot.data()?['name']; // Assuming 'name' is the field in Firestore
    }
  }
  return null; // If user data is not found
}

  // Sign out
  Future <void> signout() async{
    return await _auth.signOut();
  }

  //errors
}
