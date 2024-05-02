import 'dart:convert';

import 'package:address_utility_app/src/models/address_model.dart';
import 'package:address_utility_app/src/utils/const.dart';
import 'package:http/http.dart' as http;

class ApiViaCep {
  Future<List<AddressModel>> getListAddress({
    required String uf,
    required String cidade,
    required String logradouro,
  }) async {
    Uri uri = Uri.parse('${Const.baseUrl}/$uf/$cidade/$logradouro/json');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<AddressModel> listAddress =
          data.map((e) => AddressModel.fromJson(e)).toList();
      return listAddress;
    }

    return [];
  }
}
