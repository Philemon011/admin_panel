import 'package:admin/models/typeSignalement.dart';
import 'package:admin/models/user.dart';
import 'package:admin/widgets/custom_dropdown.dart';

import '../../../models/category.dart';
import '../provider/listUser_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class UserSubmitForm extends StatefulWidget {
  final User? user;

  const UserSubmitForm({super.key, this.user});

  @override
  State<UserSubmitForm> createState() => _UserSubmitFormState();
}

class _UserSubmitFormState extends State<UserSubmitForm> {

  @override
  void initState() {
    super.initState();
    // Charger les statuts au démarrage
    Future.microtask(() {
      context.read<UserProvider>().fetchRoles();
    });
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.userProvider.setDataForUpdateUser(widget.user);
    return SingleChildScrollView(
      child: Form(
        key: context.userProvider.updateUserFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              formRow(
                    'Role:',
                    Consumer<UserProvider>(
                      builder: (context, UserProvider, child) {
                        return CustomDropdown(
                          hintText: 'Role',
                          initialValue:
                              UserProvider.oldRole,
                          items: UserProvider.roles
                              .map((roles) => roles.lib ?? "Admin")
                              .toList(),
                          displayItem: (val) => val,
                          onChanged: (newValue) {
                            UserProvider.selectedRole =
                                newValue ?? 'Admin';
                            UserProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez sélectionner un status';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),

              // CustomTextField(
              //   controller: context.typeSignalementProvider.typeSignalementNameCtrl,
              //   labelText: 'Nom du type de Signalement',
              //   onSave: (val) {},
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Veuillez entrer le Nom du type de Signalement svp';
              //     }
              //     return null;
              //   },
              // ),
              
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Annuler'),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context
                          .userProvider.updateUserFormKey.currentState!
                          .validate()) {
                        context
                            .userProvider.updateUserFormKey.currentState!
                            .save();
                        context.userProvider.submitUserRole();

                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Enrégistrer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the category popup
void showUpdateUserRoleForm(BuildContext context, User user) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Modifier de rôle de ${user.name}'.toUpperCase(),
                    style: TextStyle(color: primaryColor))),
        content: UserSubmitForm(user: user),
      );
    },
  );
}

Widget formRow(String label, Widget dataWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expanded(
          //     flex: 1,
          //     child: Text(label,
          //         style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 16,
          //             color: primaryColor))),
          Expanded(flex: 2, child: dataWidget),
        ],
      ),
    );
  }
