class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
 // final String phoneNumber;
  final String langPref;

  UserModel(  {
    required this.id,
    required this.firstName,
    required this.lastName,
    //required this.phoneNumber,
    required this.email,
  required this.langPref,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName' : lastName,
      'email': email,
  //    'phoneNumber' : phoneNumber,
      'lang pref':langPref,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      firstName: map['first name'],
      lastName: map['last name'],
    //  phoneNumber: map['phone number'],
      email: map['email'],
      langPref: map['lang pref']
    );
  }
}