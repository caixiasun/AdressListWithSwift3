//
//  LeaveListController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveListController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,LeaveListModelDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    var dataSource:NSMutableArray?
    var sectionArray:NSMutableArray?
    let cellReuseIdentifier = "AdressListCell"
    let headerIdentifier = "HeaderReuseIdentifier"
    
    var messageView:MessageView?
    let leaveModel:LeaveListModel = LeaveListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNaviBar()
        
        self.initSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageView?.setMessageLoading()
        self.leaveModel.requestLeaveList()
    }
    
    func initNaviBar()
    {
        self.navigationItem.title = "请假列表"
        let addBtn = YTDrawButton(frame: CGRect(x:0, y:0, width:kNavigationBar_button_w, height:kNavigationBar_button_w), Img: UIImage(named: "add.png"), Target: self, Action: #selector(LeaveListController.addAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
    }
    
    func initSubviews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.register(UINib(nibName: self.cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: self.cellReuseIdentifier)
        
        self.dataSource = NSMutableArray()
        
        self.messageView = addMessageView(InView: self.view)
        self.leaveModel.delegate = self
    }
    
    //MARK: -action method
    func addAction()
    {
        let controller = ApplyLeaveController()
        controller.hidesBottomBarWhenPushed = true
        let navi = YTNavigationController(rootViewController: controller)
        navi.initNavigationBar()
        self.present(navi, animated: true, completion: nil)
    }
    
    //MARK:- UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSource?.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! AdressListCell
        cell.setContent(data: self.dataSource?.object(at: indexPath.row) as! LeaveListData)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LeaveDetailController()
        controller.data = self.dataSource?.object(at: indexPath.row) as? LeaveListData
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: -LeaveListModelDelegate
    func requestLeaveListSucc(result: LeaveListResultData) {
        self.messageView?.hideMessage()
        self.dataSource = result.data
        self.tableView.reloadData()
    }
    func requestLeaveListFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
}
