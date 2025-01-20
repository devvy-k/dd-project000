Expanded(
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SizedBox(
      width: gridSize * 2, // Largeur explicite (ajustez selon vos besoins)
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Grille principale
          SizedBox(
            height: gridSize,
            width: gridSize,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: List.generate(axesX.length, (index) {
                      return Expanded(
                        child: Container(
                          color: _getZoneColor(index % 2, index ~/ 2),
                          margin: const EdgeInsets.all(2.0),
                          child: Center(
                            child: Text("Col $index"),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          // Autres Widgets (par exemple des colonnes supplémentaires)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
              groupedPP.length,
              (index) => Container(
                width: 100,
                height: 100,
                color: Colors.blueAccent.withOpacity(0.2 * (index + 1)),
                margin: const EdgeInsets.all(8.0),
                child: Center(child: Text("Colonne $index")),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),

