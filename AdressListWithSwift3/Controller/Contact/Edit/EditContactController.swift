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
            exitThisController()
            break
        case 2://done
            exitThisController()
            break
        case 3://删除联系人
            break
        default:
            break
        }
    }
    func exitThisController()
    {
        self.navigationController!.dismiss(animated: true, completion: nil)
    }
    
}
