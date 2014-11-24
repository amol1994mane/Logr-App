//
//  JournalTVC.swift
//  Logr
//
//  Created by Amol Mane on 27/10/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import UIKit

class JournalTVC: UITableViewController, UITableViewDelegate, journalChecked {
    
    var journals:[String:[String:String]] = ["lol":["lol":"lol"]]
    var filledLogs:[String:[String]] = ["lol":["lol"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        journals.removeAll(keepCapacity: false)
        filledLogs.removeAll(keepCapacity: false)
        
        var copy = Logs2VC()
        var jsonData = copy.loadPreviousData()
        var copy2 = LogsTVC()
        filledLogs = copy2.getFilledLogs()
        
        println(jsonData)
        println(filledLogs)
        
        var dateArray = [String](filledLogs.keys)
        
        if (filledLogs.count > 0) {
            
            for x in 0...(filledLogs.count - 1) {
                var date = dateArray[x]
                for y in 0...((filledLogs[date]! as Array).count - 1) {
                    var newHr = (filledLogs[date]! as Array)[y]
                    var journalEntry = jsonData[date][newHr]["journal"]
                    var jjr = journalEntry.stringValue
                    
                    if ((journals[date]) != nil) {
                        var j = journals[date]! as [String:String]
                        j.updateValue(jjr, forKey: newHr)
                        journals.updateValue(j, forKey: date)
                    }
                    else {
                        var dict = [newHr:jjr]
                        journals.updateValue(dict, forKey: date)
                    }
                }
            }
            }
            //else {
            //journals = ["":["":""]]
            //}
        
        println(journals)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        return journals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("JournalCell", forIndexPath: indexPath) as UITableViewCell
        
        //self.viewWillAppear(true)
        
        var dateArray = [String](filledLogs.keys)
        var dt = dateArray[indexPath.row]

        /*
        var hourArray = [String]((journals[dt]! as Dictionary).keys)
        var hr = hourArray[indexPath.row]
        var jArray = [String]((journals[dt]! as Dictionary).values)
        var j = jArray[indexPath.row]
        */
        cell.textLabel.text = dt
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        var n = self.tableView.indexPathForSelectedRow()?.row
        var dateArray = [String](journals.keys)
        var date = dateArray[n!]
        
        println(date)
        
        let journal2TVC = segue.destinationViewController as Journal2TVC
        journal2TVC.delegate=self
        journal2TVC.date = date
        journal2TVC.journals = journals
        
    }
    
    
    func getJournals() -> [String:[String:String]] {
        self.viewWillAppear(true)
        return journals
    }
    
}
