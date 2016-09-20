//
//  ContactModel.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class ContactModel: NSObject {
    let urlPrefix = "http://address.uduoo.com/"
    var delegate:ContactModelDelegate?
    let manager = AFHTTPRequestOperationManager()
    
    ////获取联系人列表
    func requestContactList()
    {
        weak var blockSelf =  self
        let url = urlPrefix + "user/list"
        manager.get(url, parameters: nil, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let result = ContactRestultData.mj_object(withKeyValues: dic)
                //如果userdata解析不出来，则使用循环手动解析成userdata。
                let coverResult = blockSelf?.covertDataToArray(data: result!)
                self.delegate?.requestContactListSucc!(result: coverResult!)
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestContactListFail!(error: data)
            }
            
            }) { (opeation, error) -> Void in
                let data = ErrorData.initWithError(obj: error)
                self.delegate?.requestContactListFail!(error: data)
        }
    }
    
    //新建联系人
    func requestNewConatct(param: Dictionary<String, Any>)
    {
        let url = urlPrefix + "user/add"
        manager.get(url, parameters: param, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let result = ContactRestultData.mj_object(withKeyValues: dic)
                
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestNewConatctFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestNewConatctFail!(error: data)
        }
        
    }
    
    
    
    //将请求到的数据转换成对应的数据类型
    func covertDataToArray(data:ContactRestultData) -> ContactRestultData
    {
        let result = ContactRestultData.createContactResultData()
        result.total = data.total
        result.status = data.status
        
        for contact in (data.data)! {
            let covercontact = ContactData.mj_object(withKeyValues: contact) as ContactData
            let memberArray = NSMutableArray()
            for memeber in covercontact.member! {
                let coverMember = UserData.mj_object(withKeyValues: memeber) as UserData
                memberArray.add(coverMember)
            }
            covercontact.member = memberArray
            result.data?.add(covercontact)
        }
        
        return result
    }
}

@objc protocol ContactModelDelegate {
    @objc optional func requestContactListSucc(result:ContactRestultData)
    @objc optional func requestContactListFail(error:ErrorData)
    
    @objc optional func requestNewConatctSucc(success:SuccessData)
    @objc optional func requestNewConatctFail(error:ErrorData)
}