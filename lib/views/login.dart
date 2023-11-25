import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foco_alternativo/models/user_model.dart';
import 'package:foco_alternativo/services/authentication.dart';
import 'package:foco_alternativo/common/My_snackbar.dart';
import 'package:foco_alternativo/services/signup_controller.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => LogInState();
}

class MyControllers {
  static final TextEditingController passwordController =
      TextEditingController();
}

class LogInState extends State<LogIn> {
  bool queroEntrar = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController nickController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          Visibility(
            visible: !queroEntrar,
            child: Container(
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
                          setState(() {
                            queroEntrar = !queroEntrar;
                          });
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_left,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Sign Up",
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
          ),
          Visibility(
              visible: queroEntrar,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade600,
                      Colors.blue.shade900
                    ],
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 80),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 50),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Welcome Back",
                            style: TextStyle(color: Colors.white, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(64),
                  )),
              child: Form(
                key: _formKeyLogin,
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
                                const Text('E-mail'),
                                TextFormField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: 'E-mail',
                                    border: InputBorder.none,
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'The e-mail cannot be empty';
                                    }
                                    if (value.length < 5) {
                                      return 'The e-mail is too short';
                                    }
                                    if (!value.contains('@')) {
                                      return 'The e-mail is not valid';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !queroEntrar,
                              child: const SizedBox(
                                height: 20,
                              )),
                          Visibility(
                              visible: queroEntrar,
                              child: const SizedBox(
                                height: 50,
                              )),

                          // BOTÃO SENHA
                          Visibility(
                            visible: !queroEntrar,
                            child: Container(
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
                                  const Text('Nickname'),
                                  TextFormField(
                                    controller: nickController,
                                    decoration: const InputDecoration(
                                      hintText: 'Nickname',
                                      border: InputBorder.none,
                                    ),
                                    validator: (String? value) {
                                      if (value == null) {
                                        return 'The nickname cannot be empty';
                                      }
                                      if (value.length < 5) {
                                        return 'The nickname is too short';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),

                          // APENAS ESPAÇOS
                          Visibility(
                            visible: !queroEntrar,
                            child: const SizedBox(height: 20),
                          ),

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
                                  controller: passwordController,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: 'password',
                                    border: InputBorder.none,
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'The password cannot be empty';
                                    }
                                    if (value.length < 5) {
                                      return 'The password is too short';
                                    }
                                    return null;
                                  },
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: !queroEntrar,
                            child: const SizedBox(height: 20),
                          ),
                          Visibility(
                            visible: !queroEntrar,
                            child: Container(
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
                                    controller: confirmPasswordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Confirm Password',
                                      border: InputBorder.none,
                                    ),
                                    validator: (String? value) {
                                      if (value == null) {
                                        return 'The confirm password cannot be empty';
                                      }
                                      if (value.length < 5) {
                                        return 'The confirm password is too short';
                                      }
                                      if (value != passwordController.text) {
                                        return 'Please enter the same passwords';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              ButtonClicked();
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
                              child: Center(
                                  child: Text(
                                (queroEntrar) ? "Login" : "Sign Up",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                          visible: !queroEntrar,
                          child: const SizedBox(
                            height: 50,
                          )),
                      Visibility(
                          visible: queroEntrar,
                          child: const SizedBox(
                            height: 50,
                          )),
                      Visibility(
                        visible: queroEntrar,
                        child: InkWell(
                            child: Text('Forgot password?',
                                style: TextStyle(fontSize: 18)),
                            onTap: () {
                              _authService
                                  .forgotPassword(email: emailController.text)
                                  .then((String? erro) {
                                if (erro != null) {
                                  showSnackBar(context: context, text: erro);
                                } else {
                                  showSnackBar(
                                      context: context,
                                      text: 'CHECK YOUR E-MAIL TO CHANGE',
                                      isError: false);
                                }
                              });
                            }),
                      ),
                      Visibility(
                          visible: queroEntrar,
                          child: const SizedBox(
                            height: 40,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (queroEntrar)
                                ? "Don't have a account? "
                                : 'You already have a account? ',
                            style: const TextStyle(fontSize: 18),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  queroEntrar = !queroEntrar;
                                });
                              },
                              child: Text((queroEntrar) ? "Create" : 'Login',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      decorationStyle:
                                          TextDecorationStyle.dashed)))
                        ],
                      ),
                      Visibility(
                          visible: !queroEntrar,
                          child: const SizedBox(
                            height: 110,
                          )),
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

  // ignore: non_constant_identifier_names
  ButtonClicked() {
    String nome = nickController.text;
    String email = emailController.text;
    String senha = passwordController.text;

    if (_formKeyLogin.currentState!.validate()) {
      if (queroEntrar) {
        print('Entrada Válida');
        _authService.loginUsers(email: email, senha: senha).then(
          (String? erro) {
            if (erro != null) {
              // Voltou com erro
              showSnackBar(context: context, text: erro);
            }
          },
        );
      } else {
        print('Cadastro válido');
        _authService
            .signUpUsers(nome: nome, senha: senha, email: email)
            .then((String? erro) {
          if (erro != null) {
            // Voltou com erro
            showSnackBar(context: context, text: erro);
          }
        });
        String? _uid = FirebaseAuth.instance.currentUser?.uid;
        final user = UserModel(uid: _uid, email: email, nickname: nome, password: senha);
        SignUpController.instance.createUser(user);
      }
    } else {
      print('Form invalido');
    }
  }
}
