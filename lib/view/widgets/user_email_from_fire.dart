import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class EmailUser extends StatefulWidget {
  const EmailUser({Key? key}) : super(key: key);

  @override
  State<EmailUser> createState() => _EmailUserState();
}

class _EmailUserState extends State<EmailUser> {
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // ${data['title']}
          return Container(
            child:
                Text(data["email"], style: const TextStyle(color: kWhiteColor)),
          );
        }

        return const Text("loading");
      },
    );
  }
}
