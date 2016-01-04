# Silo

Silo is a extremely easy to use and very basic image loader for iOS built in Swift.

if you use Silo in your project please let me know!

![alt tag](https://i.imgur.com/g7BimCx.gif)

### Version
2.0

### Installation

Download from [here] [dld]
- import the Swift Files

Just drag and drop both Silo and SiloExt files.

### Usage

##### If you are using AutoLayout please call after the view appears or in ViewDidAppear method

#### UIImageView from storyboard
```swift
imageView.toSiloView(String)
imageView.toSiloView(String, loaderColor: UIColor)

//Set loader color after initialization
imageView.setLoaderColorForSiloView(UIColor.redColor())
```

#### Initialize a new UIImageView
```swift
   UIImageView(withUrl: String, frame: CGRect)
   UIImageView(withUrl: String, loaderColor: UIColor, frame: CGRect)
```

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)


   [dld]: <https://github.com/josejuanqm/Silo/blob/master/V2/SiloiOS.zip?raw=true>


