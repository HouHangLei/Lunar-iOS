# Lunar-iOS

[![Version](https://img.shields.io/cocoapods/v/Lunar-iOS.svg?style=flat)](https://cocoapods.org/pods/Lunar-iOS)
[![Platform](https://img.shields.io/cocoapods/p/Lunar-iOS.svg?style=flat)](https://cocoapods.org/pods/Lunar-iOS)
[![SwiftVersion](https://camo.githubusercontent.com/dbc1086c1003cfafe358963c7358842813aa12e74f7a5b58769abd3b0ca45fe3/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f53776966742d342e302532422d6f72616e67652e737667)]()
[![iOSVersion](https://camo.githubusercontent.com/17f58f43c71c652239f1c8bbb766c562812841b0b1fbc03905b8913b35b9128b/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f694f532d382e302532422d626c75652e737667)]()

## 介绍

基于[Lunar](https://6tail.cn/calendar/api.html)封装的iOS版本，支持`Objective-C`和`Swift`。

## 示例

#### 对象初始化方法（例，阴历对象）

```javascript
// Lunar
var d = Lunar.fromYmd(1986, 4, 21);
// Swift
var d = Lunar(year: 1986, month: 4, day: 21)
// OC
Lunar *d = [[Lunar alloc] initWithYear:1986 month:4 day:21];
```

#### 调用方法（方法名和Lunar中一样）

```javascript
// Lunar
var d = Lunar.fromYmd(1986, 4, 21);
d.toFullString()
// Swift
var d = Lunar(year: 1986, month: 4, day: 21)
d.toFullString()
// OC
Lunar *d = [[Lunar alloc] initWithYear:1986 month:4 day:21];
[d toFullString];
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

Lunar-iOS is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Lunar-iOS'
```

## License

Lunar-iOS is available under the MIT license. See the LICENSE file for more info.
