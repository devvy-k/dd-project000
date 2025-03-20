import 'dart:math';

import 'package:devvy_proj/com_module/controller/tableau_controller.dart';
import 'package:devvy_proj/com_module/tableau/data/models/row_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final List<List<int>> _graphDatas = Get.find<TableauControllerCom>().partiesPDatasGraph;
  final TableauControllerCom tableauController = Get.find();

  final List<int> axesX = List.generate(12, (index) => index);
  final List<int> axesY = List.generate(12, (index) => index).reversed.toList();

    // Couleurs des zones
  Color _getZoneColor(int row, int col) {
    if (row == 1 && col == 0) return Colors.red.shade300.withOpacity(0.5);
    if (row == 1 && col == 1) return Colors.orange.shade300.withOpacity(0.5);
    if (row == 0 && col == 0) return Colors.blue.shade300.withOpacity(0.5);
    return Colors.green.shade300;
  }

  @override
  Widget build(BuildContext context) {

    double gridSize = MediaQuery.of(context).size.width;
    gridSize = gridSize > 400 ? 600 : gridSize;

          // Diviser les enjeux en plusieurs colonnes
    List<RowDataModel> rows = tableauController.rowsData;
    int itemsPerColumn = (gridSize ~/ 40).toInt();

    List<List<RowDataModel>> groupedPP = [];
    for (int i = 0; i < rows.length; i += itemsPerColumn) {
      groupedPP.add(rows.sublist(i, i + itemsPerColumn > rows.length ? rows.length : i + itemsPerColumn));
    }

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 90),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('HIERARCHISATION DES PARTIES PRENANTES', style: TextStyle(fontWeight: FontWeight.bold),),
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
      ),
      body: Padding(padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: gridSize * 3.5,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                            Expanded(
                              child: Stack(
                              children: [
                                Column(
                                  children: List.generate(2, (rowIndex){
                                    return Expanded(
                                      child: Row(
                                      children: List.generate(2, (colIndex){
                                        return Expanded(
                                          child: Container(
                                          margin: const EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                            color: _getZoneColor(rowIndex, colIndex)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: (colIndex == 0 && rowIndex == 1) || (colIndex == 1 && rowIndex == 1) ? MainAxisAlignment.end
                                              : MainAxisAlignment.start ,
                                            children: [
                                              colIndex == 0 && rowIndex == 1 ? Text("SURVEILLER", style: TextStyle(fontWeight: FontWeight.bold),)
                                              : colIndex == 1 && rowIndex == 1 ? Text("TENIR INFORMER", style: TextStyle(fontWeight: FontWeight.bold))
                                              : colIndex == 0 && rowIndex == 0 ? Text("MAINTENIR SATISFAIT", style: TextStyle(fontWeight: FontWeight.bold))
                                              : Text("SUIVRE DE PRES", style: TextStyle(fontWeight: FontWeight.bold))
                                            ],
                                          ),
                                        ));
                                      }),
                                    ));
                                  })
                                ),
                                _buildBubbles(gridSize),
                                // // Diagonale
                                // CustomPaint(
                                //   size: Size(gridSize, gridSize),
                                //   painter: DiagonalPainter(),
                                // )
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
                          Text("Intérêt des parties prenantes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ],
                  ),
                ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 30,),
                  Expanded(
                    child: 
                      Padding(
                        padding:const EdgeInsets.only(top: 3.0, right: 8.0, left: 8.0, bottom: 3.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(groupedPP.length, 
                              (colIndex){
                                return Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children:
                                      List.generate(groupedPP[colIndex].length, (rowIndex){
                                        final rowData = groupedPP[colIndex][rowIndex];
                                        return Row(
                                          children: [
                                            Container(
                                            width: 40,
                                            height: 30,
                                            margin: const EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                              color:Colors.lightBlue,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "S${rowData.numeroPartiePrenante}",
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15
                                                ),
                                              ),
                                            ),
                                                          ),
                                            Expanded(
                                            child: 
                                              Text(
                                                rowData.partiePrenante,
                                                style: const TextStyle(fontSize: 15.5),
                                              ),
                                                          ),
                                          ],
                                        );
                                      })
                                    ,
                                  )
                                  );
                              }),
                            )
                          ],
                        ),
                        )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_circle_right_outlined, color: Colors.blue, size: 50,)
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 320,
                      height: 300,
                      child: quadrants()
                      ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_circle_right_outlined, color: Colors.blue, size: 50,)
                      ],
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 400,
                      height: 750,
                      child: Tactiques()
                      )
                ],
                
                          ),
              ),
            ),),
            // Bouton retour
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => context.go('/tableau-com'),
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

Widget _buildBubbles(double gridSize) {
  // Map pour stocker les positions déjà utilisées
  final Map<String, bool> usedPositions = {};
  final Random random = Random();
  final List<Color> baseColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
  ];

  return Stack(
    children: _graphDatas.map((enjeu) {
      final xCoord = enjeu[1]; // x-coordinate
      final yCoord = enjeu[2]; // y-coordinate

      // Position proportionnelle dans la grille
      var xPos = (xCoord / 12.5) * gridSize;
      var yPos = (yCoord / 11) * gridSize;

      // Création d'une clé unique pour cette position
      String posKey = '${xPos.round()}_${yPos.round()}';

      // Si la position est déjà utilisée, ajouter un petit décalage aléatoire
      if (usedPositions.containsKey(posKey)) {
        // Décalage aléatoire entre -10 et 10 pixels
        xPos += random.nextDouble() * 20 - 35;
        yPos += random.nextDouble() * 20 - 27;
      }

      // Marquer la position comme utilisée
      usedPositions[posKey] = true;
      final Color randomColor = baseColors[random.nextInt(baseColors.length)]
          .withOpacity(0.6);

      return Positioned(
        left: xPos - 12,
        top: gridSize - yPos - 12,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.4),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              "S${enjeu[0].toString()}",
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

class quadrants extends StatelessWidget {
  const quadrants({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("QUADRANTS DES TACTIQUES", style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 10,
          ),
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
                    child: Text('COMMUNIQUER', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    child: Text('ENGAGER LE DIALOGUE', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    child: Text('INFORMER' , style: TextStyle(fontWeight: FontWeight.bold)),
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
                    child: Text('COMMUNIQUER', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ]
    );
  }
}

class Tactiques extends StatelessWidget {
  const Tactiques({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> tactiques = [
      {"Engager le dialogue":"(priorité élevée)"},
      {"Communiquer":"(priorité moyenne)"},
      {"Informer":"(priorité faible)"},
    ];

    List<String> formats = [
      "Co-entreprise",
      "Partenariat",
      "Collaboration dans la recherche",
      "Sommet",
      "Parrainage",
      "Sondage",
      "Publipostage ou lettre d'information",
      "Réseaux sociaux",
      "Conférence",
      "Campagne marketing",
      "Rapport sur le développement durable",
      "Publication",
      "Reportage d'actualités"
    ];
    return Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("TACTIQUES", style: TextStyle(fontWeight: FontWeight.bold),),
        Text("FORMATS", style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
    SizedBox(height: 10),
    // ligne 1
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5)
      ),
      child: IntrinsicHeight( // Ajout pour égaliser la hauteur des colonnes
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                      width: double.infinity, // Force le container à prendre toute la largeur
                      padding: EdgeInsets.symmetric(vertical: 10), // Ajoute du padding vertical
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.green
                      ),
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(tactiques[0].keys.first),
                          SizedBox(height: 10,),
                          Text(tactiques[0]["Engager le dialogue"]!)
                        ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: List.generate(
                  4,
                  (index) => Container(
                    width: double.infinity, // Force le container à prendre toute la largeur
                    padding: EdgeInsets.symmetric(vertical: 10), // Ajoute du padding vertical
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)
                    ),
                    child: Center( // Centre le texte horizontalement
                      child: Text(formats[index]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    //Ligne 2
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5)
      ),
      child: IntrinsicHeight( // Ajout pour égaliser la hauteur des colonnes
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                      width: double.infinity, // Force le container à prendre toute la largeur
                      padding: EdgeInsets.symmetric(vertical: 10), // Ajoute du padding vertical
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.green
                      ),
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(tactiques[1].keys.first),
                          SizedBox(height: 10,),
                          Text(tactiques[1]["Communiquer"]!)
                        ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: List.generate(
                  4,
                  (index) => Container(
                    width: double.infinity, // Force le container à prendre toute la largeur
                    padding: EdgeInsets.symmetric(vertical: 10), // Ajoute du padding vertical
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)
                    ),
                    child: Center( // Centre le texte horizontalement
                      child: Text(formats[index + 4]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    //Ligne 3
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5)
      ),
      child: IntrinsicHeight( // Ajout pour égaliser la hauteur des colonnes
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                      width: double.infinity, // Force le container à prendre toute la largeur
                      padding: EdgeInsets.symmetric(vertical: 10), // Ajoute du padding vertical
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.green
                      ),
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(tactiques[2].keys.first),
                          SizedBox(height: 10,),
                          Text(tactiques[2]["Informer"]!)
                        ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: List.generate(
                  4,
                  (index) => Container(
                    width: double.infinity, // Force le container à prendre toute la largeur
                    padding: EdgeInsets.symmetric(vertical: 10), // Ajoute du padding vertical
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1)
                    ),
                    child: Center( // Centre le texte horizontalement
                      child: Text(formats[index + 8]),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    )  
     ]
);
  }
}