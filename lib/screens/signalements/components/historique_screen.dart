import 'package:admin/core/data/data_provider.dart';
import 'package:admin/models/historique.dart';
import 'package:admin/screens/signalements/provider/historyProvider.dart';
import 'package:flutter/material.dart';

class HistoriqueScreen extends StatefulWidget {
  final int signalementId;
  const HistoriqueScreen({Key? key, required this.signalementId})
      : super(key: key);

  @override
  _HistoriqueScreenState createState() => _HistoriqueScreenState();
}

class _HistoriqueScreenState extends State<HistoriqueScreen> {
  final Historyprovider historyProvider = Historyprovider();
  late Future<List<Historique>> _historiqueFuture;

  @override
  void initState() {
    super.initState();
    _historiqueFuture =
        historyProvider.getHistoriqueSignalement(widget.signalementId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Historique des modifications")),
      body: FutureBuilder<List<Historique>>(
        future: _historiqueFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune modification trouvée"));
          }

          List<Historique> historique = snapshot.data!;

          return ListView.builder(
            itemCount: historique.length,
            itemBuilder: (context, index) {
              final item = historique[index]; // Un historique
              final modifications = item.modifications; // Les modifications

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Afficher l'utilisateur ayant fait la modification
                      Text(
                        "Par : ${item.user != null ? item.user!['name'] : 'Inconnu'}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),

                      // Afficher le statut avec ancien et nouveau
                      if (modifications.containsKey('status'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Statut : ${modifications['status']['ancien']} → ${modifications['status']['nouveau']}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),

                      // Afficher les autres modifications
                      for (var key in modifications.keys)
                        if (key != "status" &&
                            key != "updated_at" &&
                            key !=
                                "status_id") // Exclure ce qui a déjà été affiché
                          Column(
                            children: [
                              Text(
                                "${getKeyLabel(key)} : ${modifications[key]}",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                      SizedBox(height: 8),

                      // Afficher la date de modification
                      Text(
                        "Date de la modification : ${modifications['updated_at']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500]),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

String getKeyLabel(String key) {
  switch (key) {
    case "cloturer_verification":
      return "Vérification clôturée";
    case "raison":
      return "Raison";
    case "status_id":
      return "ID du statut";
    default:
      return key; // Retourne le nom par défaut si non trouvé
  }
}
