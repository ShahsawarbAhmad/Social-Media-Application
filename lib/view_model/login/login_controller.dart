import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/routes/route_name.dart';
import '../../utils/utils/utils.dart';
import '../services/session_manager.dart';

class LoginController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void login(String email, String password, context) {
    setLoading(true);
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        SessionController().userId = value.user!.uid.toString();
        setLoading(false);
        Navigator.pushNamed(context, RouteName.dashboardScreen);
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
