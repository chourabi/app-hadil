
class CouponModel{
  final int id;
  final String etat;
  final int code;
  final DateTime dateExpiration;
  final double montant;
  final DateTime dateCreation;

  CouponModel({this.id,  this.etat, this.code, this.dateExpiration ,this.montant ,this.dateCreation});

  //mapping json data
  factory CouponModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = CouponModel(
      id: jsonMap["id"],
      etat: jsonMap["etat"],
      code: jsonMap["code"],
      dateExpiration: jsonMap["dateExpiration"],
      montant: jsonMap["montantBandeAchat"],
      dateCreation: jsonMap["dateCreation"],
     

    );
    return data;
  }
}