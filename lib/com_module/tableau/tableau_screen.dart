import 'dart:developer';

import 'package:devvy_proj/com_module/controller/tableau_controller.dart';
import 'package:devvy_proj/com_module/tableau/component/head_table.dart';
import 'package:devvy_proj/com_module/tableau/component/row_template.dart';
import 'package:devvy_proj/com_module/tableau/data/data_test.dart';
import 'package:devvy_proj/com_module/tableau/data/models/row_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class TableauScreenCom extends StatefulWidget {
  const TableauScreenCom({super.key});

  @override
  State<TableauScreenCom> createState() => _TableauScreenComState();
}

class _TableauScreenComState extends State<TableauScreenCom> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  final TableauControllerCom tableauController = Get.find();

  final test = TestModuleCom();

  void ajouterPartiePrenante(BuildContext context){
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Ajouter une partie prenante'),
          content: Form(
            key: _formKey,
            child: Column(
                mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Entrez l'intitulé de la partie prenante",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Entrez un intitulé',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un intitulé.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          tableauController.rowsData.add(RowDataModel.fromMap(
                            {
                              "partiePrenante": _textEditingController.text,
                              "numero": tableauController.numeroPartiePrenante.value,
                              "influence": 0,
                              "interet": 0,
                            }
                          ));
                          tableauController.numeroPartiePrenante.value++;
                          Navigator.of(context).pop();
                          _textEditingController.clear();
                        }
                      },
                      child: const Text("Valider"),
                    ),
                  ],
                ),                
                ]            
            )
            ),
        );
      }
      );
  }
  
  bool validateAllEnjeux() {
  return true;
}
  
  @override
  Widget build(BuildContext context) {
    return 
        Obx(() {
      return     Scaffold(
      appBar: AppBar(
        title: 
            const Text("Tableau des Parties Prenantes"),
      ),
      body: Column(
        children: [
          // Bouton Ajouter une ligne
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => ajouterPartiePrenante(context),
                      child: const Text("Ajouter une ligne"),
                    ),
                    IconButton(onPressed: (){
                      test.convertPPtoRows(test.dataTest);
                      tableauController.rowsData.value = test.listDataRows;
                      log("${tableauController.rowsData}");
                      tableauController.numeroPartiePrenante.value = test.listDataRows.length;
                    }, icon: Icon(
                      Icons.add,
                      color: Colors.orange,
                    ))
                  ],
                ),
              ],
            ),
          ),
          // Tableau avec l'en-tête et les lignes
          Expanded(
            child:  Column(
              children: [
                const HeadTable(), // En-tête du tableau
                Expanded(
                  child: ListView.builder(
                    itemCount: tableauController.rowsData.length,
                    itemBuilder: (context, index) {
                      return RowTemplate(
                        rowData: tableauController.rowsData[index],
                      );
                    },
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: () async{
                              showDialog(
                                context: context,
                                barrierDismissible: false, // Empêcher de fermer le dialogue
                                builder: (BuildContext context) {
                                  return Center(
                                    child: Card(
                                      elevation: 8,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 10),
                                            Text("Generation du Graphe"),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );

                              // Attendre quelques secondes pour simuler le chargement
                              await Future.delayed(const Duration(seconds: 3));
                              Navigator.of(context).pop();

                              // Fermer le dialogue et naviguer vers la page suivante
                      if(validateAllEnjeux()){
                      //debugDumpRenderTree();
                      context.go('/graphique-strategie-com');
                      
                      }
                      
                    }, child: Text("Generer Graphe"))
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
    },);
  }
}