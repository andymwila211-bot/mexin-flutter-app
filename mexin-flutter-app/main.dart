import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamChatWrapper();
  }
}

class StreamChatWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamChat(
      apiKey: 'YOUR_STREAM_API_KEY',
      child: MaterialApp(
        title: 'Mexin Chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChatScreen(),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamChatClient client;
  late Channel channel;

  @override
  void initState() {
    super.initState();
    client = StreamChatClient('YOUR_STREAM_API_KEY');
    channel = client.channel('messaging', id: 'general');
    /// connect the client to the stream server.
    client.connectUser(
      User(
        id: 'user_id', // Replace with actual user ID
      ),
      'user_token', // Replace with actual user token
    );
    channel.watch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ChannelWidget(
              channel: channel,
              child: MessageListView(),
            ),
          ),
          MessageInput(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    client.disconnectUser();
    super.dispose();
  }
}
