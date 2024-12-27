import 'package:get/state_manager.dart';

class TableauController extends GetxController {

  final isQualitative = false.obs;
  final isQuantitative = false.obs;
  final titlePartiePrenanteA = "".obs;
  final titlePartiePrenanteB = "".obs;
  final piliersList = <String>[].obs;
  final qualitativeValueList = <String>[].obs;
  final numeroEnjeu = 1.obs;

  final datasList = [].obs;

  final impactValuesList = [].obs;

  final enjeuxDataGraph = <List<int>>[].obs;

  List<String> getImpactValuesList(){
    if(isQualitative.value){
      return qualitativeValueList;
    } else {
      return ["0", "1", "2", "3", "4"];
    }
  }

  void addEnjeu(Map<String, dynamic> enjeu) {
    impactValuesList.add(enjeu);
  }
}