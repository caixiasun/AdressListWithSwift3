//
//  EditContactController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class EditContactController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var loadImgBtn: UIButton!
    @IBOutlet weak var nameTextFileld: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var birthDayTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var deleteBtn: UIButton!
    
    //用于从详情界面接收数据
    var userData:UserData?
    var messageView:MessageView?
    var alerController:UIAlertController?
    let doneMessage = "您尚未做任何修改，确认要退出本界面吗？"
    let deleteMessage = "您确定要删除该联系人吗？"
    
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
        if ((userData?.headImg) != nil) {
            self.headImg.image = userData?.headImg
            self.updateUploadHeadBtn(status: true)
        }
        
        self.nameTextFileld.text = userData?.name
        self.telTextField.text = userData?.tel
        self.emailTextField.text = userData?.email
        self.addressTextField.text = userData?.address
        self.birthDayTextField.text = userData?.birthDay
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
        //如果所有字段都和原始的model相同，则不需要保存，
        let headStatus = (userData?.headImg == self.headImg.image)
        let nameStatus = (userData?.name == self.nameTextFileld.text)
        let telStatus = (userData?.tel == self.telTextField.text)
        let emailStatus = (userData?.email == self.emailTextField.text)
        let birthStatus = (userData?.birthDay == self.birthDayTextField.text)
        let addressStatus = (userData?.address == self.addressTextField.text)
        if headStatus && nameStatus && telStatus && emailStatus && birthStatus && addressStatus {
            present(self.alerController!, animated: true, completion: nil)
            return ;
        }
        
        //有改动，保存修改
        let tel = userData?.tel
        let name = userData?.name
        userData?.headImg = self.headImg.image
        userData?.name = self.nameTextFileld.text
        userData?.tel = self.telTextField.text
        userData?.email = self.emailTextField.text
        userData?.birthDay = self.birthDayTextField.text
        userData?.address = self.addressTextField.text
        let array = NSArray(array: [name,tel])
        updateDataWithCoreData(Model: userData!, Where: array)
        
        self.view.endEditing(true)
        self.messageView?.setMessage(Message: "修改成功！", Duration: 1)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotification_refresh_contact_detail_from_edit), object: nil, userInfo: ["model":userData])
        perform(#selector(exitThisController), with: nil, afterDelay: 1.5)
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
                deleteCoreData(ConditionDic: ["tel":userData?.tel])
                self.messageView?.setMessage(Message: "删除成功!", Duration: 1)
                perform(#selector(returnRootViewController), with: nil, afterDelay: 2)
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
    
}
