import 'package:dp_project/register.dart';
import 'package:dp_project/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emcontroller = TextEditingController();
  String _email = "";
  final TextEditingController _pscontroller = TextEditingController();
  String _password = "";
  bool _passVisible = true;
  bool _rememberMe = false;
  SharedPreferences prefs;

  @override
  void initState() {
    loadpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.pink[100],
          appBar: AppBar(
            centerTitle: true,
            title: Text('Login'),
            backgroundColor: Colors.purple[300],
          ),
          body: new Container(
              padding: EdgeInsets.all(40),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(),
                    Image.asset(
                      'assets/images/logo.png',
                      scale: 0.9,
                    ),
                    Text(
                      "Selamat Datang Ke Dream Petals",
                      style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                        controller: _emcontroller,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email', /*icon: Icon()*/
                        )),
                    TextField(
                      controller: _pscontroller,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passVisible = !_passVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: _passVisible,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (bool value) {
                            _onChange(value);
                          },
                        ),
                        Text('Remember Me', style: TextStyle(fontSize: 16))
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                        onTap: _onForgot,
                        child: Text('Forgot password ?',
                            style: TextStyle(fontSize: 16))),
                    SizedBox(
                      height: 15,
                    ),
                    Wrap(
                      children: [
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minWidth: 10,
                          height: 50,
                          child: Text('Login'),
                          color: Colors.purple[300],
                          textColor: Colors.black,
                          elevation: 15,
                          onPressed: _onLogin,
                        ),
                        Padding(
                          padding: new EdgeInsets.all(10.0),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          minWidth: 10,
                          height: 50,
                          child: Text('Register Account'),
                          color: Colors.purple[300],
                          textColor: Colors.black,
                          elevation: 15,
                          onPressed: _onRegister,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ))),
    );
  }

  void _onLogin() {
    Toast.show(
          "Login success",
          context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
        );
    setState(() {});
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Main()));
  }

  void _onRegister() {
    setState(() {});

    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Register()));
  }

  void _onForgot() {}

  void loadpref() async {
    prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email')) ?? '';
    _password = (prefs.getString('password')) ?? '';
    _rememberMe = (prefs.getBool('rememberme')) ?? false;
    if (_email.isNotEmpty) {
      setState(() {
        _emcontroller.text = _email;
        _pscontroller.text = _password;
        _rememberMe = _rememberMe;
      });
    }
  }

  void savepref(bool value) async {
    prefs = await SharedPreferences.getInstance();
    _email = _emcontroller.text;
    _password = _pscontroller.text;

    if (value) {
      if (_email.length < 5 && _password.length < 3) {
        print("EMAIL/PASSWORD EMPTY");
        _rememberMe = false;
        
        return;
      } else {
        await prefs.setString('email', _email);
        await prefs.setString('password', _password);
        await prefs.setBool('rememberme', value);
       
        print("SUCCESS");
      }
    } else {
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      await prefs.setBool('rememberme', false);
      setState(() {
        _emcontroller.text = "";
        _pscontroller.text = "";
        _rememberMe = false;
      });
    }
  }

  void _onChange(bool value) {
    setState(() {
      _rememberMe = value;
      savepref(value);
    });
  }
}
