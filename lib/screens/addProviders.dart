

import 'dart:io';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dolibarr/controllers/provider.dart';
import 'package:mobile_dolibarr/screens/provider.dart';


class AddProviderScreen extends StatefulWidget {
  const AddProviderScreen({super.key});


  @override
  State<StatefulWidget> createState() => _AddProviderState();

}

class _AddProviderState extends State<AddProviderScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255,38, 60, 92),
        title:  Row(
          children: [
            Image.asset("images/doligo.png",height: 40,),
            const Text('Fournisseurs', selectionColor: Colors.white,),
          ],
        ),
      ),
        body: Center(
            child: isSmallScreen
                ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Container(
                      child: const Text("Ajouter un nouveau Fournisseur"),
                    ),
                    const _FormContent(),
                ],
            )
                : Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                      child: Row(
                        children: const [
                          Expanded(child: Text("Ajouter un nouveau Fournisseur")),
                          Expanded(
                            child: Center(child: _FormContent()),
                          ),
                      ],
                ),
            )));
  }
}

class CustomImageFormField extends StatelessWidget {
  CustomImageFormField(
      {Key? key, required this.validator, required this.onChanged,}) : super(key: key);
  final String? Function(File?) validator;
  final Function(File) onChanged;
  File? _pickedFile;
  @override
  Widget build(BuildContext context) {
    return FormField<File>(
        validator: validator,
        builder: (formFieldState) {
          return Column(
            children: [

              if (formFieldState.hasError)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 10),
                  child: Text(
                    formFieldState.errorText!,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 13,
                        color: Colors.red[700],
                        height: 0.5),
                  ),
                )
            ],
          );
        });
  }
}



class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() {
    return __FormContentState();
  }
}

class  __FormContentState extends State<_FormContent> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  XFile? uploadImage ;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  Future<void>  chooseImage() async {
    try {
       var chosenImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      //set source: ImageSource.camera to get image from camera
      setState(() {
        print(chosenImage?.mimeType);
        uploadImage = chosenImage;
        print(chosenImage as File);

      });
    } catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                _gap(),
                Container(  //show image here after choosing image
                    child:uploadImage == null ?
                    const Text("Hey"): //if uploadimage is null then show empty container
                    SizedBox(
                        height:150,
                        width: 150,
                        child:Image.file(uploadImage! as File) //load image from file
                    )
                ),
                _gap(),
                TextButton.icon(
                  onPressed: (){
                    chooseImage(); // call choose image function
                  },
                  icon:const Icon(Icons.folder_open),
                  label: const Text("Ajouter logo"),

                ),
                _gap(),
                TextFormField(
                  validator: (value) {

                  },
                  controller: name,
                  decoration: const InputDecoration(

                    labelText: 'Fournisseur',
                    hintText: 'Entrer le nom du fournisseur',
                    prefixIcon: Icon(Icons.people_rounded),
                    border: OutlineInputBorder(),
                  ),
                ),
                _gap(),
                TextFormField(
                  validator: (value) {

                  },
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Entrer la description',
                    prefixIcon: Icon(Icons.description),
                    border: OutlineInputBorder(),
                  ),
                ),
                _gap(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Ajouter',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        /// do something
                        print(name.text);
                        print(description.text);
                        addProvider(name.text, description.text).then((value) {
                          print("done");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProviderScreen()));
                        }).catchError((onError) {
                          print("sorry");
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          )
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}