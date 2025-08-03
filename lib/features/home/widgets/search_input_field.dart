import 'package:eventify_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme.dart';
import '../../profile/cubit/theme_cubit.dart';

typedef Change = void Function(String)?;

class SearchInputField extends StatelessWidget {
  final Change onChange;

  const SearchInputField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final themeMode = context
        .watch<ThemeCubit>()
        .state;
    final isDark = themeMode == ThemeMode.dark;
    return TextField(
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: S
            .of(context)
            .search,
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        enabled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: ThemeManager.darkPinkColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: isDark ? ThemeManager.secondaryColor : ThemeManager
                  .primaryColor, width: 2),
        ),
      ),
    );
  }
}
