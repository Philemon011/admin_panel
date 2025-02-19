import 'package:admin/screens/listUser/listUser_screen.dart';
import 'package:admin/screens/signalements/signalements_screen.dart';
import 'package:admin/screens/status/status_screen.dart';
import 'package:admin/screens/typeSignalement/typeSignalement_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreenProvider extends ChangeNotifier{
  Widget selectedScreen = DashboardScreen();



  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        selectedScreen = DashboardScreen();
        break; 
      case 'ListuserScreen':
        selectedScreen = ListuserScreen();
        break;
      case 'TypeSignalement':
        selectedScreen = TypeSignalementScreen();
        break;
      case 'Signalements':
        selectedScreen = SignalementsScreen();
        break;
      case 'Status':
        selectedScreen = StatusScreen();
        break;
      default:
        selectedScreen = DashboardScreen();
    }
    notifyListeners();
  }
  
  
}