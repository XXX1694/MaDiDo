import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_event.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_state.dart';
import 'package:to_do/features/settings/presentation/widgets/settings_chip_selector.dart';
import 'package:to_do/features/settings/presentation/widgets/settings_section_header.dart';
import 'package:to_do/l10n/generated/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return ListView(
            key: const ValueKey('settings_list_view'),
            padding: const EdgeInsets.all(20),
            children: [
              SettingsSectionHeader(title: l10n.general),
              const Gap(8),
              SettingsChipSelector<Locale>(
                selectedValue: state.locale,
                onSelected: (newLocale) {
                  context.read<SettingsBloc>().add(ChangeLocale(newLocale));
                },
                items: [
                  SettingsChipItem(
                    value: const Locale('en'),
                    label: l10n.english,
                    icon: Icons.language_rounded,
                  ),
                  SettingsChipItem(
                    value: const Locale('ru'),
                    label: l10n.russian,
                    icon: Icons.language_rounded,
                  ),
                  SettingsChipItem(
                    value: const Locale('kk'),
                    label: l10n.kazakh,
                    icon: Icons.language_rounded,
                  ),
                ],
              ),
              const Gap(32),
              SettingsSectionHeader(title: l10n.appearance),
              const Gap(8),
              SettingsChipSelector<ThemeMode>(
                selectedValue: state.themeMode,
                onSelected: (newMode) {
                  context.read<SettingsBloc>().add(ChangeTheme(newMode));
                },
                items: [
                  SettingsChipItem(
                    value: ThemeMode.system,
                    label: l10n.system,
                    icon: Icons.settings_suggest_rounded,
                  ),
                  SettingsChipItem(
                    value: ThemeMode.light,
                    label: l10n.light,
                    icon: Icons.light_mode_rounded,
                  ),
                  SettingsChipItem(
                    value: ThemeMode.dark,
                    label: l10n.dark,
                    icon: Icons.dark_mode_rounded,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
