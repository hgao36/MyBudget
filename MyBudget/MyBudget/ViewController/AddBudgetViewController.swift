//
//  AddBudgetViewController.swift
//  MyBudget
//
//  Created by Huawei Gao on 2018/12/6.
//  Copyright © 2018 Huawei Gao. All rights reserved.
//

import UIKit
import RealmSwift
class AddBudgetViewController: UIViewController,MapDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var type: UISegmentedControl!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var type2: UISegmentedControl!
    var date = String()
    var address = String()
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        // Do any additional setup after loading the view.
    }
    
    //s点击完成
    @IBAction func touchDone(_ sender: Any) {
        print("touchDone")
        if(price.text?.count == 0){
            showAlertView(text: "price is nil")
        }else if(address.count == 0){
            showAlertView(text: "address is nil")
        }else if(date.count == 0){
            showAlertView(text: "date is nil")
        }else{
            let realm = try! Realm()
            let priceText = price.text
            var expenseText = ""
            if type2.selectedSegmentIndex == 0 {
                expenseText = "diet"
            }else if type2.selectedSegmentIndex == 1 {
                expenseText = "travel"
            }else if type2.selectedSegmentIndex == 2 {
                expenseText = "shopping"
            }else if type2.selectedSegmentIndex == 3 {
                expenseText = "traffic"
            }else{
                expenseText = "other"
            }
            let budget = Budget(value: ["priceStr":priceText,"typeInt":"\(type.selectedSegmentIndex)","expenseStr":expenseText,"dateStr":date,"addressStr":address])
            try! realm.write {
                realm.add(budget)
                showAlertView(text: "succeed")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    //选择位置
    @IBAction func touchAddress(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func didDelegateText(text: String) {
        self.address = text
        addressLabel.text = text
    }
    
    //显示警告框
    @objc func showAlertView( text:String) {
        let av = UIAlertController(title: "", message: text as String, preferredStyle: .alert)
        av.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(av, animated: true, completion: nil)
    }

    //日期选择器响应方法
    @objc func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date = formatter.string(from: datePicker.date)
        self.dateLabel.text = date
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
