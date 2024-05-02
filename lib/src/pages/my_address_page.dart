import 'package:address_utility_app/src/components/card_my_address.dart';
import 'package:address_utility_app/src/store/address_store.dart';
import 'package:address_utility_app/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:address_utility_app/src/components/my_drawer.dart';
import 'package:address_utility_app/src/models/address_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MyAddressPage extends StatefulWidget {
  const MyAddressPage({super.key});

  @override
  State<MyAddressPage> createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  String _selectedUF = 'UF';
  TextEditingController bairroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AddressStore addressStore = Provider.of<AddressStore>(context);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Meus endereços',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 60,
                width: size.width,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 5),
                            child: TextFormField(
                              controller: bairroController,
                              decoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                hintText: 'Bairro',
                                hintStyle: TextStyle(color: Colors.black),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 8, bottom: 8, left: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              value: _selectedUF,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedUF = newValue!;
                                });
                              },
                              items: Const.ufs.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100),
                        onPressed: () {
                          if (bairroController.text == '' &&
                              _selectedUF == 'UF') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Campos obrigatórios'),
                                content: const Text(
                                    'Por favor, preencha pelo menos um campo.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            addressStore.filterMyListAddress(
                              bairro: bairroController.text,
                              uf: _selectedUF,
                            );

                            if (addressStore.filtredListAddressIsEmpty) {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                      'Não encontrado endereço com esse bairro ou UF.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Buscar',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 30, bottom: 15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: size.height * 0.70,
                width: size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Observer(builder: (context) {
                    if (addressStore.myListAddress.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Lista de endereços vazia',
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange.shade800),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, '/searchAddress');
                            },
                            child: const Text(
                              'Adicionar endereço',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      );
                    }

                    return ListView.builder(
                      itemCount: addressStore.myListAddress.length,
                      itemBuilder: (context, index) {
                        AddressModel address =
                            addressStore.myListAddress[index];
                        return CardMyAddress(
                          address: address,
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
