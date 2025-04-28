import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class AnimatedAddToCart extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final VoidCallback onEnd;
  final String imageUrl;

  const AnimatedAddToCart({
    Key? key,
    required this.startPosition,
    required this.imageUrl,
    required this.endPosition,
    required this.onEnd,
  }) : super(key: key);

  @override
  _AnimatedAddToCartState createState() => _AnimatedAddToCartState();
}

class _AnimatedAddToCartState extends State<AnimatedAddToCart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 800), vsync: this);

    _positionAnimation = Tween<Offset>(
      begin: widget.startPosition,
      end: widget.endPosition,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward().whenComplete(widget.onEnd);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Positioned(
          left: _positionAnimation.value.dx,
          top: _positionAnimation.value.dy,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl ,
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          ),
        );
      },
    );
  }
}
