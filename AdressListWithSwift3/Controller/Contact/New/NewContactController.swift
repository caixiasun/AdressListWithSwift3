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
    LeaveReason = 18//请假原因
}
class NewContactController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var _headImg: UIImageView!
    @IBOutlet weak var _nameTextField: UITextField!
    @IBOutlet weak var _loadImgBtn: UIButton!
    @IBOutlet weak var _telTextField: UITextField!
    @IBOutlet weak var _emailTextField: UITextField!
    @IBOutlet weak var _birthDayTextField: UITextField!
    @IBOutlet weak var _addressTextField: UITextField!
    
    var _alertController:UIAlertController!
    var _imagePickerController:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSubviews()
        
    }
    //MARK:- init method
    func initSubviews()
    {
        self.initNaviBar()
        
        setCornerRadius(view: _loadImgBtn, radius: kRadius_headImg_common)
        setCornerRadius(view: _headImg, radius: kRadius_headImg_common)
        
        self.initAlertController()
        self.initImagePickerController()
        
    }
    
    func initNaviBar()
    {
        self.navigationItem.title = "新建联系人"
        let navi = self.navigationController as! YTNavigationController
        navi.initNavigationBar()
        
        let cancelBtn = ETDrawButton(title: "Cancel", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(NewContactController.itemAction(sender:)))
        cancelBtn.tag = 1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelBtn)
        
        let doneBtn = ETDrawButton(title: "Done", TitleColor: WhiteColor, FontSize: kFontSize_navigationBar_button, Target: self, Action: #selector(NewContactController.itemAction(sender:)))
        doneBtn.tag = 2
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneBtn)
    }
    
    func initAlertController()
    {
        weak var blockSelf = self
        _alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        _alertController.view.tintColor = MainColor
        let takePhoto = UIAlertAction(title: "拍照", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let photoLib = UIAlertAction(title: "从相册选择", style: UIAlertActionStyle.default) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        let cancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in
            blockSelf?.actionAction(action: action)
        }
        _alertController?.addAction(takePhoto)
        _alertController?.addAction(photoLib)
        _alertController?.addAction(cancel)
    }
    func initImagePickerController()
    {
        _imagePickerController = UIImagePickerController()
        _imagePickerController.delegate = self
        // 设置是否可以管理已经存在的图片或者视频
        _imagePickerController.allowsEditing = true
        
    }
    
    //MARK:- action method
    @IBAction func itemAction(sender: UIButton) {
        switch sender.tag {
        case 1://导航上的cancel
            exitThisController()
            break
        case 2://导航上的done
            exitThisController()
            break
        case 3://上传头像
            self.present(_alertController, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    func exitThisController()
    {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    
    func actionAction(action:UIAlertAction)
    {
        if action.title == "拍照" {
            print("1111")
        }else if action.title == "从相册选择" {
            self.getImageFromPhotoLib()
        }
    }
    
    func getImageFromPhotoLib()
    {
        _imagePickerController.sourceType = .photoLibrary
        //判断是否支持相册
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.present(_imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){

        let type:String = (info[UIImagePickerControllerMediaType] as! String)
        //当选择的类型是图片
        if type == "public.image"
        {
            let img = info[UIImagePickerControllerOriginalImage] as? UIImage
            picker.dismiss(animated: true, completion: nil)
            let w:CGFloat = (img?.size.width)!*0.5
            let v:CGFloat = w*0.5
            let newImg = img?.getSubImage(CGRect(x: kScreenWidth*0.5, y: kScreenHeight*0.5, width: w, height: w))
            _headImg.image = newImg
            
        }
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
}
