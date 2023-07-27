import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tech_media/res/color.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/utils/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileController with ChangeNotifier {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final nameFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();

  DatabaseReference ref = FirebaseDatabase.instance.ref('User');
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void pickGalleryImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      // ignore: use_build_context_synchronously
      uploadImage(context);
    }
  }

  void pickCameraImage(BuildContext context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      notifyListeners();
      // ignore: use_build_context_synchronously
      uploadImage(context);
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: sized_box_for_whitespace
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      pickCameraImage(context);
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Icons.camera,
                      color: AppColors.primaryIconColor,
                    ),
                    title: const Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      pickGalleryImage(context);
                    },
                    leading: const Icon(
                      Icons.browse_gallery_outlined,
                      color: AppColors.primaryIconColor,
                    ),
                    title: const Text("Gallery"),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref('/profileImage${SessionController().userId}');

    firebase_storage.UploadTask uploadTask =
        storageRef.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = storageRef.getDownloadURL();

    ref.child(SessionController().userId.toString()).update({
      'profile': newUrl.toString(),
    }).then((value) {
      setLoading(false);
      Utils.toastMessage('Profile Update');
      _image = null;
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
      setLoading(false);
    });
  }

  void showUserNameDialogAlert(BuildContext context, String name) {
    nameController.text = name;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextField(
                    myController: nameController,
                    focusNode: nameFocusNode,
                    onFieldSubmittedValue: (value) {},
                    onValidator: (value) {
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    hint: 'Enter name',
                    obscureText: false)
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancle",
                  style: Theme.of(context)
                      .textTheme
                      // ignore: deprecated_member_use
                      .subtitle2!
                      .copyWith(color: AppColors.alertColor),
                )),
            TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    'userName': nameController.text.toString(),
                  }).then((value) {
                    nameController.clear();
                  });
                  Navigator.pop(context);
                },
                child:
                    // ignore: deprecated_member_use
                    Text("Ok", style: Theme.of(context).textTheme.subtitle2)),
          ],
        );
      },
    );
  }

  void showPhoneDialogAlert(BuildContext context, String phoneNumber) {
    phoneController.text = phoneNumber;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                InputTextField(
                    myController: phoneController,
                    focusNode: phoneFocusNode,
                    onFieldSubmittedValue: (value) {},
                    onValidator: (value) {
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    hint: 'Enter Phone',
                    obscureText: false)
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancle",
                  style: Theme.of(context)
                      .textTheme
                      // ignore: deprecated_member_use
                      .subtitle2!
                      .copyWith(color: AppColors.alertColor),
                )),
            TextButton(
                onPressed: () {
                  ref.child(SessionController().userId.toString()).update({
                    'phone': phoneController.text.toString(),
                  }).then((value) {
                    phoneController.clear();
                  });
                  Navigator.pop(context);
                },
                child:
                    // ignore: deprecated_member_use
                    Text("Ok", style: Theme.of(context).textTheme.subtitle2)),
          ],
        );
      },
    );
  }
}
