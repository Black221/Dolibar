  import 'package:flutter/material.dart';
import 'package:mobile_dolibarr/widgets/providerItem.dart';

import 'addProviders.dart';


class ProviderScreen extends StatefulWidget {
    const ProviderScreen({super.key});

    @override
    State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController logoController = TextEditingController();

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(255,38, 60, 92),
              leading: Image.asset("images/doligo.png"),
              title: const Text('Fournisseurs', selectionColor: Colors.white,),
            ),
            body: const ProviderItem(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255,38, 60, 92),
                child:const Icon( Icons.add, ),
                onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const AddProviderScreen()));
                },
            ),
        );
    }
}