class User{

  dynamic id;
  dynamic name;
  dynamic email;
  dynamic password;
  dynamic phoneNumber;
  dynamic image;
  dynamic points;
  dynamic credit;
  dynamic token;

  //Used in map of data
  static String idKey = "id";
  static String nameKey = "name";
  static String emailKey = "email";
  static String passwordKey = "password";
  static String phoneNumberKey = "phone";
  static String imageKey = "image";
  static String pointsKey = "points";
  static String creditKey = "credit";
  static String tokenKey = "token";

  //take the json map and create an object

  User.fromJson(Map<String,dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
    password = data['password'];
    phoneNumber = data['phone'];
    image = data['image'];
    points = data['points'];
    credit = data['credit'];
    token = data['token'];
  }

  User({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.image,
    this.credit,
    this.points,
    this.token
  });
}