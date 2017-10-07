# PVOnboardKit

![][10] ![][11] ![][12]

PVOnboardKit is a framework that allows you to add your own walkthrough/intro/tutorial into your app. As main concept uses [**UITableView**][1]. Also, for more customization [**PVOnboardKit**][2] uses [**TAPageControl**][3] instead of [**UIPageControl**][4].

![Demo!](http://i.imgur.com/yvcI91a.gif)

# Requirements
Xcode 9. Ready for use on iOS 8+

# Install
Adding the following to your Podfile and running pod install should do the trick:
```
pod 'PVOnboardKit'
```

1. Import [PVOnboardKit][2]
1. Create [PVOnboardView][7] and add to your view
1. Implement [PVOnboardViewDelegate][8] and [PVOnboardViewDataSource][9] and assign to instance of [PVOnboardView][7]
1. Call reloadData from instance of [PVOnboardView][7]
1. Enjoy 😎

# Thanks

Thank @TanguyAladenise for [**TAPageControl**][3].

# Community

Questions, comments, issues, and pull requests are always welcome!

# License

Distributed under the MIT license. See LICENSE for more information.

[1]: https://developer.apple.com/reference/uikit/uitableview
[2]: https://github.com/vpeschenkov/PVOnboardKit
[3]: https://github.com/TanguyAladenise/TAPageControl
[4]: https://developer.apple.com/reference/uikit/uipagecontrol
[5]: https://github.com/CocoaPods/Specs
[6]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardPage.h
[7]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L44
[8]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L125
[9]: https://github.com/vpeschenkov/PVOnboardKit/blob/master/PVOnboardKit/PVOnboardView.h#L150
[10]: https://travis-ci.org/vpeschenkov/PVOnboardKit.svg?branch=master
[11]: https://cocoapod-badges.herokuapp.com/v/PVOnboardKit/badge.png
[12]: https://cocoapod-badges.herokuapp.com/p/PVOnboardKit/badge.png
