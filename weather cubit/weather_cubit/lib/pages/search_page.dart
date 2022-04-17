import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchPage> {

  final formKey = GlobalKey<FormState>();
  String? _city;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;


_onSubmit()async {
  setState(() {
    autovalidateMode = AutovalidateMode.always;
  });

  final form = formKey.currentState;

  if(form != null && form.validate()){
    form.save();
    Navigator.pop(context, _city!.trim());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Page"),),
      body: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Column(
          children:   [
           const  SizedBox(height: 50,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
             child: TextFormField(
               style: const TextStyle(fontSize: 20),
               decoration:const  InputDecoration(
                 hintText: "more then 2 char",
                 labelText: "City",
                 prefixIcon: Icon(Icons.search_sharp),
                 border: OutlineInputBorder()
               ),
               validator: (v){
                 if(v!.length.isNaN || v.trim().length < 2){
                   return "City name must be 2 char long";
                 }
               },
               onSaved: (text){
                 _city = text;
               },
             ),),
             const SizedBox(height: 30,),
             ElevatedButton(onPressed: _onSubmit, child:const  Text("How's Weather", style: TextStyle(fontSize: 22),))
          ],
        ),
      ),
    );
  }
}
