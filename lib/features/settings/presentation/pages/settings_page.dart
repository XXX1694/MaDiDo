import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_event.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_state.dart';
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
            padding: const EdgeInsets.all(16),
            children: [
              _SectionHeader(title: l10n.general),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: Text(l10n.language, style: GoogleFonts.inter()),
                      trailing: DropdownButton<Locale>(
                        value: state.locale,
                        underline: const SizedBox(),
                        onChanged: (Locale? newLocale) {
                          if (newLocale != null) {
                            context.read<SettingsBloc>().add(
                              ChangeLocale(newLocale),
                            );
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            value: const Locale('en'),
                            child: Text(
                              l10n.english,
                              style: GoogleFonts.inter(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: const Locale('ru'),
                            child: Text(
                              l10n.russian,
                              style: GoogleFonts.inter(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: const Locale('kk'),
                            child: Text(
                              l10n.kazakh,
                              style: GoogleFonts.inter(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _SectionHeader(title: l10n.appearance),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.brightness_6),
                      title: Text(l10n.theme, style: GoogleFonts.inter()),
                      trailing: DropdownButton<ThemeMode>(
                        value: state.themeMode,
                        underline: const SizedBox(),
                        onChanged: (ThemeMode? newMode) {
                          if (newMode != null) {
                            context.read<SettingsBloc>().add(
                              ChangeTheme(newMode),
                            );
                          }
                        },
                        items: [
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text(
                              l10n.system,
                              style: GoogleFonts.inter(),
                            ),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text(l10n.light, style: GoogleFonts.inter()),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text(l10n.dark, style: GoogleFonts.inter()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
