class RowDataModel {
  String pilier;
  String enjeu;
  int numeroEnjeu;
  Map<String, bool> partiePrenanteA;
  Map<String, bool> partiePrenanteB;

  RowDataModel({
    required this.pilier,
    required this.enjeu,
    required this.numeroEnjeu,
    required this.partiePrenanteA,
    required this.partiePrenanteB,
  });

  // Méthode pour convertir un Map en instance de RowDataModel
  factory RowDataModel.fromMap(Map<String, dynamic> map) {
    return RowDataModel(
      pilier: map['pilier'] as String,
      enjeu: map['enjeu'] as String,
      numeroEnjeu: map['numero'] as int,
      partiePrenanteA: Map<String, bool>.from(map['partiePrenanteA']),
      partiePrenanteB: Map<String, bool>.from(map['partiePrenanteB']),
    );
  }

  // Méthode pour convertir une instance de RowDataModel en Map
  Map<String, dynamic> toMap() {
    return {
      'pilier': pilier,
      'enjeu': enjeu,
      'numero': numeroEnjeu,
      'partiePrenanteA': partiePrenanteA,
      'partiePrenanteB': partiePrenanteB,
    };
  }

  // Méthode pour réinitialiser les valeurs de partiePrenanteA et partiePrenanteB
  void resetEvaluations() {
    partiePrenanteA.updateAll((key, value) => false);
    partiePrenanteB.updateAll((key, value) => false);
  }
}
