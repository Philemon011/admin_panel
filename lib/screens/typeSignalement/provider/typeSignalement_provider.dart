
import 'package:admin/models/api_response.dart';
import 'package:admin/models/typeSignalement.dart';
import 'package:admin/utility/snack_bar_helper.dart';

import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';

class TypeSignalementProvider extends ChangeNotifier {
  HttpService service = HttpService();
  DataProvider _dataProvider;
  final addTypeSignalementFormKey = GlobalKey<FormState>();
  TextEditingController typeSignalementNameCtrl = TextEditingController();
  TypeSignalement? typeSignalementForUpdate;

  TypeSignalementProvider(this._dataProvider);

  addTypeSignalement() async {
    try {
      Map<String, dynamic> typeSignalement = {
        'libelle': typeSignalementNameCtrl.text,
      };

      final response = await service.addItem(
          endpointUrl: 'typeSignalement', itemData: typeSignalement);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(
              "type signalement ajouté avec succès");
          _dataProvider.getAllTypeSignalement();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Erreur lors de l\'ajout du type Signalement');
          print(
              'Erreur lors de l\'ajout du type Signalement : ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Une erreur s\'est produite $e');
      rethrow;
    }
  }



  updateTypeSignalement() async {
    try {
      Map<String, dynamic> typeSignalement = {
        'libelle': typeSignalementNameCtrl.text,
      };
      final response = await service.updateItem2(
          endpointUrl: 'typeSignalement',
          itemId: typeSignalementForUpdate?.id ?? 0,
          itemData: typeSignalement);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(
              "type signalement modifié avec succès");
          _dataProvider.getAllTypeSignalement();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Erreur lors de la modification du type Signalement');
          print(
              'Erreur lors de la modification du type Signalement : ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body?['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Une erreur s\'est produite $e');
      rethrow;
    }
  }


  submitTypeSignalement() {
    if (typeSignalementForUpdate != null) {
      updateTypeSignalement();
    } else {
      addTypeSignalement();
    }
  }

  deleteTypeSignalement(TypeSignalement typeSignalement) async {
    try {
      Response response = await service.deleteItem2(
          endpointUrl: 'typeSignalement', itemId: typeSignalement.id ?? 0);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          SnackBarHelper.showSuccessSnackBar(
              "Type Signalement supprimé avec succès");
          _dataProvider.getAllTypeSignalement();
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            "Le Type de Signalement ne peut pas être supprimé");
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Une erreur s\'est produite $e');
      rethrow;
    }
  }



  //? set data for update on editing
  setDataForUpdateTypeSignalement(TypeSignalement? typeSignalement) {
    if (typeSignalement != null) {
      clearFields();
      typeSignalementForUpdate = typeSignalement;
      typeSignalementNameCtrl.text = typeSignalement.libelle ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    typeSignalementNameCtrl.clear();
    typeSignalementForUpdate = null;
  }
}
