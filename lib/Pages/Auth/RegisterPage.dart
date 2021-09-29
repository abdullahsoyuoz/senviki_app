import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Pages/Auth/LoginWithEmailPage.dart';
import 'package:senviki_app/Service/Auth.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Widgets/appSnackbar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Kayıt Ol',
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
                  controller: _nameController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.trim().isEmpty)
                      return 'Lütfen isminizi giriniz...';
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        FontAwesomeIcons.solidUser,
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
                      labelText: 'İsminiz',
                      labelStyle: GoogleFonts.roboto(
                        color: AppColors.secondaryColor,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: TextFormField(
                  controller: _emailController,
                  // ignore: missing_return
                  validator: (value) {
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
                        registerController();
                      }
                    },
                    color: AppColors.secondaryColor,
                    child: Text(
                      'Kayıt Ol',
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
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => LoginWithEmailPage(),
                        ));
                  },
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Daha önce kayıt oldunuz mu?',
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

  void registerController() {
    try {
      AppAuth()
          .register(_emailController.text, _passwordController.text, nameController: _nameController.text)
          .whenComplete(() {
        _emailController.clear();
        _passwordController.clear();
        Navigator.pop(context);
      });
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Scaffold.of(context).showSnackBar(appSnackBar(e.toString()));
    }
  }
}
