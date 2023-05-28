import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/tokens/token.dart';
import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/icon_button.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/text_field.dart';
import '../../../favorite_tokens/widgets/favorite_button.dart';
import '../../models/crypto_categories.dart';
import '../../widgets/discover_header.dart';
import '../bl/bloc.dart';

class TokenSearchScreen extends StatelessWidget {
  const TokenSearchScreen({
    super.key,
    this.category,
  });

  final CryptoCategories? category;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider<TokenSearchBloc>(
            create: (context) => sl<TokenSearchBloc>(),
          ),
          Provider<CryptoCategories?>.value(value: category),
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

  void _onCategoryTap(CryptoCategories val) {
    _selected = _selected != val ? val : null;
    context.read<TokenSearchBloc>().add(SearchCategoryRequest(_selected));
  }

  @override
  void initState() {
    super.initState();
    context.read<CryptoCategories?>().maybeFlatMap(_onCategoryTap);
    _controller.addListener(() {
      _selected = null;
      context.read<TokenSearchBloc>().add(SearchTextRequest(_controller.text));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CpTextField(
              controller: _controller,
              padding: const EdgeInsets.all(12),
              fontSize: 14,
              border: CpTextFieldBorder.stadium,
              placeholder: context.l10n.searchPlaceholder,
              backgroundColor: const Color(0xffEFEFEF),
              inputType: TextInputType.text,
              prefix: Assets.icons.searchButtonIcon.svg(),
              suffix: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CpIconButton(
                  icon: Assets.icons.closeButtonIconLight.svg(),
                  onPressed: _controller.clear,
                  variant: CpIconButtonVariant.light,
                  size: CpIconButtonSize.micro,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<TokenSearchBloc, TokenSearchState>(
              builder: (context, state) => Column(
                children: [
                  if (_selected != null || state.isInitial())
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: DiscoverHeader(
                        selected: _selected,
                        onTap: _onCategoryTap,
                      ),
                    ),
                  Expanded(
                    child: Center(
                      child: state.when(
                        failure: (_) => Text(context.l10n.failedToSearch),
                        initial: Container.new,
                        processing: LoadingIndicator.new,
                        success: (result) => result.isEmpty
                            ? Text(context.l10n.emptySearch)
                            : ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                itemCount: result.length,
                                itemBuilder: (context, index) =>
                                    _TokenItem(result[index]),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
          trailing: FavoriteButton(
            token: token,
            variant: FavoriteButtonVariant.light,
          ),
        ),
      );
}

class _TokenSymbolWidget extends StatelessWidget {
  const _TokenSymbolWidget(this.symbol);

  final String symbol;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 57,
        child: Container(
          padding: const EdgeInsets.all(6),
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
