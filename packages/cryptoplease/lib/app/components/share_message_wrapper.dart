import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/cupertino.dart';

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
              padding: const EdgeInsets.fromLTRB(48, 56, 24, 56),
              child: Text.rich(widget.textSpan),
            ),
          ),
        ),
      );
}
