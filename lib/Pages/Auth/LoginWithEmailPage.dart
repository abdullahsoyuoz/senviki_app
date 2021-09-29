import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Pages/Auth/RegisterPage.dart';
import 'package:senviki_app/Pages/MainPageView.dart';
import 'package:senviki_app/Service/Auth.dart';
import 'package:senviki_app/Service/SharedPrefs.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWithEmailPage extends StatefulWidget {
  @override
  _LoginWithEmailPageState createState() => _LoginWithEmailPageState();
}

class _LoginWithEmailPageState extends State<LoginWithEmailPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  TextEditingController _emailController;
  TextEditingController _passwordController;
  FocusNode _mailfocusNode = FocusNode();
  FocusNode _passwordfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'test3@test.com');
    _passwordController = TextEditingController(text: '12341234');
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      FontAwesomeIcons.chevronLeft,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Text(
                  'Giriş Yap',
                  style: GoogleFonts.roboto(
                    color: AppColors.primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  focusNode: _mailfocusNode,
                  controller: _emailController,
                  // ignore: missing_return
                  validator: (value) {
                    assert(value != null);
                    if (value.trim().isEmpty)
                      return 'Email adresiniz geçersiz...';
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        FontAwesomeIcons.envelope,
                        color: AppColors.secondaryColor,
                        size: 20,
                      ),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor)),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      labelText: 'Email adresiniz',
                      labelStyle: GoogleFonts.roboto(
                        color: AppColors.secondaryColor,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  focusNode: _passwordfocusNode,
                  controller: _passwordController,
                  obscureText: true,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.trim().isEmpty) return 'Şifre giriniz...';
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.fingerprint,
                        color: AppColors.secondaryColor,
                        size: 20,
                      ),
                      border: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor)),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.redAccent)),
                      labelText: 'Parolanız',
                      labelStyle: GoogleFonts.roboto(
                        color: AppColors.secondaryColor,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        loginController();
                        _mailfocusNode.unfocus();
                        _passwordfocusNode.unfocus();
                      }
                    },
                    color: AppColors.secondaryColor,
                    child: Text(
                      'Giriş Yap',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: InkWell(
                  onTap: () {
                    //
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Şifrenizi mi unuttunuz?',
                      style:
                          GoogleFonts.openSans(color: AppColors.primaryColor),
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => RegisterPage(),
                        ));
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Henüz kayıt olmadınız mı?',
                      style:
                          GoogleFonts.openSans(color: AppColors.primaryColor),
                    ),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void loginController() async {
    await AppAuth()
        .login(_emailController.text, _passwordController.text)
        .then((value) {
      setUserPrefs(_emailController.text, _passwordController.text);
      _emailController.clear();
      _passwordController.clear();

      if (value.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => MainPageView()),
            (route) => false);
      }
    }).catchError((e) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Email veya şifre hatalı...')));
    });
  }
}
