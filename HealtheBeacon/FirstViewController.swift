//
//  SecondViewController.swift
//  HealtheBeacon
//
//  Created by Andrew McKittrick on 6/16/16.
//  Copyright © 2016 Andrew McKittrick. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: Properties
    
    @IBOutlet var cernerIDTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    var teams: [Int:String] = [1 : "HealtheIntent | Registires",
                               2 : "HealtheIntent | Services",
                               3 : "HealtheIntent | Infrastructure",
                               4 : "Millennium | Development",
                               5 : "test",
                               6 : "another test"]
    @IBOutlet var pickerView: UIPickerView!
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cernerIDTextField.delegate = self;
        self.nameTextField.delegate = self;
        pickerView.dataSource = self;
        pickerView.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return teams.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        defaults.setValue(row, forKey: "teamID")
        return teams[row]
    }
    
    //MARK: Actions
    
    @IBAction func submit(sender: UIButton) {
        defaults.setValue(cernerIDTextField.text, forKey: "cernerID")
        defaults.setValue(nameTextField.text, forKey: "name")
    }
}

