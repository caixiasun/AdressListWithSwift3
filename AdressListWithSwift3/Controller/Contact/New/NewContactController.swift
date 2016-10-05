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
    NickName = 19, //昵称
    StartDate = 20,//开始时间
    EndDate = 21, //结束时间
    LeaveDays = 22  //请假时长 天数
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
    
    var uploadAlertController:UIAlertController!
    var modifyAlertController:UIAlertController!
    var imagePickerController:UIImagePickerController!
    var messageView:MessageView?
    var contactModel:ContactModel = ContactModel()
    let userData:UserData = UserData()
    var imageData_global:Data?
    
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
        
        //修改外观
        self.setupUI()
        
        self.preBtn_department = self.testBtn
        self.preBtn_level = self.level_testBtn
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
            if (self.imageData_global != nil)  {
                self.uploadHeadImg()
            }else{
                if self.isCanSave() {
                    self.saveData(headImgUrl: "" )
                }
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
    //先上传头像，获得url再新建该联系人
    func uploadHeadImg()
    {
        self.view.endEditing(true)
        if (self.imageData_global != nil)  {
            self.messageView?.setMessageLoading()
            self.contactModel.requestUploadContactHeadImgFile(imageData: self.imageData_global!)
        }
    }
    
    func saveData(headImgUrl:String)
    {
        let name = self.nameTextField.text
        let mobile = self.telTextField.text
        let email = self.emailTextField.text
        
        userData.name = name
        userData.tel = mobile
        userData.email = email
        
        if !((self.nickNameTextField.text?.isEmpty)!) {
            userData.nickName = self.nickNameTextField.text
        }
        
        //发送请求新建联系人
        var params = Dictionary<String,Any>()
        params[kName] = name
        params[kMobile] = mobile
        params[kEmail] = email
        if !((self.nickNameTextField.text?.isEmpty)!) {
            params["nickname"] = self.nickNameTextField.text
        }
        params[kToken] = dataCenter.getToken()
        params["department_id"] = self.preBtn_department?.tag
        params[kPassword] = kPassword_value
        params["level_id"] = self.preBtn_level?.tag
        if !headImgUrl.isEmpty {
            params["head_img"] = headImgUrl
        }
        self.contactModel.requestNewConatct(param: params)
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
            self.imageData_global = UIImageJPEGRepresentation(self.headImg.image!, 0.5)
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
        self.messageView?.setMessage(Message: success.message!, Duration: 1)
        //成功后退出本界面(并发送通知刷新所有联系人界面)
        perform(#selector(exitThisController), with: nil, afterDelay: 1.5)
        
        //将联系人保存到本地
        addCoreData(Model: userData)
    }
    func requestNewConatctFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    func requestUploadContactHeadImgFileSucc(result: URLData) {
        if self.isCanSave() {
            self.saveData(headImgUrl: result.url!)
        }
    }
    func requestUploadContactHeadImgFileFail(error: ErrorData) {
        
    }
}
