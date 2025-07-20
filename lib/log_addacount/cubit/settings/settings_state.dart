abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class ThemeChangedState extends SettingsState {}

class LanguageChangedState extends SettingsState {}

class UserDataUpdatedState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsErrorState extends SettingsState {
  final String error;
  SettingsErrorState(this.error);
}
class SettingsLoadedFromCacheState extends SettingsState {}