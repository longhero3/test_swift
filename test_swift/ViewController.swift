//
//  ViewController.swift
//  test_swift
//
//  Created by East Agile on 6/3/14.
//  Copyright (c) 2014 East Agile. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    @IBOutlet var appsTableView : UITableView
    var data: NSMutableData = NSMutableData()
    var tableData: NSArray = NSArray()
    var currentMatchIndex: Int = 0
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveMatchData()
    }
    
    func retrieveMatchData() {
        var urlPath = "http://192.168.1.115:3003/matches/index.json"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        
        println("Get all matches for today")
        
        connection.start()
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    

    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        println(rowData["title"])

        cell.text = rowData["title"] as NSString
        cell.detailTextLabel.text = rowData["id"].string
        cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) -> () {
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        self.currentMatchIndex = indexPath.row
        self.performSegueWithIdentifier("showMatchDetails", sender: nil)
    }
    
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Connection failed.\(error.localizedDescription)")
    }
    
    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
        println("Recieved response")
    }
    
    
    func connection(didRecØØeiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the recieved chunk of data to our data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert it to a string
        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)
        
        // Convert the retrieved data in to an object through JSON deserialization
        var err: NSError
        println(self.data)
        var arrayResult: NSArray = NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray

        if arrayResult.count>0 {
            self.tableData = arrayResult
            self.appsTableView.reloadData()
            
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if ( segue.identifier == "showMatchDetails" ) {
            var detailViewController: ShowMatchDetailViewController = segue.destinationViewController as ShowMatchDetailViewController
            let rowData: NSDictionary = self.tableData[self.currentMatchIndex] as NSDictionary
            detailViewController.setMatch(matchTemp: rowData)
        }
    }
    
}
