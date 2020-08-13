//
//  ViewController.swift
//  SwiftEmptyData
//
//  Created by jackiehu on 07/08/2020.
//  Copyright (c) 2020 jackiehu. All rights reserved.
//

import UIKit 
import SwiftBrick
class ViewController: JHViewController ,UITableViewDelegate,UITableViewDataSource{
    
//    var mainArray = [String]()
    var mainArray = ["示例UIView1","示例UIView2","示例UIView3-可点击","示例UIImageView-可点击","示例UIImageView","示例Button"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tableView = UITableView.snpTableView(supView: view, delegate: self, dataSource: self) { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.registerCell(JHTableViewCell.self)

 
        tableView.emptyView = EmptyView.empty({ (config) in
//            config.firstReloadHidden = true
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
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(JHTableViewCell.self)
        cell.backgroundColor = UIColor.random
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    deinit{
        print("释放")
    }
}
