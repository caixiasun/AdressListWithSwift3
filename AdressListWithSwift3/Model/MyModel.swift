//
//  MyModel.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/21.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class MyModel: BaseModel {
    var delegate:MyModelDelegate?
    
    //获取个人信息
    func requestMyInfo()
    {
        let url = urlPrefix + "user/self"
        let params = [kToken:dataCenter.getToken() as Any]
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let userData = UserData.createUserData(dic: dic["data"] as! Dictionary<String, Any>)
                self.delegate?.requestMyInfoSucc!(result: userData)
            }else{
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestMyInfoFail!(error: data)
            }
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestMyInfoFail!(error: data)
        }
        
    }
    //编辑个人信息
    func requestEditMyInfo(params: Dictionary<String, Any>)
    {
        let url = urlPrefix + "user/save"
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let data = SuccessData.initData()
                self.delegate?.requestEditMyInfoSucc!(success: data)
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestEditMyInfoFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestEditMyInfoFail!(error: data)
        }
    }
    //修改密码
    func requestModifyPassword(params: Dictionary<String, Any>)
    {
        let url = urlPrefix + "user/savePassword"
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let data = SuccessData.initData()
                self.delegate?.requestModifyPasswordSucc!(success: data)
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestModifyPasswordFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestModifyPasswordFail!(error: data)
        }
    }
    
    //获取我的请假记录列表
    func requestMyLeaveRecord(status:Int)
    {        
        weak var blockSelf =  self
        let url = urlPrefix + "leave/self"
        var params = [kToken:dataCenter.getToken() as Any]
        params["status"] = status
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let res = LeaveListResultData.mj_object(withKeyValues: dic)
                let newResult = blockSelf?.convertToModel(data: res!)
                self.delegate?.requestMyLeaveRecordSucc!(result: newResult!)
            }else{//请求失败  status=error
                //                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: nil)
                self.delegate?.requestMyLeaveRecordFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestMyLeaveRecordFail!(error: data)
        }
    }
    //删除请假记录
    func requestDeleteLeaveRecored(id:Int)
    {
        let url = urlPrefix + "leave/delete"
        var params = [kToken:dataCenter.getToken() as Any]
        params["id"] = id
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                self.delegate?.requestDeleteLeaveRecoredSucc!()
            }else{
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestDeleteLeaveRecoredFail!(error: data)
            }
            }) { (opeation, error) -> Void in
                let data = ErrorData.initWithError(obj: nil)
                self.delegate?.requestDeleteLeaveRecoredFail!(error: data)
        }
    }
    
    //上传头像文件，获取头像url
    func requestUploadFile(imageData:Data)
    {
        let url = urlPrefix + "uploadsurl"
        DebugLogTool.debugRequestLog(item: url)
        let array = ["text/html","text/plain","text/json"  ,"application/json","text/javascript"]
        let sets=NSSet(array: array) as! Set<AnyHashable>
        manager.responseSerializer.acceptableContentTypes = sets
        manager.requestSerializer = AFHTTPRequestSerializer()
        weak var blockSelf = self
        manager.post(url, parameters: nil, constructingBodyWith: { (formData:AFMultipartFormData?) in
            formData?.appendPart(withFileData: imageData, name: "file[]", fileName: "file.jpg", mimeType: "image/jpeg")
            
            }, success: { (oper, data) -> Void in
                let dic = data as! Dictionary<String, Any>
                let status = dic["status"] as! String
                if status == "ok" {
                    let arr = dic["data"] as? NSArray
                    let urlData = URLData.createURLData(data: arr?.firstObject as! Dictionary<String, Any>)
                    blockSelf?.requestUploadHeadImg(urlData: urlData)
                }else{
                    let errorObj = dic["error"]
                    let data = ErrorData.initWithError(obj: errorObj)
                    self.delegate?.requestUploadHeadImgFail!(error: data)
                }
                
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestUploadHeadImgFail!(error: data)
        }
    }
    
    //上传头像
    private func requestUploadHeadImg(urlData:URLData)
    {
        let url = urlPrefix + "user/saveHeadImg"
        var params = [kToken:dataCenter.getToken() as Any]
        params["url"] = urlData.relativeUrl
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                self.delegate?.requestUploadHeadImgSucc!(result: urlData)
            }else{
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestUploadHeadImgFail!(error: data)
            }
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestUploadHeadImgFail!(error: data)
        }
    }
    
    
    //解析model
    func convertToModel(data:LeaveListResultData) ->LeaveListResultData
    {
        let returnData = LeaveListResultData.createContactResultData()
        returnData.total = data.total
        returnData.status = data.status
        for item in data.data! {
            let convert = LeaveListData.mj_object(withKeyValues: item) as LeaveListData
            returnData.data?.add(convert)
        }
        return returnData
    }
}
@objc protocol MyModelDelegate {
    @objc optional func requestMyLeaveRecordSucc(result:LeaveListResultData)
    @objc optional func requestMyLeaveRecordFail(error:ErrorData)
    
    @objc optional func requestUploadHeadImgSucc(result:URLData)
    @objc optional func requestUploadHeadImgFail(error:ErrorData)
    
    @objc optional func requestDeleteLeaveRecoredSucc()
    @objc optional func requestDeleteLeaveRecoredFail(error:ErrorData)
    
    @objc optional func requestMyInfoSucc(result:UserData)
    @objc optional func requestMyInfoFail(error:ErrorData)
    
    @objc optional func requestEditMyInfoSucc(success:SuccessData)
    @objc optional func requestEditMyInfoFail(error:ErrorData)
    
    @objc optional func requestModifyPasswordSucc(success:SuccessData)
    @objc optional func requestModifyPasswordFail(error:ErrorData)
}
