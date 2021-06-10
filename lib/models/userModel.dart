class UserModel{
  final int id;
  final String email;
  final String nom;
  final String prenom;
  final String telephone;
  final String sexe;
  final int solde;
  final dynamic  naissance;

  UserModel({this.id,  this.email, this.nom, this.prenom, this.telephone, this.sexe, this.solde, this.naissance});

  //mapping json data
  factory UserModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = UserModel(
      id: jsonMap["id"],
      email: jsonMap["email"],
      nom: jsonMap["nom"],
      prenom: jsonMap["prenom"],
      telephone: jsonMap["telephone"],
      sexe: jsonMap["sexe"],
      solde: jsonMap["nombre_points"],
      naissance: jsonMap["date_naissance"]

    );
    return data;
  }
}