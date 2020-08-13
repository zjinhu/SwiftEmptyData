# SwiftEmptyData

[![CI Status](https://img.shields.io/travis/jackiehu/SwiftEmptyData.svg?style=flat)](https://travis-ci.org/jackiehu/SwiftEmptyData)
[![Version](https://img.shields.io/cocoapods/v/SwiftEmptyData.svg?style=flat)](https://cocoapods.org/pods/SwiftEmptyData)
[![License](https://img.shields.io/cocoapods/l/SwiftEmptyData.svg?style=flat)](https://cocoapods.org/pods/SwiftEmptyData)
[![Platform](https://img.shields.io/cocoapods/p/SwiftEmptyData.svg?style=flat)](https://cocoapods.org/pods/SwiftEmptyData)



一个Swift语言封装的EmptyView显示库，可作用于UITableView、UICollectionView

## 用法

```ruby
tableView.emptyView = EmptyView.empty({ (config) in
//          config.firstReloadHidden = true
            config.emptyViewCanTouch = true
            config.offsetY = -100
            config.image = UIImage.init(named: "placeholder_tumblr")
            config.title = "sdfasd"
            config.detail = "asdasd"
            config.buttonTitle = "asdasdasd"
            config.buttonColor = .orange
            config.buttonSize = .init(width: 200, height: 50)
        }) {
            print("点击")
        }

collectionView?.emptyView = EmptyView.empty({ (config) in
            config.firstReloadHidden = true
            config.image = UIImage.init(named: "placeholder_tumblr")
            config.title = "暂无"
            config.detail = "------------"
        })
```



## 适配器参数

```ruby
public class EmptyConfig {
    //用于请求网络前Reload时暂时隐藏emptyView ,网络回来后会根据当前的tableView/collectionView的 DataSource来自动判断是否显示emptyView,不请求网络默认为false
    public var firstReloadHidden = false
    /// 内容视图的偏移量
    public var offsetY : CGFloat = 0
    ///整个遮罩层的背景色
    public var emptyViewColor : UIColor = .clear
    /// 内容区域是否可点击
    public var emptyViewCanTouch = false
    /// 图片
    public var image : UIImage?
    /// 自定义图片size
    public var imageSize : CGSize?
    /// title到图片间距
    public var titleSpace : CGFloat = 5
    /// 标题
    public var title : String?
    /// 标题字体
    public var titleFont : UIFont = .systemFont(ofSize: 30)
    /// 标题颜色
    public var titleColor : UIColor = .black
    /// 副标题到标题间距
    public var detailSpace : CGFloat = 5
    /// 副标题
    public var detail : String?
    /// 副标题字体
    public var detailFont : UIFont = .systemFont(ofSize: 14)
    /// 副标题颜色
    public var detailColor : UIColor = .lightGray
    /// 按钮到副标题间距
    public var buttonSpace : CGFloat = 5
    /// 按钮标题
    public var buttonTitle : String?
    /// 按钮字体颜色
    public var buttonFont : UIFont = .systemFont(ofSize: 15)
    /// 按钮标题颜色
    public var buttonTitleColor : UIColor = .lightGray
    /// 按钮宽高
    public var buttonSize : CGSize?
    /// 按钮圆角
    public var buttonRadius : CGFloat = 5
    /// 按钮背景色
    public var buttonColor : UIColor = .clear
}
```

如果不喜欢内置的布局可以直接重写或者自定义视图添加到EmptyView上

## 安装

SwiftEmptyData is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftEmptyData'
```

## Author

jackiehu, jackie

## License

SwiftEmptyData is available under the MIT license. See the LICENSE file for more info.
