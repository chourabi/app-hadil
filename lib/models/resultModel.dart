

class MsgModel {
  final String message;

  MsgModel({this.message});

  //mapping json data
  factory MsgModel.fromJSON(Map<String, dynamic> jsonMap){
    
    final data = MsgModel(
      message: jsonMap["message"],
    );
    return data;
  }

}