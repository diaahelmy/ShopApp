import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/componant/shopappcomponat.dart';
import 'package:shopapp/log_addacount/cubit/cubit.dart';
import 'package:shopapp/log_addacount/cubit/status.dart';
import 'package:shopapp/log_addacount/registerScreen.dart';
import 'package:shopapp/network/local/Cache.dart';
import 'package:shopapp/screen/ShopHomeScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});



  var formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> obscurePassword = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              defaultFormField(
                                controler: emailController,
                                type: TextInputType.emailAddress,
                                validator: (value) =>
                                    validateRequiredField(value, 'email'),
                                prefix: Icons.email_outlined,
                                lable: 'Email',
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
                                    onSubmit: (value) {
                                      if (formKey.currentState!.validate()) {
                                        ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    suffixIcon: obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    onSuffixTap: () {
                                      obscurePassword.value =
                                          !obscurePassword.value;
                                    },
                                    validator: (value) => validateRequiredField(
                                      value,
                                      'password',
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text('Forgot Password?'),
                                ),
                              ),
                              SizedBox(height: 20),
                              ConditionalBuilder(
                                condition: state is! ShopLoginLoadingState,
                                builder: (BuildContext context) =>
                                    defaultButton(
                                      label: 'Login',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          ShopLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        }


                                      },
                                    ),
                                fallback: (BuildContext context) =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don’t have an account? "),
                            GestureDetector(
                              onTap: () {
                                // Navigate to Register
                                navigateTo(context, Registerscreen());
                              },
                              child: Text(
                                'Register',
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
            ),
          );
        },
        listener: (BuildContext context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status!){
              Cache.saveData(key: 'token', value: state.loginModel.data!.token!).then((onValue){
                navigateAndFinsh(context, ShopHomescreen());
              });

            }else{

             showToast(text: state.loginModel.message!, state: ToastStates.Error);
            }

          }

        },
      ),
    );
  }
}
