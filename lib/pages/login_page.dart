import 'package:flutter/material.dart';
import '/service/api_service.dart';
import 'package:provider/provider.dart';
import '/main.dart';
import '/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}):super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = "";
  bool _progressBar = false;

  void _navigateToLoginSucces() {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => const LoginSuccesPage()));
  }
  
  var titlePage = "Login";

  @override
  Widget build(BuildContext context) {
    StateNotifier appState = context.watch<StateNotifier>();
    return Scaffold(
      appBar: AppBar(title: Text(titlePage)),
      body: Center(
        child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(  
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(hintText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un username';
                  } 
                  return null;
                },
              ),
              const SizedBox(height: 15,),

              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(hintText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez saisir votre mot de passe';
                  } 
                  return null;
                },
              ),

              const SizedBox(height: 15,),
              _progressBar ? const LinearProgressIndicator() : Text(_error, style: const TextStyle(color: Colors.red, fontSize: 12),),

              const SizedBox(height: 15,),
              ElevatedButton(onPressed: () async {
                setState(() {
                  _progressBar = true;
                });
                if (_formKey.currentState!.validate()) {
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  Map<String, String> loginInfo = {"username":username, "password":password};
                  bool response = await APIService.login(loginInfo);
                  print("User connected $response");
                  if (response) {
                    dynamic user = await APIService.getUser(username);
                    await appState.login(user);
                    setState(() {
                      _error = "";
                    });
                    _navigateToLoginSucces();
                  } else {
                    setState(() {
                      _error = "Username or password incorrect";
                    });
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("data is not correct")));
                }
                setState(() {
                  _progressBar = false;
                });
              }, child: const Text("Se Connecter")),
            ],
          ),
        ),
      ),
      )
    );
  }
}

class LoginSuccesPage extends StatelessWidget{
  const LoginSuccesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Success")),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (ctx){ return const MainScreen();}));
                },
                child: const Text("Return to the home page"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
