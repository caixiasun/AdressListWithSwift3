//
//  MyController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyController: UIViewController ,UITableViewDelegate,UITableViewDataSource,MyModelDelegate{
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "SettingCell"
    let headerIdentifier = "headerIdentifier"
    var dataSource:NSMutableArray?
    var myModel:MyModel = MyModel()
    
    var messageView:MessageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        
        self.myModel.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshContent), name: NSNotification.Name(rawValue: kNotification_refresh_my_index_from_myInfo), object: nil)
        
    }
    func refreshContent()
    {
        let url = URL(string: dataCenter.getHeadImgUrlString())
        self.headImg.sd_setImage(with: url, placeholderImage: kHeadImgObj)
    }
    
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageView?.setMessageLoading()
        self.myModel.requestMyInfo()
        
    }
    func initSubviews()
    {
        self.navigationItem.title = "更多"
        self.view.backgroundColor = PageGrayColor
        
        self.messageView = addMessageView(InView: self.view)
        setCornerRadius(view: self.headImg, radius: kRadius_headImg_common)
        
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.backgroundColor = PageGrayColor
        self.dataSource = NSMutableArray()
        self.dataSource?.addObjects(from: [["image":"leave.png","title":"我的请假记录"],["image":"leave","title":"设置"]])
    }
    
    //MARK: - UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataSource?.count)!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! SettingCell
        cell.setContent(dic: self.dataSource?.object(at: indexPath.section) as! Dictionary<String, Any>)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {//请假记录
            let controller = MyLeaveRecordController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }else {//设置
            let controller = SettingController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    
    @IBAction func myInfoGesture(_ sender: AnyObject) {
        let controller = MyInfoController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
   //MARK: -MyModelDelegate
    func requestMyInfoSucc(result: UserData) {
        self.messageView?.hideMessage()
        if result.headImgUrlStr != nil && (result.headImgUrlStr?.hasPrefix("http:"))!{
            self.headImg.sd_setImage(with: URL(string:result.headImgUrlStr!), placeholderImage: kHeadImgObj)
        }
        self.nameLab.text = result.name
    }
    func requestMyInfoFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
}
