import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get mettingsHistory => _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('mettings')
      .snapshots();

  void addToMettingHistory(String roomName) async {
    print('print------->${_auth.currentUser!.displayName}');
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('mettings')
          .add({
        'meeting id': roomName,
        'StartTime': DateTime.now(),
      });
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }
}
