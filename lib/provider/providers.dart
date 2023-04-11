import 'package:coding_test/repository/home/notifier/homepage.notifier.dart';
import 'package:coding_test/repository/register/notifier/register.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [

  ChangeNotifierProvider<RegisterNotifier>(create: (context) => RegisterNotifier()),
  ChangeNotifierProvider<HomePageNotifier>(create: (context) => HomePageNotifier()),

];
