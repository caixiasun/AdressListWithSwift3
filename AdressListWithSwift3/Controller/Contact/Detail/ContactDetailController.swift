//
//  ContactDetailController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ContactDetailController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var _headImg: UIImageView!
    @IBOutlet weak var _nameLab: UILabel!
    @IBOutlet weak var _headImgTapBtn: UIButton!
    
    @IBOutlet weak var _tablView: UITableView!
    let _cellIdentifier = "ContactDetailCell"
    var _dataSource:NSDictionary?
    var _userModel:UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        //模拟请求
        self.getData()
        
    }
    
    //MARK:- init method
    func initSubviews()
    {
        self.view.backgroundColor = WhiteColor
        
        self.initNaviBar()
        
        _tablView.register(UINib(nibName: _cellIdentifier, bundle: nil), forCellReuseIdentifier: _cellIdentifier)
        _dataSource = NSDictionary()
        
        setCornerRadius(view: _headImg, radius: kRadius_headImg_common)
        setCornerRadius(view: _headImgTapBtn, radius: kRadius_headImg_common)
    }
    func initNaviBar()
    {
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
        
        let editBtn = ETDrawButton(title: "Edit", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(ContactDetailController.itemAction(sender:)))
        editBtn.tag = 1
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editBtn)
    }
    
    //MARK:- action method
    @IBAction func itemAction(sender:UIButton)
    {
        switch sender.tag {
        case 1:
            let controller = YTNavigationController(rootViewController: EditContactController())
            controller.initNavigationBar()
            self.present(controller, animated: false, completion: nil)
            break
        case 2:
            
            break
        default:
            break
        }
    }
    
    //MARK:- UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (_userModel?.count)!
        }else{//发送信息 模块
            return 2
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellIdentifier, for: indexPath) as! ContactDetailCell
        if indexPath.section == 0 {
            cell.telLab.isHidden = false
            switch indexPath.row {
            case 0:
                cell.titleLab.text = "电话号码"
                cell.telLab.text = _userModel?.tel
                break
            case 1:
                cell.titleLab.text = "电子邮件"
                cell.telLab.text = _userModel?.email
                break
            case 2:
                cell.titleLab.text = "出生日期"
                cell.telLab.text = _userModel?.birthday
                break
            case 3:
                cell.titleLab.text = "家庭住址"
                cell.telLab.text = _userModel?.address
                break
            default:
                break
            }
        }else{
            cell.telLab.isHidden = true
            if indexPath.row == 0 {
                cell.titleLab.text = "发送信息"
                
            }else{
                cell.titleLab.text = "共享联系人"
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0://拨打电话
            let tel = "tel://" + (_userModel?.tel)!
            let url = URL(string: tel)
            if application.canOpenURL(url!) {
                application.open(url!)
            }
            break
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
   
    
    
    func getData()
    {
        let dic1 = ["name":"丫头","tel":"15214141452","email":"","address":"中国香港","birthday":"1990.01.01"]
        _userModel = UserModel.mj_object(withKeyValues: dic1) as UserModel
        _nameLab.text = _userModel?.name
        _userModel?.count = dic1.count - 1
        _tablView.reloadData()
    }
    
}
