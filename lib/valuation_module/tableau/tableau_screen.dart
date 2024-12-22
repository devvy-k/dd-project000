import 'package:devvy_proj/valuation_module/tableau/component/head_table.dart';
import 'package:devvy_proj/valuation_module/tableau/data/data_table.dart';
import 'package:flutter/material.dart';

class TableauScreen extends StatelessWidget {

  const TableauScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> axes = ["Très faible", "Faible", "Moyenne", "Élevée", "Très élevée"];
    final List<Color> borderColors = [
      Colors.green, // Très faible
      Colors.blue,  // Faible
      Colors.yellow, // Moyenne
      Colors.orange, // Élevée
      Colors.red,   // Très élevée
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tableau des Enjeux"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Importance des enjeux pour les parties prenantes",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Table(
                border: TableBorder.all(color: Colors.black, width: 1),
                columnWidths: {
                  0: const FlexColumnWidth(1),
                  1: const FlexColumnWidth(2),
                },
                children: [
                  // Header row for the axes
                  TableRow(
                    children: [
                      const SizedBox(),
                      for (var axis in axes)
                        Center(
                          child: Text(
                            axis,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  // Rows for the priority levels
                  for (int i = 0; i < axes.length; i++)
                    TableRow(
                      children: [
                        // Row header for the axes
                        Center(
                          child: Text(
                            axes[i],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Cells for each axis combination
                        for (int j = 0; j < axes.length; j++)
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColors[i], width: 2),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Importance des enjeux pour le Conseil Municipal",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
