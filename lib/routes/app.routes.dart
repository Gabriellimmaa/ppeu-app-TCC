import 'package:ppue/screens/SelectUser.screen.dart';
import 'package:ppue/screens/Signin.screen.dart';
import 'package:ppue/screens/Signup.screen.dart';
import 'package:ppue/screens/Welcome.screen.dart';

class AppRoutes {
  static const String SelectUserRoute = "/select_user";
  static const String SinginRoute = "/singin";
  static const String SingupRoute = "/signup";
  static const String WelcomeRoute = "/welcome";

  static final routes = {
    SelectUserRoute: (context) => SelectUserScreen(),
    SinginRoute: (context) => SigninScreen(),
    SingupRoute: (context) => SignupScreen(),
    WelcomeRoute: (context) => WelcomeScreen(),
  };
}
