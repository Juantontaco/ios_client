//
//  CustomFormViewController.swift
//  ios_client
//
//  Created by Max Dignan on 6/1/18.
//  Copyright © 2018 RideZoot. All rights reserved.
//

import UIKit

class CustomFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    var isForCharger = false
    var isForHelment = false
    
    var chargerCount = 0
    
    @IBOutlet var topLabel : UILabel!
    @IBOutlet var secondLabel : UILabel!
    
    @IBOutlet var addressTextField : UITextField!
    @IBOutlet var address2TextField : UITextField!
    @IBOutlet var cityTextField : UITextField!
    @IBOutlet var stateTextField : UITextField!
    @IBOutlet var zipCodeTextField : UITextField!
    
    @IBOutlet var countButton : UIButton!
    @IBOutlet var countPicker : UIPickerView!
    
    @IBOutlet var requestButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addVerticalGradient()
        showLogo()
        showMenu()
        
        if isForCharger {
            buildCharger()
        } else if isForHelment {
            buildHelmet()
        }

        requestButton.addBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildCharger() {
        self.topLabel.text = "Earn $5 per Zooter that you charge each day."
        
        self.secondLabel.text = "Tell us where you live and we will second you (a) Zoot charger(s) within 5 business days."
        
        self.countPicker.isHidden = true
        self.countPicker.delegate = self
        self.countPicker.dataSource = self
        self.countButton.setTitle("Tap to Select: Number of Chargers: 0", for: .normal)
        
        requestButton.setTitle("Request Chargers", for: .normal)
    }
    
    @IBAction func countButtonPressed(_ sender: Any) {
        self.countPicker.isHidden = false
        self.countButton.isHidden = true
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let str = NSAttributedString(string: "\(row)", attributes:[NSAttributedStringKey.font:UIFont(name: "Gill Sans", size: 17.0)!,NSAttributedStringKey.foregroundColor:UIColor.white])
        
        return str
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.chargerCount = row
        self.countButton.setTitle("Tap to Select: Number of Chargers: \(row)", for: .normal)
        self.countPicker.isHidden = true
        self.countButton.isHidden = false

    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 11
    }
    
    func buildHelmet() {
        self.topLabel.text = "Need a Helmet? No problem!"
        
        self.secondLabel.text = "Tell us where you live and we will send you helmet within 5 business days. "
        
        self.countPicker.isHidden = true
        self.countPicker.delegate = self
        self.countPicker.dataSource = self
        self.countButton.isHidden = true
        
        requestButton.setTitle("Request Helmet", for: .normal)
    }

}
