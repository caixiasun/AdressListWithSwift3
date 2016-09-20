//
//  LeaveListModel.swift
//  AdressListWithSwift3
//
//  Created by caixiasun on 16/9/20.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveListModel: BaseModel {
    
    var delegate:LeaveListModelDelegate?
    
    //获取请假列表
    func requestLeaveList()
    {
        weak var blockSelf =  self
        let url = urlPrefix + "leave/list"
        let token = dataCenter.getToken()
        let param = [kToken:token]
        manager.get(url, parameters: param, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let res = LeaveListResultData.mj_object(withKeyValues: dic)
                let newResult = blockSelf?.convertToModel(data: res!)
                self.delegate?.requestLeaveListSucc!(result: newResult!)
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestLeaveListFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestLeaveListFail!(error: data)
        }
    }
    func requestLeaveDetail(id:Int)
    {
        let url = "/leave/detail"
        let token = dataCenter.getToken()
        let param = [kID:id,kToken:token] as [String : Any]
        manager.get(url, parameters: param, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
//                let res = LeaveListResultData.mj_object(withKeyValues: dic)
            }else{//请求失败  status=error
                let errorObj = dic["error"]
                let data = ErrorData.initWithError(obj: errorObj)
                self.delegate?.requestLeaveListFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestLeaveListFail!(error: data)
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

@objc protocol LeaveListModelDelegate {
    @objc optional func requestLeaveListSucc(result:LeaveListResultData)
    @objc optional func requestLeaveListFail(error:ErrorData)
    
    @objc optional func requestLeaveDetailSucc(succ:SuccessData)
    @objc optional func requestLeaveDetailFail(error:ErrorData)
}