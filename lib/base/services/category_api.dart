import "package:store_project/base/api.dart";
import "package:store_project/models/base/list_api_data.dart";
import "package:store_project/models/category.dart";
import "package:store_project/config/constant_values.dart";

class CategoryApi {
  final _service = ApiService(ConstantValues.apiDomain);

  Future<List<Category>> getCategories() async {
    try {
      final response = await _service.getData(
          endPoint: ConstantValues.getCategoriesEndPoint);
      ListAPIResponse<Category> data = ListAPIResponse.fromJson(response.data);

      return data.data;
    } catch (e) {
      rethrow;
    }
  }
}
