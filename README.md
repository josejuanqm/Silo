# Silo (under development)

Silo is a extremly easy to use and very basic image loader for Swift.

![alt tag](https://i.imgur.com/g7BimCx.gif)

### Version
1.0

### Installation

Download from [here] [dld]
- import the framework
```swift
import SiloView
```

- Properties
```swift
let Silo = SiloImageView(frame: self.view.bounds)
self.view.addSubview(Silo)
Silo.imageContentMode = .ScaleAspectFit
Silo.loaderColor = UIColor.redColor()
Silo.fetchUrl("http://images.apple.com/v/ipad-pro/c/images/overview/canvas_large_2x.jpg")
```

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dld]: <https://github.com/josejuanqm/Silo/blob/master/SiloView.framework.zip?raw=true>


