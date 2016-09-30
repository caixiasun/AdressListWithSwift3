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
        let params = [kToken:dataCenter.getToken()]
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
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
    //请假详情
    func requestLeaveDetail(id:Int)
    {
        let url = urlPrefix + "leave/detail"
        let token = dataCenter.getToken()
        let params = [kID:id,kToken:token] as [String : Any]
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>            
            let res = LeaveListData.mj_object(withKeyValues: dic["data"])
            self.delegate?.requestLeaveDetailSucc!(result: res!)
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestLeaveDetailFail!(error: data)
        }
    }
    //请假申请
    func requestLeaveApply(param:Dictionary<String, Any>)
    {        
        let url = urlPrefix + "leave/add"
        DebugLogTool.debugRequestLog(item: url, params: param)
        manager.get(url, parameters: param, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let data = SuccessData.initData()
                self.delegate?.requestLeaveApplySucc!(success: data)
            }else{//请求失败  status=error
                let data = ErrorData.initWithError(obj: nil)
                self.delegate?.requestLeaveListFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestLeaveListFail!(error: data)
        }
    }
    //请假审核：通过、拒绝
    func requestLeaveAudit(params:Dictionary<String, Any>)
    {
        let url = urlPrefix + "leave/save"
        DebugLogTool.debugRequestLog(item: url, params: params)
        manager.get(url, parameters: params, success: { (oper, data) -> Void in
            let dic = data as! Dictionary<String, Any>
            let status = dic["status"] as! String
            if status == "ok" {
                let data = SuccessData.initData()
                self.delegate?.requestLeaveAuditSucc!(success: data)
            }else{//请求失败  status=error
                let data = ErrorData.initWithError(obj: nil)
                self.delegate?.requestLeaveAuditFail!(error: data)
            }
            
        }) { (opeation, error) -> Void in
            let data = ErrorData.initWithError(obj: error)
            self.delegate?.requestLeaveAuditFail!(error: data)
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
    
    @objc optional func requestLeaveDetailSucc(result:LeaveListData)
    @objc optional func requestLeaveDetailFail(error:ErrorData)
    
    @objc optional func requestLeaveApplySucc(success:SuccessData)
    @objc optional func requestLeaveApplyFail(error:ErrorData)
    
    @objc optional func requestLeaveAuditSucc(success:SuccessData)
    @objc optional func requestLeaveAuditFail(error:ErrorData)
    
}
