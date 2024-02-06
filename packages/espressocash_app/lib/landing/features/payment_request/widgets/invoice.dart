import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/presentation/utils.dart';
import '../../../../gen/assets.gen.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key, required this.address});

  final String address;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () {
          final url = _createAddressLink(address);
          launchUrl(Uri.parse(url));
        },
        child: Container(
          height: 37,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Color(0xFFDFDFDF)),
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.icons.txIcon.svg(
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Invoice ${address.toShortAddress()}',
                style: const TextStyle(
                  color: Color(0xFF34393C),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.23,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      );
}

String _createAddressLink(String address) {
  final sb = StringBuffer()
    ..write('https://explorer.solana.com/address/')
    ..write(address);

  return sb.toString();
}
