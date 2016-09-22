//
//  MyLeaveRecordController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyLeaveRecordController: UIViewController,UITableViewDataSource,UITableViewDelegate ,MyModelDelegate,YTOtherLibToolDelegate{

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "LeaveRecordCell"
    let headerIdentifier = "headerIdentifier"
    var dataSource:NSMutableArray?
    var messageView:MessageView?
    var myModel = MyModel()
    var otherlibTool = YTOtherLibTool()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavibar()
        self.view.backgroundColor = PageGrayColor
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
        self.otherlibTool.delegate = self
        otherlibTool.addDownPullAnimate(InView: self.tableView!)
        
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.dataSource = NSMutableArray()
        self.tableView.backgroundColor = PageGrayColor
        
        self.messageView?.setMessageLoading()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tableView?.stopLoading()
        self.otherlibTool.delegate = nil
    }
    func downpullRequest() {
        self.myModel.requestMyLeaveRecord()
    }
    func initNavibar()
    {
        self.navigationItem.title = "我的请假记录"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
    }
    //MARK: -UITableViewDataSource,UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataSource?.count)!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! LeaveRecordCell
        cell.setContent(data: self.dataSource?.object(at: indexPath.section) as! LeaveListData)
        return cell
    }
    //MARK: -MyModelDelegate
    func requestMyLeaveRecordSucc(result: LeaveListResultData) {
        self.messageView?.hideMessage()
        self.tableView?.stopLoading()
        self.dataSource = result.data
        self.tableView.reloadData()
    }
    func requestMyLeaveRecordFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.tableView?.stopLoading()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }

}
