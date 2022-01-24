import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatelessWidget {
  final String uid;
  EditScreen(this.uid);
  @override
  Widget build(BuildContext context) {
    final TextEditingController divisiController = TextEditingController();
    final TextEditingController targetController = TextEditingController();
    final TextEditingController strategiController = TextEditingController();
    final TextEditingController progresController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference renstra = firestore.collection('renstra');
    return StreamBuilder(
      stream: renstra.doc(uid).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        var dataDoc = snapshot.data;
        divisiController.text = dataDoc['divisi'];
        targetController.text = dataDoc['target'];
        strategiController.text = dataDoc['strategi'];
        progresController.text = dataDoc['progres_program'].toString();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: Text('Edit Data ' + dataDoc['divisi']),
          ),
          body: Column(children: <Widget>[
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: divisiController,
                decoration: InputDecoration(labelText: "Divisi"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: targetController,
                decoration: InputDecoration(labelText: "Target"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: strategiController,
                decoration: InputDecoration(labelText: "Strategi"),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: progresController,
                decoration: InputDecoration(labelText: "Progress Program"),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () async {
                  await renstra.doc(uid).update({
                    'divisi': divisiController.text,
                    'target': targetController.text,
                    'strategi': strategiController.text,
                    'progres_program':
                        int.tryParse(progresController.text) ?? 0,
                  });
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(colors: [
                        Color.fromARGB(255, 255, 136, 34),
                        Color.fromARGB(255, 255, 177, 41)
                      ])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Update",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}
