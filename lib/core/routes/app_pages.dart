import 'package:admin/screens/Login/login_screen.dart';
import 'package:admin/screens/Login/register_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../screens/main/main_screen.dart';



class AppPages {
  static const HOME = '/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';

  static final routes = [
    GetPage(
      name: HOME,
      fullscreenDialog: true,
      page: () => MainScreen()
    ),
    GetPage(
      name: LOGIN,
      fullscreenDialog: true,
      page: () => LoginPage()
    ),
    GetPage(
      name: REGISTER,
      fullscreenDialog: true,
      page: () => RegisterPage()
    ),

  ];
}
