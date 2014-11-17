//
//  Logs2VC.swift
//  Logr
//
//  Created by Amol Mane on 09/11/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import UIKit

protocol logCompleted:NSObjectProtocol {
    func didCompleteLog()
}

class Logs2VC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var goalField: UITextField! //figure out a way to make checkboxes for options
    @IBOutlet weak var happinessField: UITextField!
    @IBOutlet weak var productivityField: UITextField!
    @IBOutlet weak var journalField: UITextField!
    
    var delegate:logCompleted?
    
    let file="json.data"
    
    @IBAction func DoneButton(sender: AnyObject) {
        
        if (goalField.text != "" && happinessField.text != "" && productivityField.text != "" && journalField.text != "") {
            
            var json=JSON(["10-11-14":["08":["goal":goalField.text, "happiness":happinessField.text, "productivity":productivityField.text, "journal":journalField.text]]])
            var error:NSError?
            let jsonData:NSData = json.rawData(options: NSJSONWritingOptions.PrettyPrinted, error:&error)!
            jsonData.writeToFile(getFilePath(), options: NSDataWritingOptions.DataWritingFileProtectionNone, error: &error)
            if let theError = error {
                print("\(theError.localizedDescription)")
            }
            
            resignFirstResponder()
            clearFields()
            
            var previousData = loadPreviousData()
            println(previousData)
            
            //figure out how to rewrite JSON data after including new data and putting it in relevant hierarchy
            
            delegate!.didCompleteLog()
            //pop back to the previous View Controller
            
        }
            
        else {
            //display an alert view "please fill out all parts"
        }
    }
    
    func clearFields() {
        goalField.text=""
        happinessField.text=""
        productivityField.text=""
        journalField.text=""
    }
    
    func loadPreviousData() ->JSON {
        var error:NSError?
        let previousNSData:NSData? = NSData(contentsOfFile: getFilePath(), options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
        var previousJSON:JSON?
        if let theError = error {
            println("\(theError.localizedDescription)")
        }
        else {
            previousJSON=JSON(data:previousNSData!)
        }
        return previousJSON!
    }
    
    func getFilePath()->String {
        let dirs:[String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        var path = ""
        if dirs != nil {
            //what is the purpose of the next 2 lines?
            let directories:[String] = dirs!
            let dirs = directories[0]
            path=dirs.stringByAppendingPathComponent(file)
        }
        return path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
