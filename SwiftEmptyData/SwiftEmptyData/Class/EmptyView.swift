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

    public var image : UIImage?
    public var imageSize : CGSize?
    
    public var title : String?
    public var titleFont : UIFont = .systemFont(ofSize: 18)
    public var titleColor : UIColor = .black
    public var detail : String?
    public var detailFont : UIFont = .systemFont(ofSize: 14)
    public var detailColor : UIColor = .lightGray
    
    public var buttonTitle : String?
    public var buttonFont : UIFont = .systemFont(ofSize: 15)
    public var buttonTitleColor : UIColor = .lightGray
    public var buttonSize : CGSize = .init(width: 180, height: 50)
    public var buttonRadius : CGFloat = 5
    public var buttonColor : UIColor = .clear
}

open class EmptyView: UIView {
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        return contentView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel()
        detailLabel.backgroundColor = .clear
        detailLabel.textAlignment = .center
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    
    lazy var button: UIButton = {
        let button = UIButton.init(type: .custom)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        button.addTarget(self, action: #selector(touchUpInSideBtnAction), for: .touchUpInside)
        return button
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
 
        contentView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 ? -44 : -30)
            make.left.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            if let size = config?.imageSize{
                make.size.equalTo(size)
            }
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(detailLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            if let size = config?.buttonSize{
                make.size.equalTo(size)
            }
        }
 
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configEmptyView(_ model : EmptyConfig){
        config = model
        
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
