import 'package:ecommerce/services/firebase/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});


  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _textControllerEmail = TextEditingController();
  final _textControllerPassword = TextEditingController();
  bool _isButtonEnabled = false;
  bool _isObscure=true;

    @override
  void initState() {
    super.initState();
    _textControllerPassword.addListener(_checkPasswordLength);
  }

  void _checkPasswordLength() {
    final password = _textControllerPassword.text;
    setState(() {
      _isButtonEnabled = password.length > 6; // actif si > 6 caractères
    });
  }

  @override
  void dispose() {
    _textControllerEmail.dispose();
    _textControllerPassword.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _textControllerEmail,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  labelText: 'Email *',
                  border: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(8),
                  ),
                ),
                 validator:(value){
                  if(value ==null || value.isEmpty){
                    return 'Email is required';
                  }else if(!value.contains("@")){
                  return 'please enter valid Email';
                }else if(!value.contains(".com")){
                  return 'please enter valid Email';
                }else{
                  return null;
                }
                 }
              ),
              SizedBox(height: 20,),
               TextFormField(
                controller: _textControllerPassword,
                obscureText: _isObscure,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Enter your password',
                  labelText: 'Password *',
                  border: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(8),
                  ),
                   suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.black,)
                ),
                ),
                 validator:(value){
                  if(value ==null || value.isEmpty){
                    return 'Password is required';
                  }else if(value.length<6){
                  return '';
                }else{
                  return null;
                }
                 },
                 
              ),
              SizedBox(height: 20,),
              Container(
                //margin: const EdgeInsets.only(top: 30),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed:() async{
                    if (_formKey.currentState!.validate()){
                      try{
                        await Auth().loginWithEmailAndPassword(
                          _textControllerEmail.text,
                          _textControllerPassword.text);
                      }on FirebaseAuthException catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${e.message}"),
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          backgroundColor: Colors.red,)
                        );
                      }
                      
                    }
                    },
                 child: const Text("Login")),
              )
            ],
          ),
        ),
         
      ),
    );
  }
}
