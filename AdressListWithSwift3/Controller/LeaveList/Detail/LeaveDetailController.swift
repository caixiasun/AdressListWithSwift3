//
//  LeaveDetailController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/9.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveDetailController: UIViewController,LeaveListModelDelegate {
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var telLab: UILabel!
    @IBOutlet weak var positionLab: UILabel!    
    @IBOutlet weak var reasonLab: UILabel!
    @IBOutlet weak var startDateLab: UILabel!
    @IBOutlet weak var endDateLab: UILabel!
    var data:LeaveListData?
    var leaveModel:LeaveListModel = LeaveListModel()
    var messageView:MessageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageView?.setMessageLoading()
        self.leaveModel.requestLeaveDetail(id: (data?.idNum)!)
    }
    func initSubviews()
    {
        self.navigationItem.title = "请假详情"
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
        
        setCornerRadius(view: self.headImg, radius: kRadius_headImg_common)
        setBorder(view: self.headImg)
        
        self.messageView = addMessageView(InView: self.view)
        self.leaveModel.delegate = self
    }
    
    func initContent()
    {
        self.nameLab.text = data?.name
        self.telLab.text = data?.tel
        self.startDateLab.text = data?.started
        self.endDateLab.text = data?.ended
        self.reasonLab.text = data?.reason
    }
    
    @IBAction func itemAction(sender: UIButton) {
        switch sender.tag {
        case 1://查看头像大图
            break
        case 2://拨打电话
            break
        default:
            break
        }
    }
    
    //MARK: -LeaveListModelDelegate
    func requestLeaveDetailSucc(result: LeaveListData) {
        self.messageView?.hideMessage()
        self.data = result
        self.initContent()
    }
    func requestLeaveDetailFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    
}
