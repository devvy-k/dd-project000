import 'package:devvy_proj/valuation_module/tableau/component/head_table.dart';
import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:devvy_proj/valuation_module/tableau/data/data_table.dart';
import 'package:devvy_proj/valuation_module/tableau/data/row_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TableauScreen extends StatefulWidget {
  const TableauScreen({super.key});

  @override
  State<TableauScreen> createState() => _TableauScreenState();
}

class _TableauScreenState extends State<TableauScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _enjeuFormController = TextEditingController();
  final TableauController tableauController = Get.find();

  final List<Map<String, dynamic>> _rows = []; // Liste des données du tableau
  String? _selectedPilier;

  // Fonction pour ajouter une ligne
  void ajouterEnjeu(BuildContext context) {
    List<String> piliers = tableauController.piliersList.value;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ajouter un enjeu"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Entrez l'intitulé de l'enjeu",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _enjeuFormController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Entrez un intitulé',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un intitulé.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Sélectionnez un pilier",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedPilier,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: piliers.map((pilier) {
                    return DropdownMenuItem(
                      value: pilier,
                      child: Text(pilier),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedPilier = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez sélectionner un pilier.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _rows.add({
                              "pilier": _selectedPilier!,
                              "numero": tableauController.numeroEnjeu.value.toString(),
                              "enjeu": _enjeuFormController.text,
                            });
                          });
                          tableauController.numeroEnjeu.value++;
                          Navigator.of(context).pop();
                          _enjeuFormController.clear();
                          _selectedPilier = null;
                        }
                      },
                      child: const Text("Valider"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

bool validateAllEnjeux() {
  return true;
}

void _showValidationError(String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ),
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau des Enjeux"),
      ),
      body: Column(
        children: [
          // Bouton Ajouter une ligne
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => ajouterEnjeu(context),
                  child: const Text("Ajouter une ligne"),
                ),
              ],
            ),
          ),
          // Tableau avec l'en-tête et les lignes
          Expanded(
            child: Column(
              children: [
                const HeadTable(), // En-tête du tableau
                Expanded(
                  child: ListView.builder(
                    itemCount: _rows.length,
                    itemBuilder: (context, index) {
                      return RowTemplate(
                        dataMap: _rows[index],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: () async{
                              showDialog(
                                context: context,
                                barrierDismissible: false, // Empêcher de fermer le dialogue
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Card(
                                      elevation: 8,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 10),
                                            Text("Generation du Graphe"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              // Attendre quelques secondes pour simuler le chargement
                              await Future.delayed(const Duration(seconds: 3));
                              Navigator.of(context).pop();

                              // Fermer le dialogue et naviguer vers la page suivante
                      if(validateAllEnjeux()){
                      context.go('/graphique-evaluation');
                      
                      }
                      
                    }, child: Text("Generer Graphe"))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


