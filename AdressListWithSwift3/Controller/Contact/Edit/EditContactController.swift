//
//  EditContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class EditContactController: UIViewController {
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var tapBtnHeadImg: UIButton!
    @IBOutlet weak var nameTextFileld: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //用于从详情界面接收数据
    var userModel:UserModel?
    var messageView:MessageView?
    var alerController:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        
    }
    func initSubviews()
    {
        self.initNaviBar()
        
        
        setCornerRadius(view: self.tapBtnHeadImg, radius: kRadius_headImg_common)
        setCornerRadius(view: self.headImg, radius: kRadius_headImg_common)
        
        self.deleteBtn.layer.borderColor = LineColor.cgColor
        self.deleteBtn.layer.borderWidth = 0.5
        setCornerRadius(view: self.deleteBtn, radius: 10)
        
        self.messageView = addMessageView(InView: self.view)
        
        self.headImg.image = userModel?.headImg
        self.nameTextFileld.text = userModel?.name
        self.telTextField.text = userModel?.tel
        self.emailTextField.text = userModel?.email
        self.birthDayTextField.text = userModel?.birthday
        self.addressTextField.text = userModel?.address
        
        weak var block = self
        self.alerController = UIAlertController(title: "温馨提醒：", message: "您尚未做任何修改，确认要退出本界面吗？", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action:UIAlertAction) in
            block?.alerAction(action: action)
        }
        let confirm = UIAlertAction(title: "确定", style: .default) { (action:UIAlertAction) in
            block?.alerAction(action: action)
        }
        self.alerController?.addAction(cancel)
        self.alerController?.addAction(confirm)
    }
    func initNaviBar()
    {
        let cancelBtn = YTDrawButton(title: "Cancel", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(EditContactController.itemAction(sender:)))
        cancelBtn.tag = 1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        let doneBtn = YTDrawButton(title: "Done", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(EditContactController.itemAction(sender:)))
        doneBtn.tag = 2
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
    }
    @IBAction func itemAction(sender:UIButton)
    {
        switch sender.tag {
        case 1://cancel
            printAllDataWithCoreData()
            exitThisController()
            break
        case 2://done
            saveModify()
            break
        case 3://删除联系人
            deleteCoreData(ConditionDic: ["tel":userModel?.tel])
            break
        default:
            break
        }
    }
    func exitThisController()
    {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    //保存修改
    func saveModify()
    {
        //如果所有字段都和原始的model相同，则不需要保存，
        let headStatus = (userModel?.headImg == self.headImg.image)
        let nameStatus = (userModel?.name == self.nameTextFileld.text)
        let telStatus = (userModel?.tel == self.telTextField.text)
        let emailStatus = (userModel?.email == self.emailTextField.text)
        let birthStatus = (userModel?.birthday == self.birthDayTextField.text)
        let addressStatus = (userModel?.address == self.addressTextField.text)
        if headStatus && nameStatus && telStatus && emailStatus && birthStatus && addressStatus {
            present(self.alerController!, animated: true, completion: nil)
            return ;
        }
        
        //有改动，保存修改
        let tel = userModel?.tel
        userModel?.headImg = self.headImg.image
        userModel?.name = self.nameTextFileld.text
        userModel?.tel = self.telTextField.text
        userModel?.email = self.emailTextField.text
        userModel?.birthday = self.birthDayTextField.text
        userModel?.address = self.addressTextField.text
        updateDataWithCoreData(Model: userModel!, Where: tel!)
        
        exitThisController()
    }
    
    // aler action
    func alerAction(action:UIAlertAction)
    {
        if action.title == "取消" {
            
        }else{
            exitThisController()
        }
    }
    
}
