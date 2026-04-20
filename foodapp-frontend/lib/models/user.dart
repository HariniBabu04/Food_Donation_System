class User {
  final int? userId;
  final String name;
  final String email;
  final String? phone;
  final String? role;
  final String? organizationName;
  final String? address;

  User({
    this.userId,
    required this.name,
    required this.email,
    this.phone,
    this.role,
    this.organizationName,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'],
      organizationName: json['organizationName'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'organizationName': organizationName,
      'address': address,
    };
  }
}
