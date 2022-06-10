import 'package:get/get.dart';

import '../projectmodel_model.dart';

class ProjectmodelProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Projectmodel.fromJson(map);
      if (map is List)
        return map.map((item) => Projectmodel.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Projectmodel?> getProjectmodel(int id) async {
    final response = await get('projectmodel/$id');
    return response.body;
  }

  Future<Response<Projectmodel>> postProjectmodel(
          Projectmodel projectmodel) async =>
      await post('projectmodel', projectmodel);
  Future<Response> deleteProjectmodel(int id) async =>
      await delete('projectmodel/$id');
}
