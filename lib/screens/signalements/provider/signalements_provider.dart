import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:admin/models/api_response.dart';
import 'package:admin/models/signalement.dart';
import 'package:admin/models/status.dart';
import 'package:admin/utility/snack_bar_helper.dart';

import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';



class SignalementsProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final SignalementFormKey = GlobalKey<FormState>();
  final sigFormKey = GlobalKey<FormState>();
  // TextEditingController trackingUrlCtrl = TextEditingController();
  String selectedSignalementStatus = 'Non traité';
  String selectedCloturerVerification = 'non';
  String writedCommentaires = '';
  String writedReponse = '';
  String selectedRaison = 'pas objet de procédure judiciaire ou disciplinaire';
  List<Status> statuses = [];
  double progress = 0.0;


  Signalement? signalementForUpdate;

  SignalementsProvider(this._dataProvider);
  


  Future<void> fetchStatuses() async {
  try {
    statuses = await _dataProvider.getAllStatus();
    notifyListeners();
  } catch (e) {
    SnackBarHelper.showErrorSnackBar('Erreur lors du chargement des statuts: $e');
  }
}



  void downloadFile(String url,String fileName) async {
  try {
    // Initialisation de Dio
    Dio dio = Dio();

    // Récupérer le répertoire de téléchargement
    final directory = await getApplicationDocumentsDirectory();

    // Créer le dossier "Signalements" si nécessaire
    final signalementsDir = Directory("${directory.path}/Signalements lnb fichiers");
    if (!await signalementsDir.exists()) {
      await signalementsDir.create(recursive: true); // Crée le dossier s'il n'existe pas
    }

    // Construire le chemin complet du fichier
    String savePath = "${signalementsDir.path}/$fileName";

    // Téléchargement du fichier
    await dio.download(
      url,
      savePath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
           progress = received / total;
            notifyListeners(); // Notifier les widgets consommateurs

          // print("Téléchargement : ${(received / total * 100).toStringAsFixed(0)}%");
        }
      },
    );
    // Réinitialiser la progression après téléchargement
      progress = 0.0;
      notifyListeners();

    SnackBarHelper.showSuccessSnackBar("Fichier téléchargé avec succès dans : $savePath");
    print("Fichier téléchargé avec succès : $savePath");
  } catch (e) {
    SnackBarHelper.showErrorSnackBar("Erreur lors du téléchargement : $e");
    print("Erreur lors du téléchargement : $e");
  }
}


  updateSignalement() async {


    try {
      // Trouver l'ID de l'admin connecté
      final box = GetStorage();
    // final token = box.read('token');
    final user_id = box.read('user_id') ?? null;

      // Trouver l'ID du statut sélectionné
    final selectedStatus = statuses.firstWhere(
      (status) => status.nom_status == selectedSignalementStatus,
      orElse: () => throw Exception('Statut invalide sélectionné'),
    );
    
      Map<String, dynamic> signalement = {
        'status_id': selectedStatus.id,
        'cloturer_verification': selectedCloturerVerification,
        'raison': selectedRaison,
        'user_id':user_id,
        'commentaires': writedCommentaires,
        'reponse' : writedReponse,
      };
      final response = await service.updateItem2(
          endpointUrl: 'signalement',
          itemId: signalementForUpdate?.id ?? 0,
          itemData: signalement);
      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar("signalement modifié avec succès");
          _dataProvider.getAllSignalement();
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Erreur lors de la modification du Signalement');
          print(
              'Erreur lors de la modification du Signalement : ${apiResponse.message}');
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

  updateUI() {
    notifyListeners();
  }

  clearFields() {
    signalementForUpdate = null;
  }

  

  
}
