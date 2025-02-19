import 'package:admin/screens/listUser/provider/listUser_provider.dart';
import 'package:admin/screens/signalements/provider/signalements_provider.dart';
import 'package:admin/screens/typeSignalement/provider/typeSignalement_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/data/data_provider.dart';
import 'core/routes/app_pages.dart';
import 'screens/dashboard/provider/dash_board_provider.dart';
import 'screens/main/main_screen.dart';
import 'screens/main/provider/main_screen_provider.dart';
// import 'screens/notification/provider/notification_provider.dart';
import 'utility/constants.dart';
import 'utility/extensions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DataProvider()),
    ChangeNotifierProvider(create: (context) => MainScreenProvider()),
    ChangeNotifierProvider(create: (context) => TypeSignalementProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => UserProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => SignalementsProvider(context.dataProvider)),
    ChangeNotifierProvider(create: (context) => DashBoardProvider(context.dataProvider)),
    // ChangeNotifierProvider(create: (context) => NotificationProvider(context.dataProvider)),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      // initialRoute: AppPages.HOME,
      initialRoute: AppPages.LOGIN,
      unknownRoute: GetPage(name: '/notFount', page: () => MainScreen()),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.routes,
    );
  }
}
