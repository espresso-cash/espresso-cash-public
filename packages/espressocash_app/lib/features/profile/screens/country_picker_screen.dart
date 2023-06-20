import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/page_fade_wrapper.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/text_field.dart';
import '../../../ui/theme.dart';
import 'countries.dart';

@RoutePage<String?>()
class CountryPickerScreen extends StatelessWidget {
  const CountryPickerScreen({
    super.key,
    this.initialCountryCode,
  });

  final String? initialCountryCode;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          appBar: CpAppBar(
            title: Text(context.l10n.selectCountryTitle.toUpperCase()),
          ),
          body:
              _Wrapper(child: _Content(initialCountryCode: initialCountryCode)),
        ),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.initialCountryCode});

  final String? initialCountryCode;

  @override
  State<_Content> createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Map<String, String>? _selectedCountry;
  String get _searchText => _searchController.text;

  @override
  void initState() {
    super.initState();

    _selectedCountry = widget.initialCountryCode != null
        ? countryCodes.firstWhereOrNull(
            (country) => country['code'] == widget.initialCountryCode,
          )
        : null;

    _searchController.addListener(() {
      setState(() {});
    });

    if (_selectedCountry != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final index = countryCodes.indexOf(_selectedCountry!);
        final centerOffset = (context.size!.height - _tileHeight) / 2.5;
        final offset = index * _tileHeight - centerOffset;
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
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
    final filteredCountries = countryCodes.where((country) {
      final nameMatches =
          country['name']?.toLowerCase().contains(_searchText.toLowerCase()) ??
              false;
      final codeMatches =
          country['code']?.toLowerCase().contains(_searchText.toLowerCase()) ??
              false;

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
            backgroundColor: const Color(0xff404040),
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredCountries.length,
              itemBuilder: (BuildContext context, int index) {
                final country = filteredCountries[index];
                final selected = country == _selectedCountry;

                return Container(
                  height: _tileHeight,
                  decoration: selected
                      ? const ShapeDecoration(
                          color: Color(0xff404040),
                          shape: StadiumBorder(),
                        )
                      : null,
                  child: ListTile(
                    dense: true,
                    title: Text(
                      country['name'] ?? '',
                      style: TextStyle(
                        fontSize: selected ? 19 : 17,
                      ),
                    ),
                    selectedColor: Colors.white,
                    shape: selected ? const StadiumBorder() : null,
                    onTap: () {
                      context.router.pop(country['code']);
                    },
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
              color: FadeGradientColor.dark,
            ),
          )
        ],
      );
}

const _tileHeight = 46.0;
