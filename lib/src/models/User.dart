class User {
  ////
  String username;
  String email;
  String firstName;
  String lastName;
  int profileId;
  String address;
  String dateOfBirth;
  String country;
  String phone;
  String city;
  String street;
  int zipCode;
  String picUrl;

  User(
      {
      this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.profileId,
      this.address,
      this.dateOfBirth,
      this.country,
      this.phone,
      this.city,
      this.street,
      this.zipCode,
      this.picUrl});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['Email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileId = json['profile_id'];
    //storeId = json['store_id'];
    address = json['address'];
    dateOfBirth = json['date_of_birth'];
    country = json['country'];
    phone = json['phone'];
    city = json['city'];
    street = json['street'];
    zipCode = json['zip_code'];
    picUrl = json['pic_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['Email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_id'] = this.profileId;
   // data['store_id'] = this.storeId;
    data['address'] = this.address;
    data['date_of_birth'] = this.dateOfBirth;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['city'] = this.city;
    data['street'] = this.street;
    data['zip_code'] = this.zipCode;
    data['pic_url'] = this.picUrl;
    return data;
  }
}