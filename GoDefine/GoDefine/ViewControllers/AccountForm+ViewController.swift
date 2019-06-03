//
//  AccountFormViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 27/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
import RLBAlertsPickers

class AccountFormViewController: UIViewController {
    
    let defaults    = UserDefaults.standard
    var dob: Date   = Date()
    var weight: Int = 0
    var height: Int = 0
    var bfp: Float  = 0.0

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var pwdCmfTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var bfpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup Views
        registerForKeyboardNotifications()
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height+20.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: UITextField) {
        sender.placeholder = ""
    }
    
    @IBAction func textFieldEditingDidEnd(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    
    @IBAction func dobTextFieldEditBegin(_ sender: UITextField) {
        sender.endEditing(true)
        sender.placeholder = nil
        
        let dobPicker = UIAlertController(style: .actionSheet, title: "Select date")
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd,yyyy"
        sender.text = formatter.string(for: Date())
        self.dob = Date()
        dobPicker.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd,yyyy"
            sender.text = formatter.string(for: date)
            self.dob = date
        }
        dobPicker.addAction(title: "OK", style: .cancel)
        show(dobPicker, sender: nil)
    }
    
    @IBAction func genderTextFieldEditBegin(_ sender: UITextField) {
        sender.endEditing(true)
        sender.placeholder = nil
        
        let genderPicker = UIAlertController(style: .actionSheet, title: "Gender", message: "Choose You Gender")
        let frameSizes: [CGFloat] = (0...1).map { CGFloat($0) }
        let pickerViewValues: [[String]] = [["Male", "Female"]]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.firstIndex(of: 0) ?? 0)
        sender.text = pickerViewValues[pickerViewSelectedValue.column][pickerViewSelectedValue.row]
        genderPicker.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, genders in
            sender.text = genders[index.column][index.row]
        }
        genderPicker.addAction(title: "Done", style: .cancel)
        show(genderPicker, sender: nil)
    }
    
    @IBAction func weightTextFieldEditBegin(_ sender: UITextField) {
        sender.endEditing(true)
        sender.placeholder = nil
        
        let weightPicker = UIAlertController(style: .actionSheet, title: "Weight", message: "Pick Your Weight")
        let frameSizes: [CGFloat] = (50...100).map { CGFloat($0) }
        let pickerViewValues: [[String]] = [frameSizes.map { Int($0).description }, ["kg"]]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.firstIndex(of: 80) ?? 0)
        self.weight = Int(pickerViewValues[pickerViewSelectedValue.column][pickerViewSelectedValue.row])!
        sender.text = "\(self.weight) kg"
        weightPicker.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, weights in
            self.weight = Int(weights[index.column][index.row])!
            sender.text = "\(self.weight) kg"
        }
        weightPicker.addAction(title: "Done", style: .cancel)
        show(weightPicker, sender: nil)
    }
    
    @IBAction func heightTextFieldEditBegin(_ sender: UITextField) {
        sender.endEditing(true)
        sender.placeholder = nil
        
        let heightPicker = UIAlertController(style: .actionSheet, title: "Height", message: "Pick you Height")
        let frameSizes: [CGFloat] = (80...230).map { CGFloat($0) }
        let pickerViewValues: [[String]] = [frameSizes.map { Int($0).description }, ["cm"]]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.firstIndex(of: 180) ?? 0)
        self.height = Int(pickerViewValues[pickerViewSelectedValue.column][pickerViewSelectedValue.row])!
        sender.text = "\(self.height) cm"
        heightPicker.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { (vc, picker, index, heights) in
            self.height = Int(heights[index.column][index.row])!
            sender.text = "\(self.height) cm"
        }
        heightPicker.addAction(title: "Done", style: .cancel)
        show(heightPicker, sender: nil)
    }
    
    @IBAction func bfpTextFieldEditBegin(_ sender: UITextField) {
        sender.endEditing(true)
        sender.placeholder = nil
        
        let bfpPicker = UIAlertController(style: .actionSheet, title: "Body Fat Persentage", message: "Pick a value")
        let frameSizes: [CGFloat] = (10...50).map { CGFloat($0) }
        let pickerViewValues: [[String]] = [frameSizes.map { Float($0).description }]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.firstIndex(of: 30) ?? 0)
        self.bfp = Float(pickerViewValues[pickerViewSelectedValue.column][pickerViewSelectedValue.row])!
        sender.text = "\(self.bfp) %"
        self.bfp = self.bfp / 100
        bfpPicker.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { (vc, picker, index, bfps) in
            self.bfp = Float(bfps[index.column][index.row]) ?? 30.0
            sender.text = "\(self.bfp) %"
            self.bfp = self.bfp / 100
        }
        bfpPicker.addAction(title: "Done", style: .cancel)
        show(bfpPicker, sender: nil)
    }
    
    @IBAction func keyboardReturnKeyTapped(_ sender: UITextField) {
        view.endEditing(true)
    }

    @IBAction func createAccountButtonTaped(_ sender: UIButton) {
        let user        = User()
        user.name       = nameTextField.text!
        user.email      = emailTextField.text!
        user.password   = pwdTextField.text!
        user.dob        = self.dob
        user.gender     = genderTextField.text!
        user.weight     = self.weight
        user.height     = self.height
        user.bfp        = self.bfp
        performSegue(withIdentifier: "EnterHomeScreen", sender: nil)
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
