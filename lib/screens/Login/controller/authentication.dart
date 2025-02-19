import 'dart:convert';
import 'package:admin/core/routes/app_pages.dart';
import 'package:admin/utility/constants.dart';
import 'package:admin/utility/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
// import 'package:lnb_ethique_app/home/home_screen.dart';
// import 'package:lnb_ethique_app/utility/constants.dart';

class AuthenticationController extends GetxController {
  final isLoading = false.obs;
  final token = "".obs;
  final savedname = "".obs;
  final savedid = 0.obs;
  final savedemail = "".obs;
  final savednomRole = "".obs;
  final box = GetStorage();

  Future register({
    required String name,
    // required String username,
    required String email,
    required String password,
    required String cpassword,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'name': name,
        'email': email,
        'password': password,
        'c_password': cpassword,
      };

      // Conversion du Map en chaîne JSON
      var response = await http.post(
        Uri.parse(MAIN_URL + '/register/to/dashbord'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // Ajout du Content-Type JSON
        },
        body: jsonEncode(data), // Conversion des données en JSON
      );

      if (response.statusCode == 201) {
        isLoading.value = false;
        box.erase();
        token.value = jsonDecode(response.body)["token"];
        savedname.value = jsonDecode(response.body)["name"];
        savednomRole.value = jsonDecode(response.body)["nomRole"];
        savedid.value = jsonDecode(response.body)["user_id"];
        savedemail.value = jsonDecode(response.body)["email"];
        box.write('token', token.value);
        box.write('name', savedname.value);
        box.write('nomRole', savednomRole.value);
        box.write('user_id', savedid.value);
        box.write('email', savedemail.value);
        SnackBarHelper.showSuccessSnackBar("Votre Compte a été bien créé");
        debugPrint(jsonDecode(response.body).toString());
        // print(json.decode(response.body).toString());
        // print(box.read('nomRole'));

        Get.toNamed(AppPages.HOME); // Redirection vers la page d'accueil
      } else {
        isLoading.value = false;
        SnackBarHelper.showErrorSnackBar(
              'Erreur lors de la création du Compte : ${json.decode(response.body).toString()}',);
        debugPrint(jsonDecode(response.body).toString()); // Affiche les erreurs
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future login({
    required String mail,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      var data = {
        'email': mail,
        'password': password,
      };

      // Conversion du Map en chaîne JSON
      var response = await http.post(
        Uri.parse(MAIN_URL + '/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json', // Ajout du Content-Type JSON
        },
        body: jsonEncode(data), // Conversion des données en JSON
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        if (responseData["nomRole"] == "Admin" ||
            responseData["nomRole"] == "Super Admin") {
          // Action pour Admin ou SuperAdmin
          isLoading.value = false;
          box.erase();
          token.value = jsonDecode(response.body)["token"];
          savedname.value = jsonDecode(response.body)["name"];
          savednomRole.value = jsonDecode(response.body)["nomRole"];
          savedid.value = jsonDecode(response.body)["user_id"];
          savedemail.value = jsonDecode(response.body)["email"];
          print(token.value);
          print(savedname.value);
          print(savednomRole.value);
          print(savedemail.value);
          print(savedid.value);
          box.write('token',
              token.value); // Sauvegarde le token dans la mémoire interne
          box.write('name', savedname.value);
          box.write('nomRole', savednomRole.value);
          box.write('user_id', savedid.value);
          box.write('email', savedemail.value);
          Get.toNamed(AppPages.HOME); // Redirection vers la page d'accueil
        } else if (jsonDecode(response.body)["nomRole"] != "Admin" ||
            jsonDecode(response.body)["nomRole"] != "Super Admin") {
          isLoading.value = false;
          SnackBarHelper.showErrorSnackBar(
              'Erreur lors de la connexion, Vous n\'êtes pas autorisé');
        }
      } else {
        isLoading.value = false;
        SnackBarHelper.showErrorSnackBar(
              'Erreur lors de la connexion: ${json.decode(response.body).toString()}',);
        debugPrint(jsonDecode(response.body).toString()); // Affiche les erreurs
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  // Fonction pour appeler l'API de déconnexion
  Future<Map<String, dynamic>?> logout() async {
    try {
      final response = await http.get(
        Uri.parse(MAIN_URL + '/logout'),
        headers: {
          'Content-Type': 'application/json',
          // Ajoute ici l'en-tête Authorization si tu utilises un token d'authentification
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Erreur lors de la déconnexion : $e');
      return null;
    }
  }
}
