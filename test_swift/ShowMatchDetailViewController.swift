//
//  ShowMatchDetailViewController.swift
//  test_swift
//
//  Created by East Agile on 6/4/14.
//  Copyright (c) 2014 East Agile. All rights reserved.
//

import UIKit

class ShowMatchDetailViewController: UIViewController {
    
    var match = NSDictionary()

    @IBOutlet var lblTitle : UILabel

    @IBOutlet var btnTeamA : UIButton
    
    @IBOutlet var btnTeamB : UIButton
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder?) {
        super.init(coder: aDecoder!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblTitle.text = match["title"] as NSString
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setMatch(matchTemp match: NSDictionary) {
        self.match = match
    }
    
    @IBAction func selectTeamA(sender : UIButton) {
        btnTeamA.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btnTeamB.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    }
    
    @IBAction func selectTeamB(sender : UIButton) {
        btnTeamB.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btnTeamA.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
    }
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
