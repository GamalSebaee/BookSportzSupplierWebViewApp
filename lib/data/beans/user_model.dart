class UserModel {
  dynamic id;
  String? name;
  String? jwtToken;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? lastLogin;
  String? status;
  String? email;
  bool? isEmailVerified;
  bool? isMobileNumberVerified;
  String? language;
  String? nationality;
  String? loginType;
  dynamic userDetails;
  ServiceProviderDetails? serviceProviderDetails;

  UserModel(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.type,
      this.jwtToken,
      this.lastLogin,
      this.status,
      this.email,
      this.isEmailVerified,
      this.isMobileNumberVerified,
      this.language,
      this.nationality,
      this.loginType,
      this.serviceProviderDetails,
      this.userDetails});

  UserModel.fromJson(Map<String, dynamic> json,{String? token}) {
    id = json['id'];
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    type = json['type'];
    lastLogin = json['lastLogin'];
    status = json['status'];
    email = json['email'];
    isEmailVerified = json['isEmailVerified'];
    isMobileNumberVerified = json['isMobileNumberVerified'];
    language = json['language'];
    nationality = json['nationality'];
    loginType = json['loginType'];
    userDetails = json['userDetails'];
    jwtToken = token ?? json['jwtToken'];
    serviceProviderDetails = json['serviceProviderDetails'] != null
        ? ServiceProviderDetails.fromJson(json['serviceProviderDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['type'] = type;
    data['lastLogin'] = lastLogin;
    data['status'] = status;
    data['email'] = email;
    data['isEmailVerified'] = isEmailVerified;
    data['isMobileNumberVerified'] = isMobileNumberVerified;
    data['language'] = language;
    data['nationality'] = nationality;
    data['loginType'] = loginType;
    data['userDetails'] = userDetails;
    data['jwtToken'] = jwtToken;
    if (serviceProviderDetails != null) {
      data['serviceProviderDetails'] = serviceProviderDetails!.toJson();
    }
    return data;
  }
}

class ServiceProviderDetails {
  Company? company;

  ServiceProviderDetails({this.company});

  ServiceProviderDetails.fromJson(Map<String, dynamic> json) {
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Company {
  String? logo;

  Company({this.logo});

  Company.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    return data;
  }
}
