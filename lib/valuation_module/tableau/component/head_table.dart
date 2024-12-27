import 'package:devvy_proj/valuation_module/tableau/controller/tableau_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class HeadTable extends StatefulWidget {
  const HeadTable({super.key});

  @override
  State<HeadTable> createState() => _HeadTableState();
}

class _HeadTableState extends State<HeadTable> {
  final TableauController tableauController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<String> impactValuesList = tableauController.getImpactValuesList();

      return Card(
        elevation: 4,
        color: Colors.blueGrey[700],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            height: 150,
            child: Row(
              children: [
                // Pilier de durabilité
                Expanded(
                  flex: 1,
                  child: HeaderTemplate(title: "PILIERS DE DURABILITE"),
                ),
                // Numero
                Expanded(
                  flex: 1,
                  child: HeaderTemplate(title: "Numero"),
                  ),
                // Enjeux
                Expanded(
                  flex: 3,
                  child: HeaderTemplate(title: "ENJEUX"),
                ),
                Expanded(
                  flex: 3, // Importance des enjeux prend 60% de la largeur totale
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Titre : Importance des enjeux
                      Expanded(
                        child: HeaderTemplate(title: "Importance des enjeux"),
                      ),
                      // Conteneurs pour "Pour le conseil" et "Pour les parties prenantes"
                      Expanded(
                        flex: 3, // La section "Pour le conseil" et "Pour les parties prenantes" prend le reste
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Pour le conseil
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: HeaderTemplate(title: tableauController.titlePartiePrenanteA.value),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: List.generate(
                                        impactValuesList.length,
                                        (index) => Expanded(
                                          child: HeaderTemplate(
                                            title: impactValuesList[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Pour les parties prenantes
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: HeaderTemplate(title: tableauController.titlePartiePrenanteB.value),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: List.generate(
                                        impactValuesList.length,
                                        (index) => Expanded(
                                          child: HeaderTemplate(
                                            title: impactValuesList[index],
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class HeaderTemplate extends StatelessWidget {
  final String title;

  const HeaderTemplate({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.white,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}



