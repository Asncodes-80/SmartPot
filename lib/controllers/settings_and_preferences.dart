/*
  Settings and preferences like a init config file.
  Like DarkTheme, Language and locale, app status, and etc...
*/
import 'package:shahjump/provider/preferences_provider.dart';

class SetupPreferences {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  currentAppTheme() async {
    darkThemeProvider.darkTheme =
        await darkThemeProvider.preferencesProvider.getPreferences(
      "bool",
      "darkTheme",
    );
  }
}
