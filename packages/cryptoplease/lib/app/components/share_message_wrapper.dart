import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareMessageWrapper extends StatefulWidget {
  const ShareMessageWrapper({
    Key? key,
    required this.textSpan,
  }) : super(key: key);

  final TextSpan textSpan;

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
  Widget build(BuildContext context) => CpRoundedRectangle(
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
        child: CupertinoScrollbar(
          radius: const Radius.circular(10),
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text.rich(
                widget.textSpan,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      );
}
