import 'package:address_utility_app/src/api/api_viacep.dart';
import 'package:mobx/mobx.dart';

import '../models/address_model.dart';

part 'address_store.g.dart';

class AddressStore = AddressBase with _$AddressStore;

abstract class AddressBase with Store {
  ApiViaCep apiViaCep = ApiViaCep();

  @observable
  bool loadingSearchAddress = false;

  @observable
  bool filtredListAddressIsEmpty = false;

  @observable
  List<AddressModel> listAddress = [];

  @observable
  List<AddressModel> myListAddress = [];

  @action
  void addInMyList({required AddressModel address}) {
    myListAddress.add(address);
  }

  @action
  void filterListAddress({String? bairro, String? uf}) {
    List<AddressModel> filteredList = List<AddressModel>.from(listAddress);

    if (bairro != null && bairro != '') {
      filteredList =
          filteredList.where((element) => element.bairro == bairro).toList();
    }

    if (uf != null && uf != '') {
      filteredList = filteredList.where((element) => element.uf == uf).toList();
    }

    if (filteredList.isEmpty) {
      filtredListAddressIsEmpty = true;
      return;
    }

    filtredListAddressIsEmpty = false;
    listAddress = filteredList;
  }

  @action
  void filterMyListAddress({String? bairro, String? uf}) {
    List<AddressModel> filteredList = List<AddressModel>.from(myListAddress);

    if (bairro != null && bairro != '') {
      filteredList =
          filteredList.where((element) => element.bairro == bairro).toList();
    }

    if (uf != null && uf != '') {
      filteredList = filteredList.where((element) => element.uf == uf).toList();
    }

    if (filteredList.isEmpty) {
      filtredListAddressIsEmpty = true;
      return;
    }

    filtredListAddressIsEmpty = false;

    myListAddress = filteredList;
  }

  @action
  Future<void> getAddress({
    required String uf,
    required String cidade,
    required String logradouro,
  }) async {
    loadingSearchAddress = true;

    listAddress = await apiViaCep.getListAddress(
        uf: uf, cidade: cidade, logradouro: logradouro);

    loadingSearchAddress = false;
  }
}
