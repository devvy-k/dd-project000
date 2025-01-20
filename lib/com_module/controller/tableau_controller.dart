import 'package:devvy_proj/com_module/tableau/data/models/row_data_model.dart';
import 'package:get/get.dart';

class TableauControllerCom extends GetxController {
  final titlePartiePrenante = "Partie Prenante".obs;
  final numeroPartiePrenante = 1.obs;
  final partiesPDatasGraph = <List<int>>[].obs;
  final rowsData = <RowDataModel>[].obs;

  final values = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
}