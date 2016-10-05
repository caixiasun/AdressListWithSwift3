//
//  AdressListTool.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/12.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

///所有头像宽高为80，半径为40
let kRadius_headImg_common:CGFloat = 40

///头像上的按钮标题
let kTitle_headImg_upload = "上传头像"
let kTitle_headImg_change = "更换头像"
let kMobile = "mobile"
let kPassword = "password"
let kToken = "token"
let kName = "name"
let kID = "id"
let kEmail = "email"
let kPassword_value = "11111"
let kHeadImgUrl = "head_image_url"

//按钮标题
let kTitle_cancel_button = "Cancel"
let kTitle_done_button = "Done"
let kTitle_submit_button = "Submit"
let kTitle_edit_button = "Edit"
let kTitle_save_button = "Save"
let kTitle_modify_button = "Modify"

///头像压缩指数
let kCompression_index_headImg:CGFloat = 0.5
let kHeadImgObj = UIImage(named: "head.png")

//NotificationName
//从eidt界面发出，刷新详情界面
let kNotification_refresh_contact_detail_from_edit = "kNotifictionRefreshContactDetailFromEdit"
//从我的信息界面发出的，通知我的  界面 更新头像信息
let kNotification_refresh_my_index_from_myInfo = "kNotificationRefreshMyIndexFromMyInfo"
// 登录 成功后通知 联系人列表 刷新数据
let kNotification_refresh_contact_index_from_login = "kNotificationRefreshContactIndexFromLogin"


