import 'dart:convert';

import 'package:hotelbooking/models/photos.dart';
import 'package:http/http.dart' as http;

import 'clients_services.dart';

class RoomsServices{
  final String url = ClientsServices().mainurl;

  getRoomPhotos(int id)async{
    String path = "http://$url/api/Photos?id=$id";

    http.Response response = await http.get(Uri.parse(path));
    try{
      if(response.statusCode == 200){
        List<dynamic> body = jsonDecode(response.body);
        List<Photo> photos = body.map((photos) => Photo.fromJson(photos)).toList();
        return photos;
      }
    }
    catch(e){
      print(e);
    }
  }



  getHotelId(int id) async{
    String path = "http://$url/api/Rooms/$id";
    http.Response response = await http.get(Uri.parse(path));
    try{
      if(response.statusCode == 200){
        Map<String, dynamic> body = jsonDecode(response.body);
        return body['hotelid'];
      }
    }
    catch(e){
      print(e);
    }
  }

  addRoom(double cost,String name, int hotelid)async{
    String path = "http://$url/api/Rooms";

    var json = {
      "hotelid" : hotelid,
      "type" : name,
      "cost" : cost,
      "time" : ""
    };
    var body = jsonEncode(json);
    http.Response response = await http.post(Uri.parse(path),body: body,headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200){
      print('done');
      Map<String, dynamic> body = jsonDecode(response.body);
      return body['roomid'];
    }
  }


  // addRoomImage(String path)async{
  //   String path = "http://$url/api/Rooms/$id";
  // }
}