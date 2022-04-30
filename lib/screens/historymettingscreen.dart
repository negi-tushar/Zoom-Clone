import 'package:flutter/material.dart';
import 'package:zoom_clone/services/firestore_methods.dart';
import 'package:intl/intl.dart';

class HistoryMettingScreen extends StatelessWidget {
  const HistoryMettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirestoreMethods _firestoreMethods = FirestoreMethods();
    return StreamBuilder(
        stream: _firestoreMethods.mettingsHistory,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: (snapshot.data! as dynamic).docs.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  'Room Name : ${(snapshot.data! as dynamic).docs[index]['meeting id']}'),
              subtitle: Text(
                'Joined on : ${DateFormat.yMMMEd().format((snapshot.data! as dynamic).docs[index]['StartTime'].toDate())}'
                    .toString(),
              ),
            ),
          );
          ;
        });
  }
}
