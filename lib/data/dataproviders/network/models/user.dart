class User {
  User({
      required this.userId,
      required this.userName,
      required this.userType,
      required this.status,
      required this.userPassword,
      required this.locationId,
      required this.locationName,
      required this.businessId,
      required this.businessName,
      required this.defaultDepartmentCode,
      required this.defaultPartyCode,});

  User.fromJson(dynamic json) {
    userId = json['UserId'];
    userName = json['UserName'];
    userType = json['UserType'];
    status = json['Status'];
    userPassword = json['UserPassword'];
    locationId = json['LocationId'];
    locationName = json['LocationName'];
    businessId = json['BusinessId'];
    businessName = json['BusinessName'];
    defaultDepartmentCode = json['DefaultDepartmentCode'];
    defaultPartyCode = json['DefaultPartyCode'];
  }
  String userId="";
  String userName="";
  String userType="";
  String status="";
  String userPassword="";
  String locationId="";
  String locationName="";
  String businessId="";
  String businessName="";
  String defaultDepartmentCode="";
  String defaultPartyCode="";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UserId'] = userId;
    map['UserName'] = userName;
    map['UserType'] = userType;
    map['Status'] = status;
    map['UserPassword'] = userPassword;
    map['LocationId'] = locationId;
    map['LocationName'] = locationName;
    map['BusinessId'] = businessId;
    map['BusinessName'] = businessName;
    map['DefaultDepartmentCode'] = defaultDepartmentCode;
    map['DefaultPartyCode'] = defaultPartyCode;
    return map;
  }

}