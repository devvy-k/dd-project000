import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_saver/file_saver.dart';

class PdfPreviewScreen extends StatefulWidget {
  const PdfPreviewScreen({Key? key}) : super(key: key);

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  late pw.Document pdfDocument;
  late Uint8List pdfBytes;

  @override
  void initState() {
    super.initState();
    _generatePdf();
  }

  // Génération du PDF
Future<Uint8List> _generatePdf() async {
  final font = await PdfGoogleFonts.robotoRegular();
  final fontBold = await PdfGoogleFonts.robotoBold();

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        return pw.Padding(
          padding: const pw.EdgeInsets.all(8.0),
          child: pw.Column(
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
                width: PdfPageFormat.a4.width - 16,
                height: PdfPageFormat.a4.height * 0.6,
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
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: axesX
                    .map((value) => pw.Text(
                          value.toString(),
                          style: pw.TextStyle(font: fontBold),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    ),
  );

  pdfBytes = await pdf.save();
  return pdf.save();
}

  // Fonction pour enregistrer le PDF sur le disque
  Future<void> _savePdf() async {
    final result = await FileSaver.instance.saveFile(
      name : 'MonDocument',
      bytes:  pdfBytes,
      mimeType: MimeType.pdf,
    );

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('PDF sauvegardé à : $result')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prévisualisation du PDF"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _savePdf,
          ),
        ],
      ),
      body: pdfBytes.isNotEmpty
          ? SfPdfViewer.memory(pdfBytes)
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Printing.sharePdf(bytes: pdfBytes, filename: 'MonDocument.pdf');
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}



