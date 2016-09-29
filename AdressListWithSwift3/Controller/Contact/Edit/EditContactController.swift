//
//  EditContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class EditContactController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ContactModelDelegate{
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var loadImgBtn: UIButton!
    @IBOutlet weak var nameTextFileld: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //为修改UI而设置为全局的变量
    @IBOutlet weak var departmentView: UIView!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var dongshiBtn: UIButton!
    @IBOutlet weak var iOSBtn: UIButton!
    @IBOutlet weak var phpBtn: UIButton!
    @IBOutlet weak var qianduanBtn: UIButton!
    @IBOutlet weak var androidBtn: UIButton!
    @IBOutlet weak var hrBtn: UIButton!
    @IBOutlet weak var bgBtn: UIButton!
    @IBOutlet weak var testBtn: UIButton!
    
    @IBOutlet weak var level_jingliBtn: UIButton!
    @IBOutlet weak var level_dashenBtn: UIButton!
    @IBOutlet weak var level_coderBtn: UIButton!
    @IBOutlet weak var level_hrBtn: UIButton!
    @IBOutlet weak var level_testBtn: UIButton!
    
    //记录上次点击的按钮
    var preBtn_department:UIButton?
    var preBtn_level:UIButton?
    
    //用于从详情界面接收数据
    var userData:UserData?
    var messageView:MessageView?
    var alerController:UIAlertController?
    let doneMessage = "您尚未做任何修改，确认要退出本界面吗？"
    let deleteMessage = "您确定要删除该联系人吗？"
    var contactModel:ContactModel = ContactModel()
    var whereArray = NSMutableArray()//用于保存修改联系人的条件（原来的名字和电话）
    
    var uploadAlertController:UIAlertController!
    var modifyAlertController:UIAlertController!
    var imagePickerController:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        self.initData()
        
    }
    func initSubviews()
    {
        self.initNaviBar()
        
        
        setCornerRadius(view: self.loadImgBtn, radius: kRadius_headImg_common)
        setCornerRadius(view: self.headImg, radius: kRadius_headImg_common)
        setBorder(view: self.headImg)
    
        setBorder(view: self.deleteBtn)
        setCornerRadius(view: self.deleteBtn, radius: 10)
        
        self.messageView = addMessageView(InView: self.view)
        self.contactModel.delegate = self
        
        
        weak var block = self
        self.alerController = UIAlertController(title: "温馨提醒：", message: doneMessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action:UIAlertAction) in
            block?.alerAction(action: action)
        }
        let confirm = UIAlertAction(title: "确定", style: .default) { (action:UIAlertAction) in
            block?.alerAction(action: action)
        }
        self.alerController?.addAction(cancel)
        self.alerController?.addAction(confirm)
        
        self.initAlertController()
        self.initImagePickerController()
        //修改外观
        self.setupUI()
        
    }
    //修改外观
    func setupUI()
    {
        setCornerRadius(view: self.departmentView, radius: 5)
        setBorder(view: self.departmentView)
        
        setCornerRadius(view: self.dongshiBtn, radius: 5)
        setBorder(view: self.dongshiBtn)
        setCornerRadius(view: self.iOSBtn, radius: 5)
        setBorder(view: self.iOSBtn)
        setCornerRadius(view: self.phpBtn, radius: 5)
        setBorder(view: self.phpBtn)
        setCornerRadius(view: self.qianduanBtn, radius: 5)
        setBorder(view: self.qianduanBtn)
        setCornerRadius(view: self.androidBtn, radius: 5)
        setBorder(view: self.androidBtn)
        setCornerRadius(view: self.hrBtn, radius: 5)
        setBorder(view: self.hrBtn)
        setCornerRadius(view: self.bgBtn, radius: 5)
        setBorder(view: self.bgBtn)
        setCornerRadius(view: self.testBtn, radius: 5)
        setBorder(view: self.testBtn)
        
        
        setCornerRadius(view: self.levelView, radius: 5)
        setBorder(view: self.levelView)
        
        setCornerRadius(view: self.level_jingliBtn, radius: 5)
        setBorder(view: self.level_jingliBtn)
        setCornerRadius(view: self.level_dashenBtn, radius: 5)
        setBorder(view: self.level_dashenBtn)
        setCornerRadius(view: self.level_coderBtn, radius: 5)
        setBorder(view: self.level_coderBtn)
        setCornerRadius(view: self.level_hrBtn, radius: 5)
        setBorder(view: self.level_hrBtn)
        setCornerRadius(view: self.level_testBtn, radius: 5)
        setBorder(view: self.level_testBtn)
        
    }
    func initNaviBar()
    {
        let cancelBtn = YTDrawButton(title: kTitle_cancel_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(EditContactController.itemAction(sender:)))
        cancelBtn.tag = 1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        let doneBtn = YTDrawButton(title: kTitle_done_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(EditContactController.itemAction(sender:)))
        doneBtn.tag = 2
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
    }
    func initAlertController()
    {
        weak var blockSelf = self
        self.uploadAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        self.uploadAlertController.view.tintColor = DeepMainColor
        let takePhoto = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let photoLib = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        self.uploadAlertController?.addAction(takePhoto)
        self.uploadAlertController?.addAction(photoLib)
        self.uploadAlertController?.addAction(cancel)
        
        self.modifyAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        self.modifyAlertController.view.tintColor = DeepMainColor
        let takePhoto2 = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let photoLib2 = UIAlertAction(title: "更换头像", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let cancel2 = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let delete = UIAlertAction(title: "删除照片", style: UIAlertActionStyle.destructive) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        
        self.modifyAlertController.addAction(takePhoto2)
        self.modifyAlertController.addAction(photoLib2)
        self.modifyAlertController.addAction(delete)
        self.modifyAlertController.addAction(cancel2)
    }
    func initImagePickerController()
    {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
    }
    func initData()
    {
        if ((userData?.headImgUrlStr) != nil) {
            self.headImg.sd_setImage(with: URL(string:(userData?.headImgUrlStr)!), placeholderImage: kHeadImgObj)
            self.updateUploadHeadBtn(status: true)
        }
        
        self.nameTextFileld.text = userData?.name
        self.telTextField.text = userData?.tel
        self.emailTextField.text = userData?.email
        self.addressTextField.text = userData?.address
        self.birthDayTextField.text = userData?.birthDay
        
        /*
         * 1://董事部  2://iOS  3://php  4://前段
         * 5://安卓   7://人事  8://后台  6：//测试
         */
        switch (userData?.departmentId)! {
        case 1:
            self.preBtn_department = self.dongshiBtn
            break
        case 2:
            self.preBtn_department = self.iOSBtn
            break
        case 3:
            self.preBtn_department = self.phpBtn
            break
        case 4:
            self.preBtn_department = self.qianduanBtn
            break
        case 5:
            self.preBtn_department = self.androidBtn
            break
        case 6:
            self.preBtn_department = self.testBtn
            break
        case 7:
            self.preBtn_department = self.hrBtn
            break
        default:
            self.preBtn_department = self.bgBtn
            break
        }
        /*
         * 1://经理  2://大神  3://程序员  4://人事
         * 5://测试
         */
        switch (userData?.levelId)! {
        case 1:
            self.preBtn_level = self.level_jingliBtn
            break
        case 2:
            self.preBtn_level = self.level_dashenBtn
            break
        case 3:
            self.preBtn_level = self.level_coderBtn
            break
        case 4:
            self.preBtn_level = self.level_hrBtn
            break
        default:
            self.preBtn_level = self.level_testBtn
            break
        }
        self.preBtn_level?.backgroundColor = NewContactButtonBgColor
        self.preBtn_department?.backgroundColor = NewContactButtonBgColor
    }
    //MARK: -action method
    @IBAction func itemAction(sender:UIButton)
    {
        switch sender.tag {
        case 1://cancel
            exitThisController()
            break
        case 2://done
            self.alerController?.message = doneMessage
            saveModify()
            break
        case 3://删除联系人
            self.alerController?.message = deleteMessage
            present(self.alerController!, animated: true, completion: nil)
            break
        case 4://上传或更改头像
            if self.loadImgBtn.title(for: .normal) == kTitle_headImg_upload {
                self.present(self.uploadAlertController, animated: true, completion: nil)
            }else{
                self.present(self.modifyAlertController, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
    //部门item点击事件
    @IBAction func departmentItemAction(_ sender: UIButton) {
        
        /*
         * 1://董事部  2://iOS  3://php  4://前段
         * 5://安卓   7://人事  8://后台  6：//测试
         */
        self.preBtn_department?.backgroundColor = ClearColor
        sender.backgroundColor = NewContactButtonBgColor
        self.preBtn_department = sender
        
    }
    
    //级别item点击事件
    @IBAction func levelItemAction(_ sender: UIButton) {
        /*
         * 1://经理  2://大神  3://程序员  4://人事
         * 5://测试
         */
        self.preBtn_level?.backgroundColor = ClearColor
        sender.backgroundColor = NewContactButtonBgColor
        self.preBtn_level = sender
    }
    func exitThisController()
    {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    //返回根视图
    func returnRootViewController()
    {
        let viewControllers = appDelegate.tabBarController.viewControllers
        let contactNavi = viewControllers?[0] as! YTNavigationController
        self.dismiss(animated: true) {
            contactNavi.popViewController(animated: true)
        }
    }
    
    //保存修改
    func saveModify()
    {
        if (self.nameTextFileld.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "名字不能为空！", Duration: 1)
            return
        }
        if (self.telTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "电话不能为空！", Duration: 1)
            return
        }
        //如果所有字段都和原始的model相同，则不需要保存，
        let nameStatus = (userData?.name == self.nameTextFileld.text)
        let telStatus = (userData?.tel == self.telTextField.text)
        let emailStatus = (userData?.email == self.emailTextField.text)
        let birthStatus = (userData?.birthDay == self.birthDayTextField.text)
        let addressStatus = (userData?.address == self.addressTextField.text)
        if nameStatus && telStatus && emailStatus && birthStatus && addressStatus {
            present(self.alerController!, animated: true, completion: nil)
            return ;
        }
        
        //有改动，保存修改
        whereArray.removeAllObjects()
        whereArray.add(userData?.name)
        whereArray.add(userData?.tel)
        
        userData?.name = self.nameTextFileld.text
        userData?.tel = self.telTextField.text
        userData?.email = self.emailTextField.text
        userData?.birthDay = self.birthDayTextField.text
        userData?.address = self.addressTextField.text
        userData?.nickName = self.nickNameTextField.text
        
        self.view.endEditing(true)
        var params = Dictionary<String, Any>()
        params[kToken] = dataCenter.getToken()
        params[kID] = userData?.idNum
        params[kName] = userData?.name
        params[kMobile] = userData?.tel
        if !(userData?.email?.isEmpty)! {
            params[kEmail] = userData?.email
        }
        if !(userData?.nickName?.isEmpty)! {
            params["nickname"] = userData?.nickName
        }
        self.messageView?.setMessageLoading()
        self.contactModel.requestEditContact(param: params)
    }
    
    // aler action
    func alerAction(action:UIAlertAction)
    {
        if alerController?.message == doneMessage {
            if action.title == "取消" {
                
            }else{
                exitThisController()
            }
        }else { //删除联系人 提醒
            if action.title == "取消" {
                
            }else{
                self.messageView?.setMessageLoading()
                self.contactModel.requestDeleteContact(id: (userData?.idNum)!)
            }
        }
        
    }
    func actionAction(action:UIAlertAction)
    {
        if action.title == "拍照" {
            self.getImageFromPhotoLib(type: .camera)
        }else if action.title == "从相册选择" || action.title == "更换头像" {
            self.getImageFromPhotoLib(type: .photoLibrary)
        }else if action.title == "删除照片" {
            self.headImg.image = kHeadImgObj
            self.updateUploadHeadBtn(status: false)
        }
    }
    
    func getImageFromPhotoLib(type:UIImagePickerControllerSourceType)
    {
        self.imagePickerController.sourceType = type
        //判断是否支持相册
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        let type:String = (info[UIImagePickerControllerMediaType] as! String)
        //当选择的类型是图片
        if type == "public.image"
        {
            let img = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.headImg.image = cropToBounds(image: img!)
            
            //修改“上传头像”按钮的状态
            self.updateUploadHeadBtn(status: true)
            
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
    //修改“上传头像”按钮状态：title和titleColor
    func updateUploadHeadBtn(status:Bool)
    {
        if status {//选择过图片了
            self.loadImgBtn.setTitle(kTitle_headImg_change, for: .normal)
            self.loadImgBtn.setTitleColor(MainColor, for: .normal)
        }else{
            self.loadImgBtn.setTitle(kTitle_headImg_upload, for: .normal)
            self.loadImgBtn.setTitleColor(TextGrayColor, for: .normal)
            
        }
    }
    
    //MARK:- ContactModelDelegate
    func requestEditContactSucc(success: SuccessData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "修改成功！", Duration: 1)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotification_refresh_contact_detail_from_edit), object: nil, userInfo: ["model":userData])
        //联系人列表刷新
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotification_refresh_contact_index_from_login), object: nil, userInfo: nil)
        perform(#selector(exitThisController), with: nil, afterDelay: 1.5)
        //将数据保存到本地 
        updateDataWithCoreData(Model: userData!, Where: whereArray)
    }
    func requestEditContactFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    func requestDeleteContactSucc() {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "删除成功!", Duration: 1)
        deleteCoreData(ConditionDic: ["tel":userData?.tel])
        //联系人列表刷新
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotification_refresh_contact_index_from_login), object: nil, userInfo: nil)
        perform(#selector(returnRootViewController), with: nil, afterDelay: 2)
    }
    func requestDeleteContactFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
}
