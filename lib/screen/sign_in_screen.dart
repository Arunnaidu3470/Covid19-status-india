import 'package:app/auth/auth_api.dart';
import 'package:app/screen/home_page_screen.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  static const String ROOTNAME = '/signInScreen';
  final FirebaseAuthApi _firebaseAuthApi = FirebaseAuthApi.initialize();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Sign In'),
        icon: Icon(Icons.lock_outline),
        onPressed: () async {
          AppUser user = await _firebaseAuthApi.handleSignIn();
          if (user != null) {
            Navigator.of(context).popAndPushNamed(MyHomePage.ROUTENAME);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FlareActor(
                  'assets/flare/corona_pink_logo.flr',
                  animation: 'move',
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 20,
            child: Text(
              'COVID-19 India',
              style: Theme.of(context).primaryTextTheme.headline3,
            ),
          )
        ],
      ),
    );
  }
}
