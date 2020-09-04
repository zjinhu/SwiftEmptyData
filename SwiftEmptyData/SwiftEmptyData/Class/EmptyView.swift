//
//  EmptyBaseView.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/7.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit
import SnapKit

public class EmptyConfig {
    //用于请求网络前Reload时暂时隐藏emptyView ,网络回来后会根据当前的tableView/collectionView的 DataSource来自动判断是否显示emptyView,不请求网络默认为false
    public var firstReloadHidden = false
    /// 内容视图的偏移量
    public var offsetY : CGFloat = 0
    /// 间距
    public var space : CGFloat = 5
    ///整个遮罩层的背景色
    public var emptyViewColor : UIColor = .clear
    /// 内容区域是否可点击
    public var emptyViewCanTouch = false
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
}


/// 获取信号栏高度
/// - Returns: 高度
func status_bar_height() ->CGFloat {
    if #available(iOS 13.0, *){
        let window = UIApplication.shared.windows.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }else{
        return UIApplication.shared.statusBarFrame.height
    }
}

/// 空占位图
open class EmptyView: UIView {
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// 图片
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    /// 标题
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    /// 副标题
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.backgroundColor = .clear
        detailLabel.textAlignment = .center
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    
    /// 按钮
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
        return button
    }()
    
    lazy var tapGesture: UITapGestureRecognizer = {
        let item = UITapGestureRecognizer(target: self, action: #selector(touchUpInSideBtnAction))
        return item
    }()

    public typealias ConfigEmpty = ((_ config : EmptyConfig) -> Void)
    
    public typealias buttonClosure = (_ tag : Int) -> Void
    
    public var firstReloadHidden = false
    
    fileprivate var bClosure: buttonClosure?
    fileprivate var config : EmptyConfig?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth , .flexibleHeight]
        addSubview(stackView)
        stackView.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.centerY.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configEmptyView(_ model : EmptyConfig){
        config = model
        
        backgroundColor = model.emptyViewColor
        
        if let bool = config?.emptyViewCanTouch, bool == true {
            addGestureRecognizer(tapGesture)
        }
        
        stackView.arrangedSubviews.forEach { (view) in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        stackView.spacing = model.space
        
        if let image = model.image {
            imageView.image = image
            stackView.addArrangedSubview(imageView)
            
            if let size = model.imageSize {
                imageView.snp.updateConstraints { (m) in
                    m.size.equalTo(size)
                }
            }
        }
        
        if let title = model.title {
            titleLabel.text = title
            titleLabel.font = model.titleFont
            titleLabel.textColor = model.titleColor
            stackView.addArrangedSubview(titleLabel)
            if let size = model.titleSize {
                titleLabel.snp.updateConstraints { (m) in
                    m.size.equalTo(size)
                }
            }
        }
        
        if let detail = model.detail {
            detailLabel.text = detail
            detailLabel.font = model.detailFont
            detailLabel.textColor = model.detailColor
            stackView.addArrangedSubview(detailLabel)
            if let size = model.detailSize {
                detailLabel.snp.updateConstraints { (m) in
                    m.size.equalTo(size)
                }
            }
        }
        
        if let buttonTitle = model.buttonTitle {
            button.titleLabel?.font = model.buttonFont
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(model.buttonTitleColor, for: .normal)
            button.backgroundColor = model.buttonColor
            button.layer.cornerRadius = model.buttonRadius
            button.clipsToBounds = true
            stackView.addArrangedSubview(button)
            if let size = model.buttonSize {
                button.snp.updateConstraints { (m) in
                    m.size.equalTo(size)
                }
            }
        }
        
        if model.offsetY != 0 {
            stackView.snp.updateConstraints { (m) in
                m.centerY.equalToSuperview().offset(model.offsetY)
            }
        }
    }
    
    /// 创建占位图
    /// - Parameters:
    ///   - deploy: 适配器回调
    ///   - closure: 按钮点击回调 或 容器点击回调
    /// - Returns: 占位图
    public static func empty(_ deploy : ConfigEmpty,
                             closure: buttonClosure? = nil) -> EmptyView{
        let model = EmptyConfig()
        deploy(model)
        
        let em = EmptyView()
        em.firstReloadHidden = model.firstReloadHidden
        em.bClosure = closure
        em.configEmptyView(model)
        return em
    }
    
    /// 刷新空视图
    /// - Parameter deploy: 适配器回调
    public func reloadEmpty(_ deploy : ConfigEmpty){
        
        if config == nil {
            config = EmptyConfig()
        }
        
        deploy(config!)
        configEmptyView(config!)
    }
    
     @objc fileprivate func touchUpInSideBtnAction() {
        if let co = bClosure {
            co(config?.eventTag ?? 0)
        }
    }
    
}
