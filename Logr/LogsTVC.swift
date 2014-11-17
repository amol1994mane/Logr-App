//
//  LogsTVC.swift
//  Logr
//
//  Created by Amol Mane on 27/10/14.
//  Copyright (c) 2014 ManeAppWorld. All rights reserved.
//

import UIKit

class LogsTVC: UITableViewController, UITableViewDelegate, logCompleted {

    
    var dateAndTimes = ["day":["1","2"]]
    var toBeFilled = ["date",1]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateAndTimes.removeValueForKey("day")
        dateAndTimes.updateValue(["08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"], forKey: "11/15/14" )
        dateAndTimes.updateValue(["11","12","13","14","15","16","17","18","19","20","21","22","23"], forKey: "11/16/14" )
        dateAndTimes.updateValue(["18","19","20","21","22","23"], forKey: "11/14/14")
        
        
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

    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return dateAndTimes.count
    }

    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        var dateArray = [String](dateAndTimes.keys)
        return (dateAndTimes[dateArray[section]]! as Array).count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        var dateArray = [String](dateAndTimes.keys)
        var number = indexPath.section
        cell.textLabel.text = (dateAndTimes[dateArray[number]]! as Array)[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var dateArray = [String](dateAndTimes.keys)
        return dateArray[section]
    }
    
    /*
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    */


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
        
        var indexPath = self.tableView.indexPathForSelectedRow()!
        
        var dateArray = [String](dateAndTimes.keys)
        
        var section = indexPath.section
        var row = indexPath.row
        
        var date = dateArray[indexPath.section]
        var time = row
        
        toBeFilled[0]=date
        toBeFilled[1]=time

        let logs2VC=segue.destinationViewController as Logs2VC
        logs2VC.delegate=self
    }
    
    func didCompleteLog() {
        var date = toBeFilled[0] as String
        var time = toBeFilled[1] as Int
        
        if ( (dateAndTimes[date]! as Array).count > 1) {
            //delete only the time
            (dateAndTimes[date]!).removeAtIndex(time)
        }
        else {
            //delete both date and time
            dateAndTimes.removeValueForKey(date)
        }
        self.tableView.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
