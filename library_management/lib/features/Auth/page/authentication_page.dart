import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/features/Auth/bloc/auth/auth_bloc.dart';
import 'package:library_management/features/Auth/model/request/login_request.dart';
import 'package:library_management/features/Auth/widget/auth_snackbar.dart';
import 'package:library_management/router/router_type.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obsecureText = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget loginButton() {
    final isEmailValid = RegExp(
      r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$",
    ).hasMatch(emailController.text.trim());

    final isDisabled =
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        !isEmailValid;

    return Material(
      borderRadius: BorderRadius.circular(8),
      color: isDisabled ? navBarIconColor : primaryColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: isDisabled
            ? null
            : () {
                context.read<AuthBloc>().add(
                  LoginAccount(
                    loginRequest: LoginRequest(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  ),
                );
              },
        child: SizedBox(
          height: 45,
          child: Center(child: Text("Login", style: bodyMediumDark)),
        ),
      ),
    );
  }

  Widget emailTextBox() => Container(
    alignment: Alignment.center,
    height: 40,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 1.5, color: navBarIconColor),
    ),
    child: TextField(
      controller: emailController,
      onChanged: (_) => setState(() {}),
      textAlignVertical: TextAlignVertical.top,
      style: Theme.of(context).textTheme.bodyMedium,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'name@example.com',
        hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
          height: 2,
          decoration: TextDecoration.none,
          color: navBarIconColor,
        ),
        border: InputBorder.none,
        suffixIcon: emailController.text.isEmpty
            ? null
            : ExcludeFocus(
                child: IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => setState(() => emailController.clear()),
                ),
              ),
      ),
    ),
  );

  Widget passwordTextBox() => Container(
    alignment: Alignment.center,
    height: 40,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 1.5, color: navBarIconColor),
    ),
    child: TextField(
      controller: passwordController,
      obscureText: obsecureText,
      onChanged: (_) => setState(() {}),
      style: Theme.of(context).textTheme.bodyMedium,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(color: navBarIconColor, height: 2),
        border: InputBorder.none,
        suffixIcon: passwordController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(
                  obsecureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () => setState(() => obsecureText = !obsecureText),
              ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuth) {
          showLoggingInSnackbar(context, false);
        } else if (state is FailedAuth) {
          showLoginFailedSnackbar(context, state.message);
        } else if (state is SuccessAuth) {
          showLoginSuccessSnackbar(context);
          Navigator.pushReplacementNamed(context, PageRouter.mainNavbarPage);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: bottomInset > 0 ? bottomInset : 0,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? MediaQuery.of(context).size.width * .30
                        : 0,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/logo/library_logo.png",
                              width: 300,
                              fit: BoxFit.fitWidth,
                            ),
                          ),

                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          emailTextBox(),
                          const SizedBox(height: 10),
                          Text(
                            "Password",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          passwordTextBox(),
                          const SizedBox(height: 20),
                          loginButton(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not yet register?",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.copyWith(fontSize: 14),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    PageRouter.registerPage,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    "Register Now",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 14,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
