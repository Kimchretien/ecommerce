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
   final _textControllerPasswordConfirm = TextEditingController();
  bool _isObscure=true;

  bool _isLoading=false;
  bool _forLogin=true;

 
  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_forLogin ? widget.title: "Se Connecter"),
        centerTitle: true,
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
                  onPressed: _isLoading? null: () {
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
                  return 'Password must be at least 6 characters';
                
                }else{
                  return null;
                }
                 },
                 
              ),SizedBox(height: 20,),
               if(!_forLogin) TextFormField(
                controller: _textControllerPasswordConfirm,
                obscureText: _isObscure,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: 'Retap your password *',
                  labelText: 'Password *',
                  border: OutlineInputBorder(
                    //borderRadius: BorderRadius.circular(8),
                  ),
                   suffixIcon: IconButton(
                  onPressed: _isLoading? null: () {
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
                  return 'Password must be at least 6 characters';
                }else if(value !=_textControllerPassword.text){
                  return 'password doesn\'t match';
                }else{
                  return null;
                }
                 },
                 
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed:() async{
                    if (_formKey.currentState!.validate()){
                          setState(() {
                            _isLoading = true;
                      });
                      try{
                        if(_forLogin){
                           await Auth().loginWithEmailAndPassword(
                          _textControllerEmail.text,
                          _textControllerPassword.text);
                        }else{
                           await Auth().createUserWithEmailAndPassword(
                          _textControllerEmail.text,
                          _textControllerPassword.text);
                        }
                          setState(() {
                      _isLoading=false;
                    });
                      }on FirebaseAuthException catch(e){
                        setState(() {
                      _isLoading=false;
                    });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${e.message}"),
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          backgroundColor: Colors.red,)
                        );
                      }
                      
                    }
                    },
                 child:_isLoading ? const CircularProgressIndicator():  Text(_forLogin ? "se connecter": "s'inscrire")),
              ),
              SizedBox(height: 20,),
              SizedBox(
                child: TextButton(
                  onPressed: (){
                    _textControllerEmail.text="";
                    _textControllerPassword.text="";
                    _textControllerPasswordConfirm.text="";
                    setState(() {
                      _forLogin=! _forLogin;
                    });
                  } , 
                  child: Text(_forLogin ? "J'ai pas un compte, s'inscrire": "J'ai deja un compte ,se connecter")),
              ),
              const Divider(),
              ElevatedButton.icon(
                onPressed: (){
                  Auth().signInWithGoogle();
                },
                icon: Image.asset("assets/images/google.png",height: 30,),
                label: const Text("Continuer avec Google"))
            ],
          ),
        ),
         
      ),
    );
  }
}
