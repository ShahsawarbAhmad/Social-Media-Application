import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils/utils.dart';
import 'package:tech_media/view_model/signup/sign_up_controller.dart';

import '../../res/component/input_text_field.dart';
import '../../res/component/round_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final usernameContoller = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    usernameContoller.dispose();
    usernameFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ChangeNotifierProvider(
              create: (_) => SignUpControler(),
              child: Consumer<SignUpControler>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        "WellCome To App",
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Text(
                        "Enter Your Email Address \n to register to your account",
                        textAlign: TextAlign.center,
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Form(
                          key: _formkey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height * .06, bottom: 0.01),
                            child: Column(
                              children: [
                                InputTextField(
                                    myController: usernameContoller,
                                    focusNode: usernameFocusNode,
                                    enable: true,
                                    onFieldSubmittedValue: (value) {
                                      Utils.fieldFocused(context,
                                          usernameFocusNode, emailFocusNode);
                                    },
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Username'
                                          : null;
                                    },
                                    keyboardType: TextInputType.text,
                                    hint: 'Username',
                                    obscureText: false),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                InputTextField(
                                    myController: emailController,
                                    focusNode: emailFocusNode,
                                    enable: true,
                                    onFieldSubmittedValue: (value) {
                                      Utils.fieldFocused(context,
                                          emailFocusNode, passwordFocusNode);
                                    },
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Email'
                                          : null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    hint: 'Email',
                                    obscureText: false),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                InputTextField(
                                    myController: passwordController,
                                    focusNode: passwordFocusNode,
                                    enable: true,
                                    onFieldSubmittedValue: (value) {},
                                    onValidator: (value) {
                                      return value.isEmpty
                                          ? 'Enter Password'
                                          : null;
                                    },
                                    keyboardType: TextInputType.text,
                                    hint: 'Password',
                                    obscureText: true),
                              ],
                            ),
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                      RoundButton(
                        loading: provider.loading,
                        title: "Sign Up",
                        onPress: () {
                          if (_formkey.currentState!.validate()) {
                            provider.signUp(
                                usernameContoller.text,
                                emailController.text,
                                passwordController.text,
                                context);
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RouteName.loginScreen);
                        },
                        child: Text.rich(TextSpan(
                            text: "Already have an account? ",
                            children: [
                              TextSpan(
                                text: 'Login ',
                                style: Theme.of(context)
                                    .textTheme
                                    // ignore: deprecated_member_use
                                    .headline2!
                                    .copyWith(
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                              ),
                            ])),
                      ),
                    ],
                  ),
                );
              }),
            )),
      ),
    );
  }
}
