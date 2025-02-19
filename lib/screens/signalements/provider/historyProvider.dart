import 'package:admin/models/historique.dart';
import 'package:admin/services/http_services.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class Historyprovider extends ChangeNotifier {
  
  HttpService service = HttpService();


  Future<List<Historique>> getHistoriqueSignalement(int signalementId, {bool showSnack = false}) async {
  try {
    Response response = await service.getItems(endpointUrl: 'signalements/$signalementId/historique');

    if (response.isOk) {
      List<dynamic> jsonData = response.body; // Récupère directement la liste JSON

      List<Historique> historiques = jsonData.map((item) => Historique.fromJson(item)).toList();

      if (showSnack) {
        SnackBarHelper.showSuccessSnackBar("Historique chargé avec succès !");
      }

      return historiques;
    }
  } catch (e) {
    if (showSnack) SnackBarHelper.showErrorSnackBar(e.toString());
    rethrow;
  }
  return [];
}
}
