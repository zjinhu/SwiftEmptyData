# SwiftEmptyData

一个Swift语言封装的EmptyView显示库，可作用于UITableView、UICollectionView

## 用法

```ruby
 ///配置展位图  
			tableView.emptyView = EmptyView.empty(firstReloadHidden: false,
                                              canTouch: true,
                                              offsetY: -100,
                                              space: 15,
                                              backColor: .orange,
                                              deploy: { (config) in
                                                config.image = UIImage.init(named: "XX")
                                                config.title = "sdfasd"
                                                config.detail = "asdasd"
                                                config.buttonTitle = "asdasdasd"
                                                config.buttonColor = .orange
                                                config.buttonSize = .init(width: 200, height: 50)
                                                config.eventTag = 2
                                              },
                                              closure: { (tag) in
                                                print("点击了tag--\(tag)")
                                              })

///刷新占位图
      tableView.emptyView?.reloadEmpty(deploy: { (config) in
                config.title = "XXXXXXXXX"
                config.buttonTitle = "XXXXXXXXX"
                config.buttonColor = .red
                config.buttonSize = .init(width: 100, height: 50)
                config.eventTag = 6
            })

```



## API

```ruby
  /// 创建占位图
    /// - Parameters:
    ///   - deploy: 适配器回调
    ///   - firstReloadHidden: 用于请求网络前Reload时暂时隐藏emptyView ,网络回来后会根据当前的tableView/collectionView的 DataSource来自动判断是否显示emptyView,不请求网络默认为false
    ///   - canTouch: 内容区域是否可点击
    ///   - offsetY: 内容视图的偏移量
    ///   - space: 内容间距
    ///   - backColor: 整个遮罩层的背景色
    ///   - closure: 按钮点击回调 或 容器点击回调
    /// - Returns: 占位图
    public static func empty(firstReloadHidden: Bool = false,
                             canTouch: Bool = false,
                             offsetY: CGFloat = 0,
                             space: CGFloat = 0,
                             backColor: UIColor = .clear,
                             deploy : ConfigEmpty,
                             closure: buttonClosure? = nil) -> EmptyView

    /// 刷新空视图
    /// - Parameter deploy: 适配器回调
    public func reloadEmpty(deploy : ConfigEmpty)
```

## 

## 适配器参数

```ruby
    /// 图片
    public var image : UIImage?
    /// 自定义图片size
    public var imageSize : CGSize?
    
    /// 标题
    public var title : String?
    /// 标题字体
    public var titleFont : UIFont = .systemFont(ofSize: 30)
    /// 标题颜色
    public var titleColor : UIColor = .black
    /// 自定义size
    public var titleSize : CGSize?
    
    /// 副标题
    public var detail : String?
    /// 副标题字体
    public var detailFont : UIFont = .systemFont(ofSize: 14)
    /// 副标题颜色
    public var detailColor : UIColor = .lightGray
    /// 自定义size
    public var detailSize : CGSize?
    
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
    
    /// 按钮处理事件tag
    public var eventTag : Int = 0
```

如果不喜欢内置的布局可以直接重写或者自定义视图添加到EmptyView上

## 安装

```ruby
pod 'SwiftEmptyData'
```

## Author
jackiehu, jackie

## License
SwiftEmptyData is available under the MIT license. See the LICENSE file for more info.
