//
//  EmptyProtocol.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/7.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit

protocol EmptyViewProtocol {
    var emptyView: EmptyView? {set get}
}

private var kEmptyView = "emptyDataView"
extension EmptyViewProtocol {
    // 空白页视图
    var emptyView: EmptyView? {
        get {
            return objc_getAssociatedObject(self, &kEmptyView) as? EmptyView
        }
        set {
            objc_setAssociatedObject(self, &kEmptyView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIScrollView {
    public var empty: EmptyViewDSL {
        return EmptyViewDSL(scroll: self)
    }
}


public class EmptyViewDSL: EmptyViewProtocol {
    
    fileprivate var scroll: UIScrollView
    
    fileprivate var itemsCount: Int {
        var items = 0
        
        // UITableView support
        if let tableView = scroll as? UITableView {
            var sections = 1
            
            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: tableView)
                }
                if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.tableView(tableView, numberOfRowsInSection: i)
                    }
                }
            }
        } else if let collectionView = scroll as? UICollectionView {
            var sections = 1
            
            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: collectionView)
                }
                if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_:numberOfItemsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
                    }
                }
            }
        }
        
        return items
    }
    
    init(scroll: UIScrollView) {
        self.scroll = scroll
        
        if scroll.isKind(of: UITableView.self) {
            EmptySwizzing.swizzingTableView
        } else if scroll.isKind(of: UICollectionView.self) {
            EmptySwizzing.swizzingCollectionView
        }
    }

    public func addEmptyView(_ view: EmptyView){
        var em = self
        em.emptyView = view
        em.scrollAddEmptyView()
    }


    fileprivate func scrollAddEmptyView(){
        scroll.subviews.forEach { (vi) in
            if vi.isKind(of: EmptyView.self){
                vi.removeFromSuperview()
            }
        }
        guard let em = emptyView else {
            return
        }
        scroll.addSubview(em)
        
        if scroll.isKind(of: UITableView.self) ||
            scroll.isKind(of: UICollectionView.self){
            setModeEmptyView()
        }else{
            em.isHidden = true
        }
    }
    
    func setModeEmptyView() {
        guard let _ = emptyView else {
            return
        }
        if itemsCount == 0 {
            show()
        }else{
            hide()
        }
    }
    
    fileprivate func show(){
        showEmptyView()
    }
    
    fileprivate func hide(){
        hideEmptyView()
    }
    
    public func showEmptyView(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = false
        scroll.bringSubview(toFront: em)
    }
    
    public func hideEmptyView(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = true
    }
    
    public func startLoading(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = true
    }
    
    public func endLoading(){
        guard let em = emptyView else {
            return
        }
        em.isHidden = itemsCount > 0 ? true : false
    }
}
