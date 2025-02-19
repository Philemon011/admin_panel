import 'package:admin/models/api_response.dart';
import 'package:admin/models/role.dart';
import 'package:admin/models/typeSignalement.dart';
import 'package:admin/models/user.dart';
import 'package:admin/utility/snack_bar_helper.dart';

import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';

class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  DataProvider _dataProvider;
  final updateUserFormKey = GlobalKey<FormState>();
  String oldRole = ' ';
  String selectedRole = 'Admin';
  List<Role> roles = [];
  User? userForUpdate;

  UserProvider(this._dataProvider);

  Future<void> fetchRoles() async {
    try {
      roles = await _dataProvider.getAllRole();
      notifyListeners();
    } catch (e) {
      SnackBarHelper.showErrorSnackBar(
          'Erreur lors du chargement des roles: $e');
    }
  }

  updateUserRole() async {
    try {
      // Trouver l'ID du statut sélectionné
      final selectedRoleSearch = roles.firstWhere(
        (role) => role.lib == selectedRole,
        orElse: () => throw Exception('Role invalide sélectionné'),
      );

      Map<String, dynamic> userNewRole = {
        'user_id': userForUpdate?.id,
        'role_id': selectedRoleSearch.id,
      };
      final response = await service.addItem(
          endpointUrl: "updateRole", itemData: userNewRole);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar(
              "Role modifié avec succès");
          _dataProvider.getAllUser();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Erreur lors de la modification du Role');
          print(
              'Erreur lors de la modification du Role : ${apiResponse.message}');
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

  submitUserRole() {
    if (userForUpdate != null) {
      updateUserRole();
    } else {}
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

  updateUI() {
    notifyListeners();
  }

  //? set data for update on editing
  setDataForUpdateUser(User? user) {
    if (user != null) {
      clearFields();
      userForUpdate = user;
      oldRole = user.lib ?? " ";
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    // typeSignalementNameCtrl.clear();
    userForUpdate = null;
  }
}
