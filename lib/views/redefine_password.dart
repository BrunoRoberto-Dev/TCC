import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foco_alternativo/common/My_snackbar.dart';
import 'package:foco_alternativo/services/authentication.dart';

class RedefinePassword extends StatefulWidget {
  const RedefinePassword({super.key});

  @override
  State<RedefinePassword> createState() => _RedefinePasswordState();
}

class _RedefinePasswordState extends State<RedefinePassword> {
  final _passController = TextEditingController();
  final _newPassController = TextEditingController();
  final _newPass2Controller = TextEditingController();
  final _formKeyPass = GlobalKey<FormState>();
  bool passwordVisible = false;
  bool newPasswordVisible = false;
  bool newPasswordVisible2 = false;

  final AuthService user = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [
                  Colors.blue.shade500,
                  Colors.blue.shade600,
                  Colors.blue.shade900
                ],
              ),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_left,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Redefine",
                      style: TextStyle(color: Colors.white, fontSize: 38),
                    ),
                    const SizedBox(
                      width: 24,
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(64),
                  )),
              child: Form(
                key: _formKeyPass,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12, color: Colors.black12),
                                ]),

                            // BOTÃO EMAIL
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Current Password'),
                                TextFormField(
                                  controller: _passController,
                                  decoration: const InputDecoration(
                                    hintText: 'Current Password',
                                    border: InputBorder.none,
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'The Current Password cannot be empty';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          // BOTÃO SENHA
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12, color: Colors.black12),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Password'),
                                TextFormField(
                                  controller: _newPassController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'password',
                                    border: InputBorder.none,
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'The password cannot be empty';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 12, color: Colors.black12),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Confirm Password'),
                                TextFormField(
                                  controller: _newPass2Controller,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'Confirm Password',
                                    border: InputBorder.none,
                                  ),
                                  validator: (String? value) {
                                    if ((value!.isEmpty || value!.length < 6) ||
                                        _newPassController.text !=
                                            _newPass2Controller) {
                                      return 'As senhas não coincidem';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              user.redefinePassword(
                                  senha: _passController.text,
                                  novasenha: _newPass2Controller.text).then((String? erro) {
                                if (erro != null) {
                                  showSnackBar(context: context, text: erro);
                                }
                                else {showSnackBar(context: context, text: 'SUCESSFUL CHANGE', isError: false);}
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                    bottomRight: Radius.circular(16),
                                  )),
                              child: const Center(
                                  child: Text(
                                "Redefine",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
