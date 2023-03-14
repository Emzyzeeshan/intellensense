import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/FullImageWidget.dart';
import '../Widgets/ProgressWidgets.dart';

class Chat extends StatelessWidget {
  final String receiverId;
  final String receiverAvatar;
  final String receiverName;
  Chat(
      {required this.receiverId,
      required this.receiverAvatar,
      required this.receiverName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.black,
              backgroundImage: CachedNetworkImageProvider(receiverAvatar),
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          receiverName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ChatScreen(receiverId: receiverId, receiverAvatar: receiverAvatar),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverAvatar;
  ChatScreen({
    required this.receiverId,
    required this.receiverAvatar,
  });
  @override
  State createState() =>
      ChatScreenState(receiverId: receiverId, receiverAvatar: receiverAvatar);
}

class ChatScreenState extends State<ChatScreen> {
  final String receiverId;
  final String receiverAvatar;
  ChatScreenState({
    required this.receiverId,
    required this.receiverAvatar,
  });
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  late bool isDisplaySticker;
  late bool isLoading;

  late File imageFile;
  late String imageUrl;

  late String chatId;
  late SharedPreferences preferences;
  late String id;
  var listMessage;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);

    isDisplaySticker = false;
    isLoading = false;

    chatId = "";

    readLocal();
  }

  readLocal() async {
    preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id") ?? "";

    if (id.hashCode <= receiverId.hashCode) {
      chatId = '$id-$receiverId';
    } else {
      chatId = '$receiverId-$id';
    }
    FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .update({'chattingWith': receiverId});

    setState(() {});
  }

  onFocusChange() {
    if (focusNode.hasFocus) {
      //hide stickers whenever keypad appears
      setState(() {
        isDisplaySticker = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              //create List of messages

              //Show sticker
              createListMessages(),
              //input Controller
              createInput(),
              (isDisplaySticker ? createSticker() : Container()),
            ],
          ),
          createLoading(),
        ],
      ),
      onWillPop: onBackPress,
    );
  }

  createLoading() {
    return Positioned(child: isLoading ? circularProgress() : Container());
  }

  Future<bool> onBackPress() {
    if (isDisplaySticker) {
      setState(() {
        isDisplaySticker = false;
      });
    } else {
      Navigator.pop(context);
    }
    return Future.value(false);
  }

  createSticker() {
    return Column(children: <Widget>[
      //1st Row
      Row(
        children: <Widget>[
          TextButton(
            onPressed: () => onSendMessage("mimi1", 2),
            child: Image.asset(
              'assets/ChatImg/mimi1.gif',
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
            onPressed: () => onSendMessage("mimi2", 2),
            child: Image.asset(
              'assets/ChatImg/mimi2.gif',
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          ),
          TextButton(
            onPressed: () => onSendMessage("mimi3", 2),
            child: Image.asset(
              'assets/ChatImg/mimi3.gif',
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),

      //2nd row
      Row(children: <Widget>[
        TextButton(
          onPressed: () => onSendMessage("mimi4", 2),
          child: Image.asset(
            'assets/ChatImg/mimi4.gif',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
        TextButton(
          onPressed: () => onSendMessage("mimi5", 2),
          child: Image.asset(
            'assets/ChatImg/mimi5.gif',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
        TextButton(
          onPressed: () => onSendMessage("mimi6", 2),
          child: Image.asset(
            'assets/ChatImg/mimi6.gif',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
      ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
      //3rd row
      Row(children: <Widget>[
        TextButton(
          onPressed: () => onSendMessage("mimi7", 2),
          child: Image.asset(
            'assets/ChatImg/mimi7.gif',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
        TextButton(
          onPressed: () => onSendMessage("mimi8", 2),
          child: Image.asset(
            'assets/ChatImg/mimi8.gif',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
        TextButton(
          onPressed: () => onSendMessage("mimi9", 2),
          child: Image.asset(
            'assets/ChatImg/mimi9.gif',
            width: 50.0,
            height: 50.0,
            fit: BoxFit.cover,
          ),
        ),
      ], mainAxisAlignment: MainAxisAlignment.spaceEvenly),
    ], mainAxisAlignment: MainAxisAlignment.spaceEvenly);
    /*decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );*/
  }

  void getSticker() {
    focusNode.unfocus();
    setState(() {
      isDisplaySticker = !isDisplaySticker;
    });
  }

  createListMessages() {
    return Flexible(
        child: chatId == "!"
            ? Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                ),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("message")
                    .doc(chatId)
                    .collection(chatId)
                    .orderBy("timestamp", descending: true)
                    .limit(20)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.lightBlueAccent),
                      ),
                    );
                  } else {
                    listMessage = snapshot.data.docs;
                    return ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) =>
                          createItem(index, snapshot.data.docs[index]),
                      itemCount: snapshot.data.docs.length,
                      reverse: true,
                      controller: listScrollController,
                    );
                  }
                },
              )
        /*child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
        ),
      ),*/
        );
  }

  bool isLastMsgRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]["idFrom"] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMsgLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1]["idFrom"] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget createItem(
    int index,
    DocumentSnapshot document,
  ) {
    //My message - Right Side
    if (document["idFrom"] == id) {
      return Row(
        children: <Widget>[
          document["type"] == 0
              //text
              ? Container(
                  child: Text(
                    document["content"],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  width: 200.0,
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: EdgeInsets.only(
                      bottom: isLastMsgRight(index) ? 20.0 : 10.0, right: 10.0),
                )
              //Image Msg
              : document["type"] == 1
                  ? Container(
                      child: TextButton(
                        child: Material(
                          child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightBlueAccent),
                              ),
                              width: 200.0,
                              height: 200.0,
                              padding: EdgeInsets.all(70.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            errorWidget: (context, url, error) => Material(
                              child: Image.asset(
                                "assets/images/img_not_available.jpeg",
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.hardEdge,
                            ),
                            imageUrl: document["content"],
                            width: 200.0,
                            height: 200.0,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      FullPhoto(url: document["content"])));
                        },
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    )
                  //Sticker .gif Msg
                  : Container(
                      child: Image.asset(
                        "assets/ChatImg/${document['content']}.gif",
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      ),
                      margin: EdgeInsets.only(
                          bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                          right: 10.0),
                    ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    }
    //Receiver message - Left Side
    else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                isLastMsgLeft(index)
                    ? Material(
                        //Display receiver profile Image
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.lightBlueAccent),
                            ),
                            width: 35.0,
                            height: 35.0,
                            padding: EdgeInsets.all(10.0),
                          ),
                          imageUrl: receiverAvatar,
                          width: 35.0,
                          height: 35.0,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        clipBehavior: Clip.hardEdge,
                      )
                    : Container(
                        width: 35.0,
                      ),
                document["type"] == 0
                    //text
                    ? Container(
                        child: Text(
                          document["content"],
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                        ),
                        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                        width: 200.0,
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    //Image Msg
                    : document["type"] == 1
                        ? Container(
                            child: TextButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.lightBlueAccent),
                                    ),
                                    width: 200.0,
                                    height: 200.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      "assets/images/img_not_available.jpeg",
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document["content"],
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document["content"])));
                              },
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        //Sticker .gif Msg
                        : Container(
                            child: Image.asset(
                              "assets/ChatImg/${document["content"]}.gif",
                              width: 100.0,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                            margin: EdgeInsets.only(
                                bottom: isLastMsgRight(index) ? 20.0 : 10.0,
                                right: 10.0),
                          ),
              ],
            ),
            //msg Time
            isLastMsgLeft(index)
                ? Container(
                    child: Text(
                      DateFormat("dd MMMM, yyyy - hh:mm:aa").format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(document["timestamp"]))),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic),
                    ),
                    margin: EdgeInsets.only(left: 60.0, top: 10.0, bottom: 0.0),
                  )
                : Container(
                  )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  createInput() {
    return Container(
      child: Row(
        children: <Widget>[
          //pick image icon button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                color: Colors.lightBlueAccent,
                onPressed: getImage,
              ),
            ),
            color: Colors.white,
          ),
          //emoji icon button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.face),
                color: Colors.lightBlueAccent,
                onPressed: getSticker,
              ),
            ),
            color: Colors.white,
          ),
          //Text Field
          Flexible(
            child: Container(
              child: TextField(
                controller: textEditingController,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
                //controller: TextEditingController.fromValue(""),
                decoration: InputDecoration.collapsed(
                    hintText: "Write Here...",
                    hintStyle: TextStyle(color: Colors.grey)),
                focusNode: focusNode,
              ),
            ),
          ),
          //send message icon button
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                color: Colors.lightBlueAccent,
                onPressed: () => onSendMessage(textEditingController.text, 0),
              ),
            ),
            color: Colors.white,
          )
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
          color: Colors.grey,
          width: 0.5,
        )),
        color: Colors.white,
      ),
    );
  }

  void onSendMessage(String contentMsg, int type) {
    //type = 0 its text msg
    //type = 1 its imageFile
    //type = 2 its sticker-emoji-gif
    if (contentMsg != "") {
      textEditingController.clear();

      var docref = FirebaseFirestore.instance
          .collection("message")
          .doc(chatId)
          .collection(chatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());
      FirebaseFirestore.instance.runTransaction((transaction) async {
        print(docref);
        await transaction.set(docref, {
          "idFrom": id,
          "idTo": receiverId,
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "content": contentMsg,
          "type": type,
        });
      });
      listScrollController.animateTo(0.0,
          duration: Duration(microseconds: 300), curve: Curves.easeInOut);
    } else {
      Fluttertoast.showToast(msg: "Empty Message. Can not be sent");
    }
  }

  Future getImage() async {
    var imageFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() => isLoading = true);
      uploadImageFile(File(imageFile.path));
    }
  }

  Future uploadImageFile(imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child("Chat Image").child(fileName);

    UploadTask storageUploadTask = storageReference.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await storageUploadTask.snapshot;

    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, 1);
      });
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: "Error: " + error);
    });
  }
}
