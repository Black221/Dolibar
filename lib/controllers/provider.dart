import 'dart:convert';

import 'package:http/http.dart' as http;

Future getProvider  () async {
  var response = await http.get(Uri.parse( "http://localhost:8080/dolibarr/api/index.php/thirdparties"), headers: {'Accept': 'application/json', 'DOLAPIKEY': 'lhackerskey'});
  if (response.statusCode == 200) {
    return {'code': 200, 'data': jsonDecode(response.body), 'msg': "All are done"};
  } else {
    return {'code': 400, 'data': null, 'msg': "Impossible to get item"};
  }
}

Future getProviderById  (id) async {
  var headers = {"Accept": "application/json", "DOLAPIKEY": "lhackerskey"};
  var response = await http.get(Uri.parse( "http://localhost:8080/dolibarr/api/index.php/thirdparties/"+id),
      headers: headers
  );
  if (response.statusCode == 200) {
    return {'code': 200, 'data': jsonDecode(response.body), 'msg': "All are done"};
  } else {
    return {'code': 400, 'data': null, 'msg': "Impossible to get item"};
  }
}

Future addProvider (name, description) async {
  try {
    var headers = {"Accept: application/json", "DOLAPIKEY: lhackerskey", 'Content-Type: application/json'};
    var response = await http.post(Uri.parse("http://localhost:8080/dolibarr/api/index.php/thirdparties?DOLAPIKEY=lhackerskey"), body: jsonEncode({
      "name": name,
    }),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'DOLAPIKEY': 'lhackerskey'}
    );
    print(response.statusCode);
    if (response.statusCode == 200) {

      return {'code': 200, 'data': jsonDecode(response.body), 'msg': "All are done"};
    } else {
      return {'code': 400, 'data': null, 'msg': "Impossible to get item"};
    }
  } catch (e) {
    print(e);

    return {"code": 500,'data': null, 'msg': "Impossible to get item"};
  }
}