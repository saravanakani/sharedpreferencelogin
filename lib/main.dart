import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    init();
  }

  bool checkLoggedIn = false;

  bool loading = false;

  setLoading() {
    setState(() {
      loading = true;
    });
  }

  resetLoading() {
    setState(() {
      loading = false;
    });
  }

  Future<void> init() async {
    setLoading();
    Future<SharedPreferences> pref = SharedPreferences.getInstance();

    final SharedPreferences prefs = await pref;

    checkLoggedIn = prefs.getBool("isloggedin") ?? false;
    resetLoading();
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: loading ? const Center(child: CircularProgressIndicator(),) : checkLoggedIn ? const HomePage() : const Loginpage(),
      ),
    );
  }
}

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  final _formkey = GlobalKey<FormState>();
  Future<void> setLoginStatus() async {
    final SharedPreferences prefs = await pref;
    prefs.setBool("isloggedin", true);
    bool? status = prefs.getBool("isloggedin");

    print('status => $status');
    showSimpleNotification(Text("you are logged in"), background: Colors.green);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const Text(
                    "Login ",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50,),

                  const Center(child:CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("images/img_2.png"),
                  ) ),
                  const SizedBox(height: 50,),


                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter the username"),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the username";
                          } else {}
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Enter the password"),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return "Enter the password";
                          } else {}
                        }),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setLoginStatus();
                          }
                        },
                        child: Text("Login")),
                  ),
                  SizedBox(height: 50),
                  Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign Up   ?",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(width: 10),
                        Text("Click Here",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
