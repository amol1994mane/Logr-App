//
//  Journal2TVC.swift
//  Logr
//
//  Created by Amol Mane on 27/10/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import UIKit

protocol journalChecked:NSObjectProtocol {
}

class Journal2TVC: UITableViewController {

    var delegate:journalChecked?
    var date:String = "lol"
    var journals:[String:[String:String]] = ["lol":["lol":"lol"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        return (journals[date]! as Dictionary).count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("journalDetailCell", forIndexPath: indexPath) as UITableViewCell

        var hourArray = [String]((journals[date]! as Dictionary).keys)
        var hr = hourArray[indexPath.row]
        var jArray = [String]((journals[date]! as Dictionary).values)
        var j = jArray[indexPath.row]
        
        cell.textLabel.text = hr
        cell.detailTextLabel?.text = j
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}


/*
stuff from JournalTVC
//
//  JournalTVC.swift
//  Logr
//
//  Created by Amol Mane on 27/10/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import UIKit

class JournalTVC: UITableViewController {

var journals:[String:[String:String]] = ["lol":["lol":"lol"]]
var filledLogs:[String:[String]] = ["lol":["lol"]]


override func viewDidLoad() {
super.viewDidLoad()

// Uncomment the following line to preserve selection between presentations
// self.clearsSelectionOnViewWillAppear = false

// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
// self.navigationItem.rightBarButtonItem = self.editButtonItem()
}


override func viewDidAppear(animated: Bool) {

journals.removeAll(keepCapacity: false)
filledLogs.removeAll(keepCapacity: false)

var copy = Logs2VC()
var jsonData = copy.loadPreviousData()
var copy2 = LogsTVC()
filledLogs = copy2.getFilledLogs()

//println(filledLogs)

var dateArray = [String](filledLogs.keys)
//println(dateArray)

for x in 0...(filledLogs.count - 1) {
var date = dateArray[x]
for y in 0...((filledLogs[date]! as Array).count - 1) {
var newHr = (filledLogs[date]! as Array)[y]
var journalEntry = jsonData[date][newHr]["journal"]
var jjr = journalEntry.stringValue
//println(journalEntry)
if ((journals[date]) != nil) {
var j = journals[date]! as [String:String]
j.updateValue(jjr, forKey: newHr)
journals.updateValue(j, forKey: date)
}
else {
var dict = [newHr:jjr]
journals.updateValue(dict, forKey: date)
}
//println(journals)
}
}
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}

// MARK: - Table view data source


override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
// #warning Potentially incomplete method implementation.
// Return the number of sections.
return journals.count
}


override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
// #warning Incomplete method implementation.
// Return the number of rows in the section.

var dateArray = [String](journals.keys)
var date = dateArray[section]
var numHrs = journals[date]?.count

return numHrs!
}


override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
var dateArray = [String](journals.keys)
return dateArray[section]
}


override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

let cell = tableView.dequeueReusableCellWithIdentifier("JournalCell", forIndexPath: indexPath) as UITableViewCell

self.viewDidAppear(true)

var dateArray = [String](journals.keys)
var dt = dateArray[indexPath.section]
var hourArray = [String]((journals[dt]! as Dictionary).keys)
var hr = hourArray[indexPath.row]
var jArray = [String]((journals[dt]! as Dictionary).values)
var j = jArray[indexPath.row]

cell.textLabel.text = hr
cell.detailTextLabel?.text = j

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

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
// Get the new view controller using [segue destinationViewController].
// Pass the selected object to the new view controller.
}
*/

func getJournals() -> [String:[String:String]] {
self.viewDidAppear(true)
return journals
}

}

*/