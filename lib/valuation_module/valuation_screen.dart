

import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ValuationScreen extends StatefulWidget {
  const ValuationScreen({super.key});

  @override
  State<ValuationScreen> createState() => _ValuationScreenState();
}

class _ValuationScreenState extends State<ValuationScreen> {
  // Exemple de données pour représenter les cercles dans la grille
  final List<List<int>> _enjeuxData = Get.find<TableauController>().enjeuxDataGraph;
  final TableauController tableauController = Get.find();


  @override
  Widget build(BuildContext context) {
    List<String> impactValuesList = tableauController.getImpactValuesList();

    double gridSize = MediaQuery.of(context).size.width * 0.8;
    gridSize = gridSize > 400 ? 500 : gridSize; // Limitez la taille maximale

    return Scaffold(
      appBar: AppBar(
        title: const Text("Matrice des d'evaluation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Matrice et Axe Y
            SizedBox(
              height: gridSize,
              width: gridSize,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Axe Y gradué
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          impactValuesList[4],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          impactValuesList[3],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          impactValuesList[2],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          impactValuesList[1],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          impactValuesList[0],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Grille principale avec diagonale
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: List.generate(5, (rowIndex) {
                            return Expanded(
                              child: Row(
                                children: List.generate(5, (colIndex) {
                                  return Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _getBorderColor(
                                              rowIndex, colIndex),
                                          width: 2,
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          // Cercles des enjeux
                                          ..._enjeuxData.where((enjeu) {
                                            return enjeu[1] == rowIndex &&
                                                enjeu[2] == colIndex;
                                          }).map(
                                            (enjeu) => Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: const BoxDecoration(
                                                  color: Colors.blue,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "${enjeu[0]}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            );
                          }),
                        ),
                        // Diagonale partant de l'origine (0, 0)
                        CustomPaint(
                          size: Size(gridSize, gridSize),
                          painter: _DiagonalPainter(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Axe X gradué
            SizedBox(
              width: gridSize,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(impactValuesList[0], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(impactValuesList[1], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(impactValuesList[2], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(impactValuesList[3], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(impactValuesList[4], style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBorderColor(int row, int col) {
    // Priorités en fonction de la position dans la matrice
    if (row >= 3 && col >= 3 ) {
      return Colors.red; // Priorité Élevée
    } else if (row >= 3 && col <= 1) {
      return Colors.yellow; // Priorité Moyenne
    } else if (row <= 2 && col >= 3) {
      return Colors.blue; // Priorité Faible
    } else {
      return Colors.green; // Priorité Très Faible
    }
  }
}

class _DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    // Tracer une diagonale à partir de (0, 0) jusqu'à (taille, taille)
    canvas.drawLine(
      Offset(0, size.height),
      Offset(size.width, 0),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



