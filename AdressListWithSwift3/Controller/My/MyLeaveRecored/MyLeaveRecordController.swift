//
//  MyLeaveRecordController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyLeaveRecordController: UIViewController,UITableViewDataSource,UITableViewDelegate ,MyModelDelegate{

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdentifier = "LeaveRecordCell"
    let headerIdentifier = "headerIdentifier"
    var dataSource:NSMutableArray?
    var messageView:MessageView?
    var myModel = MyModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavibar()
        self.view.backgroundColor = PageGrayColor
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
        self.tableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.dataSource = NSMutableArray()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageView?.setMessageLoading()
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UITableViewHeaderFooterView.init(reuseIdentifier: headerIdentifier)
        let view = UIView(frame:headView.bounds)
        view.backgroundColor = ClearColor
        headView.addSubview(view)
        headView.backgroundColor = ClearColor
        return headView
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
        self.dataSource = result.data
        self.tableView.reloadData()
    }
    func requestMyLeaveRecordFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }

}
