import 'package:devvy_proj/com_module/controller/tableau_controller.dart';
import 'package:devvy_proj/com_module/tableau/data/models/row_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RowTemplate extends StatefulWidget {
  final RowDataModel rowData; 
  const RowTemplate({super.key, required this.rowData});

  @override
  State<RowTemplate> createState() => _RowTemplateState();
}

class _RowTemplateState extends State<RowTemplate> {
  final TableauControllerCom tableauController = Get.find();

  int selectedInteretNum = 0;
  int selectedInfluenceNum = 0;
  int dropdowBoxIndexToColor = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
              // numero
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: (){
                            _deleteRow(widget.rowData.numeroPartiePrenante);
                          }, 
                          icon: const Icon(Icons.delete, color: Colors.red,)
                          )
                      ],
                    ),
                    SizedBox(width: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.rowData.numeroPartiePrenante.toString())
                      ],
                    )
                  ],
                ),
              ),
              // Parties Prenantes
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                  ),
                  child: Text(widget.rowData.partiePrenante),
                )),
                // Interets
                Expanded(
                  flex: 1,
                  child: dropdownMenu(isForInfluence: false),
                ),
                // Influences
                Expanded(
                  flex: 1,
                  child: dropdownMenu(isForInfluence: true),
                ),
            ],
          ),
        ),
        )
    );
  }

  /// Supprime une ligne et met à jour les numéros
  void _deleteRow(int numeroEnjeu) {
    setState(() {
      // Supprime la ligne ciblée
      tableauController.rowsData.removeWhere((row) => row.numeroPartiePrenante == numeroEnjeu);
      tableauController.partiesPDatasGraph.removeWhere((row) => row[0] == numeroEnjeu);

      // Met à jour les numéros des lignes restantes
      for (int i = 0; i < tableauController.rowsData.length; i++) {
        tableauController.rowsData[i].numeroPartiePrenante = i + 1; // Numérotation à partir de 1
      }

      // Met à jour le compteur de numéro dans le contrôleur
      tableauController.numeroPartiePrenante.value--;
    });
  }

  Widget dropdownMenu({required bool isForInfluence}){
    return Container(
      color: Colors.transparent,
      child: DropdownMenu<int>(
        initialSelection: isForInfluence ? widget.rowData.influenceValue : widget.rowData.interetValue,
        onSelected: (int? value){
          setState(() {
            if (value == null){
              _updateEvaluation(0, isForInfluence: isForInfluence);
            } else{
              dropdowBoxIndexToColor = value;
              _updateEvaluation(value, isForInfluence: isForInfluence);
            }        
          });
        },
        dropdownMenuEntries: tableauController.values.map<DropdownMenuEntry<int>>((int value) {
          return DropdownMenuEntry<int>(value: value, label: value.toString());
        }).toList(),
      ),
    );
  }

  void _updateEvaluation(int value, {required bool isForInfluence}){
    setState(() {
      if(isForInfluence){
        widget.rowData.influenceValue = value;
      } else {
        widget.rowData.interetValue = value;
      }

      int x = widget.rowData.interetValue;
      int y = widget.rowData.influenceValue;

      var existingEntryIndex = tableauController.partiesPDatasGraph.indexWhere(
        (element) => element[0] == widget.rowData.numeroPartiePrenante,
      );

      if(existingEntryIndex != -1){
        tableauController.partiesPDatasGraph[existingEntryIndex] = [
          widget.rowData.numeroPartiePrenante,
          x,
          y,
        ];
      } else {
        tableauController.partiesPDatasGraph.add([
          widget.rowData.numeroPartiePrenante,
          x,
          y,
        ]);
      }
    });
  }

 Color getDropBoxColor(int value){
  switch(value) {
    case 1:
     return Colors.green;
    case 2:
     return const Color.fromARGB(255, 116, 175, 76);
    case 3:
     return const Color.fromARGB(255, 149, 175, 76);
    case 4:
     return const Color.fromARGB(255, 168, 175, 76);
    case 5:
     return const Color.fromARGB(255, 173, 175, 76);
    case 6:
     return const Color.fromARGB(255, 175, 168, 76);
    case 7:
     return const Color.fromARGB(255, 175, 157, 76);
    case 8:
     return const Color.fromARGB(255, 175, 132, 76);
    case 9:
     return const Color.fromARGB(255, 175, 120, 76);
    case 10:
     return const Color.fromARGB(255, 175, 104, 76);
    case 11:
     return const Color.fromARGB(255, 175, 76, 76);
    default:
      return Colors.transparent;
  }
 }
}