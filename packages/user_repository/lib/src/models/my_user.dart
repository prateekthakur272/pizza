class MyUser{
  String name;
  String email;
  String id;

  MyUser({required this.name, required this.email, required this.id});

  factory MyUser.fromMap(Map<String, dynamic> map){
    return MyUser(name: map['name'], email: map['email'], id: map['id']);
  }

  Map<String, dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'id':id
    };
  }
}