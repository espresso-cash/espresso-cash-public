import 'package:flutter/material.dart';
import '../../../core/blockchain.dart';

class PaymentMethodDropdown extends StatelessWidget {
  const PaymentMethodDropdown({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final Blockchain current;
  final ValueSetter<Blockchain> onChanged;

  @override
  Widget build(BuildContext context) {
    final blockchains = Blockchain.values.where((e) => e != Blockchain.solana);

    return SizedBox(
      width: 325,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(63),
            ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Blockchain>(
            isExpanded: true,
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
            value: current,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            selectedItemBuilder: (context) => blockchains
                .map<Widget>(
                  (value) => Center(
                    child: Text(
                      'With USDC on ${value.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
            items: blockchains
                .map<DropdownMenuItem<Blockchain>>(
                  (value) => DropdownMenuItem<Blockchain>(
                    value: value,
                    child: Text(value.name),
                  ),
                )
                .toList(),
            dropdownColor: Colors.black,
            icon: const Icon(
              Icons.expand_more,
              color: Colors.white,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}
