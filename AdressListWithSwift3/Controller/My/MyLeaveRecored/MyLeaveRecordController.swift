//
//  MyLeaveRecordController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyLeaveRecordController: UIViewController,UITableViewDataSource,UITableViewDelegate ,MyModelDelegate,YTOtherLibToolDelegate,UIScrollViewDelegate{

    @IBOutlet weak var nopassTableView: UITableView!
    @IBOutlet weak var alreadyPassTableView: UITableView!
    @IBOutlet weak var refusedTableView: UITableView!
    @IBOutlet weak var terminalTableView: UITableView!
    
    
    //label
    @IBOutlet weak var nopassLab: UILabel!
    @IBOutlet weak var alreadyPassLab: UILabel!
    @IBOutlet weak var refusedLab: UILabel!
    @IBOutlet weak var terminalLab: UILabel!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var status:Int = 0//请假状态
    
    var preLab:UILabel?
    var preTableView:UITableView?
    
    let cellReuseIdentifier = "LeaveRecordCell"
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
        otherlibTool.addDownPullAnimate(InView: self.nopassTableView!)
        otherlibTool.addDownPullAnimate(InView: self.alreadyPassTableView!)
        otherlibTool.addDownPullAnimate(InView: self.refusedTableView!)
        otherlibTool.addDownPullAnimate(InView: self.terminalTableView!)
        self.nopassTableView.startLoading()
        
        self.nopassTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.nopassTableView.backgroundColor = PageGrayColor
        self.alreadyPassTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.alreadyPassTableView.backgroundColor = PageGrayColor
        self.refusedTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.refusedTableView.backgroundColor = PageGrayColor
        self.terminalTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        self.terminalTableView.backgroundColor = PageGrayColor
        self.dataSource = NSMutableArray()
        self.messageView?.setMessageLoading()
        
        //初始状态
        self.preLab = nopassLab
        self.preTableView = nopassTableView
        self.status = 1 //未通过
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.preTableView?.stopLoading()
        self.otherlibTool.delegate = nil
    }
    func downpullRequest() {
        self.myModel.requestMyLeaveRecord(status: self.status)
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
        self.preTableView?.stopLoading()
        self.dataSource = result.data 
        self.preTableView?.reloadData()
    }
    func requestMyLeaveRecordFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.preTableView?.stopLoading()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    //tapGesture
    @IBAction func topItemTapGesture(_ tap: UITapGestureRecognizer) {
        self.mainScrollView.setContentOffset(CGPoint(x:CGFloat((tap.view?.tag)!-1) * kScreenWidth,y:0), animated: true)
        modifyLabAndTabViewStatus(tag: (tap.view?.tag)!)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetX:Int = Int(scrollView.contentOffset.x/kScreenWidth) + 1
        modifyLabAndTabViewStatus(tag: offsetX)
    }
    func modifyLabAndTabViewStatus(tag:Int)
    {
        self.preLab?.textColor = TextGrayColor
        self.preTableView?.stopLoading()
        
        switch tag {
        case LeaveStatus.NoPass.rawValue://未通过
            self.preLab = self.nopassLab
            self.preTableView = self.nopassTableView
            self.status = 1
            self.nopassLab.textColor = BlackColor
            self.nopassTableView.startLoading()
            break
        case LeaveStatus.AlreadyPass.rawValue://已通过
            self.preLab = self.alreadyPassLab
            self.preTableView = self.alreadyPassTableView
            self.status = 2
            self.alreadyPassLab.textColor = BlackColor
            self.alreadyPassTableView.startLoading()
            break
        case LeaveStatus.Refused.rawValue://审核拒绝
            self.preLab = self.refusedLab
            self.preTableView = self.refusedTableView
            self.status = 3
            self.refusedLab.textColor = BlackColor
            self.refusedTableView.startLoading()
            break
        default://已销假
            self.preLab = self.terminalLab
            self.preTableView = self.terminalTableView
            self.status = 4
            self.terminalLab.textColor = BlackColor
            self.terminalTableView.startLoading()
            break
        }
    }
}
