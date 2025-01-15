import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaginationScrollController {
  late ScrollController scrollController;
  bool isLoading = false;
  bool stopLoading = false;
  int currentPage = 1;
  double boundaryOffset = 0.5;
  late Function loadAction;

  void init({Function? initAction, required Function loadAction}) {
    if (initAction != null) {
      initAction();
    }
    this.loadAction = loadAction;
    scrollController = ScrollController()..addListener(scrollListener);
  }

  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
  }

  void scrollListener() {
    if (!stopLoading && !isLoading) {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        // User is scrolling down
        if (scrollController.offset >=
            scrollController.position.maxScrollExtent * boundaryOffset) {
          isLoading = true;
          loadAction().then((shouldStop) {
            isLoading = false;
            currentPage++;
            boundaryOffset = 1 - 1 / (currentPage * 2);
            if (shouldStop == true) {
              stopLoading = true;
            }
          });
        }
      }
    }
  }
}
