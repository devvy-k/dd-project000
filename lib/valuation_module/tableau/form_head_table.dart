import 'package:devvy_proj/valuation_module/controller/tableau_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';

class FormHeadTableScreen extends StatefulWidget {
  const FormHeadTableScreen({super.key});

  @override
  State<FormHeadTableScreen> createState() => _FormHeadTableScreenState();
}

class _FormHeadTableScreenState extends State<FormHeadTableScreen> {
  final TableauController tableauController = Get.find();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _partiePrenanteA = TextEditingController();
  final TextEditingController _partiePrenanteB = TextEditingController();
  final TextEditingController _piliers = TextEditingController();
  final TextEditingController _qualitativeInput = TextEditingController();
  bool isQuantitative = false;
  bool isQualitative = false;
  String? evaluationMessage;

  List<String> _piliersList = [];
  List<String> _qualitativeWords = [];

  @override
  void initState() {
    super.initState();
  }

  void _removePilier(String pilier) {
    setState(() {
      _piliersList.remove(pilier);
    });
  }

  void _addPilier(String pilier) {
    if (!_piliersList.contains(pilier)) {
      setState(() {
        _piliersList.add(pilier);
        _piliers.clear();
      });
    }
  }

  void _addQualitativeWord(String word) {
    //if (!_qualitativeWords.contains(word) && _qualitativeWords.length < 5) {
      setState(() {
        _qualitativeWords.add(word);
        _qualitativeInput.clear();
      });
    
  }

  void _removeQualitativeWord(String word) {
    setState(() {
      _qualitativeWords.remove(word);
    });
  }

  void choixPiliers(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Choix des piliers"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _piliers,
                onFieldSubmitted: (value) {
                  _addPilier(value);
                },
                decoration: const InputDecoration(
                  labelText: 'Ajouter un pilier',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: _piliersList
                    .map((pilier) => Chip(
                          label: Text(pilier),
                          onDeleted: () => _removePilier(pilier),
                        ))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }

  bool _validateForm() {
    if (_partiePrenanteA.text.trim().isEmpty) {
      _showValidationError("Le champ 'Partie Prenante A' est obligatoire.");
      return false;
    }

    if (_partiePrenanteB.text.trim().isEmpty) {
      _showValidationError("Le champ 'Partie Prenante B' est obligatoire.");
      return false;
    }

    if (_piliersList.isEmpty) {
      _showValidationError("Veuillez ajouter au moins un pilier.");
      return false;
    }

    if (!isQuantitative && !isQualitative) {
      _showValidationError(
          "Veuillez sélectionner soit une évaluation quantitative, soit qualitative.");
      return false;
    }

    if (isQualitative && _qualitativeWords.length != 5) {
      _showValidationError(
          "L'évaluation qualitative nécessite exactement 5 mots.");
      return false;
    }

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

  void validateForm() async{
                               tableauController.titlePartiePrenanteA.value = _partiePrenanteA.text.trim();
                               tableauController.titlePartiePrenanteB.value = _partiePrenanteB.text.trim();
                               tableauController.piliersList.value = _piliersList;
                               tableauController.qualitativeValueList.value = _qualitativeWords;

                                    // Afficher le chargement
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
                                            Text("Chargement en cours..."),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              // Attendre quelques secondes pour simuler le chargement
                              await Future.delayed(const Duration(seconds: 3));

                              // Fermer le dialogue et naviguer vers la page suivante
                              Navigator.of(context).pop();
                              context.go('/tableau');
  } 

@override
void dispose() {
  _partiePrenanteA.dispose();
  _partiePrenanteB.dispose();
  _piliers.dispose();
  _qualitativeInput.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 400,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Intitulé partie prenante A (axe Y)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _partiePrenanteA,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Entrez un intitulé',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Intitulé partie prenante B (axe X)",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _partiePrenanteB,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Entrez un intitulé',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Choix des piliers",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () => choixPiliers(context),
                      icon: const Icon(Icons.add),
                      label: const Text("Ajouter des piliers"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _piliersList
                          .map((pilier) => Chip(
                                label: Text(pilier),
                                onDeleted: () => _removePilier(pilier),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),

                    // Evaluation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isQuantitative = true;
                              tableauController.isQualitative.value = false;
                              tableauController.isQuantitative.value = true;
                              isQualitative = false;
                              evaluationMessage = "Veuillez noter de 0 à 4.";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isQuantitative
                                ? Colors.blue
                                : Colors.grey[400],
                          ),
                          child: const Text("Évaluation Quantitative"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isQuantitative = false;
                              tableauController.isQualitative.value = true;
                              tableauController.isQuantitative.value = false;
                              isQualitative = true;
                              evaluationMessage =
                                  "Ajoutez jusqu'à 5 mots (faible, moyen, élevé, ...).";
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isQualitative
                                ? Colors.blue
                                : Colors.grey[400],
                          ),
                          child: const Text("Évaluation Qualitative"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    if (isQualitative) ...[
                      TextFormField(
                        controller: _qualitativeInput,
                        onFieldSubmitted: (value) {
                          _addQualitativeWord(value.trim());
                        },
                        decoration: const InputDecoration(
                          hintText: "Entrez un mot (faible, moyen...)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _qualitativeWords
                            .map((word) => Chip(
                                  label: Text(word),
                                  onDeleted: () => _removeQualitativeWord(word),
                                ))
                            .toList(),
                      ),
                      if (_qualitativeWords.length >= 5)
                        const Text(
                          "Vous ne pouvez ajouter que 5 mots.",
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                    if (isQuantitative)
                      const Text(
                        "Notations disponibles: 0, 1, 2, 3, 4.",
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go('/');
                          },
                          child: const Text("Annuler"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_validateForm()) {
                              validateForm();
                            }
                          },
                          child: const Text("Valider"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



