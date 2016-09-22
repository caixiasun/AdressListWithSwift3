//
//  MyController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/19.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "SettingCell"
    let headerIdentifier = "headerIdentifier"
    var dataSource:NSMutableArray?
    
    var messageView:MessageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        self.nameLab.text = dataCenter.getUserData().name
        
    }    
    func initSubviews()
    {
        self.navigationItem.title = "更多"
        self.view.backgroundColor = PageGrayColor
        
        self.messageView = addMessageView(InView: self.view)
        
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.tableView.backgroundColor = PageGrayColor
        self.dataSource = NSMutableArray()
        self.dataSource?.add("我的请假记录")
        self.dataSource?.add("设置")
    }
    
    //MARK: - UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        cell.titleLab.text = dataSource?.object(at: indexPath.section) as? String
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
   
}
