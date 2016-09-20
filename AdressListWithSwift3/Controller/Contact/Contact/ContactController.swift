//
//  ContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

let searchViewHeight:CGFloat = 45

class ContactController: UIViewController ,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,ContactModelDelegate {
    
    var searchView:UIView?
    var textField:UITextField?
    var searchLab:UILabel?
    var searchImg:UIImageView?
    var searchCoverView:UIView?
    
    var tableView:UITableView?
    var dataSource:NSMutableArray?
    var sectionArray:NSMutableArray?
    let cellReuseIdentifier = "AdressListCell"
    let headerIdentifier = "HeaderReuseIdentifier"
    var messageView:MessageView?
    let contactModel:ContactModel = ContactModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNaviBar()
        
        self.initSearchView()
        
        self.initSubviews()
        
        self.view.bringSubview(toFront: searchCoverView!)
        
        self.messageView = addMessageView(InView: self.view)
        self.contactModel.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageView?.setMessageLoading()
        //请求列表
        self.contactModel.requestContactList()
    }
    
    //MARK:- init method
    func initNaviBar()
    {
        self.navigationItem.title = "所有联系人"
        let addBtn = YTDrawButton(frame: CGRect(x:0, y:0, width:kNavigationBar_button_w, height:kNavigationBar_button_w), Img: UIImage(named: "add.png"), Target: self, Action: #selector(ContactController.addAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
    }    
    
    func addAction()
    {
        let navi = YTNavigationController(rootViewController: NewContactController())
        navi.initNavigationBar()
        self.present(navi, animated: false, completion: nil)
    }
    
    func initSearchView()
    {
        let searchColor = colorWithHexString(hex: "E0E0E0")
        let bgView = UIView()
        bgView.backgroundColor = searchColor
        self.view.addSubview(bgView)
        
        bgView.mas_makeConstraints { (make) in
            make?.top.equalTo()(self.view)?.setOffset(0)
            make?.left.equalTo()(self.view)?.setOffset(0)
            make?.right.equalTo()(self.view)?.setOffset(0)
            make?.height.equalTo()(self.view)?.setOffset(searchViewHeight)
        }
        
        let searchView = UIView()
        searchView.frame = CGRect(x:6, y:7.5, width:kScreenWidth-12, height:30)
        setCornerRadius(view: searchView, radius: 15)
        searchView.backgroundColor = WhiteColor
        bgView.addSubview(searchView)
        
        let w:CGFloat = 15.0
        let centerX = kScreenWidth*0.5;
        let centerY:CGFloat = 15
        let searchImg = UIImageView()
        setYTSize(obj: searchImg, size: CGSize(width:w, height:w))
        //设置searchImg的右为searchLab的左-5
        setYTRight(obj: searchImg, right: centerX-35)
        setYTCenterY(obj: searchImg, y: centerY)
        searchImg.image = UIImage(named: "search.png")
        searchView.addSubview(searchImg)
        self.searchImg = searchImg
        
        let textField = UITextField()
        textField.frame = CGRect(x:6, y:0, width:kScreenWidth*0.5, height:30)
        setCornerRadius(view: textField, radius: 10)
        setYTLeft(obj: textField, left: getYTRight(obj: self.searchImg!)+6)
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 16)
        searchView.addSubview(textField)
        self.textField = textField
        
        let searchLab = UILabel()
        setYTSize(obj: searchLab, size: CGSize(width:85, height:20))
        setYTLeft(obj: searchLab, left: getYTRight(obj: self.searchImg!)+6)
        setYTCenterY(obj: searchLab, y: centerY)
        searchLab.text = "搜索联系人"
        searchLab.textColor = colorWithHexString(hex: "999999")
        searchLab.font = UIFont.systemFont(ofSize: 16)
        searchLab.textAlignment = NSTextAlignment.center
        searchView.addSubview(searchLab)
        self.searchLab = searchLab
        
        self.searchCoverView = YTDrawCoverView(InView: self.view, Frame: CGRect(x: 0, y: searchViewHeight, width: kScreenWidth, height: kScreenHeight-getYTHeight(obj: bgView)), Target: self, Action: #selector(ContactController.coverViewTapGesture))
    }
    func coverViewTapGesture()
    {
        self.searchCoverView?.isHidden = true
        setSearchViewPosition()
    }
    func setSearchViewPosition()
    {
        let w = kScreenWidth*0.7
        let centerX = kScreenWidth*0.5
        if getYTWidth(obj: self.textField!) == w {//编辑状态 --> 初始状态
            self.searchCoverView?.isHidden = true
            self.searchLab?.isHidden = false
            self.textField?.placeholder = ""
            self.textField?.resignFirstResponder()
            setYTRight(obj: self.searchImg!, right: centerX-35)
            setYTLeft(obj: self.textField!, left: getYTRight(obj: self.searchImg!)+6)
            setYTLeft(obj: self.searchLab!, left: getYTRight(obj: self.searchImg!)+6)
            setYTWidth(obj: self.textField!, width: centerX)
        }else{//初始状态--> 编辑状态
            self.searchCoverView?.isHidden = false
            self.searchLab?.isHidden = true
            self.textField?.placeholder = self.searchLab?.text
            setYTLeft(obj: self.searchImg!, left: 24)
            setYTLeft(obj: self.searchLab!, left: getYTRight(obj: self.searchImg!)+6)
            setYTLeft(obj: self.textField!, left: getYTRight(obj: self.searchImg!)+6)
            setYTWidth(obj: self.textField!, width: w)
        }
    }
    
    func initSubviews()
    {
        let tableView = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        tableView.register(UINib(nibName: self.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        self.view.addSubview(tableView)
        self.tableView = tableView;
        
        tableView.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.view)?.setOffset(searchViewHeight)
            make?.bottom.equalTo()(self.view)?.setOffset(0)
            make?.left.equalTo()(self.view)?.setOffset(0)
            make?.right.equalTo()(self.view)?.setOffset(0)
        })
        
        self.dataSource = NSMutableArray()
    }
    
    //MARK:- UITableViewDelegate,UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "全部"
        }
        let data = self.dataSource?.object(at: section) as! ContactData
        return data.name
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UITableViewHeaderFooterView.init(reuseIdentifier: headerIdentifier)
        let view = UIView(frame:headView.bounds)
        view.backgroundColor = PageGrayColor
        headView.addSubview(view)
        return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((self.dataSource?.object(at: section) as! ContactData).member?.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! AdressListCell
        let data = (self.dataSource?.object(at: indexPath.section) as! ContactData).member?.object(at: indexPath.row) as! UserData
        cell.setContent(data: data)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ContactDetailController()
        controller.hidesBottomBarWhenPushed = true
        let data = (self.dataSource?.object(at: indexPath.section) as! ContactData).member?.object(at: indexPath.row) as! UserData
        controller.userData = data
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: -UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) { 
            self.setSearchViewPosition()
        }
        
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.setSearchViewPosition()
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    //MARK: -ContactModelDelegate
    func requestContactListSucc(result: ContactRestultData) {
        self.messageView?.hideMessage()
        var message:String? = "列表获取成功！"
        if result.total == 0 {
            message = message! + "但服务器没有数据，暂时使用本地假数据"
        }else{
            //将列表存入coredata，记得卸载程序，抹掉假数据。
            self.dataSource = result.data
            self.tableView?.reloadData()
        }
        self.messageView?.setMessage(Message: message!, Duration: 1)
    }
    func requestContactListfail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
}
