import 'package:devvy_proj/com_module/tableau/component/row_template.dart';
import 'package:devvy_proj/com_module/tableau/data/models/row_data_model.dart';

class TestModuleCom {
  final List<RowDataModel> listDataRows = [];
  final List<String> dataTest = [
    "Comités de Développement des Quartiers (CDQ)",
    "Conseil Citoyen Consultatif (CCC)",
    "Conseil Municipal",
    "Administration Municipale",
    "Personnel",
    "Syndicats",
    "Visiteurs",
    "Travailleurs quotidiens",
    "Entreprises privées",
    "Organisations Non-Gouvernementales (ONG)",
    "Associations et assimilés ",
    "Ministère de l’Intérieur et de la Sécurité",
    "Ministère des Finances et du Budget",
    "Préfecture d’Abidjan",
    "Commissariat de police du 1er Arrondissement du Plateau",
    "Partenaires économiques ",
    "Partenaires financiers ",
    "Partenaires techniques "
  ];

  List<RowTemplate> convertPPtoRows(List<String> ppDatas){
    final List<RowTemplate> rows = [];
    int numero = 1;

    for (var data in ppDatas){
      final rowData = RowDataModel(
        partiePrenante: data, 
        numeroPartiePrenante: numero, 
        influenceValue: 0, 
        interetValue: 0
        );
      listDataRows.add(rowData);
      rows.add(RowTemplate(rowData: rowData));
      numero++;
    }

    return rows;
  }
}