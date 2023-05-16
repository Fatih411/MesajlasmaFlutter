// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_haberlesme/contants/contants.dart';
import 'package:flutter_haberlesme/model/usersModel';
import 'package:flutter_haberlesme/pages/messagePage.dart';
import 'package:flutter_haberlesme/services/usersServices.dart';

//kisileri sayfasi
class Users extends StatefulWidget {
  final String title;
  final int getId;
  const Users({
    Key? key,
    required this.title,
    required this.getId,
  }) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

late List<UserModel> iUsers;
late List<UserModel> addUsers;

class _UsersState extends State<Users> {
  @override
  void initState() {
    super.initState();
    iUsers = <UserModel>[];
    addUsers = <UserModel>[];
  }

  @override
  Widget build(BuildContext context) {
    UserServices.loginUsers(widget.getId);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => UsersAlertDialog(getId: widget.getId),
            );
          },
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              )),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title.toString(),
          style: Contants.titletTextStyle(),
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return FutureBuilder(
      future: UserServices.loginUsers(widget.getId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          iUsers = snapshot.data!;
          return ListView.builder(
            itemCount: iUsers.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  debugPrint("getId : ${widget.getId}");
                  debugPrint("1. ${iUsers[index].id}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessagePage(
                          title: iUsers[index].isim.toString(),
                          getId: iUsers[index].id!,
                          pushId: widget.getId,
                        ),
                      ));
                },
                child: ListTile(
                  tileColor: Contants.titleColor(index),
                  title: Text("${iUsers[index].isim} ${iUsers[index].soyad}"),
                ),
              );
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class UsersAlertDialog extends StatelessWidget {
  final int getId;
  const UsersAlertDialog({
    Key? key,
    required this.getId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserServices.allUsers(getId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          addUsers = snapshot.data!;
          return AlertDialog(
            title: Text('Sohbet Başlat'),
            content: Container(
              width: double.maxFinite,
              height: 300.0,
              child: ListView.builder(
                itemCount: addUsers.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessagePage(
                              title: addUsers[i].isim.toString(),
                              getId: addUsers[i].id!,
                              pushId: getId,
                            ),
                          ));
                    },
                    child: ListTile(
                      title: Text('${addUsers[i].isim} ${addUsers[i].soyad}'),
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                child: Text('Kapat'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
