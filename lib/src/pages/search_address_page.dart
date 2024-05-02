import 'package:address_utility_app/src/components/card_my_address.dart';
import 'package:address_utility_app/src/components/my_drawer.dart';
import 'package:address_utility_app/src/models/address_model.dart';
import 'package:address_utility_app/src/store/address_store.dart';
import 'package:address_utility_app/src/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SearchAddressPage extends StatefulWidget {
  const SearchAddressPage({super.key});

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  @override
  void initState() {
    super.initState();
  }

  String _selectedUF = 'UF';

  TextEditingController logradouroController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();

  String? selectedUF;

  @override
  Widget build(BuildContext context) {
    AddressStore addressStore = Provider.of<AddressStore>(context);

    addressStore.listAddress = [];

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Procurar endereços',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.orange.shade800,
      ),
      body: SingleChildScrollView(
        child: Observer(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: addressStore.listAddress.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, right: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                    ),
                    onPressed: () {
                      _selectedUF = 'UF';
                      cidadeController.text = '';
                      logradouroController.text = '';

                      addressStore.listAddress = [];
                    },
                    child: const Text(
                      'Nova pesquisa',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: addressStore.listAddress.isNotEmpty,
                child: Padding(
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
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 8),
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
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                  items: Const.ufs
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                            color: Colors.black),
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
                                addressStore.filterListAddress(
                                    bairro: bairroController.text,
                                    uf: _selectedUF);

                                if (addressStore.filtredListAddressIsEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Não encontrado endereço com esse bairro.'),
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
              ),
              Visibility(
                visible: addressStore.listAddress.isEmpty,
                child: LayoutBuilder(builder: (context, constraints) {
                  if (constraints.maxWidth <= 500) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15),
                              ),
                            ),
                            height: 60,
                            width: size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
                                        child: TextFormField(
                                          controller: cidadeController,
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            hintText: 'Cidade',
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 5, right: 5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
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
                                          items: Const.ufs
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                            height: 60,
                            width: size.width,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8, left: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        border: Border.all(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5, bottom: 5),
                                        child: TextFormField(
                                          controller: logradouroController,
                                          decoration: const InputDecoration(
                                            enabledBorder: InputBorder.none,
                                            hintText: 'Logradouro',
                                            hintStyle:
                                                TextStyle(color: Colors.black),
                                            border: InputBorder.none,
                                          ),
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
                                    onPressed: () async {
                                      if (_selectedUF == 'UF' ||
                                          cidadeController.text == '' ||
                                          logradouroController.text == '') {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text(
                                                'Campos obrigatórios'),
                                            content: const Text(
                                                'Por favor, preencha todos os campos.'),
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
                                        await addressStore.getAddress(
                                            uf: _selectedUF,
                                            cidade: cidadeController.text,
                                            logradouro:
                                                logradouroController.text);
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
                      ],
                    );
                  }

                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
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
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 8),
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
                                    controller: logradouroController,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Logradouro',
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 8),
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
                                    controller: cidadeController,
                                    decoration: const InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Cidade',
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
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                    items: Const.ufs
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.black),
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
                              onPressed: () async {
                                if (_selectedUF == 'UF' ||
                                    cidadeController.text == '' ||
                                    logradouroController.text == '') {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Campos obrigatórios'),
                                      content: const Text(
                                          'Por favor, preencha todos os campos.'),
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
                                  await addressStore.getAddress(
                                      uf: _selectedUF,
                                      cidade: cidadeController.text,
                                      logradouro: logradouroController.text);
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
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 30, bottom: 15),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: size.height * 0.75,
                  width: size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Observer(
                      builder: (context) {
                        if (addressStore.loadingSearchAddress) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (addressStore.listAddress.isEmpty) {
                          return const Center(
                            child: Text('Lista de endereços vazia'),
                          );
                        }

                        return ListView.builder(
                          itemCount: addressStore.listAddress.length,
                          itemBuilder: (context, index) {
                            AddressModel address =
                                addressStore.listAddress[index];
                            return CardMyAddress(
                              address: address,
                              addButton: true,
                              onPressed: () {
                                addressStore.addInMyList(address: address);

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Endereço adicionado.'),
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
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
