import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFirestoreService {
  Future createUserSignIn(dynamic userType);
}