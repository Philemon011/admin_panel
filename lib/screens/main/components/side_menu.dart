import 'package:get_storage/get_storage.dart';

import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final nomRole = box.read('nomRole');
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(""),
                Center(child: Text("Logo ici")),
              ],
            ),
          ),
          DrawerListTile(
            title: "Tableau de bord",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Dashboard');
            },
          ),
          DrawerListTile(
            title: "Les Signalements",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Signalements');
            },
          ),
          DrawerListTile(
            title: "Type de Signalement",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('TypeSignalement');
            },
          ),
          DrawerListTile(
            title: "Status",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Status');
            },
          ),
          nomRole=="Super Admin" ? DrawerListTile(
            title: "Attribution de rôle",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('ListuserScreen');
            },
          ): SizedBox(),
          
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
