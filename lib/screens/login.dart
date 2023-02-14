//import 'package:flutter/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:mobile_dolibarr/screens/home.dart';

// import '../styles/fadeAnimation.dart';

Future sayHello (login, password) async {
  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(Uri.parse('http://localhost:8080/dolibarr/api/index.php/login?login='+login+'&password='+password));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    print('you are login like ${jsonResponse}');
    return {'code': 200};
  } else {
    print('Request failed with status: ${response.statusCode}.');
    return {'code': 400};
  }
}

class LoginScreen extends StatelessWidget {
  LoginScreen( {super.key});

  get email => "admin";
  get password => "passer123";

  TextEditingController loginController=TextEditingController();
  TextEditingController passwordController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: const BoxDecoration (
                    image: DecorationImage (
                        image: AssetImage('images/background.png'),
                        fit: BoxFit.fill
                    )
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 30,
                      width: 80,
                      height: 200,
                      child:Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/light-1.png')
                            )
                        ),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/light-2.png')
                            )
                        ),
                      )
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/clock.png')
                            )
                        ),
                      )
                    ),
                    Positioned(
                      child:  Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: const Center(
                          child: Text("Login", style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                        ),
                      )
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                     Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            //decoration: BoxDecoration(
                                //border: Border(bottom: BorderSide(color: Colors.grey[100]))
                            //),
                            child: TextField(
                              controller: loginController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email or Phone number",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey[400])
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(143, 148, 251, 1),
                                Color.fromRGBO(143, 148, 251, .6),
                              ]
                          )
                      ),
                      child: TextButton(
                        child: const Center(
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                        ),
                        onPressed: () {
                          sayHello(loginController.text, passwordController.text).then((value) => {
                            if (value['code'] == 200)
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen("title")))

                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 70,),
                    const Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}