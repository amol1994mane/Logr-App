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
    
    @IBOutlet weak var goalField: UITextField! //figure out a way to make checkboxes for option
    @IBOutlet weak var journalTextView: UITextView!
    
    @IBOutlet weak var sLabel: UILabel!
    @IBOutlet weak var sl: UISlider!
    @IBAction func slValueChanged(sender: AnyObject) {
        var a = Int(sl.value)
        sLabel.text = "\(a)"
    }

    @IBOutlet weak var s2Label: UILabel!
    @IBOutlet weak var sl2: UISlider!
    @IBAction func sl2ValueChanged(sender: AnyObject) {
        var b = Int(sl2.value)
        s2Label.text = "\(b)"
    }
    
    
    
    var delegate:logCompleted?
    var date = ""
    var time = ""
    
    let file="json23.data"
    
    @IBAction func DoneButton(sender: AnyObject) {
        
        /*
        {
        "11\/16\/14" : {
            "11" : {
                "journal" : "skinned my knee",
                "happiness" : "3",
                "productivity" : "2",
                "goal" : "played soccer"
                }
            }
        }
        */
        
        if (goalField.text != "" && /*sLabel.text != "" && s2Label.text != "" && */journalTextView.text != "") {
            var json:JSON
            if isPreviousData() {
                json = loadPreviousData()

                if (json[date] == nil) {
                    json[date] = ["\(time)":["goal":goalField.text, "happiness":sLabel.text, "productivity":s2Label.text, "journal":journalTextView.text]]
                } else {
                    json[date][time] = ["goal":goalField.text, "happiness":sLabel.text!, "productivity":s2Label.text!, "journal":journalTextView.text]
                }
            } else {
                json=JSON(["\(date)":["\(time)":["goal":goalField.text, "happiness":sLabel.text, "productivity":s2Label.text, "journal":journalTextView.text]]])
            }
            //println(json)
            //WRITE THE FILE
            var error:NSError?
            let jsonData:NSData = json.rawData(options: NSJSONWritingOptions.PrettyPrinted, error:&error)!
            jsonData.writeToFile(getFilePath(), options: NSDataWritingOptions.DataWritingFileProtectionNone, error: &error)
            if let theError = error {
                print("\(theError.localizedDescription)")
            }
            else {
            resignFirstResponder()
            clearFields()
            delegate!.didCompleteLog()
            self.navigationController!.popViewControllerAnimated(true)
            }
        }
        else {
            //display an alert view "please fill out all parts"
        }
    }
    
    func getFile() -> JSON {
        var json:JSON
        json = loadPreviousData()
        return json
    }
    
    func clearFields() {
        goalField.text=""
        //happinessField.text=""
        //productivityField.text=""
        journalTextView.text=""
    }
    
    
    func isPreviousData() ->Bool {
        var error:NSError?
        let previousNSData:NSData? = NSData(contentsOfFile: getFilePath(), options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
        if let theError = error {
            return false
        }
        if let previousNSDataUnwrapped = previousNSData {
            return true
        }
        return false
    }
    
    func loadPreviousData() ->JSON {
        var error:NSError?
        let previousNSData:NSData? = NSData(contentsOfFile: getFilePath(), options: NSDataReadingOptions.DataReadingMappedIfSafe, error: &error)
        var previousJSON:JSON?
        if let theError = error {
            println("\(theError.localizedDescription)")
            return nil
        }
        else {
            previousJSON=JSON(data:previousNSData!)
            return previousJSON!
        }
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