//
//  ContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ContactController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var _searchView:UIView?
    var _textField:UITextField?
    var _searchLab:UILabel?
    var _searchImg:UIImageView?
    
    var _tableView:UITableView?
    var _dataSource:NSMutableArray?
    var _sectionArray:NSMutableArray?
    let _cellReuseIdentifier = "AdressListCell"
    let _headerIdentifier = "HeaderReuseIdentifier"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNaviBar()
        
        self.initSearchView()
        
        self.initSubviews()
        
    }
    
    //MARK:- init method
    func initNaviBar()
    {
        self.navigationItem.title = "所有联系人"
        let addBtn = ETDrawButton(frame: CGRect(x:0, y:0, width:kNavigationBar_button_w, height:kNavigationBar_button_w), Img: UIImage(named: "add.png"), Target: self, Action: #selector(ContactController.addAction))        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
    }    
    
    func addAction()
    {
        let navi = YTNavigationController(rootViewController: NewContactController())
        navi.initNavigationBar()
        self.present(navi, animated: true, completion: nil)
    }
    
    func initSearchView()
    {
        let searchColor = colorWithHexString(hex: "E0E0E0")
        let searchView = UIView()
        searchView.backgroundColor = searchColor
        self.view.addSubview(searchView)
        _searchView = searchView
        
        searchView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.setOffset(0)
            make?.left.equalTo()(self.view)?.setOffset(0)
            make?.right.equalTo()(self.view)?.setOffset(0)
            make?.height.equalTo()(self.view)?.setOffset(45)
        }
        
        let textField = UITextField()
        textField.frame = CGRect(x:6, y:7.5, width:kScreenWidth-12, height:30)
        textField.backgroundColor = WhiteColor
        setCornerRadius(view: textField, radius: 10)
        searchView.addSubview(textField)
        _textField = textField
        
        let centerX = kScreenWidth*0.5;
        let centerY:CGFloat = 22.5
        let searchLab = UILabel()
        setETSize(obj: searchLab, size: CGSize(width:85, height:20))
        setETLeft(obj: searchLab, left: centerX-20)
        setETCenterY(obj: searchLab, y: centerY)
        searchLab.center = CGPoint(x:searchLab.center.x, y: centerY)
        searchLab.text = "搜索联系人"
        searchLab.textColor = searchColor
        searchLab.font = UIFont.systemFont(ofSize: 16)
        searchLab.textAlignment = NSTextAlignment.center
        searchView.addSubview(searchLab)
        _searchLab = searchLab
        
        let w:CGFloat = 17.0
        let searchImg = UIImageView()
        setETSize(obj: searchImg, size: CGSize(width:w, height:w))
        //设置searchImg的右为searchLab的左-5
        setETRight(obj: searchImg, right: ETLeft(obj: searchLab)-5)
        setETCenterY(obj: searchImg, y: centerY)
        searchImg.image = UIImage(named: "search.png")
        searchView.addSubview(searchImg)
        _searchImg = searchImg
        
    }
    
    func initSubviews()
    {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.register(UINib(nibName: _cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: _cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        _tableView = tableView;
        
        tableView.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.view)?.setOffset(45)
            make?.bottom.equalTo()(self.view)?.setOffset(0)
            make?.left.equalTo()(self.view)?.setOffset(0)
            make?.right.equalTo()(self.view)?.setOffset(0)
        })
        
        _dataSource = NSMutableArray()
        _dataSource?.addObjects(from: ["丫头","桃子","阿狸","影子","大熊"])
        
        _sectionArray = NSMutableArray()
        _sectionArray?.addObjects(from: ["A","B","C","D","E","F","G","H","I"])
    }
    
    //MARK:- UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (_dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _sectionArray?.object(at: section) as? String
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UITableViewHeaderFooterView.init(reuseIdentifier: _headerIdentifier)
        let view = UIView(frame:headView.bounds)
        view.backgroundColor = PageGrayColor
        headView.addSubview(view)
        return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (_dataSource?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellReuseIdentifier, for: indexPath) as! AdressListCell
        cell.nameLab.text = _dataSource?.object(at: indexPath.row) as? String
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ContactDetailController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
