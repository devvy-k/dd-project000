import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class RowTemplate extends StatefulWidget {
  final Map<String, dynamic> dataMap;
  const RowTemplate({super.key, required this.dataMap});

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
                  child: Text(widget.dataMap["pilier"] ?? ""),
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
                  child: Text(widget.dataMap["numero"] ?? ""),
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
                  child: Text(widget.dataMap["enjeu"] ?? ""),
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
                        children: [
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationA == "Très faible",
                            onTap: () => _updateEvaluation("Très faible", isForParties: false),
                            color: Colors.green,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationA == "Faible",
                            onTap: () => _updateEvaluation("Faible", isForParties: false),
                            color: Colors.green,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationA == "Moyen",
                            onTap: () => _updateEvaluation("Moyen", isForParties: false),
                            color: Colors.yellow,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationA == "Élevé",
                            onTap: () => _updateEvaluation("Élevé", isForParties: false),
                            color: Colors.orange,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationA == "Très Élevé",
                            onTap: () => _updateEvaluation("Très Élevé", isForParties: false),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    // Pour les parties prenantes
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationB == "Très faible",
                            onTap: () => _updateEvaluation("Très faible", isForParties: false),
                            color: Colors.green,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationB == "Faible",
                            onTap: () => _updateEvaluation("Faible", isForParties: true),
                            color: Colors.green,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationB == "Moyen",
                            onTap: () => _updateEvaluation("Moyen", isForParties: true),
                            color: Colors.yellow,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationB == "Élevé",
                            onTap: () => _updateEvaluation("Élevé", isForParties: true),
                            color: Colors.orange,
                          ),
                          _buildEvaluationBox(
                            label: "",
                            isSelected: selectedEvaluationB == "Très Élevé",
                            onTap: () => _updateEvaluation("Très Élevé", isForParties: true),
                            color: Colors.red,
                          ),
                        ],
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

  void _updateEvaluation(String value, {required bool isForParties}) {
    setState(() {
      if (isForParties) {
        selectedEvaluationB = value;
      } else {
        selectedEvaluationA = value;
      }

      if (selectedEvaluationA.isNotEmpty && selectedEvaluationB.isNotEmpty) {
        int x = _getEvaluationIndex(selectedEvaluationA);
        int y = _getEvaluationIndex(selectedEvaluationB);

        tableauController.enjeuxDataGraph.add([
          int.parse(widget.dataMap["numero"]), // Numéro de l'enjeu
          x,
          y,
        ]);
      }
    });
  }

  int _getEvaluationIndex(String evaluation) {
    switch (evaluation) {
      case "Très faible":
      return 0;
      case "Faible":
        return 1;
      case "Moyen":
        return 2;
      case "Élevé":
        return 3;
      case "Très Élevé":
        return 4;
      default:
        return -1;
    }
  }

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
}



