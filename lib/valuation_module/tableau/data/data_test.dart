import 'dart:developer';

import 'package:devvy_proj/valuation_module/tableau/data/models/row_data_model.dart';
import 'package:devvy_proj/valuation_module/tableau/data/row_template.dart';

class Test {

final List<RowDataModel> listDataRows = [];

final List<Map<String, dynamic>> dataTest = [
  {
    "pilier": "Environnement",
    "enjeux": [
      "Transports durables",
      "Transition énergétique",
      "Adoption d’une politique de gestion environnementale claire",
      "Construction durable",
      "Réduction des émissions des GES",
      "Intégration des énergies renouvelables",
      "Prévention de la pollution",
      "Préservation de la biodiversité urbaine et des écosystèmes",
      "Éducation et sensibilisation à la durabilité environnementale",
    ],
  },
  {
    "pilier": "Economie",
    "enjeux": [
      "Allocation rapide du budget municipal",
      "Mobilisation de capitaux internationaux",
      "Introduction de la fiscalité verte",
      "Accès aux Fonds verts",
      "Innovation durable",
      "Transformation des déchets",
      "Création d’emplois verts et stables",
      "Financement de projets écologiques",
      "Déploiement de la Smart City",
      "Autonomie financière de la commune",
      "Optimisation continue des recettes fiscales",
      "Préparation à la croissance urbaine",
      "Insuffisance et cherté des logements résidentiels",
    ],
  },
  {
    "pilier": "Social",
    "enjeux": [
      "Promotion d’une meilleure coordination entre les parties prenantes",
      "Accès équitable aux services sociaux de base",
      "Participation citoyenne accrue dans la gouvernance urbaine",
      "Lutte contre les exclusions sociales",
      "Renforcement de la résilience urbaine face aux risques naturels",
    ],
  },
];

List<RowTemplate> convertEnjeuxToRows(List<Map<String, dynamic>> enjeuxData) {
  final List<RowTemplate> rows = [];
  int numero = 1;

  for (var data in enjeuxData) {
    final pilier = data['pilier'];
    final enjeux = data['enjeux'] as List<String>;

    for (var enjeu in enjeux) {
      final rowData = RowDataModel(
        pilier: pilier,
        enjeu: enjeu,
        numeroEnjeu: numero,
        partiePrenanteA: {
          "0": false,
          "1": false,
          "2": false,
          "3": false,
          "4": false,
        },
        partiePrenanteB: {
          "0": false,
          "1": false,
          "2": false,
          "3": false,
          "4": false,
        },
      );

      listDataRows.add(rowData);
      rows.add(RowTemplate(rowData: rowData));
      numero++;
    }
  }

  log("$listDataRows");
  

  return rows;
}
}


