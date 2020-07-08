//
//  EmptySwizzing.swift
//  SwiftBrick
//
//  Created by iOS on 2020/7/7.
//  Copyright © 2020 狄烨 . All rights reserved.
//

import UIKit

struct EmptySwizzing {

    /// 替换 tableView 相关函数
    static let swizzingTableView: Void = {

        swizzing(sel: #selector(UITableView.reloadData),
                 of: #selector(UITableView.empty_reloadData),
                 in: UITableView.self)

        swizzing(sel: #selector(UITableView.insertRows(at:with:)),
                 of: #selector(UITableView.empty_insertRows(at:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.reloadRows(at:with:)),
                 of: #selector(UITableView.empty_reloadRows(at:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.deleteRows(at:with:)),
                 of: #selector(UITableView.empty_deleteRows(at:with:)),
                 in: UITableView.self)
        
        swizzing(sel: #selector(UITableView.insertSections(_:with:)),
                 of: #selector(UITableView.empty_insertSections(_:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.deleteSections(_:with:)),
                 of: #selector(UITableView.empty_deleteSections(_:with:)),
                 in: UITableView.self)
        swizzing(sel: #selector(UITableView.reloadSections(_:with:)),
                 of: #selector(UITableView.empty_reloadSections(_:with:)),
                 in: UITableView.self)
    }()
    
    /// 替换 CollectionView 相关函数
    static let swizzingCollectionView: Void = {
        swizzing(sel: #selector(UICollectionView.reloadData),
                 of: #selector(UICollectionView.empty_reloadData),
                 in: UICollectionView.self)
        
        swizzing(sel: #selector(UICollectionView.insertItems(at:)),
                 of: #selector(UICollectionView.empty_insertItems(at:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.deleteItems(at:)),
                 of: #selector(UICollectionView.empty_deleteItems(at:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.reloadItems(at:)),
                 of: #selector(UICollectionView.empty_reloadItems(at:)),
                 in: UICollectionView.self)
        
        swizzing(sel: #selector(UICollectionView.insertSections(_:)),
                 of: #selector(UICollectionView.empty_insertSections(_:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.deleteSections(_:)),
                 of: #selector(UICollectionView.empty_deleteSections(_:)),
                 in: UICollectionView.self)
        swizzing(sel: #selector(UICollectionView.reloadSections(_:)),
                 of: #selector(UICollectionView.empty_reloadSections(_:)),
                 in: UICollectionView.self)
    }()
    
    /// 交换方法
    ///
    /// - Parameters:
    ///   - selector: 被交换的方法
    ///   - replace: 用于交换的方法
    ///   - classType: 所属类型
    static func swizzing(sel: Selector,
                         of: Selector,
                         in classType: AnyClass) {
        let select1 = sel
        let select2 = of
        
        guard let select1Method = class_getInstanceMethod(classType, select1) else {
            assertionFailure("can't find method: " + select1.description)
            return
        }
        
        guard let select2Method = class_getInstanceMethod(classType, select2) else {
            assertionFailure("can't find method: " + select1.description)
            return
        }
        
        let didAddMethod = class_addMethod(classType,
                                           select1,
                                           method_getImplementation(select2Method),
                                           method_getTypeEncoding(select2Method))
        if didAddMethod {
            class_replaceMethod(classType,
                                select2,
                                method_getImplementation(select1Method),
                                method_getTypeEncoding(select1Method))
        } else {
            method_exchangeImplementations(select1Method, select2Method)
        }
    }
}

fileprivate extension UITableView {
    
    @objc func empty_reloadData() {
        self.empty_reloadData()
        empty.setModeEmptyView()
    }
    
    
    @objc func empty_insertSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.empty_insertSections(sections, with: animation)
        empty.setModeEmptyView()
    }
    
    @objc func empty_deleteSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.empty_deleteSections(sections, with: animation)
        empty.setModeEmptyView()
    }
    
    @objc func empty_reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
        self.empty_reloadSections(sections, with: animation)
        empty.setModeEmptyView()
    }
    
    
    @objc func empty_insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.empty_insertRows(at: indexPaths, with: animation)
        empty.setModeEmptyView()
    }
    
    @objc func empty_deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.empty_deleteRows(at: indexPaths, with: animation)
        empty.setModeEmptyView()
    }
    
    @objc func empty_reloadRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
        self.empty_reloadRows(at: indexPaths, with: animation)
        empty.setModeEmptyView()
    }
    
}

fileprivate extension UICollectionView {

    @objc func empty_reloadData() {
        self.empty_reloadData()
        empty.setModeEmptyView()
    }
    
    @objc func empty_insertSections(_ sections: IndexSet) {
        self.empty_insertSections(sections)
        empty.setModeEmptyView()
    }
    
    @objc func empty_deleteSections(_ sections: IndexSet) {
        self.empty_deleteSections(sections)
        empty.setModeEmptyView()
    }
    
    @objc func empty_reloadSections(_ sections: IndexSet) {
        self.empty_reloadSections(sections)
        empty.setModeEmptyView()
    }
    
    @objc func empty_insertItems(at indexPaths: [IndexPath]) {
        self.empty_insertItems(at: indexPaths)
        empty.setModeEmptyView()
    }
    
    @objc func empty_deleteItems(at indexPaths: [IndexPath]) {
        self.empty_deleteItems(at: indexPaths)
        empty.setModeEmptyView()
    }
    
    @objc func empty_reloadItems(at indexPaths: [IndexPath]) {
        self.empty_reloadItems(at: indexPaths)
        empty.setModeEmptyView()
    }
}
