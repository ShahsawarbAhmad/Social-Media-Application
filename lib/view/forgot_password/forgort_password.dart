import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/component/input_text_field.dart';
import 'package:tech_media/res/component/round_button.dart';
import 'package:tech_media/view_model/forgot_password/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  final emailFocusNode = FocusNode();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();

    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
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
                  "Forgot Password",
                  // ignore: deprecated_member_use
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  "Enter Your Email Address \n to recover  your password",
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
                              onFieldSubmittedValue: (value) {},
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Email' : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              hint: 'Email',
                              obscureText: false),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => ForgotPasswordController(),
                  child: Consumer<ForgotPasswordController>(
                      builder: (context, provider, child) {
                    return RoundButton(
                      loading: provider.loading,
                      title: "Recover",
                      onPress: () {
                        if (_formkey.currentState!.validate()) {
                          provider.forgortPassword(
                              emailController.text, context);
                        }
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
