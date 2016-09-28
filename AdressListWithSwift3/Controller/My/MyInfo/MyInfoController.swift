//
//  MyInfoController.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/22.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyInfoController: UIViewController,MyModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var myModel = MyModel()
    var uploadAlertController:UIAlertController!
    var imagePickerController:UIImagePickerController!
    var messageView:MessageView?
    @IBOutlet weak var headImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initSubviews()
        self.initAlertController()
        self.initImagePickerController()
    }
    func initSubviews()
    {
        self.view.backgroundColor = PageGrayColor
        self.navigationItem.title = "个人信息"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.default
        self.navigationController?.navigationBar.tintColor = WhiteColor
        
        self.messageView = addMessageView(InView: self.view)
        self.myModel.delegate = self
        
        self.headImg.sd_setImage(with: URL(string: dataCenter.getHeadImgUrlString()!), placeholderImage: kHeadImgObj)
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
    
    //tapGesture
    
    @IBAction func telTapGesture(_ sender: AnyObject) {
        
    }
    
    @IBAction func headImgTapGesture(_ sender: AnyObject) {
        present(self.uploadAlertController, animated: true, completion: nil)
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

}
