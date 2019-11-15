class UserInformation {
  int userId;
  String userName;
  String shopPic;
  String shopName;

  UserInformation({
    this.userId,
    this.userName,
    this.shopName,
    this.shopPic,
  });

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    String name = json['userName'];
    int id ;
//    print('fromJson==========userName '+ name);
    if(json['userName'] == null){
//      name = json['url_name'];
    }
    if(json['userID'].runtimeType == int){
      id = json['userID'];
    }else{
      id = int.parse(json['userID']);
    }
    return UserInformation(
//        shopPic: json['shopPic'],
        userId: id,
        userName: name,
        shopName: json['userShopname']);
  }
}
