//
//  MyInfoController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyInfoController: UIViewController,MyModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var headImg: UIImageView!
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var telLab: UILabel!
    @IBOutlet weak var nickNameLab: UILabel!    
    @IBOutlet weak var emailLab: UILabel!
    
    var myModel = MyModel()
    var uploadAlertController:UIAlertController!
    var imagePickerController:UIImagePickerController!
    var messageView:MessageView?
    var data:UserData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        self.initAlertController()
        self.initImagePickerController()
        self.initContentData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.messageView?.setMessageLoading()
        self.myModel.requestMyInfo()
    }
    func initContentData()
    {
        if data?.headImgUrlStr != nil {
            self.headImg.sd_setImage(with: URL(string: (data?.headImgUrlStr)!), placeholderImage: kHeadImgObj)
        }
        self.nameLab.text = data?.name
        self.nickNameLab.text = data?.nickName
        self.telLab.text = data?.tel
        self.emailLab.text = data?.email
        
    }
    func initSubviews()
    {
        self.view.backgroundColor = PageGrayColor
        self.navigationItem.title = "个人信息"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
        
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
        
        setCornerRadius(view: self.headImg, radius: 15)
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
    }
    func initImagePickerController()
    {
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        self.imagePickerController.allowsEditing = true
    }
    func actionAction(action:UIAlertAction)
    {
        if action.title == "拍照" {
            self.getImageFromPhotoLib(type: .camera)
        }else if action.title == "从相册选择" || action.title == "更换头像" {
            self.getImageFromPhotoLib(type: .photoLibrary)
        }else if action.title == "删除照片" {
            self.headImg.image = UIImage(named: "head")
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
            let imgData = UIImageJPEGRepresentation(self.headImg.image!, 0.5)
            self.messageView?.setMessageLoading()
            self.myModel.requestUploadFile(imageData:imgData!)
            
            picker.dismiss(animated: true, completion: nil)
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func tapGesture(_ tap: UITapGestureRecognizer) {
        var titleString = ""
        var text = ""
        switch (tap.view?.tag)! {
        case 1://头像
            present(self.uploadAlertController, animated: true, completion: nil)
            break
        case 2://姓名
            titleString = "姓名"
            if data?.name != nil && !(data?.name?.isEmpty)! {
                text = self.nameLab.text!
            }
            break
        case 3://昵称
            titleString = "昵称"
            if data?.nickName != nil && !(data?.nickName?.isEmpty)! {
                text = self.nickNameLab.text!
            }
            
            break
        case 4://电话
            titleString = "电话"
            if data?.tel != nil && !(data?.tel?.isEmpty)! {
                text = self.telLab.text!
            }
            break
        default://邮箱
            titleString = "邮箱"
            if data?.email != nil && !(data?.email?.isEmpty)! {
                text = self.emailLab.text!
            }
            break
        }
        let controller = ModifyMyInfoController()
        controller.naviTitle = titleString
        controller.textFieldText = text
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: -ContactModelDelegate
    func requestUploadHeadImgSucc(result: URLData) {
        
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: "头像上传成功！", Duration: 1)
        /*
         * 1、头像上传成功,更新本地的userdata的headImg
         * 2、发通知到MyController，更新头像
         */
        dataCenter.setHeadImgUrlString(imageUrl: result.url!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotification_refresh_my_index_from_myInfo), object: nil, userInfo: nil)
        
    }
    func requestUploadHeadImgFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }
    func requestMyInfoSucc(result: UserData) {
        self.messageView?.hideMessage()
        self.data = result
        self.initContentData()
    }
    func requestMyInfoFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
    }

}
