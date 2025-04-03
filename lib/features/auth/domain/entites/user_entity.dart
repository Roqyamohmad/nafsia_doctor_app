class UserEntity {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String phoneNumber;
  final String specialty;
  final String medicalLicenseNumber;
  final String licensingAuthority;
  final String email;
  final String password;
  final String? imagePath; // Optional field for profile image
  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.specialty,
    required this.medicalLicenseNumber,
    required this.licensingAuthority,
    required this.email,
    required this.password,
    this.imagePath,
  });
/*
  // Convert to Map for serialization (e.g., sending to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'specialty': specialty,
      'medicalLicenseNumber': medicalLicenseNumber,
      'licensingAuthority': licensingAuthority,
      'email': email,
      'password': password,
      'imagePath': imagePath,
    };
  }

  // Create a UserEntity from a Map (e.g., retrieving from Firestore)
  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      firstName: map['firstName'],
      lastName: map['lastName'],
      age: map['age'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      specialty: map['specialty'],
      medicalLicenseNumber: map['medicalLicenseNumber'],
      licensingAuthority: map['licensingAuthority'],
      email: map['email'],
      password: map['password'],
      imagePath: map['imagePath'],
    );
  }
  */
}
