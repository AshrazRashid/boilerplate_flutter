import 'package:flutter/material.dart';
import 'dart:math' as math;
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCurvedNavigationBar extends StatelessWidget {
  const CustomCurvedNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.red,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _CurvedPainter(),
                    size: Size(
                      size.width,
                      80,
                    ),
                  ),

                  //? floating action button

                  Center(
                    heightFactor: .0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(180)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xff0D6EFD),
                        elevation: 2.0,
                        onPressed: () {},
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),

                  //? icons

                  SizedBox(
                    height: 90,
                    // width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.home_outlined),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.heart_broken),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.verified_user),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCurvedNavigationWidget extends StatelessWidget {
  const CustomCurvedNavigationWidget(
      {super.key,
      required this.items,
      required this.onTap,
      this.selectedColor = const Color(0xff0D6EFD),
      this.unselectedColor = Colors.black,
      this.currentIndex = 0})
      : assert(
          items.length == 4,
          'The correct functioning of this widgets '
          'depends on its items being exactly 4',
        );

  final List<CurvedNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  // final int Function() onTap;
  final Color unselectedColor;
  final Color selectedColor;
  final int currentIndex;
  // final

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // ignore: sized_box_for_whitespace
    return Container(
      color: Colors.transparent,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 70,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _CurvedPainter(),
                    size: Size(
                      size.width,
                      80,
                    ),
                  ),

                  //? floating action button

                  Center(
                    heightFactor: .0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(180)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xff0D6EFD),
                        elevation: 2.0,
                        onPressed: () {},
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  ),

                  //? icons

                  SizedBox(
                    height: 90,
                    // width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(items.length, (index) {
                        final item = items[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: (index == 0 || index == 3) ? 20.0 : 0,
                          ),
                          child: IconButton(
                            onPressed: () => onTap?.call(index),
                            color: index == currentIndex
                                ? selectedColor
                                : unselectedColor,
                            icon: Icon(
                              index == currentIndex
                                  ? item.selectedIconData ?? item.iconData
                                  : item.iconData,
                            ),
                          ),
                        );
                      })
                        ..insert(2, SizedBox(width: size.width * 0.20)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//? Curved Navigation Bar Item

class CurvedNavigationBarItem {
  final IconData iconData;
  final IconData? selectedIconData;

  CurvedNavigationBarItem({required this.iconData, this.selectedIconData});
}

//? NavBar Clipper

class _CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint paint = Paint()
    //   ..color = Colors.red
    //   ..style = PaintingStyle.fill;

    // Path path = Path();
    // path.moveTo(0, 0); // Start
    // path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.3, 0);
    // path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 30);
    // path.arcToPoint(Offset(size.width * 0.60, 10),
    //     radius: const Radius.elliptical(5, 5), clockwise: false);
    // path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    // path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0); // -30
    // path.lineTo(size.width, size.height);
    // path.lineTo(0, size.height);
    // path.lineTo(0, -30);
    // canvas.drawShadow(path, Colors.black, 15, true);
    // canvas.drawPath(path, paint);

    Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.elliptical(6, 4), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, -30);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);

    // Paint for the drawer body
    // Paint paintLightGray = Paint()
    //   ..color = Colors.grey[300]!
    //   ..style = PaintingStyle.fill;

    // Paint for the handle
    // Paint paintDarkGray = Paint()
    //   ..color = Colors.grey[700]!
    //   ..style = PaintingStyle.fill;

    // // Path for the drawer body
    // Path pathBody = Path();
    // pathBody.moveTo(0, 0);
    // pathBody.quadraticBezierTo(size.width * 0.25, 0, size.width * 0.35, 0);
    // pathBody.quadraticBezierTo(size.width * 0.40, 20, size.width * 0.40, 30);
    // pathBody.arcToPoint(Offset(size.width * 0.60, 10),
    //     radius: const Radius.elliptical(5, 5), clockwise: false);
    // pathBody.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.8, 0);
    // pathBody.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    // pathBody.lineTo(size.width, size.height);
    // pathBody.lineTo(0, size.height);
    // pathBody.close(); // Close the path to fill the shape

    // Path for the handle
    // Path pathHandle = Path();
    // pathHandle.moveTo(size.width * 0.75, size.height * 0.20);
    // pathHandle.quadraticBezierTo(size.width * 0.80, size.height * 0.10,
    //     size.width * 0.85, size.height * 0.20);
    // pathHandle.lineTo(size.width * 0.85, size.height * 0.60);
    // pathHandle.quadraticBezierTo(size.width * 0.80, size.height * 0.70,
    //     size.width * 0.75, size.height * 0.60);
    // pathHandle.close();

    // Draw the drawer body
    // canvas.drawPath(pathBody, paintLightGray);

    // Draw the handle on top of the body
    // canvas.drawPath(pathHandle, paintDarkGray);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
