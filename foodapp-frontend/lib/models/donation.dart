import 'user.dart';

class Donation {
  final int? donationId;
  final String foodName;
  final String foodType;
  final int quantity;
  final String? pickupAddress;
  final String? contactPerson;
  final String? contactNumber;
  final String status;
  final User? donor;
  final User? ngo;

  Donation({
    this.donationId,
    required this.foodName,
    required this.foodType,
    required this.quantity,
    this.pickupAddress,
    this.contactPerson,
    this.contactNumber,
    required this.status,
    this.donor,
    this.ngo,
  });

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      donationId: json['donationId'],
      foodName: json['foodName'] ?? '',
      foodType: json['foodType'] ?? '',
      quantity: json['quantity'] ?? 0,
      pickupAddress: json['pickupAddress'],
      contactPerson: json['contactPerson'],
      contactNumber: json['contactNumber'],
      status: json['status'] ?? 'CREATED',
      donor: json['donor'] != null ? User.fromJson(json['donor']) : null,
      ngo: json['ngo'] != null ? User.fromJson(json['ngo']) : null,
    );
  }
}
