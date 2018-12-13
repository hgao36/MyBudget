//
//  ViewController.swift
//  MyBudget
//
//  Created by Huawei Gao on 2018/12/6.
//  Copyright © 2018 Huawei Gao. All rights reserved.
//

import UIKit
import RealmSwift
class Budget: Object {
    @objc dynamic var priceStr : String?//金额
    @objc dynamic var typeInt : String?//类型 支出收入
    @objc dynamic var expenseStr : String?//备注
    @objc dynamic var dateStr : String?//日期
    @objc dynamic var addressStr : String?//地址
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var datas = Array<Any>()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
         tableView.register(UINib(nibName: "BudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }

    //更新数据
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }

    @IBAction func change(_ sender: Any) {
        update()
    }
    @objc func update() {
        if(segmented.selectedSegmentIndex==0){
            let realm = try! Realm()
            let budgets = realm.objects(Budget.self).sorted(byKeyPath: "dateStr", ascending: false)
            datas = Array(budgets)
            tableView.reloadData()
        }else{
            let realm = try! Realm()
            let budgets = realm.objects(Budget.self).sorted(byKeyPath: "dateStr", ascending: true)
            datas = Array(budgets)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BudgetTableViewCell
        let budget = datas[indexPath.row] as! Budget
        cell.dateLabel.text = budget.dateStr
        cell.expenseLaebl.text = budget.expenseStr
        cell.addressLabel.text = budget.addressStr
        if budget.typeInt == "0" {
            cell.BGView.backgroundColor = UIColor.red
            cell.priceLabel.text = "-\(budget.priceStr ?? "")"
        }else{
            cell.BGView.backgroundColor = UIColor.green
            cell.priceLabel.text = "+\(budget.priceStr ?? "")"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
    
    //cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    //删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let realm = try! Realm()
        let budget = datas[indexPath.row] as! Budget
        try! realm.write {
            realm.delete(budget)
        }
        update()
    }
}

