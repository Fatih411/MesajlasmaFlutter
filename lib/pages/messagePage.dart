import 'package:flutter/material.dart';
import 'package:flutter_haberlesme/contants/contants.dart';
import 'package:flutter_haberlesme/model/message.dart';
import 'package:flutter_haberlesme/services/message.dart';

class MessagePage extends StatefulWidget {
  final String title;
  final int getId;
  final int pushId;
  const MessagePage({
    Key? key,
    required this.title,
    required this.getId,
    required this.pushId,
  }) : super(key: key);
  @override
  State<MessagePage> createState() => _MessagePageState();
}

late List<MessageModel> messageList;
TextEditingController _textController = TextEditingController();
late final double hegiht;

class _MessagePageState extends State<MessagePage> {
  @override
  void initState() {
    super.initState();
    messageList = <MessageModel>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new)),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 6.0, right: 3.0),
                child: Icon(
                  Icons.account_circle_rounded,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple.shade700,
        title: Text(
          widget.title.toUpperCase(),
          style: Contants.containertTextStyle(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.deepPurpleAccent.shade700,
              Colors.blue.shade900
            ])),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: MessageServices.getMessage(widget.pushId, widget.getId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    messageList = snapshot.data!;
                    return ListView.builder(
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        if (messageList[index].mesajAlanId == widget.pushId) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 100),
                            child: Container(
                              height:
                                  messageList[index].mesajIcerik!.length <= 20
                                      ? 50
                                      : messageList[index].mesajIcerik!.length *
                                          1.1,
                              width: 50,
                              color: Colors.transparent.withOpacity(0.2),
                              child: Text(
                                messageList[index].mesajIcerik!,
                                style: Contants.containertTextStyle(),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 100),
                            child: Container(
                                width: 50,
                                height:
                                    messageList[index].mesajIcerik!.length <= 20
                                        ? 50
                                        : messageList[index]
                                                .mesajIcerik!
                                                .length *
                                            1.1,
                                color: Colors.white.withOpacity(0.2),
                                child: Text(
                                  messageList[index].mesajIcerik!,
                                  textAlign: TextAlign.end,
                                  style: Contants.containertTextStyle(),
                                )),
                          );
                        }
                      },
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: "Mesaj yaz",
                          hintStyle: Contants.containertTextStyle()),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      debugPrint(_textController.text);
                      setState(() {
                        MessageServices.addMessage(
                            widget.pushId, widget.getId, _textController.text);
                        _textController.text = "";
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
