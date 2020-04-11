# Introduction 
Tutorial on mobx and I've made some additional changes :

- Moved to ListView.builder

- Gestures

- [Source] - https://circleci.com/blog/state-management-for-flutter-apps-with-mobx/

- retired the fade on scroll stuff (this needs more work!)

```Dart
children: <Widget>[
    FadeOnScroll(
        scrollController: scrollController,
        fullOpacityOffset: 50,
        zeroOpacityOffset: 105,
        child: InfoCard(
            infoValue: _numberOfReviews,
            infoLabel: "reviews",
            cardColor: Colors.green,
            iconData: Icons.comment)),
```


