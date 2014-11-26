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
    var filledLogs = ["day":["1"]]
    
    func stringToDate(#year:Int, month:Int, day:Int, hour:Int, minutes: Int) -> NSDate {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        c.hour = hour
        c.minute = minutes
        
        var gregorian = NSCalendar(identifier:NSGregorianCalendar)
        var date = gregorian!.dateFromComponents(c)
        return date!
    }
    
    class func dateToString (date: NSDate) -> (year: Int, month: Int, day: Int, hour: Int, minutes: Int){
        var calendar = NSCalendar.currentCalendar()
        var c = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        var year = c.year
        var month = c.month
        var day = c.day
        var hour = c.hour
        var minutes = c.minute
        return (year: year, month: month, day: day, hour: hour, minutes: minutes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //var trial = Notifications()
        //trial.createArray(NSDate())
        
        //string will be the time at which user opens the app for the first time
        var startTime = stringToDate(year: 2014, month: 11, day: 20, hour: 08, minutes: 00)
        var nowTime = NSDate()
        var difference = nowTime.timeIntervalSinceDate(startTime)
        //println(startTime)
        //println(nowTime)
        //println(difference)
        
        var s:Int = Int(difference)
        var m = s/60
        var h = m/60
        var d = h/24
        
        var counter = h - (8 * d)
        var c = 0
        
        var hoursInLastDay = h - (d * 24)
        
        var daysAndHours1=[0:["0"]]
        var hours=["0"]
        daysAndHours1.removeAll(keepCapacity: false)
        hours.removeAtIndex(0)
        
        for i in 0...d {
            for j in 08...23 {
                if(c<=counter) {
                    hours.append(String(j))
                    c++
                }
            }
            daysAndHours1.updateValue(hours, forKey: i)
            hours.removeAll(keepCapacity: false)
        }
        
        dateAndTimes.removeAll(keepCapacity: false)
        filledLogs.removeAll(keepCapacity: false)
        
        for i in 0...d {
            var interval = 86400 * Double(i)
            var dayDate = startTime.dateByAddingTimeInterval(interval)
            var formatter = NSDateFormatter()
            formatter.dateStyle = .ShortStyle
            var dayString = formatter.stringFromDate(dayDate)
            dayString = dayString.stringByReplacingOccurrencesOfString("/", withString: "-", options: NSStringCompareOptions.LiteralSearch, range: nil)
            //println(dayString)
            dateAndTimes.updateValue( daysAndHours1[i]!, forKey: dayString)
        }
        
        //send notifications once dateAndTimes hour gets updated
        
        var copy = Logs2VC()
        var jsonData = copy.loadPreviousData()
        
        var dateArray = [String](dateAndTimes.keys)
        
        for x in 0...(dateArray.count - 1) {
            
            var hrs = (dateAndTimes[dateArray[x]]! as Array).count - 1
            var cc = 0
            for j in 0...hrs {
                
                var t = jsonData[dateArray[x]]["\(j+8)"]["journal"]
                var f:Bool
                if (t != nil) {
                    f = true
                }
                else {
                    f = false
                }
                if (f){
                    //println(dateAndTimes[dateArray[x]])
                    var add = dateAndTimes[dateArray[x]]?.removeAtIndex(j-cc)
                    if ((filledLogs[dateArray[x]]) != nil){
                        var hrs = filledLogs[dateArray[x]]! as Array
                        hrs.append(add!)
                        filledLogs.updateValue(hrs, forKey: dateArray[x])
                    }
                    else {
                        var arr:[String] = [add! as String]
                        filledLogs.updateValue(arr, forKey: dateArray[x])
                    }
                    cc++
                }
                if ((dateAndTimes[dateArray[x]]! as Array).count == 0){
                    dateAndTimes.removeValueForKey(dateArray[x])
                }
            }
        }
        
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
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
        logs2VC.date = date
        logs2VC.time = (dateAndTimes[date]! as Array)[time]

        
    }
    
    func didCompleteLog() {
        var date = toBeFilled[0] as String
        var time = toBeFilled[1] as Int
        
        if ( (dateAndTimes[date]! as Array).count > 1) {
            //delete only the time
            var add = (dateAndTimes[date]!).removeAtIndex(time)
            println(filledLogs)
            if ((filledLogs[date]) != nil) {
                var arr = filledLogs[date]
                println(arr)
                filledLogs.updateValue(arr!, forKey: date)
            }
            else {
                var arr = [add]
                filledLogs.updateValue(arr, forKey: date)
            }
        }
        else {
            //delete both date and time
            dateAndTimes.removeValueForKey(date)
        }
        self.tableView.reloadData()
    }
    
    func getLogDetails(aName: String) -> [String] {
        var date = toBeFilled[0] as String
        var time = toBeFilled[1] as String
        return [date,time]
    }
    
    func getFilledLogs() -> [String:[String]] {
        self.viewDidLoad()
        return filledLogs
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
