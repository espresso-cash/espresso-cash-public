import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/page_spacer_wrapper.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import '../models/country.dart';

class CountryPickerScreen extends StatelessWidget {
  const CountryPickerScreen({
    super.key,
    this.initial,
  });

  final Country? initial;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text(context.l10n.selectCountryTitle.toUpperCase()),
          ),
          body: _Wrapper(child: _Content(initial: initial)),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.initial});

  final Country? initial;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Country? _selectedCountry;
  String _searchText = '';

  final _countries = Country.all;

  @override
  void initState() {
    super.initState();

    _selectedCountry = widget.initial;

    _searchController.addListener(() {
      setState(() => _searchText = _searchController.text);
    });

    final country = _selectedCountry;
    if (country != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index = _countries.indexOf(country);
        final centerOffset = ((context.size?.height ?? 0) - _tileHeight) / 2.5;
        final offset = index * _tileHeight - centerOffset;
        _scrollController.jumpTo(offset);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredCountries = _countries.where((country) {
      final nameMatches =
          country.name.toLowerCase().contains(_searchText.toLowerCase());

      final codeMatches =
          country.code.toLowerCase().contains(_searchText.toLowerCase());

      return nameMatches || codeMatches;
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: CpTextField(
            controller: _searchController,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            fontSize: 16,
            border: CpTextFieldBorder.stadium,
            placeholder: context.l10n.searchPlaceholder,
            backgroundColor: CpColors.blackTextFieldBackgroundColor,
            textColor: Colors.white,
            inputType: TextInputType.text,
          ),
        ),
        if (filteredCountries.isEmpty)
          Expanded(
            child: Center(
              child: Text(
                context.l10n.noResultsFound,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        else
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: filteredCountries.length,
              itemExtent: _tileHeight,
              itemBuilder: (BuildContext context, int index) {
                final country = filteredCountries[index];
                final selected = country == _selectedCountry;

                return DecoratedBox(
                  decoration: selected
                      ? const ShapeDecoration(
                          color: CpColors.blackTextFieldBackgroundColor,
                          shape: StadiumBorder(),
                        )
                      : const BoxDecoration(),
                  child: ListTile(
                    dense: true,
                    title: Text(
                      country.name,
                      style: TextStyle(fontSize: selected ? 19 : 17),
                    ),
                    selectedColor: Colors.white,
                    shape: selected ? const StadiumBorder() : null,
                    onTap: () => Navigator.pop(context, country),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: FadeGradient(
              height: 100,
              direction: FadeGradientDirection.bottomUp,
            ),
          ),
        ],
      );
}

const _tileHeight = 46.0;
