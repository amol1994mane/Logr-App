//
//  Logs2VC.swift
//  Logr
//
//  Created by Amol Mane on 09/11/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import UIKit

class Logs2VC: UIViewController {

    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var happinessField: UITextField!
    @IBOutlet weak var productivityField: UITextField!
    @IBOutlet weak var journalField: UITextField!
    
    let file="json.data"
    
    @IBAction func DoneButton(sender: AnyObject) {
        var json=JSON(["10-11-14":["08":["goal":goalField.text, "happiness":happinessField.text, "productivity":productivityField.text, "journal":journalField.text]]])
        var error:NSError?
        let jsonData:NSData = json.rawData(options: NSJSONWritingOptions.PrettyPrinted, error:&error)!
        jsonData.writeToFile(getFilePath(), options: NSDataWritingOptions.DataWritingFileProtectionNone, error: &error)
        if let theError = error {
            print("\(theError.localizedDescription)")
        }
        
        clearFields()
        
        var previousData = loadPreviousData()
        println(previousData)
        //figure out a way to make checkboxes for options
        //after clicking done, app should shift to the previous table. table should have been updated (one less cell because we filled out information for it)
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
    
    /*
    @IBAction func loadName(sender: AnyObject) {
    
    var error:NSError?
    let data:NSData? = NSData(contentsOfFile: getFilePath(), options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
    if let theError = error {
    print("\(theError.localizedDescription)")
    } else {
    let json = JSON(data:data!)
    let name = json["name"].string
    if name != nil{
    nameField.text = name
    }
    if let surname = json["surname"].string {
    surnameField.text = surname
    }
    }
    }
    */

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
