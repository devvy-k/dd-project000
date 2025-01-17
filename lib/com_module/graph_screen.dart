import 'dart:math';

import 'package:devvy_proj/utils/widgets/diagonal_painter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Random _random = Random();
  final axesX = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
  final List<List<int>> _enjeuxData = [
    [1, 0, 0], // Enjeu 1 dans la cellule (0, 0)
    [2, 1, 1], // Enjeu 2 dans la cellule (1, 1)
    [3, 2, 2], // Enjeu 3 dans la cellule (2, 2)
    [4, 3, 3], // Enjeu 4 dans la cellule (3, 3)
  ];
  @override
  Widget build(BuildContext context) {

    double gridSize = MediaQuery.of(context).size.width;
    gridSize = gridSize > 400 ? 600 : gridSize;

    final axesY = axesX.reversed.toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('STRATEGIE DE COMMUNICATION', style: TextStyle(fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: () {
                      context.go('/');
                  },
                  icon: Icon(
                    Icons.home,
                    color: Colors.blueGrey,
                  ),
                )
          ],
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(child: Row(
            children: [
              SizedBox(
                height: gridSize,
                width: gridSize,
                child: Column(
                  children: [
                    Expanded(child: 
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            RotatedBox(quarterTurns: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Influence des parties prenantes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                    ],
                                  ),),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: List.generate(axesY.length - 1,
                                  (index) => RotatedBox(quarterTurns: 3,
                                  child: Text(
                                    axesY[index].toString(),
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),)
                                  ),
                                ),
                              ),
                        Expanded(child: Stack(
                          children: [
                            Column(
                              children: List.generate(2, (rowIndex){
                                return Expanded(child: Row(
                                  children: List.generate(2, (colIndex){
                                    return Expanded(child: Container(
                                      margin: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: colIndex == 0 && rowIndex == 1 ? Colors.red.shade300
                                          : colIndex == 1 && rowIndex == 1 ? Colors.orange.shade300
                                          : colIndex == 0 && rowIndex == 0 ? Colors.blue.shade300
                                          : Colors.green.shade300
                                      ),
                                      child: Column(
                                        mainAxisAlignment: (colIndex == 0 && rowIndex == 1) || (colIndex == 1 && rowIndex == 1) ? MainAxisAlignment.end
                                          : MainAxisAlignment.start ,
                                        children: [
                                          colIndex == 0 && rowIndex == 1 ? Text("Surveiller")
                                          : colIndex == 1 && rowIndex == 1 ? Text("Tenir informer")
                                          : colIndex == 0 && rowIndex == 0 ? Text("Maintenir satisfait")
                                          : Text("Suivre de près")
                                        ],
                                      ),
                                    ));
                                  }),
                                ));
                              })
                            ),
                            _buildBubbles(gridSize),
                            // Diagonale
                            CustomPaint(
                              size: Size(gridSize, gridSize),
                              painter: DiagonalPainter(),
                            )
                          ],
                        ),),

                      ],
                    ),),
              SizedBox(
              width: gridSize,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(axesX.length, 
                      (index) => Text(axesX[index].toString(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),)
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Interets des parties prenantes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
                  ],
                ),
              ),
              const SizedBox(width: 30,),
              Expanded(child: 
                Stack(
                  children: [ Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Première ligne
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                border: Border.all(color: Colors.black)
                              ),
                              height: 100,
                              child: const Center(
                                child: Text('Communiquer'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(color: Colors.black)
                              ),
                              height: 100,
                              child: const Center(
                                child: Text('Engager le dialogue'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      // Deuxième ligne  
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                border: Border.all(color: Colors.black)
                              ), 
                              height: 100,
                              child: const Center(
                                child: Text('Informer'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                border: Border.all(color: Colors.black)
                              ), 
                              height: 100,
                              child: const Center(
                                child: Text('Communiquer'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ]
                ))
            ],
          ),)
        ],
      ),
      ),
    );
  }

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

}