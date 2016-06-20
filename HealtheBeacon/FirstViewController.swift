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
    let button = UIButton(type: UIButtonType.Custom)
    var teams = ["HealtheIntent | Registires",
                    "HealtheIntent | Services",
                    "HealtheIntent | Infrastructure",
                    "Millennium | Development",
                    "test",
                    "another test"]
    var teamsDictionary: [String:Int] = ["HealtheIntent | Registires" : 1,
                              "HealtheIntent | Services" : 2,
                              "HealtheIntent | Infrastructure" : 3,
                              "Millennium | Development" : 4,
                              "test" : 5,
                              "another test" : 6]
    @IBOutlet var pickerView: UIPickerView!
    let defaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.cernerIDTextField.delegate = self;
        pickerView.dataSource = self;
        pickerView.delegate = self;
        
        button.setTitle("Done", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 163, 106, 53)
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: "Done:", forControlEvents: UIControlEvents.TouchUpInside)

    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(note : NSNotification) -> Void{
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.button.hidden = false
            let keyBoardWindow = UIApplication.sharedApplication().windows.last
            self.button.frame = CGRectMake(0, (keyBoardWindow?.frame.size.height)!-53, 106, 53)
            keyBoardWindow?.addSubview(self.button)
            keyBoardWindow?.bringSubviewToFront(self.button)
            UIView.animateWithDuration(((note.userInfo! as NSDictionary).objectForKey(UIKeyboardAnimationCurveUserInfoKey)?.doubleValue)!, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.view.frame = CGRectOffset(self.view.frame, 0, 0)
                }, completion: { (complete) -> Void in
                    print("Complete")
            })
        }
    }
    
    func Done(sender : UIButton){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            
            self.cernerIDTextField.resignFirstResponder()
        }
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
        return teams[row]
    }
    
    //MARK: Actions
    
    @IBAction func submit(sender: UIButton) {
        defaults.setValue(cernerIDTextField.text, forKey: "cernerID")
        defaults.setValue(teamsDictionary[teams[pickerView.selectedRowInComponent(0)]], forKey: "teamID")
    }
}

