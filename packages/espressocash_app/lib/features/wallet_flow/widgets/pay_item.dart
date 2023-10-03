import 'package:flutter/material.dart';

class PayMethodItem extends StatelessWidget {
  const PayMethodItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.buttonText,
    this.onPressed,
    this.buttonTrailing,
  });

  final String title;
  final String? subtitle;

  final String buttonText;
  final Widget? buttonTrailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: StadiumBorder(),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                onTap: onPressed,
                title: Text(
                  buttonText,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: buttonTrailing,
              ),
            ),
            const SizedBox(height: 12),
            if (subtitle case final subtitle?)
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8F8F8F),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      );
}
