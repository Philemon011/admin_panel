import 'package:admin/models/historique.dart';
import 'package:admin/models/role.dart';
import 'package:admin/models/signalement.dart';
import 'package:admin/models/status.dart';
import 'package:admin/models/typeSignalement.dart';
import 'package:admin/models/user.dart';

import '../../models/api_response.dart';
import '../../models/my_notification.dart';
import '../../services/http_services.dart';
import '../../utility/snack_bar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Signalement> _allSignalements = [];
  List<Signalement> _filteredSignalements = [];
  List<Signalement> get signalements => _filteredSignalements;
  
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  List<User> get users => _filteredUsers;

  List<TypeSignalement> _allTypeSignalements = [];
  List<TypeSignalement> _filteredTypeSignalements = [];
  List<TypeSignalement> get typeSignalements => _filteredTypeSignalements;

  List<Status> _allStatus = [];
  List<Status> _filteredStatus = [];
  List<Status> get status => _filteredStatus;

  List<Role> _allRoles = [];
  List<Role> _filteredRoles = [];
  List<Role> get roles => _filteredRoles;


  // List<MyNotification> _allNotifications = [];
  // List<MyNotification> _filteredNotifications = [];
  // List<MyNotification> get notifications => _filteredNotifications;

  DataProvider() {
    getAllTypeSignalement();
    getAllStatus();
    getAllSignalement();
    getAllUser();
    getAllRole();
  }


  


  

  //TODO: should complete getAllUser

  Future<List<User>> getAllUser({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'users');
      if (response.isOk) {
        ApiResponse<List<User>> apiResponse =
            ApiResponse<List<User>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => User.fromJson(item))
                    .toList());
        _allUsers = apiResponse.data ?? [];
        _filteredUsers = List.from(_allUsers);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "List des Admin actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredUsers;
  }
  //TODO: should complete getAllSignalement

  Future<List<Signalement>> getAllSignalement({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'signalement');
      if (response.isOk) {
        ApiResponse<List<Signalement>> apiResponse =
            ApiResponse<List<Signalement>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Signalement.fromJson(item))
                    .toList());
        _allSignalements = apiResponse.data ?? [];
        _filteredSignalements = List.from(_allSignalements);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "Signalements actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredSignalements;
  }

  //TODO: should complete filterSignalements
  void filterSignalements(String keyword) {
    if (keyword.isEmpty) {
      _filteredSignalements = List.from(_allSignalements);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSignalements = _allSignalements.where((signalement) {
        return (signalement.nomStatus ?? "")
            .toLowerCase()
            .contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  void filterSignalementsByCode(String keyword) {
    if (keyword.isEmpty) {
      _filteredSignalements = List.from(_allSignalements);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredSignalements = _allSignalements.where((signalement) {
        return (signalement.codeDeSuivi ?? "")
            .toLowerCase()
            .contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllTypeSignalement

  Future<List<TypeSignalement>> getAllTypeSignalement(
      {bool showSnack = false}) async {
    try {
      Response response =
          await service.getItems(endpointUrl: 'typeSignalement');
      if (response.isOk) {
        ApiResponse<List<TypeSignalement>> apiResponse =
            ApiResponse<List<TypeSignalement>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => TypeSignalement.fromJson(item))
                    .toList());
        _allTypeSignalements = apiResponse.data ?? [];
        _filteredTypeSignalements = List.from(_allTypeSignalements);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "types Signalements actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredTypeSignalements;
  }

  //TODO: should complete filterTypeSignalements
  void filterTypeSignalements(String keyword) {
    if (keyword.isEmpty) {
      _filteredTypeSignalements = List.from(_allTypeSignalements);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredTypeSignalements = _allTypeSignalements.where((typeSignalement) {
        return (typeSignalement.libelle ?? "")
            .toLowerCase()
            .contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //TODO: should complete getAllRole

  Future<List<Role>> getAllRole({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'role');
      if (response.isOk) {
        ApiResponse<List<Role>> apiResponse =
            ApiResponse<List<Role>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Role.fromJson(item))
                    .toList());
        _allRoles = apiResponse.data ?? [];
        _filteredRoles = List.from(_allRoles);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "Liste des Roles actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredRoles;
  }

  Future<List<Status>> getAllStatus({bool showSnack = false}) async {
    try {
      Response response = await service.getItems(endpointUrl: 'status');
      if (response.isOk) {
        ApiResponse<List<Status>> apiResponse =
            ApiResponse<List<Status>>.fromJson(
                response.body,
                (json) => (json as List)
                    .map((item) => Status.fromJson(item))
                    .toList());
        _allStatus = apiResponse.data ?? [];
        _filteredStatus = List.from(_allStatus);
        notifyListeners();
        if (showSnack)
          SnackBarHelper.showSuccessSnackBar(
              "Liste des Status actualisés avec succès");
      }
    } catch (e) {
      if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
      rethrow;
    }
    return _filteredStatus;
  }

  //TODO: should complete filterTypeSignalements
  void filteredStatus(String keyword) {
    if (keyword.isEmpty) {
      _filteredStatus = List.from(_allStatus);
    } else {
      final lowerKeyword = keyword.toLowerCase();
      _filteredStatus = _allStatus.where((status) {
        return (status.nom_status ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }





  void filterSignalementByStatus(String signalementStatusType) {
    if (signalementStatusType == "Tous les signalements") {
      _filteredSignalements = List.from(_allSignalements);
    } else if (signalementStatusType == "Non traité") {
      _filteredSignalements = _allSignalements.where((signalement) {
        return signalement.nomStatus == "Non traité";
      }).toList();
    } else if (signalementStatusType == "En cours") {
      _filteredSignalements = _allSignalements.where((signalement) {
        return signalement.nomStatus == "En cours";
      }).toList();
    } else if (signalementStatusType == "Autres") {
      _filteredSignalements = _allSignalements.where((signalement) {
        return (signalement.nomStatus == "Résolu" ||
            signalement.nomStatus == "Rejeté");
      }).toList();
    } else {
      _filteredSignalements = List.from(_allSignalements);
    }
    notifyListeners();
  }

  Map<String, int> getSignalementCounts() {
    return {
      "Tous les signalements": _allSignalements.length,
      "Non traité":
          _allSignalements.where((s) => s.nomStatus == "Non traité").length,
      "En cours":
          _allSignalements.where((s) => s.nomStatus == "En cours").length,
      "Autres": _allSignalements.where((s) {
        return s.nomStatus == "Résolu" || s.nomStatus == "Rejeté";
      }).length,
    };
  }

  Map<String, int> getPieChartData() {
  int totalSignalement = _allSignalements.length;
  int totalCloture = _allSignalements
      .where((signalement) => signalement.cloturer_verification == "oui")
      .length;
  int totalNonCloture = totalSignalement - totalCloture;

  return {
    "totalSignalement": totalSignalement,
    "totalCloture": totalCloture,
    "totalNonCloture": totalNonCloture,
  };
}


}
