import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/fonts.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 40,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.6),
        ),
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          headline1: TextStyle(
              fontSize: 40,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.6),
          // ignore: deprecated_member_use
          headline2: TextStyle(
              fontSize: 32,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.9),
          // ignore: deprecated_member_use
          headline3: TextStyle(
              fontSize: 28,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.6),
          // ignore: deprecated_member_use
          headline4: TextStyle(
              fontSize: 24,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.6),
          // ignore: deprecated_member_use
          headline5: TextStyle(
              fontSize: 20,
              fontFamily: AppFonts.sfProDisplayMedium,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w500,
              height: 1.6),
          // ignore: deprecated_member_use
          headline6: TextStyle(
              fontSize: 17,
              fontFamily: AppFonts.sfProDisplayBold,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w700,
              height: 1.6),

          // ignore: deprecated_member_use
          bodyText1: TextStyle(
              fontSize: 17,
              fontFamily: AppFonts.sfProDisplayBold,
              color: AppColors.primaryTextTextColor,
              fontWeight: FontWeight.w700,
              height: 1.6),
          // ignore: deprecated_member_use
          bodyText2: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.sfProDisplayRegular,
              color: AppColors.primaryTextTextColor,
              height: 1.6),
          // ignore: deprecated_member_use
          caption: TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.sfProDisplayBold,
              color: AppColors.primaryTextTextColor,
              height: 2.26),
        ),
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
