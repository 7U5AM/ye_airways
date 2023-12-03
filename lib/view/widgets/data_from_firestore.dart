import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ye_airways/model/des_model.dart';
import 'package:ye_airways/model/hn_user_model.dart';
import 'package:ye_airways/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({Key? key, required this.documentId})
      : super(key: key);

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  final dialogUsernameController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  myDialog(Map data, dynamic mykey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: const EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: dialogUsernameController,
                  maxLength: 20,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "  ${data[mykey]}    ",
                    // labelText: "User Name",
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({mykey: dialogUsernameController.text});

                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 17, color: kPrimaryColor),
                        )),
                    TextButton(
                        onPressed: () {
                          // addnewtask();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 17, color: kPrimaryColor),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          HN_UserModel user = HN_UserModel.fromDocument(snapshot.data!);

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 9,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   user.balance.toString(),
                    //   // "UserName: ${data['userName']}",
                    //   style: const TextStyle(
                    //     fontSize: 17,
                    //   ),
                    // ),
                    Text(
                      "Name:  ${data['userName']}",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          myDialog(data, 'userName');
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Email: ${data['email']}",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          myDialog(data, 'email');
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Password: ${data['pass']}",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          myDialog(data, 'pass');
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Phone: ${data['phone']} ",
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          myDialog(data, 'phone');
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   "Balance: \$${data['balance']} ",
                    //   style: const TextStyle(
                    //     fontSize: 17,
                    //   ),
                    // ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Center(
                //   child: TextButton(
                //       onPressed: () {
                //         // credential!.delete();
                //         // Navigator.pushReplacementNamed(context, LoginYEScreen.id);
                //       },
                //       child: const Text(
                //         "Delete User",
                //         style: TextStyle(fontSize: 18, color: Colors.black87),
                //       )),
                // ),
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
