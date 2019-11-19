import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pull_refresh/user.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  RefreshController _refreshController ;

  List<User> _users=[];
  int numpage=1;


  Future<http.Response> getlist(int pageno) async{
    http.Response responseurl=await http.get("http://www.json-generator.com/api/json/get/ceDTBYcMEi?indent=$pageno");
//    if(responseurl.statusCode==200){
//      var jsonData=json.decode(responseurl.body);
//      for(var userinfo in jsonData){
//        User _user=User(userinfo['index'],userinfo['about'] ,userinfo['picture'] ,userinfo['email'] ,userinfo['name']);
//        _users.add(_user);
//      }
//      return _users;
//    }
//    else
//      return throw new Exception();
  return responseurl;
  }
  void _onRefresh() {
    _users=[];
    numpage=1;
    getlist(numpage).then((res){
      setState(() {
        addToUserList(json.decode(res.body));
      });
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() {
    numpage++;
    getlist(numpage).then((res){
      setState(() {
        addToUserList(json.decode(res.body));
      });
    });
//    getlist(numpage).then((res)=>addToUserList(json.decode(res.body)));
//        var jsonData=json.decode(res.body);
//        for(var userinfo in jsonData){
//          User _user=User(userinfo['index'],userinfo['about'] ,userinfo['picture'] ,userinfo['email'] ,userinfo['name']);
//          _users.add(_user);
//        }

    _refreshController.loadComplete();

  }

  void addToUserList(jData){
    for(var userinfo in jData){
      User _user=User(userinfo['index'],userinfo['about'] ,userinfo['picture'] ,userinfo['email'] ,userinfo['name']);
      _users.add(_user);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController=RefreshController(initialRefresh: true);
//    getlist(numpage).then((res){
//      var jsonData=json.decode(res.body);
//      for(var userinfo in jsonData){
//        User _user=User(userinfo['index'],userinfo['about'] ,userinfo['picture'] ,userinfo['email'] ,userinfo['name']);
//        _users.add(_user);
//      }
//    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pull to Refresh"),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("pull up load");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("Load Failed!Click retry!");
            }
            else if(mode == LoadStatus.canLoading){
              body = Text("release to load more");
            }
            else{
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (BuildContext context,int index){

            return Container(
              // color: Colors.yellow,
              padding: EdgeInsets.only(left:4.0,right: 4.0),
              child: Card(
                elevation: 5.0,
                color: Colors.lightGreenAccent,
                shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)
                ) ,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_users[index].picture),
                  ),
                  title: Text("${_users[index].name}"),
                  subtitle: Text("${_users[index].email}"),
                  onTap: (){
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(snapshot.data[index])));
                  },
                ),
              ),
            );
          },
        ),
//        child: FutureBuilder(
//          future: getlist(numpage),
//            builder: (BuildContext context,AsyncSnapshot snapshot){
//          if(snapshot.data==null){
//            return Container(
//              child: Center(
//                child: Text("Loading...",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
//              ),
//            );
//          }
//          else{
//            return ListView.builder(
//              itemCount: snapshot.data.length,
//                itemBuilder: (BuildContext context,int index){
//                return Container(
//                 // color: Colors.yellow,
//                  padding: EdgeInsets.only(left:4.0,right: 4.0),
//                  child: Card(
//                    elevation: 5.0,
//                    color: Colors.pink,
//                    shape:RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10.0)
//                    ) ,
//                    child: ListTile(
//                      leading: CircleAvatar(
//                        backgroundImage: NetworkImage(snapshot.data[index].picture),
//                      ),
//                      title: Text("${snapshot.data[index].name}"),
//                      subtitle: Text("${snapshot.data[index].email}"),
//                      onTap: (){
//                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(snapshot.data[index])));
//                      },
//                    ),
//                  ),
//                );
//                },
//            );
//          }
//            }
//        )
      ),
    );
  }
}
