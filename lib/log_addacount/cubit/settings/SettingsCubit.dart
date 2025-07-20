

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/settings/settings_state.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/network/remote/dioHelper.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(context) => BlocProvider.of(context);

  bool isDark = false;
  String language = 'en';
  String name = 'Diaa Helmy';
  String email = 'diaa@example.com';

  void toggleTheme() {
    isDark = !isDark;
    emit(ThemeChangedState());
  }

  void changeLanguage(String langCode) {
    language = langCode;
    emit(LanguageChangedState());
  }

  void updateUserData({required String newName, required String newEmail}) {
    name = newName;
    email = newEmail;
    emit(UserDataUpdatedState());
  }
  void loadUserFromCache() {
    name = Cache.getData(key: 'name') ?? '';
    email = Cache.getData(key: 'email') ?? '';
    emit(SettingsLoadedFromCacheState());
  }
  void updateUserDataFromAPI({
    required String newName,
    required String newEmail,
    required int userId,
    required String token,
  }) {
    emit(SettingsLoadingState());

    DioHelper.putData(
      url: 'v1/users/$userId',
      token: token,
      data: {
        "name": newName,
        "email": newEmail,
      },
    ).then((value) {
      // ⬅ هنا بنخزنهم في المتغيرات الموجودة في الكلاس
      name = value.data['name'];
      email = value.data['email'];
      // ✅ خزّنهم في الكاش
      Cache.saveData(key: 'name', value: name);
      Cache.saveData(key: 'email', value: email);

      Cache.saveData(key: 'name', value: newName);
      Cache.saveData(key: 'email', value: newEmail);
      emit(UserDataUpdatedState());
    }).catchError((error) {
      print("Update Error: $error");
      emit(SettingsErrorState(error.toString()));
    });
  }
}
