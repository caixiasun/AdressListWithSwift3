//
//  LeaveListController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveListController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource ,LeaveListModelDelegate,YTOtherLibToolDelegate{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataSource:NSMutableArray?
    var sectionArray:NSMutableArray?
    let cellReuseIdentifier = "LeaveCell"
    let headerIdentifier = "HeaderReuseIdentifier"
    
    var messageView:MessageView?
    let leaveModel:LeaveListModel = LeaveListModel()
    var otherlibTool = YTOtherLibTool()
    
    //标记 拖动手势是否可用，根据collectionView的contentSize来判断
    var isAvailable:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNaviBar()
        
        self.initSubviews()
        
        self.otherlibTool.delegate = self
        otherlibTool.addDownPullAnimate(InView: self.collectionView!)
        self.messageView?.setMessageLoading()
        self.downpullRequest()
        
        //解决无数据或数据少时 无法下拉刷新问题add by scx
        let pan = UIPanGestureRecognizer(target: self, action: #selector(LeaveListController.panAction(panGesture:)))
        self.view.addGestureRecognizer(pan)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.collectionView.stopLoading()
        self.otherlibTool.delegate = nil
    }
    func downpullRequest() {
        
        self.leaveModel.requestLeaveList()
    }
    
    func initNaviBar()
    {
        self.navigationItem.title = "请假列表"
        let addBtn = YTDrawButton(frame: CGRect(x:0, y:0, width:kNavigationBar_button_w, height:kNavigationBar_button_w), Img: UIImage(named: "add.png"), Target: self, Action: #selector(LeaveListController.addAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
    }
    
    func initSubviews()
    {
//        self.automaticallyAdjustsScrollViewInsets = false
        self.collectionView.register(UINib(nibName: self.cellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        self.dataSource = NSMutableArray()
        
        self.messageView = addMessageView(InView: self.view)
        self.leaveModel.delegate = self
    }
    
    //MARK: -action method
    func addAction()
    {
        let controller = ApplyLeaveController()
        controller.hidesBottomBarWhenPushed = true
        let navi = YTNavigationController(rootViewController: controller)
        navi.initNavigationBar()
        self.present(navi, animated: true, completion: nil)
    }
    
    //MARK: - UICollectionViewDelegate,UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.dataSource?.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! LeaveCell
        cell.setContent(data: self.dataSource?.object(at: indexPath.row) as! LeaveListData)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = LeaveDetailController()
        controller.data = self.dataSource?.object(at: indexPath.row) as? LeaveListData
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK: -LeaveListModelDelegate
    func requestLeaveListSucc(result: LeaveListResultData) {
        self.messageView?.hideMessage()
        self.collectionView.stopLoading()
        self.dataSource = result.data
        self.collectionView.reloadData()
        
        if self.collectionView.contentSize.height > kScreenHeight {
            self.isAvailable = false
        }else{
            self.isAvailable = true
        }
    }
    func requestLeaveListFail(error: ErrorData) {
        self.messageView?.hideMessage()
        self.collectionView.stopLoading()
        self.messageView?.setMessage(Message: error.message!, Duration: 1)
        
        if self.collectionView.contentSize.height > kScreenHeight {
            self.isAvailable = false
        }else{
            self.isAvailable = true
        }
    }
    /**
     *  解决无数据或数据少时 无法下拉刷新问题
     */
    func panAction(panGesture:UIPanGestureRecognizer)
    {
        let translation = panGesture.translation(in: self.view).y
        if translation > 0 {            
            if self.isAvailable {
                self.collectionView.startLoading()
            }
            self.isAvailable = false
        }
    }
}
