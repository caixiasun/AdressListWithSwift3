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
    
    //上传头像文件，获取头像url
    func requestUploadFile(imageData:Data)
    {
        let url = urlPrefix + "user/uploadsurl"
//        let url = "http://meiyu-api.uduoo.com/a3/user/image/upload?sign=a0f99db5be3f611e8f8b4f6f557aeff3&ver=3.0.0,08082122&app=enjoytouch.com.cn.yushangUser"
        DebugLogTool.debugRequestLog(item: url)
        
        let array = ["text/html","text/plain","text/json"  ,"application/json","text/javascript"]
        let sets=NSSet(array: array) as! Set<AnyHashable>
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = sets
        
//        //构造上传的参数
//        let tokenStr = "token=\(dataCenter.getToken())"
//        let tokenData = tokenStr.data(using: .utf8)
//        var params = [kToken:dataCenter.getToken() as Any]
//        params[kToken] = dataCenter.getToken()
        /*
        let params = ["file":""]
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let res = LeaveListResultData.mj_object(withKeyValues: dic)
               
            }else{//请求失败  status=error
                //                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: nil)
                
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            
        }
        */
        
        let token = "d8e225e091262ccbcb0cc3dc2c788b33"
        let params = [kToken:token]
        manager.post(url, parameters: nil, constructingBodyWith: { (formData:AFMultipartFormData?) in
            formData?.appendPart(withFileData: imageData, name: "file[]", fileName: "file", mimeType: "image/jpeg")
//            formData?.appendPart(withForm: tokenData, name: "token")
            
            }, success: { (oper, data) -> Void in
                let dicData = data as! Data
                let str =  String(data: dicData, encoding: .utf8)
                print(str)
//                let status = dic["status"] as! String
//                if status == "ok" {
//                    let data = SuccessData.initData()
//                    self.delegate?.requestUploadHeadImgSucc!(success: data)
//                }else{
//                    let errorObj = dic["error"]
//                    let data = ErrorData.initWithError(obj: errorObj)
//                    self.delegate?.requestUploadHeadImgFail!(error: data)
//                }                
                
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
    
    @objc optional func requestUploadHeadImgSucc(success:SuccessData)
    @objc optional func requestUploadHeadImgFail(error:ErrorData)
}
