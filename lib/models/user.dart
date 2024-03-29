class User {
  final int id;
   String? firstName;
   String? lastName;
   String email;
  final String? NID;
  final String? phone;
  final UserType type;
  final String? ip;

  User(
      {required this.id,
      this.firstName,
      this.lastName,
      required this.email,
      this.NID,
      this.phone,
      required this.type,
      this.ip});
  factory User.fromJson(dynamic json) {
    var type = (json['type'] == 'manager')
        ? UserType.manager
        : (json['type'] == 'customer')
            ? UserType.customer
            : UserType.esp32;
    return User(
        id: json['id'] ?? -1,
        firstName: json['first_name'] ?? "",
        lastName: json['last_name'] ?? "",
        NID: json['natinal_id'] ?? "",
        phone: json['phone_number'] ?? "",
        type: type,
        ip: json['ip'] ?? "",
        email: json['email'] ?? "");
  }
  factory User.empty() {
    return User(
      id: -1,
      email: '',
      type: UserType.customer,
    );
  }
}

enum UserType { manager, customer, esp32 }
