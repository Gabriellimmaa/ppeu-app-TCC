import 'package:ppeu/core/notifier/authentication.notifier.dart';
import 'package:ppeu/core/notifier/database.notifier.dart';
import 'package:ppeu/core/notifier/hospitalUnit.notifier.dart';
import 'package:ppeu/core/notifier/mobileUnit.notifier.dart';
import 'package:ppeu/core/notifier/newPP.notifier.dart';
import 'package:ppeu/core/notifier/user.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => DatabaseNotifier()),
    ChangeNotifierProvider(create: (_) => HospitalUnitNotifier()),
    ChangeNotifierProvider(create: (_) => MobileUnitNotifier()),
    ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
    ChangeNotifierProvider(create: (_) => UserNotifier()),
    ChangeNotifierProvider(create: (_) => NewPPNotifier())
  ];
}
