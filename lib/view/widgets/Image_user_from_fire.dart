import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/model/hn_user_model.dart';
import 'package:ye_airways/shared/components/constantes.dart';
import 'package:flutter/material.dart';

class ImgUser extends StatefulWidget {
  const ImgUser({Key? key}) : super(key: key);

  @override
  State<ImgUser> createState() => _IState();
}

class _IState extends State<ImgUser> {
  @override
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
          usermodel = HN_UserModel.fromJson(data);
          return CircleAvatar(
            backgroundImage: NetworkImage(data["imgPath"]),
            radius: 71,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
