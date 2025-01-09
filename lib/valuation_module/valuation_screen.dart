

import 'package:devvy_proj/valuation_module/services/database_service.dart';
import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:devvy_proj/valuation_module/tableau/data/models/row_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final DatabaseService dbService = DatabaseService();


  @override
  Widget build(BuildContext context) {

    

    List<String> impactValuesList = tableauController.getImpactValuesList();

    double gridSize = MediaQuery.of(context).size.width * 0.9;
    gridSize = gridSize > 400 ? 600 : gridSize; // Limitez la taille maximale

        // Diviser les enjeux en plusieurs colonnes
    List<RowDataModel> rows = tableauController.rowsData;
    int itemsPerColumn = (gridSize ~/ 40).toInt();

    List<List<RowDataModel>> groupedEnjeux = [];
    for (int i = 0; i < rows.length; i += itemsPerColumn) {
      groupedEnjeux.add(rows.sublist(i, i + itemsPerColumn > rows.length ? rows.length : i + itemsPerColumn));
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("MATRICE DE DOUBLE MATERIALITE", style: TextStyle(fontWeight: FontWeight.bold),),
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
                            RotatedBox(quarterTurns: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(tableauController.titlePartiePrenanteA.value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                    ],
                                  ),),
                              // Axe Y gradué     
                                                 
                              // CustomPaint(
                              //   size: Size(50, gridSize),
                              //   painter : _ArrowAxisPainter(
                              //     direction : Axis.vertical,
                              //     labels: impactValuesList.toList()
                              //   )
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 140.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(impactValuesList[4],
                                      style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                      ),
                                  RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(impactValuesList[3],
                                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                  ),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(impactValuesList[2],
                                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                  ),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(impactValuesList[1],
                                  style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                                  ),
                                  ],
                                ),
                              ),
                              // Matrice avec diagonale
                              Expanded(
                                child: Stack(
                                  children: [
                                    Column(
                                      children: List.generate(4, (rowIndex) {
                                        return Expanded(
                                          child: Row(
                                            children: List.generate(4, (colIndex) {
                                              return Expanded(
                                                child: Container(
                                                  margin: const EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: _getBorderColor(rowIndex, colIndex),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child:
                                                  _enjeuxData.isNotEmpty ? 
                                                  Stack(
                                                    children: [
                                                          ..._enjeuxData
                                                          .where((enjeu) =>
                                                              enjeu[1] == (3 - rowIndex ) && enjeu[2] == colIndex)
                                                          .toList()
                                                          .asMap()
                                                          .entries
                                                          .map(
                                                        (entry) { 
                                                          final enjeu = entry.value;
                                                          final index = entry.key;

                                                                // Calculer un décalage pour éviter les chevauchements
                                                          final offsetX = (index % 3) * 30.0; // Décalage horizontal
                                                          final offsetY = (index ~/ 3) * 20.0; // Décalage vertical

                                                          return Positioned(
                                                              left: offsetX,
                                                              top: offsetY,
                                                              child: SizedBox(
                                                                width: 30,
                                                                height: 30,
                                                                child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: _getEnjeuColor(tableauController.rowsData[enjeu[0] - 1]),
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
                                                            ) ;
                                                        
                                                        }
                                                      ),
                                                      
                                                    ],
                                                  )
                                                  : SizedBox(),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // const SizedBox(width: 30),
                        // Expanded(
                        //   child: CustomPaint(
                        //     size: Size(gridSize, 50),
                        //     painter: _ArrowAxisPainter(
                        //       direction: Axis.horizontal,
                        //       labels: impactValuesList
                        //     ),
                        //   ),
                        // )
                        Text(impactValuesList[0],
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        Text(impactValuesList[1],
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        Text(impactValuesList[2],
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        Text(impactValuesList[3],
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        Text(impactValuesList[4],
                        style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(tableauController.titlePartiePrenanteB.value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30),
                  // Légendes
Expanded(
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 3.0, right: 8.0, left: 8.0, bottom: 3.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('LEGENDE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          // Première ligne : Liste des enjeux
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                  const Text(
                    "Liste des enjeux",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              // Colonnes côte à côte
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(groupedEnjeux.length, (colIndex) {
                  return Expanded(
                    child: Column(
                      children: List.generate(groupedEnjeux[colIndex].length, (rowIndex) {
                        final rowData = groupedEnjeux[colIndex][rowIndex];
                              return Row(
                              children: [
                                // Cercle avec le numéro de l'enjeu
                                Container(
                  width: 30,
                  height: 20,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: _getEnjeuColor(rowData),
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
                  child: 
                    Text(
                      rowData.enjeu,
                      style: const TextStyle(fontSize: 12.5),
                    ),
                                ),
                              ],
                            );
                      }),
                    ),
                  );
                                }),
                              ),
                            ],
                          ),
                ),
              ],
            ),
          ),
          // Deuxième ligne : Typologie et Priorité
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Typologie des enjeux
                Expanded(
                  flex: 1,
      child: SizedBox(
        height: 115,
        child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 10.0, left: 10.0), // Ajouter du padding autour des éléments
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Typologie des enjeux",
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          _buildPilierLegendItem(Colors.green, "Environnement"),
                          SizedBox(height: 5,),
                          _buildPilierLegendItem(
                    const Color.fromARGB(169, 255, 136, 0),
                    "Economie",
                  ),
                  SizedBox(height: 5,),
                          _buildPilierLegendItem(Colors.blue, "Social"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        ),
      ),
      
                ),
                const SizedBox(width: 10),
      
                // Priorités
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 115,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 10.0, left: 10.0),
                        child: 
                        Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Priorités",
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _buildPriorityLegendItem(Colors.red, "Priorité élevée"),
                      SizedBox(height: 2,),
                      _buildPriorityLegendItem(Colors.orange, "Priorité moyenne"),
                      SizedBox(height: 2,),
                      _buildPriorityLegendItem(
                    Colors.blue,
                    "Priorité faible",
                  ),
                  SizedBox(height: 2,),
                      _buildPriorityLegendItem(Colors.green, "Priorité très faible"),
                    ],
                  ),
                ],
              ),
            ],
          ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
),


                ],
              ),
            ),
            const SizedBox(height: 10),
            // Bouton retour
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/tableau'),
                  child: const Text("RETOUR"),
                ),
                // ElevatedButton(
                //   onPressed: () async {
                //     try {
                //       dbService.createProject("projet_test001", tableauController.rowsData);
                //       context.go('/'); // Redirection après succès
                //     } catch (e) {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(
                //           content: Text("Erreur : ${e.toString()}"),
                //           backgroundColor: Colors.red,
                //         ),
                //       );
                //     }
                //   },
                //   child: const Text("SAUVEGARDER"),
                // )

              ],
            ),
          ],
        ),
      ),
    );
  }



// Fonction auxiliaire pour créer les items de la légende des priorités
Widget _buildPriorityLegendItem(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(fontSize: 12.5),
      ),
    ],
  );
}

Widget _buildPilierLegendItem(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 40,
        height: 20,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
        ),
      ),
      const SizedBox(width: 8),
      Text(
        label,
        style: const TextStyle(fontSize: 12.5),
      ),
    ],
  );
}

Color _getBorderColor(int row, int col) {
  if (row < 2 && col >= 2) {
    return Colors.red; // Zone supérieure droite
  } else if (row < 2 && col <= 1) {
    return Colors.yellow; // Lignes 3-4 et colonnes 0-2
  } else if (row >= 2 && col >= 2) {
    return const Color.fromARGB(255, 12, 67, 112); // Colonnes 3-4 et lignes 0-2
  } else {
    return Colors.green; // Colonnes et lignes 0-2
  }
}

Color _getEnjeuColor(RowDataModel rowEnjeu) {
    if (rowEnjeu.pilier == "Environnement") {
      return Colors.green;
    } else if (rowEnjeu.pilier == "Social") {
      return Colors.blue;
    } else {
      return const Color.fromARGB(169, 255, 136, 0);
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
      canvas.drawLine(
        Offset(size.width / 2, size.height),
        Offset(size.width / 2, 0),
        paint,
      );
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2 - 5, 10),
        paint,
      );
      canvas.drawLine(
        Offset(size.width / 2, 0),
        Offset(size.width / 2 + 5, 10),
        paint,
      );

      // Labels sur l'axe Y
      double cellHeight = size.height / (labels.length - 1);
      for (int i = 0; i < labels.length; i++) {
        double y = size.height - (i * cellHeight) - (cellHeight / 2); // Centre de la cellule
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: i == 0 ? labels[1] : i == 1 ? labels[2] : i == 2 ? labels[3] : i == 3 ? labels[4] : "",
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            size.width / 2 - textPainter.width - 8, // Décalage à gauche de l'axe
            y - textPainter.height / 2, // Centrage vertical
          ),
        );
      }
    } else {
      // Flèche horizontale (axe X)
      canvas.drawLine(
        Offset(0, size.height / 2),
        Offset(size.width, size.height / 2),
        paint,
      );
      canvas.drawLine(
        Offset(size.width, size.height / 2),
        Offset(size.width - 10, size.height / 2 - 5),
        paint,
      );
      canvas.drawLine(
        Offset(size.width, size.height / 2),
        Offset(size.width - 10, size.height / 2 + 5),
        paint,
      );

      // Labels sur l'axe X
      double cellWidth = size.width / (labels.length - 1);
      for (int i = 0; i < labels.length; i++) {
        double x = (i * cellWidth) + (cellWidth / 2); // Centre de la cellule
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text:i == 0 ? labels[1] : i == 1 ? labels[2] : i == 2 ? labels[3] : i == 3 ? labels[4] : "",
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(
            x - textPainter.width / 2, // Centrage horizontal
            size.height / 2 + 5, // Décalage sous l'axe
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class EnjeuxList extends StatelessWidget {
  final TableauController tableauController;
  final double maxColumnHeight;

  const EnjeuxList({
    super.key,
    required this.tableauController,
    required this.maxColumnHeight, // Définir une hauteur maximale pour chaque colonne
  });

  @override
  Widget build(BuildContext context) {
    // Diviser les enjeux en plusieurs colonnes
    List<RowDataModel> rows = tableauController.rowsData;
    int itemsPerColumn = (maxColumnHeight ~/ 30).toInt(); // En supposant une hauteur d'élément de 50

    List<List<RowDataModel>> groupedEnjeux = [];
    for (int i = 0; i < rows.length; i += itemsPerColumn) {
      groupedEnjeux.add(rows.sublist(i, i + itemsPerColumn > rows.length ? rows.length : i + itemsPerColumn));
    }

    return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Liste des enjeux",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Colonnes côte à côte
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(groupedEnjeux.length, (colIndex) {
              return Expanded(
                child: Column(
                  children: List.generate(groupedEnjeux[colIndex].length, (rowIndex) {
                    final rowData = groupedEnjeux[colIndex][rowIndex];
                          return Row(
          children: [
            // Cercle avec le numéro de l'enjeu
            Container(
              width: 30,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: _getEnjeuColor(rowData),
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
            // Texte avec défilement horizontal
            Expanded(
              child: 
                Text(
                  rowData.enjeu,
                  style: const TextStyle(fontSize: 12.5),
                ),
            ),
          ],
        );
                  }),
                ),
              );
            }),
          ),
        ],
      );
  }

Color _getEnjeuColor(RowDataModel rowEnjeu) {
    if (rowEnjeu.pilier == "Environnement") {
      return Colors.green;
    } else if (rowEnjeu.pilier == "Social") {
      return Colors.blue;
    } else {
      return const Color.fromARGB(169, 255, 136, 0);
    }
}
}




