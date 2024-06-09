import 'package:booksportz_supplier_webview_app/commons/images.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../commons/app_validator.dart';
import '../../../commons/colors.dart';
import '../../../commons/dimens.dart';
import '../../../commons/routes.dart';
import '../../../commons/ui_utils.dart';
import '../../providers/login_provider.dart';
import '../../providers/user_auth_provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  late final _loginProvider = context.read<LoginProvider>();
  late final _userAuthProvider = context.read<UserAuthProvider>();

  bool enableLoginBtn = false;

  String userEmail = "";

  String userPassword = "";

  String? errorMessage;

  bool showPassword = false;

  bool _emailHasError = false;

  final bool _passwordHasError = false;

  bool _loadingLoginRequest = false;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
/*    emailController.text="gopaya5310@usoplay.com";
    passwordController.text="Dht123457";*/
    emailController.addListener(() {
      userEmail = emailController.text;
      checkEmptyForm();
    });
    passwordController.addListener(() {
      userPassword = passwordController.text;
      checkEmptyForm();
    });
  }

  void checkEmptyForm() {
    bool isValidData = true;
    if (!AppValidator.isNotBlank(userEmail) ||
        !AppValidator.isNotBlank(userPassword)) {
      isValidData = false;
    }
    enableLoginBtn = isValidData;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //_authProvider = Provider.of<localAuthProvider.AuthProvider>(context);
    return Scaffold(
      backgroundColor: ColorSet.colorWhite,
      appBar: AppBar(
        toolbarHeight: Dimens.dimen_0,
        backgroundColor: ColorSet.colorWhite,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: ColorSet.colorWhite,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimens.dimen_35),
                        topLeft: Radius.circular(Dimens.dimen_35),
                      )),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                               addVerticalSpace(Dimens.dimen_60),
                              Image.asset(
                                Images.loginLogo,
                                height: Dimens.dimen_100,
                              ),
                              addVerticalSpace(Dimens.dimen_32),
                              Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Dimens.dimen_20),
                                  child: Text(
                                    "${AppLocalizations.of(context)?.welcome_back_txt}",
                                       style: const TextStyle(
                                    color: ColorSet.COLOR_333333,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimens.dimen_25),
                                  ),
                                ),
                              ),
                              addVerticalSpace(Dimens.dimen_25),
                              createSignupInputWidget(
                                  textInputType: TextInputType.emailAddress,
                                  hintText:
                                      "${AppLocalizations.of(context)?.inputFieldHint(AppLocalizations.of(context)?.email_address.toLowerCase() ?? '')}",
                                  titleText:
                                      "${AppLocalizations.of(context)?.email_address}",
                                  inputController: emailController,
                                  hasError:
                                      _emailHasError || errorMessage != null,
                                  enableInput: true),
                              addVerticalSpace(Dimens.dimen_16),
                              createSignupInputWidget(
                                  isPassword: !showPassword,
                                  suffixWidgetIcon: GestureDetector(
                                    onTap: () {
                                      showPassword = !showPassword;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: Dimens.dimen_16,
                                      color: ColorSet.COLOR_BDBDBD,
                                    ),
                                  ),
                                  hasError:
                                      _passwordHasError || errorMessage != null,
                                  titleText:
                                      "${AppLocalizations.of(context)?.password}",
                                  hintText:
                                      "${AppLocalizations.of(context)?.inputFieldHint(AppLocalizations.of(context)?.password.toLowerCase() ?? '')}",
                                  inputController: passwordController),
                              addVerticalSpace(Dimens.dimen_7),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.dimen_25),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Visibility(
                                        visible: (errorMessage != null &&
                                                errorMessage!.isNotEmpty)
                                            ? true
                                            : false,
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              Images.closeCircleFilled,
                                              color: ColorSet.red,
                                              height: Dimens.dimen_13,
                                            ),
                                            addHorizontalSpace(Dimens.dimen_4),
                                            Expanded(
                                              child: Text("$errorMessage",
                                                  style: const TextStyle(
                                                      color: ColorSet.red,
                                                      fontSize:
                                                          Dimens.dimen_10)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _validateEmail();
                                      },
                                      child: Text(
                                          "${AppLocalizations.of(context)?.forget_password_txt}",
                                          style: const TextStyle(
                                              color: ColorSet.COLOR_3D98FF,
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: Dimens.dimen_12)),
                                    ),
                                  ],
                                ),
                              ),
                              addVerticalSpace(Dimens.dimen_20),
                              AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 10),
                                  child: _loadingLoginRequest
                                      ? customLoadingView()
                                      : GestureDetector(
                                          onTap: () {
                                            if (enableLoginBtn) {
                                              confirmLogin();
                                            }
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: Dimens.dimen_25),
                                            width: double.infinity,
                                            height: Dimens.dimen_48,
                                            decoration: containerBtnBlueBg(
                                                enableLoginBtn),
                                            child: Center(
                                              child: Text(
                                                  "${AppLocalizations.of(context)?.sign_in_txt}",
                                                  style: const TextStyle(
                                                      color:
                                                          ColorSet.COLOR_WHITE,
                                                      fontSize:
                                                          Dimens.dimen_16),
                                                  textAlign: TextAlign.center),
                                            ),
                                          ),
                                        )),
                              addVerticalSpace(Dimens.dimen_30),
                              isLoading ? customLoadingView() : Container(),
                              addVerticalSpace(Dimens.dimen_30),

                              addVerticalSpace(Dimens.dimen_40),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void confirmLogin() async {
    dismissKeyboard(context);
    bool emailCheck = validateEmail(userEmail);
    if (emailCheck && userPassword.isNotEmpty) {
      errorMessage = null;
      _loadingLoginRequest = true;
      _emailHasError = false;
      setState(() {});
      await _loginProvider.confirmLogin(
          userEmail: userEmail, password: userPassword);
      _loadingLoginRequest = false;
      if (_loginProvider.hasError) {
        setState(() {
          errorMessage = _loginProvider.errorMsg ?? 'An Error Happened';
        });
      } else {
        handleLoginResponse();
      }
    } else {
      if (!emailCheck) {
        _loadingLoginRequest = false;
        _emailHasError = true;
        errorMessage = "${AppLocalizations.of(context)?.invalid_email_txt}";
      } else if (userPassword.isEmpty) {
        _emailHasError = true;
        _loadingLoginRequest = false;
        errorMessage = "${AppLocalizations.of(context)?.invalid_password_txt}";
      }
      setState(() {
        _loadingLoginRequest = false;
      });
    }
  }

  void handleLoginResponse() async {
    _loadingLoginRequest = true;
    setState(() {});
    await _userAuthProvider.getSelf();
    _loadingLoginRequest = false;
    setState(() {});
    if (_userAuthProvider.userModel != null &&
        _userAuthProvider.userModel!.isEmailVerified == true) {
      openHomePage();
    }
  }

  void openHomePage() {
    openPageWithName(context, Routes.home, closeBefore: true);
  }

  void _validateEmail() {
    dismissKeyboard(context);
    bool emailCheck = validateEmail(userEmail);
    if (emailCheck) {
      _loadingLoginRequest = true;
      _emailHasError = false;
    } else {
      _emailHasError = true;
      errorMessage = AppLocalizations.of(context)?.invalid_email_txt;
    }
    setState(() {});
  }
}
