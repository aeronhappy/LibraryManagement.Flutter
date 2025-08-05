import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/features/Auth/bloc/auth/auth_bloc.dart';
import 'package:library_management/features/Auth/bloc/role/role_bloc.dart';
import 'package:library_management/features/Auth/model/request/register_request.dart';
import 'package:library_management/features/Auth/model/role_model.dart';
import 'package:library_management/features/Auth/widget/auth_snackbar.dart';
import 'package:library_management/router/router_type.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  List<RoleModel> listOfRoles = [];
  List<String> selectedRoles = [];
  bool obsecureText = true;
  bool confirmObsecureText = true;

  @override
  void initState() {
    super.initState();
    context.read<RoleBloc>().add(GetAllRoles());
  }

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
        selectedRoles.isEmpty ||
        nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text != passwordController.text ||
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
                  RegisterAccount(
                    registerRequest: RegisterRequest(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      rolesId: selectedRoles,
                    ),
                  ),
                );
              },
        child: SizedBox(
          height: 45,
          child: Center(child: Text("Register", style: bodyMediumDark)),
        ),
      ),
    );
  }

  Widget nameTextBox() => Container(
    alignment: Alignment.center,
    height: 40,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 1.5, color: navBarIconColor),
    ),
    child: Center(
      child: TextField(
        controller: nameController,
        onChanged: (_) => setState(() {}),
        textAlignVertical: TextAlignVertical.top,
        style: Theme.of(context).textTheme.bodyMedium,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          hintText: 'Full name',
          hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
            height: 2,
            decoration: TextDecoration.none,
            color: navBarIconColor,
          ),
          border: InputBorder.none,
          suffixIcon: nameController.text.isEmpty
              ? null
              : ExcludeFocus(
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => setState(() => nameController.clear()),
                  ),
                ),
        ),
      ),
    ),
  );

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

  Widget confirmPasswordTextBox() => Container(
    alignment: Alignment.center,
    height: 40,
    padding: const EdgeInsets.only(left: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(width: 1.5, color: navBarIconColor),
    ),
    child: TextField(
      controller: confirmPasswordController,
      obscureText: confirmObsecureText,
      onChanged: (_) => setState(() {}),
      style: Theme.of(context).textTheme.bodyMedium,
      textAlignVertical: TextAlignVertical.top,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        hintStyle: Theme.of(
          context,
        ).textTheme.labelLarge!.copyWith(color: navBarIconColor, height: 2),
        border: InputBorder.none,
        suffixIcon: confirmPasswordController.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(
                  confirmObsecureText ? Icons.visibility_off : Icons.visibility,
                  size: 20,
                ),
                onPressed: () =>
                    setState(() => confirmObsecureText = !confirmObsecureText),
              ),
      ),
    ),
  );

  Widget selectRoleBox() => Row(
    children: listOfRoles.map((role) {
      return Padding(
        padding: const EdgeInsets.only(right: 20),
        child: InkWell(
          onTap: () {
            setState(() {
              if (selectedRoles.contains(role.id)) {
                selectedRoles.remove(role.id);
              } else {
                selectedRoles.add(role.id);
              }
            });
          },
          child: Row(
            children: [
              Container(
                height: 17,
                width: 17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1.2),
                ),
                child: selectedRoles.contains(role.id)
                    ? Container(
                        color: Colors.blue,
                        child: Center(child: Icon(Icons.check, size: 12)),
                      )
                    : Container(),
              ),
              const SizedBox(width: 5),
              Text(role.name, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      );
    }).toList(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoadingAuth) {
              showLoggingInSnackbar(context, true);
            } else if (state is FailedAuth) {
              showLoginFailedSnackbar(context, state.message);
            } else if (state is SuccessAuth) {
              showLoginSuccessSnackbar(context);
              Navigator.pushReplacementNamed(
                context,
                PageRouter.mainNavbarPage,
              );
            }
          },
        ),
        BlocListener<RoleBloc, RoleState>(
          listener: (context, state) {
            if (state is LoadedRole) {
              setState(() {
                listOfRoles = state.roles;
              });
            }
          },
        ),
      ],
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
                              width: 200,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          Text(
                            "Name",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          nameTextBox(),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          Text(
                            "Confirm Password",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          confirmPasswordTextBox(),
                          const SizedBox(height: 10),
                          Text(
                            "Select Role",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          selectRoleBox(),
                          const SizedBox(height: 20),
                          loginButton(),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: Theme.of(
                                  context,
                                ).textTheme.labelMedium!.copyWith(fontSize: 14),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 2,
                                  ),
                                  child: Text(
                                    "SignIn",
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
