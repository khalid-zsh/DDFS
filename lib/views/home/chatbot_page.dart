import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';

void showChatDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Tawk(
            directChatLink: 'https://tawk.to/chat/67dafcd328a175191aa7423d/1imnmn6vb',
            visitor: TawkVisitor(
              name: 'DDFS',
              email: 'eyeshotkhalid@gmail.com',
            ),
            onLoad: () {
              debugPrint("Tawk Chat Loaded");
            },
            onLinkTap: (String url) {
              debugPrint("User tapped on: $url");
            },
          ),
        ),
      );
    },
  );
}
