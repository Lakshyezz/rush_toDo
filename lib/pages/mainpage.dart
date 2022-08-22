import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rush/pages/loginPage.dart';

import '../detail/widgets/view.dart';
import 'homePage.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance
            .authStateChanges(), //this line checks if used logged in or not
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //if server has user data present it ll return home page or else login page
            return HomePageTask();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
