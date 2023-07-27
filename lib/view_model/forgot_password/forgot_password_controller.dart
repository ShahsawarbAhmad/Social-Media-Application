import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils/utils.dart';

class ForgotPasswordController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void forgortPassword(String email, context) {
    setLoading(true);
    try {
      auth.sendPasswordResetEmail(email: email).then((value) {
        setLoading(false);
        Navigator.pushNamed(context, RouteName.loginScreen);
        Utils.toastMessage('Please check you email to recover your password');
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setLoading(false);
      });
    } catch (e) {
      Utils.toastMessage(e.toString());
      setLoading(false);
    }
  }
}
