

import 'package:flutter/material.dart';

class ValuationScreen extends StatefulWidget {
  const ValuationScreen({super.key});

  @override
  State<ValuationScreen> createState() => _ValuationScreenState();
}

class _ValuationScreenState extends State<ValuationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Axe Y gradué
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Très Élevée",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Élevée",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Moyenne",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "Faible",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Grille principale
                  Expanded(
                    child: Column(
                      children: List.generate(4, (rowIndex) {
                        return Expanded(
                          child: Row(
                            children: List.generate(4, (colIndex) {
                              return Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: _getBorderColor(rowIndex, colIndex),
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Axe X gradué
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Faible", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Moyenne", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Élevée", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Très Élevée", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRiskLabel(int row, int col) {
    const labels = [
      ["Faible", "Moyenne", "Élevée", "Très Élevée"],
      ["Faible", "Moyenne", "Élevée", "Très Élevée"],
      ["Faible", "Moyenne", "Élevée", "Très Élevée"],
      ["Faible", "Moyenne", "Élevée", "Très Élevée"],
    ];
    return labels[row][col];
  }

  Color _getBorderColor(int row, int col) {
    // Priorités en fonction de la position dans la matrice
    if (row + col >= 5) {
      return Colors.red; // Priorité Élevée
    } else if (row + col == 4) {
      return Colors.yellow; // Priorité Moyenne
    } else if (row + col == 3) {
      return Colors.blue; // Priorité Faible
    } else {
      return Colors.green; // Priorité Très Faible
    }
  }
}
