import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildTable() {
  return Container(
      color: Colors.grey[200], // Couleur de fond gris clair
      padding: const EdgeInsets.all(8.0), // Ajout d'espace autour du tableau
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Assure une hauteur égale
        children: [
          // Première colonne : PILIER DE DURABILITÉ
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Bordure noire
                color: Colors.white, // Fond blanc
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "PILIER DE DURABILITÉ",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8.0), // Espacement entre colonnes

          // Deuxième colonne : ENJEUX
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black), // Bordure noire
                color: Colors.white, // Fond blanc
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "ENJEUX",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 8.0), // Espacement entre colonnes

          // Troisième colonne : Importance des enjeux
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // Ligne supérieure : Importance des enjeux
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // Bordure noire
                      color: Colors.white, // Fond blanc
                    ),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      "Importance des enjeux",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0), // Espacement entre lignes

                // Ligne inférieure : Conseil et Parties Prenantes
                Expanded(
                  child: Row(
                    children: [
                      // Pour le Conseil
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), // Bordure noire
                            color: Colors.white, // Fond blanc
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            "Pour le Conseil",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0), // Espacement entre colonnes

                      // Pour les parties prenantes
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black), // Bordure noire
                            color: Colors.white, // Fond blanc
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          child: const Text(
                            "Pour les parties prenantes",
                            textAlign: TextAlign.center,
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
    );
}


