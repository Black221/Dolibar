import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mobile_dolibarr/screens/Productitems.dart';
import 'package:mobile_dolibarr/screens/addProduct.dart';
import 'package:mobile_dolibarr/screens/Productdetail.dart';
import 'package:http/http.dart' as http;

class Product_list extends StatefulWidget {
  const Product_list({super.key});

  @override
  State<Product_list> createState() => _Product_listState();
}

class _Product_listState extends State<Product_list> {
  bool isloading = false;
  late Future  data;
  List  item = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=fetchProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( 
          title: Text('Liste des produits'),
          
          actions:<Widget> [
          IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
          onPressed: navigateToAddProcuct,
          // label:Text('Add Product') //faire une icon
              )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Rechercher....",
                  hintStyle: TextStyle(color: Colors.white),
                  fillColor: Color.fromARGB(255, 163, 228, 239),
                  border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),
          ),
          ),
        body:FutureBuilder(
          future: data,
          builder:(context, snapshot) {
            if(snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: ((context,int index){
                    final item = snapshot.data[index] as Map;
                  // Divider(height: 40, color: Color.fromARGB(255, 2, 63, 194));
                  return  Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top:0, bottom:20),
                      child: Column(
                        children:<Widget>[ Visibility(
                          visible: isloading,
                          child: Center(child: CircularProgressIndicator()),// logo de rafraichissement 
                            replacement:RefreshIndicator(
                            onRefresh: fetchProduct,//rfraichir
                            child: ListTile(
                                leading: CircleAvatar(
                                  child: Text('${index+1}'),
                                  
                                  ),//affiche des number devant les produits
                                title: Text(
                                  "${snapshot.data[index]['label']}",
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 119, 255) )
                                  ),
                                 subtitle:Text("${snapshot.data[index]['label']}"),
                                 trailing: PopupMenuButton(
                                      //implementation des methodes qui disent quelle est le bouton qui a été selection pur delete or edti
                                      onSelected:(value){
                                        if (value =='edit') {
                                          //open the edit page
                                           navigateToEditPage(item);
                                        }else if (value =='delete') {
                                          //open the delete page and rafraichi la page
                                          //popupdialog
                                          // onTap(){
                                            // Get.defaultDialog(
                                            //   title: "Are you sure you want to delete",
                                            //   content: Container(),
                                            //   textConfirm: "Confirm",
                                            //   textCancel: "Cancel",
                                            //   confirmTextColor: Color.fromARGB(255, 6, 2, 2),
                                              // onConfirm: (){
                                                deleteById(){}
                                              //   }
                                            // );
                                          // }
                                        }
                                      },
                                      itemBuilder: (context){//pop up menu button : --> edit delete
                                        return[
                                          PopupMenuItem(child: Text('edit'),
                                          value: 'edit',//methode de d'edit
                                          ),
                                          PopupMenuItem(child: Text('delete'),
                                          value: 'delete',//methode de d'edit
                                          ),
                                        ];
                                      },
                                    ),
                            ),
                          ),
                        ),]
                      ),
                    ),
                  );
              }));
            } else{
              return Text("Bachirlb");
            
            }
          },
        ),
    );
  }

  Future<void> navigateToAddProcuct() async {// Refresh after adding futre<>...async--> await
    final route =MaterialPageRoute(
      builder: (context)=>AddProduct()
    );
    await Navigator.push(context, route);
    //Change moi la page avec setstate
    setState(() {
      isloading=false;
    });
    fetchProduct();
  }
  void navigateToEditPage(Map item) {
    final route =MaterialPageRoute(
      builder: (context)=>AddProduct(product:item)// qd on clique sur le bouton edit on va donner l'id à la page add
    );
    Navigator.push(context, route);
  }

  // deleteById(String id)async{
  //   // delete the id
  //   final url ='http://localhost/dolibarr/api/index.php/products/$id';
  //   final uri=Uri.parse(url);
  //   final response = await http.delete(uri);
  //   if (response.statusCode == 200) {
  //   //remove the id from the list
  //   final nodeleted = data.where((element) => element['_id'] != id).toList();
  //     setState(() {
  //       data = nodeleted;
  //     });
  //   } else {
  //     showFailedMessage('Delete failed');
  //   }
  // }
  //Getting data from the server
  Future fetchProduct() async {
    final url = "http://localhost/dolibarr/api/index.php/products";
    final uri = Uri.parse(url);
    final response = await http.get(uri,
      headers:{'Content-Type': 'application/json', 'DOLAPIKEY': '1xsrnA7XOLmS6w72348TZO2UyoonkVT4'},//Sometimes required
    ); // pas besoin de body car juste affichege
  
      //print(response.statusCode);
      //print(response.body);
    if (response.statusCode == 200) {
        return jsonDecode(response.body) ;
        
    }  
      // setState(() { Comment actualiser directement les données
      //   isloading = true ;
      // }); 
  }

  
  void showFailedMessage(String message){
    final alert = SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.red,
                  );
    ScaffoldMessenger.of(context).showSnackBar(alert);
  }
}

