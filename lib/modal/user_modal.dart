class UserModal {
  UserModal({
    this.firstName,
    this.lastName,
    this.profileImage,
    this.securityNumber,
  });

  UserModal.fromJson(dynamic json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['image'];
    securityNumber = json['security_number'];
  }

  String? firstName;
  String? lastName;
  String? profileImage;
  int? securityNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['image'] = profileImage;
    map['security_number'] = securityNumber;

    return map;
  }
}

class DonationItems {
  DonationItems({
    this.donationId,
    this.imageURL,
  });

  DonationItems.fromJson(dynamic json) {
    donationId = json['donationId'];
    imageURL = json['imageURL'];
  }

  String? donationId;
  String? imageURL;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['donationId'] = donationId;
    map['imageURL'] = imageURL;
    return map;
  }
}
