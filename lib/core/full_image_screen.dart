import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FullImageScreen extends StatefulWidget {
  final String imagePath, imageTag;
  final int? backgroundOpacity;

  const FullImageScreen(
      {Key? key, required this.imagePath, required this.imageTag, this.backgroundOpacity})
      : super(key: key);

  @override
  _FullImageScreenState createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  late TransformationController _transformationController;
  TapDownDetails? tapDownDetails;
  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      onDoubleTap: () {
        // Fluttertoast.showToast(
        //   msg: "Pinch to Zoom",
        //   toastLength: Toast.LENGTH_SHORT,
        //   fontSize: 18.0,
        // );
      },
      //  onDoubleTap: () {
      //   final position = tapDownDetails!.localPosition;
      //   final double scale = 3;
      //   final x = -position.dx * (scale - 1);
      //   final y = -position.dy * (scale-1.5);
      //   final zoomed = Matrix4.identity()
      //   ..translate(x,y)
      //   ..scale(scale);
      //   _transformationController.value = _transformationController.value.isIdentity()? zoomed : Matrix4.identity();
      // },
      // onDoubleTapDown: (details) => tapDownDetails = details,
      child: Scaffold(
        backgroundColor:
            Colors.black.withAlpha(widget.backgroundOpacity == null ? 220 : widget.backgroundOpacity!),
        body: Center(
          child: Hero(
            tag: widget.imageTag,
            child: InteractiveViewer(
              transformationController: _transformationController,
              panEnabled: true,
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 4,
              child: CachedNetworkImage(
                imageUrl: widget.imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
