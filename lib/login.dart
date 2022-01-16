import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_screen/signup.dart';
import 'homepage.dart';

class Login extends StatelessWidget {
  String? _token;
  DateTime? _expiryDate;

  Login({Key? key}) : super(key: key);
  Future<void> SignIn(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD0gxgqEWZsfFJeHKcpVzmL6kj8VhWlVrc';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    //print(json.decode(response.body));
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      // print(responseData['error']);
    }
    _token = responseData['idToken'];
    _expiryDate = DateTime.now().add(
      Duration(
          seconds: int.parse(
        responseData['expiresIn'].toString(),
      )),
    );
    // print(_token);
    // print(_expiryDate!.isAfter(DateTime.now()));
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _email = TextEditingController();
    TextEditingController _pass = TextEditingController();

    return SafeArea(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(29.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your Login Page",
              style: TextStyle(fontSize: 40, color: Colors.red),
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              autofocus: false,
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.isEmpty) {
                  return ("inter valid email");
                }
                if (!RegExp("^[a-zA-Z0-9+_,-]").hasMatch(value)) {
                  return ("please Enter valid email");
                }
                return null;
              },
              onSaved: (value) {
                _email.text = value!;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: 'Enter Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              autofocus: false,
              obscureText: true,
              validator: (value) {
                RegExp regex = RegExp(r'^.{6,}$');
                if (value!.isEmpty) {
                  return ("Password is required");
                }
                if (!regex.hasMatch(value)) {
                  return ("please enter valid password(Min. 6 character)");
                }
              },
              controller: _pass,
              onSaved: (value) {
                _pass.text = value!;
              },
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.vpn_key),
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintText: 'Enter Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(30),
              color: Colors.redAccent,
              child: MaterialButton(
                onPressed: () async {
                  await SignIn(_email.text, _pass.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePage()));
                },
                child: const Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                minWidth: MediaQuery.of(context).size.width,
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Don't have account?",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp())),
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) == true &&
        _token != null) {
      return _token;
    }
  }

  bool get isAuth {
    return token != null;
  }

  void notifyListeners() {}
}
