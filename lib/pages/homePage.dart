import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("We logged In" + user!.email!),
            MaterialButton(
              color: Colors.green,
              onPressed: () {
                FirebaseAuth.instance
                    .signOut(); //on clicking button .. user ll log out
              },
              child: Text("Sign Out"),
            )
          ],
        ),
      ),
    );
  }
}
