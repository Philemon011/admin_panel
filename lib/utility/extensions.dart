import 'package:admin/screens/listUser/provider/listUser_provider.dart';
import 'package:admin/screens/signalements/provider/signalements_provider.dart';
import 'package:admin/screens/typeSignalement/provider/typeSignalement_provider.dart';
import '../screens/dashboard/provider/dash_board_provider.dart';
import '../screens/main/provider/main_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../core/data/data_provider.dart';


extension Providers on BuildContext {
  DataProvider get dataProvider => Provider.of<DataProvider>(this, listen: false);
  MainScreenProvider get mainScreenProvider => Provider.of<MainScreenProvider>(this, listen: false);
  TypeSignalementProvider get typeSignalementProvider => Provider.of<TypeSignalementProvider>(this, listen: false);
  UserProvider get userProvider => Provider.of<UserProvider>(this, listen: false);
  SignalementsProvider get signalementProvider => Provider.of<SignalementsProvider>(this, listen: false);
  DashBoardProvider get dashBoardProvider => Provider.of<DashBoardProvider>(this, listen: false);
}