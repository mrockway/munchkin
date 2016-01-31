//
//  ImageViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var WelcomeTour: UIButton!
    @IBOutlet weak var weeklyImage: UIImageView!
    @IBAction func welcomeTour(sender: AnyObject) {
        
    }
    
    func firstTimeUser() {
        let skipWelcome = getUserSettings()
        if (skipWelcome == true) {
            findWeek()
            return
        } else {
            return
        }
    }
    
    func getUserSettings() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        let returningUser = defaults.boolForKey("returningUser")
        if returningUser == false {
            WelcomeTour.hidden = false
            settings.hidden = true
            return false
        } else {
            WelcomeTour.hidden = true
            return true
        }
    }

    func getDate() -> NSDate {
        let defaults = NSUserDefaults.standardUserDefaults()
        let dueDate = defaults.objectForKey("DueDate")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if dueDate == nil {
            return NSDate()
        } else {
            return dueDate as! NSDate
        }

    }
    func findWeek() {
        let dueDate = getDate()
        let today = NSDate()
        let compare = (dueDate.compare(today)  == .OrderedDescending)
        if( compare  == true ) {
            // dueDate < today
            let weeks = dueDate.timeIntervalSinceDate(today)/604800
            let weeksLeft = String(Int(ceil(weeks)))
            weeklyImage.image = UIImage(named: "\(weeksLeft)")
        } else {
            let weeks = today.timeIntervalSinceDate(dueDate)/604800
            let weeksLeft = String(Int(ceil(weeks))+40)
            weeklyImage.image = UIImage(named: "\(weeksLeft)")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTimeUser()
        findWeek()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
