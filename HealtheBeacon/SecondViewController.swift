//
//  ViewController.swift
//  Defining and Processing iBeacons - Source
//
//  Created by Vandad Nahavandipoor on 7/8/14.
//  Copyright (c) 2014 Pixolity Ltd. All rights reserved.
//
//  These example codes are written for O'Reilly's iOS 8 Swift Programming Cookbook
//  If you use these solutions in your apps, you can give attribution to
//  Vandad Nahavandipoor for his work. Feel free to visit my blog
//  at http://vandadnp.wordpress.com for daily tips and tricks in Swift
//  and Objective-C and various other programming languages.

import UIKit
import CoreLocation
import CoreBluetooth

class SecondViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var peripheralManager : CBPeripheralManager?
    
    /* A newly-generated UUID for our beacon */
    let uuid = NSUUID()
    
    /* The identifier of our beacon is the identifier of our bundle here */
    let identifier = NSBundle.mainBundle().bundleIdentifier!
    let options = NSUserDefaults.standardUserDefaults()
    
    /* Made up major and minor versions of our beacon region */
    let major: CLBeaconMajorValue = 1
    let minor: CLBeaconMinorValue = 0
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager,
                                              error: NSError?){
        
        if error == nil{
            print("Successfully started advertising beacon data")
            
            let message = "Successfully set up beacon. " +
                "The unique identifier is: \(uuid.UUIDString)"
            
            print(message)
            
            let controller = UIAlertController(title: "iBeacon",
                                               message: message,
                                               preferredStyle: .Alert)
            
            controller.addAction(UIAlertAction(title: "OK",
                style: .Default,
                handler: nil))
            
            presentViewController(controller, animated: true, completion: nil)
            
        } else {
            print("Failed to advertise our beacon. Error = \(error)")
        }
        
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager){
        
        peripheral.stopAdvertising()
        
        //print("The peripheral state is ", appendNewline: false)
        switch peripheral.state{
        case .PoweredOff:
            print("Powered off")
        case .PoweredOn:
            print("Powered on")
        case .Resetting:
            print("Resetting")
        case .Unauthorized:
            print("Unauthorized")
        case .Unknown:
            print("Unknown")
        case .Unsupported:
            print("Unsupported")
        }
        
        /* Bluetooth is now powered on */
        if peripheral.state != .PoweredOn{
            
            let controller = UIAlertController(title: "Bluetooth",
                                               message: "Please turn Bluetooth on",
                                               preferredStyle: .Alert)
            
            controller.addAction(UIAlertAction(title: "OK",
                style: .Default,
                handler: nil))
            
            presentViewController(controller, animated: true, completion: nil)
            
        } else {
            
            let manufacturerData = identifier.dataUsingEncoding(
                NSUTF8StringEncoding,
                allowLossyConversion: false)
            
            let theUUid = CBUUID(NSUUID: uuid)
            
            let cernerID = options.stringForKey("cernerID")
            
            let teamID = options.stringForKey("teamID")
            
            let myInformation = cernerID! + " " + teamID!
            
            let dataToBeAdvertised:[String: AnyObject!] = [
            CBAdvertisementDataLocalNameKey : myInformation,
                CBAdvertisementDataManufacturerDataKey : manufacturerData,
                CBAdvertisementDataServiceUUIDsKey : [theUUid],
                ]
            
            peripheral.startAdvertising(dataToBeAdvertised)
            
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        peripheralManager = CBPeripheralManager(delegate: self, queue: queue)
        if let manager = peripheralManager{
            manager.delegate = self
        }
        
    }
    
    
}
