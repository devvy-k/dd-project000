class RowDataModel {
  String partiePrenante;
  int numeroPartiePrenante;
  int influenceValue;
  int interetValue;

  RowDataModel({
    required this.partiePrenante,
    required this.numeroPartiePrenante,
    required this.influenceValue,
    required this.interetValue,
  });

  // Méthode pour convertir un Map en instance de RowDataModel
  factory RowDataModel.fromMap(Map<String, dynamic> map) {
    return RowDataModel(
      partiePrenante: map['partiePrenante'] as String,
      numeroPartiePrenante: map['numero'] as int,
      influenceValue: map['influence'] as int,
      interetValue: map['interet'] as int,
    );
  }

  // Méthode pour convertir une instance de RowDataModel en Map
  Map<String, dynamic> toMap() {
    return {
      'partiePrenante': partiePrenante,
      'numero': numeroPartiePrenante,
      'influence': influenceValue,
      'interet': interetValue,
    };
  }
}