import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/utils/utils/utils.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

import '../../../res/color.dart';

class MessageScreen extends StatefulWidget {
  final String name, image, email, receiverID;
  const MessageScreen(
      {super.key,
      required this.email,
      required this.image,
      required this.name,
      required this.receiverID});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageController = TextEditingController();
  final DatabaseReference ref = FirebaseDatabase.instance.ref().child('Chat');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return Text(index.toString());
              },
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        controller: messageController,

                        cursorColor: AppColors.primaryTextTextColor,

                        // ignore: deprecated_member_use
                        style: Theme.of(context)
                            .textTheme
                            // ignore: deprecated_member_use
                            .bodyText2!
                            .copyWith(fontSize: 19, height: 0),
                        decoration: InputDecoration(
                          hintText: 'Enter Message',
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                sendMessage();
                              },
                              child: const CircleAvatar(
                                backgroundColor: AppColors.primaryIconColor,
                                child: Icon(
                                  Icons.send,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(15),
                          // ignore: deprecated_member_use
                          hintStyle: Theme.of(context)
                              .textTheme
                              // ignore: deprecated_member_use
                              .bodyText2!
                              .copyWith(
                                  height: 0,
                                  color: AppColors.primaryTextTextColor
                                      .withOpacity(0.8)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: AppColors.textFieldDefaultFocus)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: AppColors.secondaryColor)),
                          errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: AppColors.alertColor)),

                          enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: AppColors.grayColor)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage() {
    if (messageController.text.isEmpty) {
      Utils.toastMessage('Enter Message');
    } else {
      final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      ref.child(timeStamp).set({
        'isSeen': false,
        'message': messageController.text.toString(),
        'sender': SessionController().userId.toString(),
        'receiver': widget.receiverID,
        'type': 'text',
        'time': timeStamp.toString(),
      });
    }
  }
}
