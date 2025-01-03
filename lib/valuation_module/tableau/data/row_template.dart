import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:devvy_proj/valuation_module/tableau/data/models/row_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RowTemplate extends StatefulWidget {
  final RowDataModel rowData;
  const RowTemplate({super.key, required this.rowData});

  @override
  State<RowTemplate> createState() => _RowTemplateState();
}

class _RowTemplateState extends State<RowTemplate> {
  final TableauController tableauController = Get.find();

  String selectedEvaluationA = ""; // Pour le conseil
  String selectedEvaluationB = ""; // Pour les parties prenantes

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 50, // Même hauteur que l'en-tête
          child: Row(
            children: [
              // Pilier de durabilité
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(widget.rowData.pilier)
                ),
              ),
              // Numéro
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(widget.rowData.numeroEnjeu.toString()),
                ),
              ),
              // Enjeux
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(widget.rowData.enjeu),
                ),
              ),
              // Importance des enjeux
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    // Pour le conseil
                    Expanded(
                      flex: 5,
                      child: Row(
                        children:
                          _buildEvaluationBoxes(widget.rowData.partiePrenanteA, isForParties: false)
                        ,
                      ),
                    ),
                    // Pour les parties prenantes
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: _buildEvaluationBoxes(widget.rowData.partiePrenanteB, isForParties: true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    /// Crée les boîtes d'évaluation pour une partie (A ou B)
  List<Widget> _buildEvaluationBoxes(
      Map<String, bool> evaluationMap, {
        required bool isForParties,
      }) {
    return evaluationMap.keys.map((key) {
      return _buildEvaluationBox(
        label: "",
        isSelected: evaluationMap[key] ?? false,
        onTap: () => _updateEvaluation(key, isForParties: isForParties),
        color: _getEvaluationColor(key),
      );
    }).toList();
  }

    /// Widget helper pour une boîte d'évaluation
    Widget _buildEvaluationBox({
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
      required Color color,
    }) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.all(2.0),
            height: double.infinity,
            decoration: BoxDecoration(
              color: isSelected ? color.withOpacity(0.5) : Colors.transparent,
              border: Border.all(color: Colors.black),
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),
      );
    }

void _updateEvaluation(String value, {required bool isForParties}) {
  setState(() {
    // Réinitialiser toutes les évaluations pour la partie sélectionnée
    if (isForParties) {
      widget.rowData.partiePrenanteB.updateAll((key, _) => false);
      widget.rowData.partiePrenanteB[value] = true;
    } else {
      widget.rowData.partiePrenanteA.updateAll((key, _) => false);
      widget.rowData.partiePrenanteA[value] = true;
    }

    // Ajouter les coordonnées dans enjeuxDataGraph si les deux parties ont une valeur
    String? selectedA = widget.rowData.partiePrenanteA.entries
        .lastWhere((entry) => entry.value, orElse: () => const MapEntry("", false))
        .key;
    String? selectedB = widget.rowData.partiePrenanteB.entries
        .lastWhere((entry) => entry.value, orElse: () => const MapEntry("", false))
        .key;

    int x = _getEvaluationIndex(selectedA);
    int y = _getEvaluationIndex(selectedB);

    // Vérifier si le numéro de l'enjeu existe déjà dans enjeuxDataGraph
    var existingEntryIndex = tableauController.enjeuxDataGraph.indexWhere(
      (entry) => entry[0] == widget.rowData.numeroEnjeu,
    );

    if (existingEntryIndex != -1) {
      // Mettre à jour les coordonnées si l'entrée existe
      tableauController.enjeuxDataGraph[existingEntryIndex] = [
        widget.rowData.numeroEnjeu,
        x,
        y,
      ];
    } else {
      // Ajouter une nouvelle entrée si elle n'existe pas
      tableauController.enjeuxDataGraph.add([
        widget.rowData.numeroEnjeu,
        x,
        y,
      ]);
    }
    });
}


    /// Renvoie la couleur correspondant à l'évaluation
  Color _getEvaluationColor(String evaluation) {
    switch (evaluation) {
      case "0":
        return Colors.green;
      case "1":
        return Colors.blue;
      case "2":
        return Colors.yellow;
      case "3":
        return Colors.orange;
      case "4":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

    /// Renvoie l'indice d'évaluation
  int _getEvaluationIndex(String evaluation) {
    switch (evaluation) {
      case "0":
        return 0;
      case "1":
        return 1;
      case "2":
        return 2;
      case "3":
        return 3;
      case "4":
        return 4;
      default:
        return -1;
    }
  }

}