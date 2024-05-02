import 'package:address_utility_app/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/store/address_store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AddressStore(),
      child: MaterialApp(
        title: 'Meus Endereços',
        initialRoute: '/',
        routes: Const.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
