import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/cubitLogin.dart';
import 'package:shopapp/log_addacount/cubit/statusLogin.dart';
import 'package:shopapp/log_addacount/loginScreen.dart';
import 'package:shopapp/model/RegisterModel.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/screen/ShopMainScreen.dart';

class Registerscreen extends StatelessWidget {
  Registerscreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      builder: (BuildContext context, ShopLoginStates state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          defaultFormField(
                            controler: nameController,
                            type: TextInputType.name,
                            lable: 'Name',
                            prefix: Icons.person_outline,
                            validator: (value) =>
                                validateRequiredField(value, 'name'),
                          ),
                          SizedBox(height: 20),
                          defaultFormField(
                            controler: emailController,
                            type: TextInputType.emailAddress,
                            lable: 'Email',
                            prefix: Icons.email_outlined,
                            validator: (value) =>
                                validateRequiredField(value, 'email'),
                          ),
                          SizedBox(height: 20),
                          ValueListenableBuilder<bool>(
                            valueListenable: obscurePassword,
                            builder: (context, obscure, _) {
                              return defaultFormField(
                                controler: passwordController,
                                type: TextInputType.visiblePassword,
                                prefix: Icons.lock_outline,
                                lable: 'Password',
                                obscuretext: obscure,
                                suffixIcon: obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                onSuffixTap: () {
                                  obscurePassword.value =
                                      !obscurePassword.value;
                                },
                                validator: (value) =>
                                    validateRequiredField(value, 'password'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    ConditionalBuilder(
                      condition: state is! ShopRegisterLoadingState,
                      builder: (BuildContext context) => defaultButton(
                        label: 'Register',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // استدعاء دالة التسجيل
                            ShopLoginCubit.get(context).userRegister(
                              avatar:
                                  'https://api.lorem.space/image/face?w=640&h=480',
                              name: nameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          }
                        },
                      ),

                      fallback: (BuildContext context) =>
                          Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account? "),
                        GestureDetector(
                          onTap: () {
                            navigateTo(context, LoginScreen());
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, ShopLoginStates state) {
        if (state is ShopRegisterSuccessState) {
          showToast(
            text: 'Account created successfully! Please login.',
            state: ToastStates.Success,
          );
          navigateAndFinsh(context, LoginScreen());
        }

        if (state is ShopRegisterErrorState) {
          showToast(
            text: 'Registration failed. Please try again.',
            state: ToastStates.Error,
          );
        }
      },
    );
  }
}
