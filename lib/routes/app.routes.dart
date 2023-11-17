import 'package:ppeu/screens/Home.screen.dart';
import 'package:ppeu/screens/SelectUser.screen.dart';
import 'package:ppeu/screens/Signin.screen.dart';
import 'package:ppeu/screens/Signup.screen.dart';
import 'package:ppeu/screens/Welcome.screen.dart';

class AppRoutes {
  static const String SelectUserRoute = "/select_user";
  static const String SinginRoute = "/singin";
  static const String SingupRoute = "/signup";
  static const String WelcomeRoute = "/welcome";
  static const String HomeRoute = "/home";

  static final routes = {
    SelectUserRoute: (context) => SelectUserScreen(),
    SinginRoute: (context) => SigninScreen(),
    SingupRoute: (context) => SignupScreen(),
    WelcomeRoute: (context) => WelcomeScreen(),
    HomeRoute: (context) => HomeScreen(),
  };
}
