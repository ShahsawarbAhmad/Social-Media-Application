import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view_model/profile/profile_controller.dart';
import 'package:tech_media/view_model/services/session_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ref = FirebaseDatabase.instance.ref('User');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: StreamBuilder(
                      stream: ref
                          .child(SessionController().userId.toString())
                          .onValue,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          Map<dynamic, dynamic> map =
                              snapshot.data.snapshot.value;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Center(
                                      child: Container(
                                        height: 130,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColors
                                                    .secondaryTextColor,
                                                width: 3)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: provider.image == null
                                              ? map['profile'].toString() == ''
                                                  ? const Icon(
                                                      Icons.person_2_outlined)
                                                  : Image(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          map['profile']
                                                              .toString()),
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return const Center(
                                                            child:
                                                                CircularProgressIndicator());
                                                      },
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        // ignore: avoid_unnecessary_containers
                                                        return Container(
                                                          child: const Icon(
                                                            Icons.error,
                                                            color: AppColors
                                                                .alertColor,
                                                          ),
                                                        );
                                                      },
                                                    )
                                              : Stack(children: [
                                                  Image.file(
                                                      File(provider.image!.path)
                                                          .absolute),
                                                  const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                ]),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      provider.pickImage(context);
                                    },
                                    child: const CircleAvatar(
                                      radius: 15,
                                      backgroundColor:
                                          AppColors.primaryIconColor,
                                      child: Icon(
                                        Icons.add,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.showUserNameDialogAlert(
                                      context, map['userName']);
                                },
                                child: ReusableRow(
                                    title: 'UserName',
                                    value: map['userName'],
                                    iconData: Icons.person_2_outlined),
                              ),
                              GestureDetector(
                                onTap: () {
                                  provider.showPhoneDialogAlert(
                                      context, map['phone']);
                                },
                                child: ReusableRow(
                                    title: 'Phone',
                                    value: map['phone'] == ''
                                        ? 'xxx-xxx-xxx'
                                        : map['phone'],
                                    iconData: Icons.phone),
                              ),
                              ReusableRow(
                                  title: 'Email',
                                  value: map['email'],
                                  iconData: Icons.person_2_outlined),
                              const SizedBox(
                                height: 50,
                              ),
                              RoundButton(
                                  title: 'Logout',
                                  onPress: () {
                                    Navigator.pushNamed(
                                        context, RouteName.loginScreen);
                                  }),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(
                              "Something went wrong",
                              // ignore: deprecated_member_use
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          );
                        }
                      },
                    )),
              );
            },
          ),
        ));
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  final IconData iconData;
  const ReusableRow(
      {super.key,
      required this.title,
      required this.value,
      required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            // ignore: deprecated_member_use
            style: Theme.of(context).textTheme.subtitle2,
          ),
          leading: Icon(
            iconData,
            color: AppColors.primaryIconColor,
          ),
          // ignore: deprecated_member_use
          trailing: Text(value, style: Theme.of(context).textTheme.subtitle2),
        ),
        Divider(
          color: AppColors.dividedColor.withOpacity(0.4),
        )
      ],
    );
  }
}
