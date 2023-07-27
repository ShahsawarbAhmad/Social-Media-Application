import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils/utils.dart';

class SignUpControler with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('User');

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void signUp(String username, String email, String password, context) {
    setLoading(true);
    try {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ref.child(value.user!.uid.toString()).set({
          'uid': value.user!.uid.toString(),
          'email': value.user!.email.toString(),
          'onlineStatus': 'noOne',
          'phone': '',
          'userName': username,
          'profile': '',
        }).then((value) {
          setLoading(false);
          Utils.toastMessage('User Created Successfully');
          Navigator.pushNamed(context, RouteName.dashboardScreen);
        }).onError((error, stackTrace) {
          setLoading(false);
        });

        // setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
      setLoading(false);
    }
  }
}
