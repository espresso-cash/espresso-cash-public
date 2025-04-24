import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/picker_screen.dart';
import '../models/bank.dart';

class BankTextField extends StatelessWidget {
  const BankTextField({super.key, required this.placeholder, this.initialBank, this.onBankChanged});

  final String placeholder;
  final Bank? initialBank;
  final ValueSetter<Bank>? onBankChanged;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: const ShapeDecoration(color: CpColors.blackGreyColor, shape: StadiumBorder()),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () async {
        await CustomPickerScreen.push<Bank>(
          context: context,
          title: context.l10n.selectBank,
          items: ngBanks,
          initial: initialBank,
          itemBuilder:
              (context, bank, {required bool selected}) => Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      bank.code,
                      style: TextStyle(fontSize: selected ? 19 : 17, color: CpColors.yellowColor),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      bank.name,
                      style: TextStyle(fontSize: selected ? 19 : 17, color: Colors.white),
                    ),
                  ),
                ],
              ),
          onTap: (bank, _) async {
            onBankChanged?.call(bank);
          },
        );
      },
      title: Text(
        initialBank?.name ?? placeholder,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: initialBank != null ? Colors.white : CpColors.greyColor,
          height: 1.2,
        ),
      ),
      trailing: const Icon(Icons.keyboard_arrow_down_outlined, color: Colors.white, size: 28),
    ),
  );
}
