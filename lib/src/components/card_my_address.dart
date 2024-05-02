import 'package:flutter/material.dart';
import 'package:address_utility_app/src/models/address_model.dart';

class CardMyAddress extends StatelessWidget {
  final AddressModel address;
  final bool addButton;
  final VoidCallback? onPressed;

  const CardMyAddress({
    super.key,
    required this.address,
    this.addButton = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddressInfoRow(
                  title: "CEP",
                  value: address.cep ?? '',
                ),
                const SizedBox(height: 8),
                AddressInfoRow(
                  title: "Logradouro",
                  value: address.logradouro ?? '',
                ),
                const SizedBox(height: 8),
                AddressInfoRow(
                  title: "Complemento",
                  value: address.complemento ?? '',
                ),
                const SizedBox(height: 8),
                AddressInfoRow(
                  title: "Bairro",
                  value: address.bairro ?? '',
                ),
                const SizedBox(height: 8),
                AddressInfoRow(
                  title: "Localidade",
                  value: address.localidade ?? '',
                ),
                const SizedBox(height: 8),
                AddressInfoRow(
                  title: "UF",
                  value: address.uf ?? '',
                ),
              ],
            ),
          ),
          if (addButton)
            Positioned(
              bottom: 12.0,
              right: 12.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade100),
                onPressed: onPressed,
                child: const Text(
                  'Adicionar',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class AddressInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const AddressInfoRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title:",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }
}
