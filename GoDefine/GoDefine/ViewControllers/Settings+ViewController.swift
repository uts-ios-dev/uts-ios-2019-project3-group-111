//
//  SettingsViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 26/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
import Eureka

class SettingsViewController: FormViewController {
    
    let user = User()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        form +++ Section("Personal Health Info")
            <<< DateRow() { row in
                row.title = "Date of Birth"
                row.value = user.dob
                }.cellUpdate({ (cell, row) in
                    self.user.dob = row.value!
                })
            <<< PickerInputRow<String>(){ row in
                row.title = "Gender"
                row.options = ["Male", "Female"]
                row.value = user.gender
                }.cellUpdate({ (cell, row) in
                    self.user.gender = row.value!
                })
            <<< PickerInputRow<Int>(){ row in
                row.title = "Weight"
                row.options = []
                for i in 50...100 {
                    row.options.append(i)
                }
                row.value = user.weight
                }.cellUpdate({ (cell, row) in
                    self.user.weight = row.value!
                })
            <<< PickerInputRow<Int>(){ row in
                row.title = "Height"
                row.options = []
                for i in 80...230 {
                    row.options.append(i)
                }
                row.value = user.height
                }.cellUpdate({ (cell, row) in
                    self.user.height = row.value!
                })
            <<< PickerInputRow<Double>(){ row in
                row.title = "Body Fat Persentage"
                row.options = []
                for i in 10...50 {
                    row.options.append(Double(i)/100)
                }
                row.value = Double(String(format: "%.2f", user.bfp))
                }.cellUpdate({ (cell, row) in
                    self.user.bfp = Float(row.value!)
                })
            
            +++ Section("Setting")
            <<< CheckRow(){ row in
                row.title = "Notification"
                row.value = true
        }
        
        tableView.backgroundColor = .white
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
