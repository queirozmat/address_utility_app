import 'package:address_utility_app/src/pages/my_address_page.dart';
import 'package:address_utility_app/src/pages/search_address_page.dart';
import 'package:flutter/material.dart';

class Const {
  static String baseUrl = 'https://viacep.com.br/ws/';

  static var routes = <String, WidgetBuilder>{
    '/': (context) => const MyAddressPage(),
    '/searchAddress': (context) => const SearchAddressPage(),
  };

  static final List<String> ufs = [
    'UF',
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];
}
