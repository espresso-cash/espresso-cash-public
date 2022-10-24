import 'package:cryptoplease/ui/rounded_rectangle.dart';
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
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: CpRoundedRectangle(
          scrollable: true,
          margin: const EdgeInsets.symmetric(vertical: 24),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 48,
          ),
          child: Text.rich(widget.textSpan),
        ),
      );
}
