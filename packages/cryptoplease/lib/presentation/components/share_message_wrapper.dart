import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareMessageWrapper extends StatefulWidget {
  const ShareMessageWrapper({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  State<ShareMessageWrapper> createState() => _ShareMessageWrapperState();
}

class _ShareMessageWrapperState extends State<ShareMessageWrapper> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 4,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: CupertinoScrollbar(
          isAlwaysShown: true,
          radius: const Radius.circular(10),
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.message,
                style: const TextStyle(
                  fontSize: 18,
                  color: CpColors.primaryTextColor,
                ),
              ),
            ),
          ),
        ),
      );
}
