import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

import '../trackLocation/ui.dart';
import 'view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
ScrollController scrollController = ScrollController();

class ChatScreen extends StatefulWidget {
  final String pp;
  final List<String> groupMembers;
  ChatScreen({this.pp, this.groupMembers});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  User LInUser;
  String messageText;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      User hey = _auth.currentUser;
      if (hey != null) {
        LInUser = hey;
      }
    } catch (e) {
      print(e);
    }
  }

  sendMessageArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.location_city),
              iconSize: 25,
              color: Colors.pink,
              onPressed: () {
                //NewTransaction().build(context, groupMembers);
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (_) => HyperTrackQuickStart(),
                    fullscreenDialog: true));
              }),
          Expanded(
            child: TextField(
              controller: messageTextController,
              onChanged: (value) {
                messageText = value;
              },
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25,
            color: Colors.pink,
            onPressed: () {
              messageTextController.clear();
              _firestore.collection(widget.pp).add({
                'text': messageText,
                'sender': LInUser?.email,
                'time': DateTime.now().millisecondsSinceEpoch.toString(),
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.pp,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ViewScreen(
                      p: widget.pp,
                    ),
                  ),
                ),
                child: Icon(Icons.more_vert),
              )),
        ],
      ),
      body: Column(
        children: <Widget>[
          MessagesStream(
            LInUser: LInUser,
            pp: widget.pp,
          ),
          sendMessageArea(),
        ],
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  final User LInUser;
  final String pp;
  MessagesStream({this.LInUser, this.pp});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection(pp)
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink,
            ),
          );
        }
        // ignore: deprecated_member_use
        final messages = snapshot.data.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final currentUser = LInUser?.email;

          final messageBubble = MessageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text, this.isMe});

  final String sender;
  final String text;
  final bool isMe;

  _launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 0.5,
            color: isMe ? Colors.red[200] : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: RichText(
                  text: TextSpan(
                text: text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL(text);
                  },
              )),
            ),
          ),
        ],
      ),
    );
  }
}
