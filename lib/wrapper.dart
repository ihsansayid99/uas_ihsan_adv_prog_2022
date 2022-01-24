import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uas_ihsansayidmuharrom_d111811012_if7c/login.dart';
import 'package:uas_ihsansayidmuharrom_d111811012_if7c/main_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);
    return (firebaseUser == null) ? LoginScreen() : MainPage(firebaseUser);
  }
}
