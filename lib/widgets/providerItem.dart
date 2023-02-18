import 'package:flutter/material.dart';
import 'package:mobile_dolibarr/controllers/provider.dart';


class ProviderItem extends StatefulWidget {
  const ProviderItem({Key? key}) : super(key: key);

  @override
  State<ProviderItem> createState() => _ProviderItemState();
}


class _ProviderItemState extends State<ProviderItem> {
  late Future providers;

  @override
  void initState() {
    super.initState();
    providers = getProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: providers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data['code']! == 200) {
                 return Container(
                   child: ListView.builder(
                     itemCount: snapshot.data['data']!.length,
                     itemBuilder: (BuildContext context, int index) {
                       final item = snapshot.data['data']![index];
                       return Container(
                         height: 136,
                         margin:
                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                         decoration: BoxDecoration(
                             border: Border.all(color: const Color(0xFFE0E0E0)),
                             borderRadius: BorderRadius.circular(8.0)),
                         padding: const EdgeInsets.all(8),
                         child: Row(
                           children: [
                             Expanded(
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(
                                       item['name'],
                                       style: const TextStyle(fontWeight: FontWeight.bold),
                                       maxLines: 2,
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                     const SizedBox(height: 8),
                                     Text("test · test",
                                         style: Theme.of(context).textTheme.bodySmall),
                                     const SizedBox(height: 8),

                                   ],
                                 )),
                             Container(
                                 width: 100,
                                 height: 100,
                                 decoration: BoxDecoration(
                                     color: Colors.grey,
                                     borderRadius: BorderRadius.circular(8.0),
                                 )),
                           ],
                         ),
                       );
                     },
                   ),
                );
              } else {
                return Text("no item to render");
              }
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
    ));
  }
}
