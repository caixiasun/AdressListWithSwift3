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
    
    func requestMyLeaveRecord()
    {
        weak var blockSelf =  self
        let url = urlPrefix + "leave/self"
        let param = [kToken:dataCenter.getToken() as Any]
        manager.get(url, parameters: param, success: { (oper, data) -> Void in
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
    //上传头像
    func requestUploadHeadImg(data:Data)
    {
//        let url = urlPrefix + "user/headImg"
        let url = "http://address.uduoo.com/user/headImg"
        print("url:",url)
        var param:Dictionary<String, Any> = Dictionary()
        param[kToken] = dataCenter.getToken()
//        param["file"] = data
        let array = ["text/html","text/plain","text/json"  ,"application/json","text/javascript"]
        let sets=NSSet(array: array) as! Set<AnyHashable>
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = sets
//        manager.requestSerializer = AFHTTPRequestSerializer()
        
        
        manager.post(url, parameters: param, constructingBodyWith: { (formData:AFMultipartFormData?) in
            formData?.appendPart(withFileData: data, name: "head", fileName: "head.jpg", mimeType: "image/jpeg")
            
            }, success: { (oper, data) -> Void in
                
                let data = SuccessData.initData()
                self.delegate?.requestUploadHeadImgSucc!(success: data)
                
                
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
