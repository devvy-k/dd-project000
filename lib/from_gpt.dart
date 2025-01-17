import 'dart:math';
import 'package:flutter/material.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Random _random = Random();
  final List<List<int>> _enjeuxData = [
    [1, 0, 0], // Enjeu 1 dans la cellule (0, 0)
    [2, 1, 1], // Enjeu 2 dans la cellule (1, 1)
    [3, 2, 2], // Enjeu 3 dans la cellule (2, 2)
    [4, 3, 3], // Enjeu 4 dans la cellule (3, 3)
  ];

  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width * 0.9;
    gridSize = gridSize > 600 ? 600 : gridSize;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'STRATEGIE DE COMMUNICATION',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.home,
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Grille principale
            SizedBox(
              height: gridSize,
              width: gridSize,
              child: Stack(
                children: [
                  _buildGrid(gridSize),
                  _buildBubbles(gridSize),
                  CustomPaint(
                    size: Size(gridSize, gridSize),
                    painter: DiagonalPainter(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Construit la grille principale
  Widget _buildGrid(double gridSize) {
    return Column(
      children: List.generate(4, (rowIndex) {
        return Expanded(
          child: Row(
            children: List.generate(4, (colIndex) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: _getGridColor(rowIndex, colIndex),
                    border: Border.all(color: Colors.black),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }

  /// Ajoute les bulles numérotées avec des positions aléatoires autour de la diagonale
  Widget _buildBubbles(double gridSize) {
    return Stack(
      children: _enjeuxData.map((enjeu) {
        double randomOffsetX = (_random.nextDouble() - 0.5) * gridSize * 0.1;
        double randomOffsetY = (_random.nextDouble() - 0.5) * gridSize * 0.1;

        double posX = (enjeu[1] + 0.5) * gridSize / 4 + randomOffsetX;
        double posY = (enjeu[2] + 0.5) * gridSize / 4 + randomOffsetY;

        return Positioned(
          left: posX - 12, // Centrer la bulle
          top: posY - 12,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.5), // Couleur pâle
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Center(
              child: Text(
                "${enjeu[0]}",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Couleurs pour les cellules de la grille
  Color _getGridColor(int row, int col) {
    if (row + col >= 5) {
      return Colors.red.shade100; // Priorité élevée
    } else if (row + col == 4) {
      return Colors.yellow.shade100; // Priorité moyenne
    } else if (row + col == 3) {
      return Colors.blue.shade100; // Priorité faible
    } else {
      return Colors.green.shade100; // Priorité très faible
    }
  }
}

/// Peint une diagonale à travers la grille
class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width, size.height),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
