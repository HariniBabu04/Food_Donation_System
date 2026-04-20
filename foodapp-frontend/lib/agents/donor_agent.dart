import '../models/donation.dart';
import '../services/api_service.dart';

class DonorAgent {
  Future<bool> announceFoodAvailability({
    required int donorId,
    required String foodName,
    required String foodType,
    required int quantity,
    required String address,
    required String contactPerson,
    required String contactNumber,
  }) async {
    try {
      final response = await ApiService.post("/food/add", {
        "donorId": donorId,
        "foodName": foodName,
        "foodType": foodType,
        "quantity": quantity,
        "pickupAddress": address,
        "contactPerson": contactPerson,
        "contactNumber": contactNumber,
      });
      return response['status'] == 'success';
    } catch (e) {
      return false;
    }
  }

  Future<List<Donation>> getMyDonations(int donorId) async {
    try {
      final response = await ApiService.get("/food/donor/$donorId") as List;
      return response.map((d) => Donation.fromJson(d)).toList();
    } catch (e) {
      return [];
    }
  }
}
