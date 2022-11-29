import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/tokens/token.dart';
import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/text_field.dart';
import '../bl/bloc.dart';
import 'discover_header.dart';

class TokenSearchScreen extends StatelessWidget {
  const TokenSearchScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<TokenSearchBloc>(
            create: (context) => sl<TokenSearchBloc>(),
          ),
        ],
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CpAppBar(
            title: Text(context.l10n.search.toUpperCase()),
          ),
          body: const _Content(),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController _controller = TextEditingController();
  CryptoCategories? _selected;

  void onCategoryTap(CryptoCategories category) {
    setState(() {
      _selected = _selected != category ? category : null;
    });

    context.read<TokenSearchBloc>().add(SearchCategoryRequest(category));
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      context.read<TokenSearchBloc>().add(SearchTextRequest(_controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          children: [
            CpTextField(
              controller: _controller,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              fontSize: 14,
              border: CpTextFieldBorder.stadium,
              placeholder: context.l10n.searchPlaceholder,
              backgroundColor: const Color(0xffEFEFEF),
              inputType: TextInputType.text,
              prefixWidget: Assets.icons.searchButtonIcon.svg(),
            ),
            const SizedBox(height: 16),
            // DiscoverHeader(
            //   selected: _selected,
            //   onTap: onCategoryTap,
            // ),
            Expanded(
              child: BlocBuilder<TokenSearchBloc, TokenSearchState>(
                builder: (context, state) => Center(
                  child: state.when(
                    failure: (_) => Text(context.l10n.failedToSearch),
                    initial: () => DiscoverHeader(
                      selected: _selected,
                      onTap: onCategoryTap,
                    ),
                    processing: LoadingIndicator.new,
                    success: (result) {
                      if (result.isEmpty) {
                        return Text(context.l10n.emptySearch);
                      }

                      return ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (context, index) =>
                            _TokenItem(result[index]),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token);
  final Token token;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: ListTile(
          onTap: () => context.router.push(
            HomeRoute(
              children: [
                InvestmentsRouter(
                  children: [TokenDetailsRoute(token: token)],
                ),
              ],
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  token.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _TokenSymbolWidget(token.symbol),
            ],
          ),
          trailing: const Icon(Icons.favorite), //TODO update to favorite button
        ),
      );
}

class _TokenSymbolWidget extends StatelessWidget {
  const _TokenSymbolWidget(
    this.symbol, {
    Key? key,
  }) : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 57,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: CpColors.lightPillBackgroundColor,
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              symbol.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
            ),
          ),
        ),
      );
}
