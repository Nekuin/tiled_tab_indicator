# tiled_tab_indicator / Tiled Tab Indicator

TiledTabIndicator is a tab indicator with multiple colored tiles in a line.

<img src="https://media.giphy.com/media/QUIefume8b1nSpKHBa/giphy.gif"/>

## Getting Started

Add this to your package's 'pubspec.yaml' file:

```
´´´
dependencies:
    tiled_tab_indicator: ^1.0.1
```

Now in your Dart code, you can import like this:

```
import 'package:tiled_tab_indicator/tiled_tab_indicator.dart';
```

# Usage

You can use it just like the UnderlineTabIndicator:

```dart
    TabBar(
        indicator: TiledTabIndicator(
            indicatorHeight: 5,
            colors: [
                Color(0xff655dfc),
                Color(0xff5174fa),
                Color(0xff3299fc),
                Color(0xff3dc9de),
            ],
            style: TiledIndicatorStyle.normal, // or .round
        ),
        indicatorSize: TabBarIndicatorSize.tab, // TiledTabIndicator will change size
                                                // just like UnderlineTabIndicator
                                                // if you'd use .label here
    ),
    tabs: [
        Tab(text: "Tab1"),
        Tab(text: "Tab2"),
    ],
    ...
```
