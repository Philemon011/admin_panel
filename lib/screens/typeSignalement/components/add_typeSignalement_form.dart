import 'package:admin/models/typeSignalement.dart';

import '../../../models/category.dart';
import '../provider/typeSignalement_provider.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../widgets/category_image_card.dart';
import '../../../widgets/custom_text_field.dart';

class TypeSignalementSubmitForm extends StatelessWidget {
  final TypeSignalement? typeSignalement;

  const TypeSignalementSubmitForm({super.key, this.typeSignalement});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    context.typeSignalementProvider.setDataForUpdateTypeSignalement(typeSignalement);
    return SingleChildScrollView(
      child: Form(
        key: context.typeSignalementProvider.addTypeSignalementFormKey,
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
              Gap(defaultPadding),
              CustomTextField(
                controller: context.typeSignalementProvider.typeSignalementNameCtrl,
                labelText: 'Nom du type de Signalement',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le Nom du type de Signalement svp';
                  }
                  return null;
                },
              ),
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
                          .typeSignalementProvider.addTypeSignalementFormKey.currentState!
                          .validate()) {
                        context
                            .typeSignalementProvider.addTypeSignalementFormKey.currentState!
                            .save();
                        context.typeSignalementProvider.submitTypeSignalement();
                        //TODO: should complete call submitCategory

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
void showAddTypeSignalementForm(BuildContext context, TypeSignalement? typeSignalement) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: typeSignalement == null
                ? Text('Ajouter un type de Signalement'.toUpperCase(),
                    style: TextStyle(color: primaryColor))
                : Text('Modifier type de Signalement'.toUpperCase(),
                    style: TextStyle(color: primaryColor))),
        content: TypeSignalementSubmitForm(typeSignalement: typeSignalement),
      );
    },
  );
}
