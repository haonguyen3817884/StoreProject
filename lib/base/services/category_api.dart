import "package:store_project/base/api.dart";
import "package:store_project/models/base/list_api_data.dart";
import "package:store_project/models/category.dart";

class CategoryApi {
  final _service = ApiService("http://www.stuckwallpapers.com");

  Future<List<Category>> getCategories() async {
    try {
      final response =
          await _service.getData(endPoint: "/GetCategoriesv3json.aspx");
      ListAPIResponse<Category> data = ListAPIResponse.fromJson(response.data);

      return data.data;
    } catch (e) {
      rethrow;
    }
  }
}
