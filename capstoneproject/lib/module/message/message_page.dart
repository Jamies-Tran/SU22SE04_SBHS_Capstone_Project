import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text(
          'Chat',
          style: TextStyle(
              fontFamily: "Sofia",
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 29.5,
              wordSpacing: 0.1),
        ),
        actions: const <Widget>[],
      ),
      body: Stack(
        children: <Widget>[
          Stack(
            children: [
              Image.asset(
                "assets/image/destinationPopuler/destination1.png",
                height: _height,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 210.0,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          blurRadius: 20.0,
                          color: Colors.black12.withOpacity(0.08))
                    ]),
                    child: Column(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 13.0, bottom: 10.0),
                          child: Text(
                            'Book It Go',
                            style: TextStyle(
                                fontFamily: "Sofia",
                                fontSize: 23.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Text(
                            "Our bots are very happy to help you through your difficulties if you have any questions, our bots will help you",
                            style: TextStyle(
                              color: Colors.black26,
                              fontFamily: "Sofia",
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(PageRouteBuilder(
                            //     pageBuilder: (_, __, ___) => chatBot()));
                          },
                          child: Container(
                            height: 45.0,
                            width: 180.0,
                            color: const Color(0xFF09314F),
                            child: const Center(
                              child: Text(
                                "Start Chatting",
                                style: TextStyle(
                                    color: Colors.white, fontFamily: "Sofia"),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
