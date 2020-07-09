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
    
    /// 中间的容器
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        return contentView
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
    
    public typealias buttonClosure = () -> Void
    
    fileprivate var bClosure: buttonClosure?
    fileprivate var config: EmptyConfig?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = [.flexibleWidth , .flexibleHeight]
        addSubview(contentView)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(button)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            if let size = config?.imageSize{
                make.size.equalTo(size)
            }
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(config?.titleSpace ?? 0)
            make.centerX.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(config?.detailSpace ?? 0)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(config?.buttonSpace ?? 0)
            make.centerX.equalToSuperview()
            if let size = config?.buttonSize{
                make.size.equalTo(size)
            }
        }
        
        contentView.snp.makeConstraints { (make) in
            if let buttonTitle = config?.buttonTitle, buttonTitle.count > 0 {
                make.bottom.equalTo(button)
            }else if let detail = config?.detail, detail.count > 0 {
                make.bottom.equalTo(detailLabel)
            }else if let title = config?.title, title.count > 0 {
                make.bottom.equalTo(titleLabel)
            }else if let _ = config?.image{
                make.bottom.equalTo(imageView)
            }
            
            make.centerY.equalToSuperview().offset(-status_bar_height() + (config?.offsetY ?? 0))
            make.left.right.equalToSuperview()
        }
 
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configEmptyView(_ model : EmptyConfig){
        config = model
        
        backgroundColor = model.emptyViewColor
        
        if let bool = config?.emptyViewCanTouch, bool == true {
            contentView.addGestureRecognizer(tapGesture)
        }

        imageView.image = model.image
        
        titleLabel.text = model.title
        titleLabel.font = model.titleFont
        titleLabel.textColor = model.titleColor
        
        detailLabel.text = model.detail
        detailLabel.font = model.detailFont
        detailLabel.textColor = model.detailColor
        
        button.titleLabel?.font = model.buttonFont
        button.setTitle(model.buttonTitle, for: .normal)
        button.setTitleColor(model.buttonTitleColor, for: .normal)
        button.backgroundColor = model.buttonColor
        button.layer.cornerRadius = model.buttonRadius
        button.clipsToBounds = true
        
        layoutSubviews()
    }
    
    /// 创建占位图
    /// - Parameters:
    ///   - config: 适配器回调
    ///   - closure: 按钮点击回调 或 容器点击回调
    /// - Returns: 占位图
    public static func empty(_ config : ConfigEmpty,
                             closure: buttonClosure? = nil) -> EmptyView{
        let model = EmptyConfig()
        config(model)
        
        let em = EmptyView()
        em.bClosure = closure
        em.configEmptyView(model)
        return em
    }
    
     @objc fileprivate func touchUpInSideBtnAction() {
        if let co = bClosure {
            co()
        }
    }
    
}
