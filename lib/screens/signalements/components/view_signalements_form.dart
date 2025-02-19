import 'package:admin/models/signalement.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utility/constants.dart';
import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_text_field.dart';
import '../provider/signalements_provider.dart';

class SignalementSubmitForm extends StatefulWidget {
  // final Order? order;
  final Signalement? signalement;

  const SignalementSubmitForm({Key? key, this.signalement}) : super(key: key);

  @override
  State<SignalementSubmitForm> createState() => _SignalementSubmitFormState();
}

class _SignalementSubmitFormState extends State<SignalementSubmitForm> {
  @override
  void initState() {
    super.initState();
    // Charger les statuts au démarrage
    Future.microtask(() {
      context.read<SignalementsProvider>().fetchStatuses();
    });
  }

  @override
  Widget build(BuildContext context) {

    final box = GetStorage();
    final nomRole = box.read('nomRole');


    var size = MediaQuery.of(context).size;
    context.signalementProvider.selectedSignalementStatus =
        widget.signalement?.nomStatus ?? '';
    context.signalementProvider.selectedRaison =
        widget.signalement?.raison ?? '';
    context.signalementProvider.selectedCloturerVerification =
        widget.signalement?.cloturer_verification ?? '';
    context.signalementProvider.writedCommentaires =
        widget.signalement?.commentaires ?? '';
    context.signalementProvider.writedReponse =
        widget.signalement?.reponse ?? '';
    context.signalementProvider.signalementForUpdate = widget.signalement;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        width: size.width * 0.5, // Adjust width based on screen size
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Form(
          key: Provider.of<SignalementsProvider>(context, listen: false)
              .SignalementFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(child: descriptionSection()),
                ],
              ),
              Row(
                children: [
                  Expanded(child: pieceJointeSection()),
                ],
              ),
              Row(
                children: [
                  Expanded(child: traitementSection()),
                ],
              ),
              Row(
                children: [
                  Expanded(child: commentaireSection()),
                ],
              ),
               Row(
                children: [
                  Expanded(child: reponseSection()),
                ],
              ),
              Gap(10),
              Gap(defaultPadding * 2),
              actionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget formRow(String label, Widget dataWidget) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              flex: 1,
              child: Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor))),
          Expanded(flex: 2, child: dataWidget),
        ],
      ),
    );
  }

  Widget descriptionSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor, // Light grey background to stand out
        borderRadius: BorderRadius.circular(8.0),
        border:
            Border.all(color: Colors.blueAccent), // Blue border for emphasis
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Description',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              widget.signalement?.description ?? 'Non Défini',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
          ),
          formRow(
              'Code de suivi:',
              Text(widget.signalement?.codeDeSuivi ?? 'Non Défini',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Type de signalement:',
              Text(widget.signalement?.libelle ?? 'Non Défini',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Date de l\'évènement:',
              Text(widget.signalement?.date_evenement ?? 'Non Défini',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Procédure Pénale ou Judiciaire:',
              Text(widget.signalement?.raison ?? 'Non Défini',
                  style: TextStyle(fontSize: 16))),
          formRow(
              'Status:',
              Text(widget.signalement?.nomStatus ?? 'Non Défini',
                  style: TextStyle(
                      fontSize: 16,
                      color: getColorForStatus(
                          widget.signalement?.nomStatus ?? ""),
                      fontWeight: FontWeight.bold))),
          formRow(
              'Clôturé:',
              Text(widget.signalement?.cloturer_verification ?? 'Non Défini',
                  style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }

  Color getColorForStatus(String status) {
    switch (status) {
      case 'Non traité':
        return Color(0xFFFF3B30); // Rouge
      case 'En cours':
        return Color(0xFF007BFF); // Bleu clair
      case 'Résolu':
        return Color(0xFF28A745); // Vert
      case 'Rejeté':
        return Color(0xFFFFC107); // Orange
      default:
        return Colors.grey; // Couleur par défaut si le statut est inconnu
    }
  }

  Widget pieceJointeSection() {
    String? fileType =
        widget.signalement?.pieceJointe?.split('.').last.toLowerCase();
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Pièce Jointe',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          SizedBox(height: defaultPadding),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  if (widget.signalement?.pieceJointe == null)
                    const Text("Aucune pièce jointe")
                  else if (fileType == "jpg" ||
                      fileType == "jpeg" ||
                      fileType == "png")
                    Image.network(
                        '$MAIN_URL_FOR_FILE${widget.signalement?.pieceJointe}')
                  else if (fileType == "mp4")
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("La pièce Jointe est une Vidéo"),
                            SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                String? fileName =
                                    widget.signalement?.codeDeSuivi ??
                                        'fichier_inconnu';
                                fileName +=
                                    ".${widget.signalement?.pieceJointe?.split('.').last}"; // Ajout de l'extension
                                context.signalementProvider.downloadFile(
                                    '$MAIN_URL_FOR_FILE${widget.signalement?.pieceJointe}',
                                    fileName);
                              },
                              child: const Text(
                                "Télécharger",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<SignalementsProvider>(
                            builder: (context, signalementsProvider, child) {
                              return signalementsProvider.progress > 0.0 &&
                                      signalementsProvider.progress < 1.0
                                  ? LinearProgressIndicator(
                                      color: primaryColor,
                                      value: signalementsProvider
                                          .progress, // Valeur entre 0.0 et 1.0
                                    )
                                  : Container(); // N'affiche rien si la progression est terminée ou à zéro
                            },
                          ),
                        ),
                      ],
                    )
                  else if (fileType == "mp3")
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("La pièce Jointe est un Audio"),
                            SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                String? fileName =
                                    widget.signalement?.codeDeSuivi ??
                                        'fichier_inconnu';
                                fileName +=
                                    ".${widget.signalement?.pieceJointe?.split('.').last}"; // Ajout de l'extension
                                context.signalementProvider.downloadFile(
                                    '$MAIN_URL_FOR_FILE${widget.signalement?.pieceJointe}',
                                    fileName);
                              },
                              child: const Text("Télécharger",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<SignalementsProvider>(
                            builder: (context, signalementsProvider, child) {
                              return signalementsProvider.progress > 0.0 &&
                                      signalementsProvider.progress < 1.0
                                  ? LinearProgressIndicator(
                                      color: primaryColor,
                                      value: signalementsProvider
                                          .progress, // Valeur entre 0.0 et 1.0
                                    )
                                  : Container(); // N'affiche rien si la progression est terminée ou à zéro
                            },
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("La pièce Jointe est un Fichier"),
                            SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                String? fileName =
                                    widget.signalement?.codeDeSuivi ??
                                        'fichier_inconnu';
                                fileName +=
                                    ".${widget.signalement?.pieceJointe?.split('.').last}"; // Ajout de l'extension
                                context.signalementProvider.downloadFile(
                                    '$MAIN_URL_FOR_FILE${widget.signalement?.pieceJointe}',
                                    fileName);
                              },
                              child: const Text(
                                "Télécharger",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Consumer<SignalementsProvider>(
                            builder: (context, signalementsProvider, child) {
                              return signalementsProvider.progress > 0.0 &&
                                      signalementsProvider.progress < 1.0
                                  ? LinearProgressIndicator(
                                      color: primaryColor,
                                      value: signalementsProvider
                                          .progress, // Valeur entre 0.0 et 1.0
                                    )
                                  : Container(); // N'affiche rien si la progression est terminée ou à zéro
                            },
                          ),
                        ),
                      ],
                    )

                  // widget.signalement?.pieceJointe == null
                  //     ? Text("Aucune pièce jointe")
                  //     : Image.network(
                  //         '$MAIN_URL_FOR_FILE${widget.signalement?.pieceJointe}')
                ],
              )),
        ],
      ),
    );
  }

  Widget traitementSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Traitement du signalement',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          SizedBox(height: defaultPadding),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  formRow(
                    'Status du signalement:',
                    Consumer<SignalementsProvider>(
                      builder: (context, SignalementsProvider, child) {
                        return CustomDropdown(
                          hintText: 'Status',
                          initialValue:
                              SignalementsProvider.selectedSignalementStatus,
                          items: SignalementsProvider.statuses
                              .map((status) => status.nom_status ?? "Inconnu")
                              .toList(),
                          displayItem: (val) => val,
                          onChanged: (newValue) {
                            SignalementsProvider.selectedSignalementStatus =
                                newValue ?? 'Non traité';
                            SignalementsProvider.updateUI();
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
                  formRow(
                    'Clôturer:',
                    Consumer<SignalementsProvider>(
                      builder: (context, SignalementsProvider, child) {
                        return CustomDropdown(
                          hintText: 'Clôturer',
                          initialValue:
                              SignalementsProvider.selectedCloturerVerification,
                          items: [
                            'non',
                            'oui',
                          ],
                          displayItem: (val) => val,
                          onChanged: (newValue) {
                            SignalementsProvider.selectedCloturerVerification =
                                newValue ?? 'non';
                            SignalementsProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez sélectionner entre oui et non';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                  formRow(
                    'Procédure Pénale ou Judiciaire:',
                    Consumer<SignalementsProvider>(
                      builder: (context, SignalementsProvider, child) {
                        return CustomDropdown(
                          hintText: 'Procédure Pénale ou Judiciaire',
                          initialValue: SignalementsProvider.selectedRaison,
                          items: [
                            'pas objet de procédure judiciaire ou disciplinaire',
                            'objet de procédure judiciaire ou disciplinaire',
                          ],
                          displayItem: (val) => val,
                          onChanged: (newValue) {
                            SignalementsProvider.selectedRaison = newValue ??
                                'pas objet de procédure judiciaire ou disciplinaire';
                            SignalementsProvider.updateUI();
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Veuillez sélectionner entre oui et non';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget commentaireSection() {
    TextEditingController commentaireController = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Commentaire',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          SizedBox(height: defaultPadding),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  formRow(
                    'Commentaire:',
                    Consumer<SignalementsProvider>(
                      builder: (context, SignalementsProvider, child) {
                        return TextField(
                          onChanged: (value) {
                              SignalementsProvider.writedCommentaires = value;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Entrez un commentaire',
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget reponseSection() {
    TextEditingController reponseController = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        border: Border.all(color: Colors.blueAccent),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Message au Client',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ),
          SizedBox(height: defaultPadding),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  formRow(
                    'Message:',
                    Consumer<SignalementsProvider>(
                      builder: (context, SignalementsProvider, child) {
                        return TextField(
                          onChanged: (value) {
                              SignalementsProvider.writedReponse = value;
                          },
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Entrez le message',
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget actionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: secondaryColor),
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Annuler',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Gap(defaultPadding),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          onPressed: () {
            if (Provider.of<SignalementsProvider>(context, listen: false)
                .SignalementFormKey
                .currentState!
                .validate()) {
              Provider.of<SignalementsProvider>(context, listen: false)
                  .SignalementFormKey
                  .currentState!
                  .save();
              //TODO: should complete call updateOrder
              context.signalementProvider.updateSignalement();
              Navigator.of(context).pop();
            }
          },
          child: const Text(
            'Enrégister',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

void showSignalementInfo(BuildContext context, Signalement? signalement) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text(
                "les détails du signalement ${signalement!.codeDeSuivi!.toUpperCase()}",
                style: TextStyle(color: primaryColor))),
        content: SignalementSubmitForm(
          signalement: signalement,
        ),
      );
    },
  );
}
