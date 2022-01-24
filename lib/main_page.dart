import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uas_ihsansayidmuharrom_d111811012_if7c/auth_service.dart';
import 'package:uas_ihsansayidmuharrom_d111811012_if7c/edit.dart';
import 'package:uas_ihsansayidmuharrom_d111811012_if7c/item_card.dart';

class MainPage extends StatelessWidget {
  final TextEditingController divisiController = TextEditingController();
  final TextEditingController targetController = TextEditingController();
  final TextEditingController strategiController = TextEditingController();
  final TextEditingController progressController = TextEditingController();
  final User user;
  MainPage(this.user);
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference renstra = firestore.collection('renstra');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Rencana Strategis'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await AuthServices.signOut();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            ListView(
              children: [
                //// VIEW DATA HERE
                StreamBuilder(
                    stream: renstra
                        .where('uid', isEqualTo: user.uid)
                        .orderBy('progres_program', descending: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: snapshot.data.docs
                              .map<Widget>((e) => ItemCard(
                                    e.data()['divisi'],
                                    e.data()['progres_program'],
                                    onUpdate: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditScreen(e.id)));
                                    },
                                    onDelete: () {
                                      renstra.doc(e.id).delete();
                                    },
                                  ))
                              .toList(),
                        );
                      } else {
                        return Text('Loading...');
                      }
                    }),
                SizedBox(
                  height: 150,
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-5, 0),
                        blurRadius: 15,
                        spreadRadius: 3)
                  ]),
                  width: double.infinity,
                  height: 205,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: divisiController,
                              decoration:
                                  InputDecoration(hintText: "Divisi Name"),
                            ),
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: targetController,
                              decoration: InputDecoration(hintText: "Target"),
                            ),
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: strategiController,
                              decoration: InputDecoration(hintText: "Strategi"),
                            ),
                            TextField(
                              style: GoogleFonts.poppins(),
                              controller: progressController,
                              decoration: InputDecoration(
                                  hintText: "Progess Program ( % )"),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 130,
                        width: 130,
                        padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            color: Colors.blue[900],
                            child: Text(
                              'Add Data',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              //// ADD DATA HERE
                              renstra.add({
                                'uid': user.uid,
                                'divisi': divisiController.text,
                                'target': targetController.text,
                                'strategi': strategiController.text,
                                'progres_program':
                                    int.tryParse(progressController.text) ?? 0
                              });

                              divisiController.text = '';
                              targetController.text = '';
                              strategiController.text = '';
                              progressController.text = '';
                            }),
                      )
                    ],
                  ),
                )),
          ],
        ));
  }
}
