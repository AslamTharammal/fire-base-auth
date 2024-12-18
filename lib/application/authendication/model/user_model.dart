class UserModel{
  String id;
  String email;
  String firstName;
  String secondName;
  String phoneNumber;
  UserModel({required this.firstName,required this.email ,required this.id,required this.phoneNumber,required this.secondName});

  factory UserModel.fromJson(Map<String,dynamic> json, ){
    return UserModel(firstName: json["firstName"], email: json["email"],
        id: json["id"], phoneNumber: json["phoneNumber"], secondName: json["secondName"]);
  }
  Map<String, dynamic>toJson(){
    return{"firstName": firstName, "email": email, "id": id, "phoneNumber": phoneNumber, "secondName": secondName};
  }
}