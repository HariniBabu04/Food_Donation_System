import '../models/donation.dart';
import '../services/api_service.dart';

class SeekerAgent {
  Future<List<Donation>> fetchAvailableFood() async {
    try {
      final response = await ApiService.get("/food/available") as List;
      return response.map((d) => Donation.fromJson(d)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> acceptFreeFood(int donationId, int seekerId) async {
    try {
      final response = await ApiService.post("/food/accept/$donationId", {
        "ngoId": seekerId,
      });
      return response['status'] == 'success';
    } catch (e) {
      return false;
    }
  }
}
