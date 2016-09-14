//
//  EditContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class EditContactController: UIViewController {
    
    @IBOutlet weak var _headImg: UIImageView!
    @IBOutlet weak var _tapBtnHeadImg: UIButton!
    @IBOutlet weak var _nameTextFileld: UITextField!
    @IBOutlet weak var _telTextField: UITextField!
    @IBOutlet weak var _birthDayTextField: UITextField!
    @IBOutlet weak var _addressTextField: UITextField!
    @IBOutlet weak var _emailTextField: UITextField!
    @IBOutlet weak var _deleteBtn: UIButton!
    
    //用于从详情界面接收数据
    var userModel:UserModel?
    var _messageView:MessageView?
    var _alerController:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        
    }
    func initSubviews()
    {
        self.initNaviBar()
        
        
        setCornerRadius(view: _tapBtnHeadImg, radius: kRadius_headImg_common)
        setCornerRadius(view: _headImg, radius: kRadius_headImg_common)
        
        _deleteBtn.layer.borderColor = LineColor.cgColor
        _deleteBtn.layer.borderWidth = 0.5
        setCornerRadius(view: _deleteBtn, radius: 10)
        
        _messageView = addMessageView(InView: self.view)
        
        _headImg.image = userModel?.headImg
        _nameTextFileld.text = userModel?.name
        _telTextField.text = userModel?.tel
        _emailTextField.text = userModel?.email
        _birthDayTextField.text = userModel?.birthday
        _addressTextField.text = userModel?.address
        
        weak var block = self
        _alerController = UIAlertController(title: "温馨提醒：", message: "您尚未做任何修改，确认要退出本界面吗？", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action:UIAlertAction) in
            block?.alerAction(action: action)
        }
        let confirm = UIAlertAction(title: "确定", style: .default) { (action:UIAlertAction) in
            block?.alerAction(action: action)
        }
        _alerController?.addAction(cancel)
        _alerController?.addAction(confirm)
    }
    func initNaviBar()
    {
        let cancelBtn = ETDrawButton(title: "Cancel", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(EditContactController.itemAction(sender:)))
        cancelBtn.tag = 1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        let doneBtn = ETDrawButton(title: "Done", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(EditContactController.itemAction(sender:)))
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
        let headStatus = (userModel?.headImg == _headImg.image)
        let nameStatus = (userModel?.name == _nameTextFileld.text)
        let telStatus = (userModel?.tel == _telTextField.text)
        let emailStatus = (userModel?.email == _emailTextField.text)
        let birthStatus = (userModel?.birthday == _birthDayTextField.text)
        let addressStatus = (userModel?.address == _addressTextField.text)
        if headStatus && nameStatus && telStatus && emailStatus && birthStatus && addressStatus {
            present(_alerController!, animated: true, completion: nil)
            return ;
        }
        
        //有改动，保存修改
        let tel = userModel?.tel
        userModel?.headImg = _headImg.image
        userModel?.name = _nameTextFileld.text
        userModel?.tel = _telTextField.text
        userModel?.email = _emailTextField.text
        userModel?.birthday = _birthDayTextField.text
        userModel?.address = _addressTextField.text
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
