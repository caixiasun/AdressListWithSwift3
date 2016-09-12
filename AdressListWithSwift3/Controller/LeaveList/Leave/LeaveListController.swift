//
//  LeaveListController.swift
//  AdressListWithSwift2
//
//  Created by caixiasun on 16/9/7.
//  Copyright © 2016年 yatou. All rights reserved.
//

import UIKit

class LeaveListController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var _tableView: UITableView!
    var _dataSource:NSMutableArray?
    var _sectionArray:NSMutableArray?
    let _cellReuseIdentifier = "AdressListCell"
    let _headerIdentifier = "HeaderReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initNaviBar()
        
        self.initSubviews()
        
    }
    
    func initNaviBar()
    {
        self.navigationItem.title = "请假列表"
        let addBtn = ETDrawButton(frame: CGRect(x:0, y:0, width:kNavigationBar_button_w, height:kNavigationBar_button_w), Img: UIImage(named: "add.png"), Target: self, Action: #selector(ContactController.addAction))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addBtn)
    }
    func addAction()
    {
        let controller = ApplyLeaveController()
        controller.hidesBottomBarWhenPushed = true
        let navi = YTNavigationController(rootViewController: controller)
        navi.initNavigationBar()
        self.present(navi, animated: true, completion: nil)
    }
    func initSubviews()
    {
        self.automaticallyAdjustsScrollViewInsets = false
        _tableView.register(UINib(nibName: _cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: _cellReuseIdentifier)
        
        _dataSource = NSMutableArray()
        _dataSource?.addObjects(from: ["丫头","桃子","阿狸","影子"])
        
        _sectionArray = NSMutableArray()
        _sectionArray?.addObjects(from: ["A","B","C"])
    }
    
    
    //MARK:- UITableViewDelegate,UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (_sectionArray?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (_dataSource?.count)!
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _sectionArray?.object(at: section) as? String
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UITableViewHeaderFooterView.init(reuseIdentifier: _headerIdentifier)
        let view = UIView(frame:headView.bounds)
        view.backgroundColor = PageGrayColor
        headView.addSubview(view)
        return headView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: _cellReuseIdentifier, for: indexPath) as! AdressListCell
        cell.nameLab.text = _dataSource?.object(at: indexPath.row) as? String
        cell.flagImg.isHidden = false
        if indexPath.row/2 == 0 {
            cell.flagImg.image = UIImage(named: "leaved.png")
        }else{
            cell.flagImg.image = UIImage(named: "leaveing.png")
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = LeaveDetailController()
        controller.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(controller, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }    
}
