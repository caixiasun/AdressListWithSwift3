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
    
    @IBOutlet weak var bottomBtnView: UIView!
    
    
    var data:LeaveListData?
    var leaveModel:LeaveListModel = LeaveListModel()
    var messageView:MessageView?
    //记录当前点击的是审核拒绝还是通过
    var currentClickStatus:Int = 0
    var idNum:Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        idNum = data?.idNum
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
        if data?.head_img != nil {
            self.headImg.sd_setImage(with: URL(string:(data?.head_img)!), placeholderImage: kHeadImgObj)
        }
        if data?.status == 1 {//只有在 状态为 未通过的情况下才需要底部的审核按钮
            self.bottomBtnView.isHidden = false
        }
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
    @IBAction func bottomItemAction(_ sender: UIButton) {
        //接口有问题，还没有试成功不成功
        // 1 审核拒绝 2、审核通过
        currentClickStatus = sender.tag
        var params = Dictionary<String, Any>()
        params[kToken] = dataCenter.getToken()
        params["id"] = idNum
        params["status"] = currentClickStatus
        self.messageView?.setMessageLoading()
        self.leaveModel.requestLeaveAudit(params: params)
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
    
    func requestLeaveAuditSucc(success: SuccessData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "审核成功！", Duration: 1)
        self.leaveModel.requestLeaveDetail(id: (data?.idNum)!)
    }
    func requestLeaveAuditFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    
}
