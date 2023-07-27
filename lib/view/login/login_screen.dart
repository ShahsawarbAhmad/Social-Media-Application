import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/utils/utils.dart';
import 'package:tech_media/view_model/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                  "Enter Your Email Address \n to connect to your account",
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
                      padding: EdgeInsets.only(top: height * .06, bottom: 0.01),
                      child: Column(
                        children: [
                          InputTextField(
                              myController: emailController,
                              focusNode: emailFocusNode,
                              enable: true,
                              onFieldSubmittedValue: (value) {
                                Utils.fieldFocused(
                                    context, emailFocusNode, passwordFocusNode);
                              },
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Email' : null;
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
                                return value.isEmpty ? 'Enter Email' : null;
                              },
                              keyboardType: TextInputType.number,
                              hint: 'Password',
                              obscureText: true),
                        ],
                      ),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, RouteName.forgotPasswordScreen);
                      },
                      child: Text(
                        "Forgot Password",
                        // ignore: deprecated_member_use
                        style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 15, decoration: TextDecoration.underline),
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                      builder: (context, provider, child) {
                    return RoundButton(
                      loading: provider.loading,
                      title: "Login",
                      onPress: () {
                        if (_formkey.currentState!.validate()) {
                          provider.login(emailController.text,
                              passwordController.text, context);
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signUpScreen);
                  },
                  child: Text.rich(
                      TextSpan(text: "don't have an account?  ", children: [
                    TextSpan(
                      text: 'Sign Up',
                      // ignore: deprecated_member_use
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 15, decoration: TextDecoration.underline),
                    ),
                  ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
