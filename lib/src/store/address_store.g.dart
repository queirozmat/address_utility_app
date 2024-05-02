// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddressStore on AddressBase, Store {
  late final _$loadingSearchAddressAtom =
      Atom(name: 'AddressBase.loadingSearchAddress', context: context);

  @override
  bool get loadingSearchAddress {
    _$loadingSearchAddressAtom.reportRead();
    return super.loadingSearchAddress;
  }

  @override
  set loadingSearchAddress(bool value) {
    _$loadingSearchAddressAtom.reportWrite(value, super.loadingSearchAddress,
        () {
      super.loadingSearchAddress = value;
    });
  }

  late final _$filtredListAddressIsEmptyAtom =
      Atom(name: 'AddressBase.filtredListAddressIsEmpty', context: context);

  @override
  bool get filtredListAddressIsEmpty {
    _$filtredListAddressIsEmptyAtom.reportRead();
    return super.filtredListAddressIsEmpty;
  }

  @override
  set filtredListAddressIsEmpty(bool value) {
    _$filtredListAddressIsEmptyAtom
        .reportWrite(value, super.filtredListAddressIsEmpty, () {
      super.filtredListAddressIsEmpty = value;
    });
  }

  late final _$listAddressAtom =
      Atom(name: 'AddressBase.listAddress', context: context);

  @override
  List<AddressModel> get listAddress {
    _$listAddressAtom.reportRead();
    return super.listAddress;
  }

  @override
  set listAddress(List<AddressModel> value) {
    _$listAddressAtom.reportWrite(value, super.listAddress, () {
      super.listAddress = value;
    });
  }

  late final _$myListAddressAtom =
      Atom(name: 'AddressBase.myListAddress', context: context);

  @override
  List<AddressModel> get myListAddress {
    _$myListAddressAtom.reportRead();
    return super.myListAddress;
  }

  @override
  set myListAddress(List<AddressModel> value) {
    _$myListAddressAtom.reportWrite(value, super.myListAddress, () {
      super.myListAddress = value;
    });
  }

  late final _$getAddressAsyncAction =
      AsyncAction('AddressBase.getAddress', context: context);

  @override
  Future<void> getAddress(
      {required String uf,
      required String cidade,
      required String logradouro}) {
    return _$getAddressAsyncAction.run(
        () => super.getAddress(uf: uf, cidade: cidade, logradouro: logradouro));
  }

  late final _$AddressBaseActionController =
      ActionController(name: 'AddressBase', context: context);

  @override
  void addInMyList({required AddressModel address}) {
    final _$actionInfo = _$AddressBaseActionController.startAction(
        name: 'AddressBase.addInMyList');
    try {
      return super.addInMyList(address: address);
    } finally {
      _$AddressBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterListAddress({String? bairro, String? uf}) {
    final _$actionInfo = _$AddressBaseActionController.startAction(
        name: 'AddressBase.filterListAddress');
    try {
      return super.filterListAddress(bairro: bairro, uf: uf);
    } finally {
      _$AddressBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterMyListAddress({String? bairro, String? uf}) {
    final _$actionInfo = _$AddressBaseActionController.startAction(
        name: 'AddressBase.filterMyListAddress');
    try {
      return super.filterMyListAddress(bairro: bairro, uf: uf);
    } finally {
      _$AddressBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadingSearchAddress: ${loadingSearchAddress},
filtredListAddressIsEmpty: ${filtredListAddressIsEmpty},
listAddress: ${listAddress},
myListAddress: ${myListAddress}
    ''';
  }
}
