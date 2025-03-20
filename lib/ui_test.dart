import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
class UiTest extends StatefulWidget {
  const UiTest({super.key});

  @override
  State<UiTest> createState() => _UiTestState();
}

class _UiTestState extends State<UiTest> {
final List<String> randomPhrases = [
 "La vie est pleine de surprises",
 "Le temps est un maître impitoyable",
 "La créativité n'a pas de limites",
 "Le silence est d'or",
 "Un voyage de mille lieues commence par un pas",
 "L'espoir fait vivre",
 "La connaissance est une arme puissante",
 "Le bonheur se trouve dans les petites choses",
 "La patience est une vertu",
 "L'union fait la force",
 "La beauté est dans l'œil de celui qui regarde",
 "Le rire est le meilleur des remèdes",
 "L'avenir appartient à ceux qui se lèvent tôt",
 "La curiosité est la clé du savoir",
 "Le changement est la seule constante",
 "La simplicité est la sophistication suprême",
 "Le succès vient à ceux qui persévèrent",
 "L'amour triomphe de tout",
 "La musique adoucit les mœurs",
 "Le présent est un cadeau",
 "L'expérience est la meilleure des enseignantes",
 "La vérité finit toujours par éclater",
 "Le doute est le début de la sagesse",
 "La liberté n'a pas de prix",
 "L'imagination est plus importante que le savoir"
];
  late Uint8List pdfBytes;
  final List<List<int>> _graphDatas = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
  ];

  final List<int> axesX = List.generate(12, (index) => index);
  final List<int> axesY = List.generate(12, (index) => index).reversed.toList();

PdfColor _getZoneColorPdf(int row, int col) {
  if (row == 1 && col == 0) {
    return PdfColor.fromInt(Colors.red.shade300.withOpacity(0.5).value);
  }
  if (row == 1 && col == 1) {
    return PdfColor.fromInt(Colors.orange.shade300.withOpacity(0.5).value);
  }
  if (row == 0 && col == 0) {
    return PdfColor.fromInt(Colors.blue.shade300.withOpacity(0.5).value);
  }
  return PdfColor.fromInt(Colors.green.shade300.value);
}

  String _getZoneLabel(int row, int col) {
    if (row == 1 && col == 0) return "SURVEILLER";
    if (row == 1 && col == 1) return "TENIR INFORMÉ";
    if (row == 0 && col == 0) return "MAINTENIR SATISFAIT";
    return "SUIVRE DE PRÈS";
  }

  Color _getZoneColor(int row, int col) {
    if (row == 1 && col == 0) return Colors.red.shade300.withOpacity(0.5);
    if (row == 1 && col == 1) return Colors.orange.shade300.withOpacity(0.5);
    if (row == 0 && col == 0) return Colors.blue.shade300.withOpacity(0.5);
    return Colors.green.shade300.withOpacity(0.5);
  }
  
Future<Uint8List> _generatePdf() async {
  final font = await PdfGoogleFonts.robotoRegular();
  final fontBold = await PdfGoogleFonts.robotoBold();

  final format = PdfPageFormat(
  42.0 * PdfPageFormat.cm, // largeur
  29.7 * PdfPageFormat.cm, // hauteur
  marginAll: 1.0 * PdfPageFormat.cm,
);

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: format, // Mode paysage
      build: (context) {
        return 
          pw.Row(
            children: [
              // Grille
            pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Titre
              pw.Text(
                'HIERARCHISATION DES PARTIES PRENANTES',
                style: pw.TextStyle(font: fontBold, fontSize: 18),
              ),
              pw.SizedBox(height: 20),

              // Grille principale avec les axes
              pw.Container(
                width: PdfPageFormat.a4.height * 0.5, // Largeur en mode paysage
                height: PdfPageFormat.a4.width * 0.5, // Hauteur en mode paysage
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // Axe Y
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(right: 8.0),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: axesY
                            .map((value) => pw.Text(
                                  value.toString(),
                                  style: pw.TextStyle(font: fontBold),
                                ))
                            .toList(),
                      ),
                    ),
                    // Grille
                    pw.Expanded(
                      child: pw.Column(
                        children: List.generate(2, (rowIndex) {
                          return pw.Expanded(
                            child: pw.Row(
                              children: List.generate(2, (colIndex) {
                                return pw.Expanded(
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      color: _getZoneColorPdf(rowIndex, colIndex),
                                      border: pw.Border.all(color: PdfColor.fromInt(Colors.black.value)),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      _getZoneLabel(rowIndex, colIndex),
                                      style: pw.TextStyle(font: font, fontSize: 12),
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

              pw.SizedBox(height: 20),

              // Axe X
              pw.Container(
                width: PdfPageFormat.a4.height * 0.5,
                child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: axesX
                    .map((value) => pw.Text(
                          value.toString(),
                          style: pw.TextStyle(font: fontBold),
                        ))
                    .toList(),
              ),
              )
            ],
          ),

          pw.SizedBox(width: 30),

          pw.Padding(
            padding: pw.EdgeInsets.only(top: 3.0, right: 8.0, left: 8.0, bottom: 3.0),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children:
                List.generate(randomPhrases.length,
                  (index){
                    return pw.Row(
                      children: [
                        pw.Container(
                          width: 40.0,
                          height: 30.0,
                          margin: pw.EdgeInsets.only(right: 10),
                          decoration: pw.BoxDecoration(
                            color: PdfColor.fromInt(Colors.lightBlue.value),
                            shape: pw.BoxShape.circle
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              index.toString(),
                              style: pw.TextStyle(
                                color: PdfColor.fromInt(Colors.white.value, ),
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 15.0
                              )
                              ),
                          )
                        ),
                        pw.SizedBox(width: 5),
                        pw.Text(randomPhrases[index], style: pw.TextStyle(fontSize: 15.5))
                      ]
                    );
                  }
                  )
            )
            )
            ]
          );
      },
    ),
  );

  pdfBytes = await pdf.save();
  return pdf.save();
}


  Future<void> _savePdf() async {
    _generatePdf();
    final result = await FileSaver.instance.saveFile(
      name : 'MonDocument',
      bytes:  pdfBytes,
      mimeType: MimeType.pdf,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('PDF sauvegardé à : $result')),
    );
    }
    
  void _printPdf() async {
    await Printing.layoutPdf(
      onLayout: (format) => _generatePdf(),
    );
  }

  @override
  void initState(){
    super.initState();
    _generatePdf();
  }
  
  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width;
    gridSize = gridSize > 400 ? 500 : gridSize;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphique des Parties Prenantes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _printPdf,
            tooltip: 'Exporter en PDF',
          ),
        ],
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Titre
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'HIERARCHISATION DES PARTIES PRENANTES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            // Grille avec axes X et Y
            SizedBox(
              height: gridSize,
              width: gridSize,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Axe Y
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: axesY
                        .map((y) => Transform.rotate(
                              angle: -0.5, // Inclinaison des labels
                              child: Text(
                                y.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(width: 8),
                  // Grille principale
                  Expanded(
                    child: Column(
                      children: List.generate(2, (rowIndex) {
                        return Expanded(
                          child: Row(
                            children: List.generate(2, (colIndex) {
                              return Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  color: _getZoneColor(rowIndex, colIndex),
                                  child: Center(
                                    child: Text(
                                      _getZoneLabel(rowIndex, colIndex),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
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
            const SizedBox(height: 8),
            // Axe X
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: axesX
                  .map((x) => Text(
                        x.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ))
                  .toList(),
            ),
          ],
        ),
    );
  }
}