class Login {
  int? id;
  int? roleId;
  String? name;
  dynamic roleName;
  dynamic userName;
  dynamic photo;
  dynamic cnic;
  String? email;
  dynamic password;
  dynamic contactNo;
  String? phone;
  bool? isVerified;
  String? token;
  dynamic appartmentId;
  dynamic designationId;
  dynamic resTypeId;
  dynamic menus;
  String? jwtExpiryDate;

  Login({
    this.id,
    this.roleId,
    this.name,
    this.roleName,
    this.userName,
    this.photo,
    this.cnic,
    this.email,
    this.password,
    this.contactNo,
    this.phone,
    this.isVerified,
    this.token,
    this.appartmentId,
    this.designationId,
    this.resTypeId,
    this.menus,
  });

  Login.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['roleId'];
    name = json['name'];
    roleName = json['roleName'];
    userName = json['userName'];
    photo = json['photo'];
    cnic = json['cnic'];
    email = json['email'];
    password = json['password'];
    contactNo = json['contactNo'];
    phone = json['phone'];
    isVerified = json['isVerified'];
    token = json['token'];
    appartmentId = json['appartmentId'];
    designationId = json['designationId'];
    resTypeId = json['resTypeId'];
    menus = json['menus'];
    jwtExpiryDate = json['jwtExpiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['roleId'] = roleId;
    data['name'] = name;
    data['roleName'] = roleName;
    data['userName'] = userName;
    data['photo'] = photo;
    data['cnic'] = cnic;
    data['email'] = email;
    data['password'] = password;
    data['contactNo'] = contactNo;
    data['phone'] = phone;
    data['isVerified'] = isVerified;
    data['token'] = token;
    data['appartmentId'] = appartmentId;
    data['designationId'] = designationId;
    data['resTypeId'] = resTypeId;
    data['menus'] = menus;
    data['jwtExpiryDate'] = jwtExpiryDate;
    return data;
  }

  DateTime getJwtExpiry() => jwtExpiryDate == null
      ? DateTime.now().add(const Duration(days: 1))
      : DateTime.parse(jwtExpiryDate!);
}
