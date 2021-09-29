import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:senviki_app/Model/UserEntity.dart';
import 'package:senviki_app/Service/Auth.dart';
import 'package:senviki_app/Service/UserFirestore.dart';
import 'package:senviki_app/Utility/Colors.dart';
import 'package:senviki_app/Utility/util.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = new TextEditingController(
      text: FirebaseAuth.instance.currentUser.displayName);
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordRController = new TextEditingController();
  FocusNode _nameFocusNode = new FocusNode();
  FocusNode _passwordNode = new FocusNode();
  FocusNode _passwordRNode = new FocusNode();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _nameFocusNode.dispose();
    _passwordController.dispose();
    _passwordRController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            FontAwesomeIcons.chevronLeft,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          'Profilini düzenle',
          style: GoogleFonts.openSans(
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Container(
        width: getSize(context),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: CircleAvatar(
                backgroundColor: AppColors.secondaryColor,
                radius: getSize(context) * 0.15,
                child: Text(
                  FirebaseAuth.instance.currentUser.displayName[0] != null
                      ? FirebaseAuth.instance.currentUser.displayName[0]
                      : '...'.toUpperCase(),
                  style:
                      GoogleFonts.openSans(color: Colors.white, fontSize: 40),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 40,
                left: 20,
                right: 20,
              ),
              child: TextFormField(
                focusNode: _nameFocusNode,
                controller: _nameController,
                // ignore: missing_return
                validator: (value) {
                  if (value.trim().isEmpty) return 'Bir isim giriniz...';
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
                focusNode: _passwordNode,
                controller: _passwordController,
                obscureText: true,
                // ignore: missing_return
                validator: (value) {
                  if (value.trim().isEmpty) return 'Şifre giriniz';
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      FontAwesomeIcons.fingerprint,
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
                    labelText: 'Şifreniz',
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
                focusNode: _passwordRNode,
                controller: _passwordRController,
                obscureText: true,
                // ignore: missing_return
                validator: (value) {
                  if (value.trim().isEmpty) return 'Şifre giriniz';
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      FontAwesomeIcons.fingerprint,
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
                    labelText: 'Şifrenizi tekrar giriniz',
                    labelStyle: GoogleFonts.roboto(
                      color: AppColors.secondaryColor,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: FlatButton(
                  onPressed: () => updateProfile(_nameController.text,
                      _passwordController.text, _passwordRController.text),
                  color: AppColors.secondaryColor,
                  child: Text(
                    'Güncelle',
                    style: GoogleFonts.openSans(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // updateProfile() async {
  //   await FirebaseAuth.instance.currentUser
  //       .updateProfile(displayName: _nameController.text);

  //   await UserFirestoreService.updateUser(UserEntity(
  //     uid: FirebaseAuth.instance.currentUser.uid,
  //     email: FirebaseAuth.instance.currentUser.email,
  //     name: _nameController.text,
  //   ));

  //   setState(() {});
  // }

  updateProfile(
    String name,
    String password,
    String passwordR,
  ) async {
    if (name != null && password != null && passwordR != null) {
      await FirebaseAuth.instance.currentUser
          .updatePassword(password)
          .whenComplete(() async {
        debugPrint('updatePassword---');
        await FirebaseAuth.instance.currentUser
            .updateProfile(displayName: name)
            .whenComplete(() async {
        debugPrint('updateName---');
          await UserFirestoreService.updateUser(UserEntity(
              uid: FirebaseAuth.instance.currentUser.uid,
              email: FirebaseAuth.instance.currentUser.email,
              name: name));
        });
      });
    }
  }
}
