//
//  NewContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit


enum TextFieldTagStyle:Int {//通过tag区分五个UITextField
    case Name = 11,//姓名
    Telephone = 12,//电话
    Email = 13,//邮件
    BirthDay = 14,//生日
    Address = 15,//住址
    Position = 16,//职位
    LeaveDate = 17,//请假时间
    LeaveReason = 18,//请假原因
    NickName = 19 //昵称
}
class NewContactController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ContactModelDelegate{
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var loadImgBtn: UIButton!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var nickNameTextField: UITextField!
    
    var uploadAlertController:UIAlertController!
    var modifyAlertController:UIAlertController!
    var imagePickerController:UIImagePickerController!
    var messageView:MessageView?
    var contactModel:ContactModel = ContactModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
        self.initGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameTextField.becomeFirstResponder()
    }
    //MARK:- init method
    func initGesture()
    {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        self.view.addGestureRecognizer(tap)
    }
    func tapAction()
    {
        self.view.endEditing(true)
    }
    func initSubviews()
    {
        self.initNaviBar()
        
        setCornerRadius(view: self.loadImgBtn, radius: kRadius_headImg_common)
        setCornerRadius(view: self.headImg, radius: kRadius_headImg_common)
        setBorder(view: self.headImg)
        
        self.initAlertController()
        self.initImagePickerController()
        
        self.messageView = addMessageView(InView: self.view)
        self.contactModel.delegate = self
    }
    
    func initNaviBar()
    {
        self.navigationItem.title = "新建联系人"
        let navi = self.navigationController as! YTNavigationController
        navi.initNavigationBar()
        
        let cancelBtn = YTDrawButton(title: kTitle_cancel_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(NewContactController.itemAction(sender:)))
        cancelBtn.tag = 1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        let doneBtn = YTDrawButton(title: kTitle_done_button, TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(NewContactController.itemAction(sender:)))
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
    
    //MARK:- action method
    @IBAction func itemAction(sender: UIButton) {
        self.view.endEditing(true)
        switch sender.tag {
        case 1://导航上的cancel
            exitThisController()
            break
        case 2://导航上的done
            if self.isCanSave() {
                
                self.saveData()
            }
            break
        case 3://上传头像 或 更换头像
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
    func saveData()
    {
        let name = self.nameTextField.text
        let mobile = self.telTextField.text
        let email = self.emailTextField.text
        
        let data = UserData()
        data.name = name
        data.tel = mobile
        data.email = email
        if self.loadImgBtn.title(for: .normal) == kTitle_headImg_change {
            data.headImg = self.headImg.image
        }
        if !((self.nickNameTextField.text?.isEmpty)!) {
            data.nickName = self.nickNameTextField.text
        }
        
        //将联系人保存到本地
//        addCoreData(Model: data)
        
        //发送请求新建联系人
        var params = Dictionary<String,Any>()
        params[kName] = name
        params[kMobile] = mobile
        params[kEmail] = email
        if !((self.nickNameTextField.text?.isEmpty)!) {
            params["nickname"] = self.nickNameTextField.text
        }
        params[kToken] = dataCenter.getToken()
        params["department_id"] = 5
        params[kPassword] = kPassword_value
        params["level_id"] = 4
        self.messageView?.setMessageLoading()
        self.contactModel.requestNewConatct(param: params)
        
        //成功后退出本界面(并发送通知刷新所有联系人界面)
        self.messageView?.setMessage(Message: "添加成功！", Duration: 1)
        perform(#selector(exitThisController), with: nil, afterDelay: 1.5)
        
    }
    func exitThisController()
    {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    
    func actionAction(action:UIAlertAction)
    {
        if action.title == "拍照" {
            self.getImageFromPhotoLib(type: .camera)
        }else if action.title == "从相册选择" || action.title == "更换头像" {
            self.getImageFromPhotoLib(type: .photoLibrary)
        }else if action.title == "删除照片" {
            self.headImg.image = UIImage(named: "head")
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
    
    // 判断是否可以保存
    func isCanSave() -> Bool
    {
        if (self.nameTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "请输入姓名！", Duration: 1)
            self.nameTextField.becomeFirstResponder()
            return false
        }
        if (self.telTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "请输入电话号码！", Duration: 1)
            self.telTextField.becomeFirstResponder()
            return false
        }
        if (self.emailTextField.text?.isEmpty)! {
            self.messageView?.setMessage(Message: "请输入邮件！", Duration: 1)
            return false
        }
        
        return true
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
    
    //MARK: - ContactModelDelegate
    func requestNewConatctSucc(success: SuccessData) {
        self.messageView?.hideMessage()
    }
    func requestNewConatctFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
}
