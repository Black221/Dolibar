import 'dart:convert';
import 'package:mobile_dolibarr/screens/Product_list.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http;

class AddProduct extends StatefulWidget {
  //add will behave like the edit page:costumize
    final Map?product;
  const AddProduct({super.key,
  this.product//la page va move vers edit page
  });
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
//le  edinting controller pour la submission
TextEditingController labelController=TextEditingController();
TextEditingController descriptionController=TextEditingController();
TextEditingController refController=TextEditingController();
//creation de la variable pour dire si on va dans page edit avec le bouton edit
bool isedit = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    final product = widget.product;
    if ( product != null) {//si on vient dans la page utilisant edit
      isedit = true;
      labelController.text = product['label'];
      descriptionController.text = product['description'];
    } else {
      
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
      title: Text(
        isedit? 'EditProduct':'AddProduct' //on change le titre de appbar si dans la page de modify
        )
      ),
      body:ListView(
        padding: EdgeInsets.all(10),
        children: [
          TextField(
            controller: labelController,
            decoration: InputDecoration(
                labelText: 'label',
                hintText: 'Entrer le nom du label',
                prefixIcon: Icon(Icons.bookmark),
                border: OutlineInputBorder(),)),
          SizedBox(height:20),
          TextField(
            controller: refController,
            decoration: InputDecoration(

                labelText: 'Reference',
                hintText: 'Entrer le nom du Reference',
                prefixIcon: Icon(Icons.alternate_email),
                border: OutlineInputBorder(),)),
          SizedBox(height:20),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: 'Description',
                  hintText: 'Entrer la description',
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                  ),
            
            ),
            SizedBox(height:20),
            ElevatedButton(
                onPressed: isedit? updatedata:submitData, 
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isedit?'Update':'Submit'
                    ),
                )
            ),
            
        ],
      )
      
    );
  }

  Widget _gap() => const SizedBox(height: 16);


  Future<void> updatedata()async{
    final product = widget.product;
    //final id = product['id'];
    final ref= refController.text;
    final label= labelController.text;
    final description= descriptionController.text;
    //Envoie des données vers le server
    final body={"ref": ref,"label": label,"description": description};
    //Submit des données vers le server
    final url= 'http://localhost/dolibarr/api/index.php/products/';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers:{'Content-Type': 'application/json', 'DOLAPIKEY': '1xsrnA7XOLmS6w72348TZO2UyoonkVT4'},//Sometimes required
      ).then((value) => {  //is equal to if else down
        refController.text = "",
        labelController.text = "",
        descriptionController.text = "",
        showSuccesMessage('Création faite'),
        Product_list()
      }).catchError((onError) => {
        print(onError),
      showFailedMessage('Création faite') 
      });

  }

  Future<void> submitData()async{
    //Récupèration des valeurs du formulaire
    final ref= refController.text;
    final label= labelController.text;
    final description= descriptionController.text;
    //Envoie des données vers le server
    final body={"ref": ref,"label": label,"description": description};
    //Submit des données vers le server
    final url= 'http://localhost/dolibarr/api/index.php/products';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers:{'Content-Type': 'application/json', 'DOLAPIKEY': '1xsrnA7XOLmS6w72348TZO2UyoonkVT4'},//Sometimes required
      ).then((value) => {  //is equal to if else down
        refController.text = "",
        labelController.text = "",
        descriptionController.text = "",
        showSuccesMessage('Création réussi') ,
      }).catchError((onError) => {
        print(onError),
      showFailedMessage('Création failed') 
      });
       /*if (response.statusCode == 200) {
      //Reset des valeurs du formulaire initialisation avec les chaines vides: 
      labelController.text='';descriptionController.text='';
      
    print('Création faite'); ou aplpel de showSuccess
    ShowSuccessMessage('Création faite')  
    
    }else{
      print('Création échouée');
      print(response.statusCode);
      ShowFailedMessage('Création faite')  
    }*/

  }

  void showSuccesMessage(String message){
    final alert = SnackBar(content: Text(message),
                  backgroundColor: Color.fromARGB(255, 0, 223, 56),);
    ScaffoldMessenger.of(context).showSnackBar(alert);
  }
  void showFailedMessage(String message){
    final alert = SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                  );
    ScaffoldMessenger.of(context).showSnackBar(alert);
  }
}