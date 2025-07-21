import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopapp/componant/shop_app_componat.dart';
import 'package:shopapp/log_addacount/login_screen.dart';
import 'package:shopapp/log_addacount/cubit/settings/settings_cubit.dart';
import 'package:shopapp/log_addacount/cubit/settings/settings_state.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/screen/switch_themes.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is UserDataUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Updated successfully')),
          );
        }
      },
      builder: (context, state) {
        final cubit = SettingsCubit.get(context);

        if (state is SettingsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }


        nameController.text = nameController.text.isEmpty ? cubit.name : nameController.text;
        emailController.text = emailController.text.isEmpty ? cubit.email : emailController.text;

        return Scaffold(
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCard(
                  context: context,
                  title: "Profile",
                  icon: Icons.person,
                  children: [
                    _buildLabeledInput("Name", nameController, Icons.person),
                    const SizedBox(height: 12),
                    _buildLabeledInput("Email", emailController, Icons.email),
                    const SizedBox(height: 20),
                    defaultButton(
                      label: "Save",
                      onPressed: () {
                        cubit.updateUserDataFromAPI(
                          newName: nameController.text,
                          newEmail: emailController.text,
                          userId: Cache.getData(key: 'userId'),
                          token: Cache.getData(key: 'token'),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCard(
                  context: context,
                  title: "App Settings",
                  icon: Icons.settings,
                  children: [
                    _buildTileWithTrailing(
                      icon: Icons.language,
                      title: "Language",
                      trailing: _buildLanguageDropdown(cubit),
                    ),
                    const Divider(),
                    _buildTileWithTrailing(
                      icon: Icons.brightness_6,
                      title: "Theme",
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        onPressed: () => navigateTo(context, const SwitchThemes()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildCard(
                  context: context,
                  title: "Security",
                  icon: Icons.lock,
                  children: [
                    defaultButton(
                      label: "Logout",
                      backgroundColor: Colors.red,
                      onPressed: () async {
                        await Cache.removeData(key: 'token');
                        await Cache.removeData(key: 'name');
                        await Cache.removeData(key: 'userId');
                        await Cache.removeData(key: 'email');

                        if (!context.mounted) return;
                        navigateAndFinsh(context, LoginScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withAlpha((0.85 * 255).round()),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Theme.of(context).iconTheme.color),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTileWithTrailing({
    required IconData icon,
     String? title,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title!,
            style: GoogleFonts.roboto(fontSize: 16),
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _buildLabeledInput(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        defaultFormField(
          controler: controller,
          type: TextInputType.text,
          prefix: icon,
          lable: label,
        ),
      ],
    );
  }

  Widget _buildLanguageDropdown(SettingsCubit cubit) {
    return DropdownButton<String>(
      value: cubit.language,
      underline: const SizedBox(),
      onChanged: (value) {
        if (value != null) cubit.changeLanguage(value);
      },
      items: const [
        DropdownMenuItem(value: 'en', child: Text("English")),
        DropdownMenuItem(value: 'ar', child: Text("العربية")),
      ],
    );
  }
}