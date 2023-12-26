import 'package:flutter/material.dart';

class ZoomablePhoto extends StatelessWidget {
  final String imageUrl;

  ZoomablePhoto({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.cancel,
            color: Colors.black,
            size: 30,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          child: Center(
            child: Image.network(
              imageUrl,
              scale: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
