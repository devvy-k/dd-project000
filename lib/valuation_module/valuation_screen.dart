

import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

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
        title: const Text("Matrice de double matérialité"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Grille et légende
            Expanded(
              child: Row(
                children: [
                  // Grille principale
                  SizedBox(
                    height: gridSize,
                    width: gridSize,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                            // Axe Y gradué
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     RotatedBox(
                          //       quarterTurns: 3,
                          //       child: Text(
                          //         impactValuesList[4],
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     RotatedBox(
                          //       quarterTurns: 3,
                          //       child: Text(
                          //         impactValuesList[3],
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     RotatedBox(
                          //       quarterTurns: 3,
                          //       child: Text(
                          //         impactValuesList[2],
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     RotatedBox(
                          //       quarterTurns: 3,
                          //       child: Text(
                          //         impactValuesList[1],
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //     RotatedBox(
                          //       quarterTurns: 3,
                          //       child: Text(
                          //         impactValuesList[0],
                          //         style: TextStyle(fontWeight: FontWeight.bold),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                              
                              CustomPaint(
                                size: Size(50, gridSize),
                                painter : _ArrowAxisPainter(
                                  direction : Axis.vertical,
                                  labels: impactValuesList.toList()
                                )
                              ),
                              // Matrice avec diagonale
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
                                                      color: _getBorderColor(rowIndex, colIndex),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      ..._enjeuxData
                                                          .where((enjeu) =>
                                                              enjeu[1] == (4 - rowIndex) && enjeu[2] == colIndex)
                                                          .toList()
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                        (entry) => Align(
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
                                                                "${entry.value[0]}",
                                                                style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
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
                                    // Diagonale
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
                                    SizedBox(
              width: gridSize,
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     Text(impactValuesList[0], style: TextStyle(fontWeight: FontWeight.bold)),
              //     Text(impactValuesList[1], style: TextStyle(fontWeight: FontWeight.bold)),
              //     Text(impactValuesList[2], style: TextStyle(fontWeight: FontWeight.bold)),
              //     Text(impactValuesList[3], style: TextStyle(fontWeight: FontWeight.bold)),
              //     Text(impactValuesList[4], style: TextStyle(fontWeight: FontWeight.bold)),
              //   ],
              // ),
              child: Row(
                children: [
                  const SizedBox(width: 30),
                  Expanded(
                    child: CustomPaint(
                      size: Size(gridSize, 50),
                      painter: _ArrowAxisPainter(
                        direction: Axis.horizontal,
                        labels: impactValuesList
                      ),
                    ),
                  )
                ],
              ),
            ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Légendes
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "LEGENDE",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: tableauController.rowsData.length,
                            itemBuilder: (context, index) {
                              final rowData = tableauController.rowsData[index];
                              return Row(
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${rowData.numeroEnjeu}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      rowData.enjeu,
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Bouton retour
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/tableau'),
                  child: const Text("RETOUR"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Color _getBorderColor(int row, int col) {
  if (row <= 2 && col >= 3) {
    return Colors.red; // Zone supérieure droite
  } else if (row <= 2 && col <= 2) {
    return Colors.yellow; // Lignes 3-4 et colonnes 0-2
  } else if (row >= 3 && col >= 3) {
    return Colors.blue; // Colonnes 3-4 et lignes 0-2
  } else {
    return Colors.green; // Colonnes et lignes 0-2
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

class _ArrowAxisPainter extends CustomPainter {
  final Axis direction;
  final List<String> labels;

  _ArrowAxisPainter({required this.direction, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    if (direction == Axis.vertical) {
      // Flèche verticale (axe Y)
      canvas.drawLine(Offset(size.width / 2, size.height), Offset(size.width / 2, 0), paint);
      canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 - 5, 10), paint);
      canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2 + 5, 10), paint);

      // Ajouter les labels
      for (int i = 0; i < labels.length; i++) {
        double y = size.height - (i * (size.height / (labels.length - 1)));
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(0, y - 6));
      }
    } else {
      // Flèche horizontale (axe X)
      canvas.drawLine(Offset(0, size.height / 2), Offset(size.width, size.height / 2), paint);
      canvas.drawLine(Offset(size.width, size.height / 2), Offset(size.width - 10, size.height / 2 - 5), paint);
      canvas.drawLine(Offset(size.width, size.height / 2), Offset(size.width - 10, size.height / 2 + 5), paint);

      // Ajouter les labels
      for (int i = 0; i < labels.length; i++) {
        double x = i * (size.width / (labels.length - 1));
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: labels[i],
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height / 2 + 5));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}



