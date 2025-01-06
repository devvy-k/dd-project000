import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devvy_proj/valuation_module/tableau/data/models/row_data_model.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;

void createProject(String projectName, List<RowDataModel> rows) async {
  List dbDatas = convertRowDataModelToDb(rows);
  try {
    await db.collection('projects').doc(projectName).set({
      "datas": dbDatas
    });
    log("Projet $projectName sauvegardé avec succès.");
  } catch (e) {
    log("Erreur lors de la sauvegarde : ${e.toString()}");
    rethrow; // Relancer l'erreur pour qu'elle puisse être gérée ailleurs
  }
}


List convertRowDataModelToDb(List<RowDataModel> rows) {
  List dbRows = [];
  for (RowDataModel row in rows) {
    dbRows.add(row.toMap());
  }
  return dbRows;
}

}