import "package:store_project/base/api.dart";
import "package:store_project/models/base/list_api_data.dart";
import "package:store_project/models/customerImage.dart";
import "package:store_project/config/constant_values.dart";

class CustomerImageApi {
  final _service = ApiService(ConstantValues.apiDomain);

  Future<List<CustomerImage>> getImages(
      int startIndex, int endIndex, String category) async {
    var query = {
      "category": category,
      "end": endIndex,
      "height": 185,
      "s": "990D9D9084293CF4AFCE0EDEF9533CBB",
      "scale": 3,
      "sort": "alltime",
      "start": startIndex,
      "width": 186
    };

    try {
      final response = await _service.getData(
          endPoint: ConstantValues.getImagesEndPoint, query: query);

      ListAPIResponse<CustomerImage> data =
          ListAPIResponse.fromJson(response.data);

      return data.data;
    } catch (e) {
      rethrow;
    }
  }
}
