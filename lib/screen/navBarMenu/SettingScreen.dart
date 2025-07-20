import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/settings/SettingsCubit.dart';
import 'package:shopapp/log_addacount/cubit/settings/settings_state.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/network/local/Cache.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {



    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
      if (state is UserDataUpdatedState) {
        var cubit = SettingsCubit.get(context);
        nameController.text = cubit.name;
        emailController.text = cubit.email;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Updated successfully')),
        );
      }
      },
      builder: (context, state) {
        final cubit = SettingsCubit.get(context);

        nameController.text = cubit.name;
        emailController.text = cubit.email;
        if (state is SettingsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                /// 🌙 الوضع الليلي
                SwitchListTile(
                  title: const Text("Dark Mode"),
                  value: cubit.isDark,
                  onChanged: (value) => cubit.toggleTheme(),
                ),

                const Divider(),

                /// 🌐 تغيير اللغة
                ListTile(
                  title: const Text("Language"),
                  trailing: DropdownButton<String>(
                    value: cubit.language,
                    items: const [
                      DropdownMenuItem(value: 'en', child: Text("English")),
                      DropdownMenuItem(value: 'ar', child: Text("العربية")),
                    ],
                    onChanged: (value) {
                      if (value != null) cubit.changeLanguage(value);
                    },
                  ),
                ),

                const Divider(),

                /// 👤 تعديل بيانات المستخدم
                defaultFormField(
                  controler: nameController,
                  type: TextInputType.name,
                  prefix: Icons.person,
                  lable: "Name",
                ),
                const SizedBox(height: 10),
                defaultFormField(
                  controler: emailController,
                  type: TextInputType.emailAddress,
                  prefix: Icons.email,
                  lable: "Email",
                ),
                const SizedBox(height: 16),

                defaultButton(
                  label: "Save",
                  onPressed: () {
                    cubit.updateUserDataFromAPI(
                      newName: nameController.text,
                      newEmail: emailController.text,
                      userId: Cache.getData(key: 'userId'),
                      token: Cache.getData(key: 'token'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Profile updated")),
                    );
                  },
                ),

                const Divider(),

                defaultButton(
                  label: "Logout",
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Cache.removeData(key: 'token');
                    Cache.removeData(key: 'name');
                    Cache.removeData(key: 'userId');
                    Cache.removeData(key: 'email').then((value) {
                      navigateAndFinsh(context, LoginScreen());
                    });
                  },
                ),
              ],
            ),
          ),
        );

      },
    );
  }
}
