import 'package:capstoneproject2/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireStoreServiceImpl extends IFirestoreService {
  final _fireStore = FirebaseFirestore.instance.collection("user");

  @override
  Future createUserSignIn(userType) async {
    if(userType is GoogleSignInAccount) {
      await _fireStore.add({
        "username" : userType.displayName,
        "email" : userType.email,
        "avatarUrl" : userType.photoUrl
      });
    }

  }

}