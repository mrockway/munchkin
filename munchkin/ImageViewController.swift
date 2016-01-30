//
//  ImageViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

// Check dueDate - Todays Date and check if date in weekly range
// Set image based on min day of range, it should == arr[i]


class ImageViewController: UIViewController {
    
    @IBOutlet weak var weeklyImage: UIImageView!
    
    func getDate() -> NSDate {
        let defaults = NSUserDefaults.standardUserDefaults()
        let dueDate = defaults.objectForKey("DueDate")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dueDate as! NSDate
    }
    func findWeek() {
        let dueDate = getDate()
        let today = NSDate()
        let weeks = dueDate.timeIntervalSinceDate(today)/604800
        let weeksLeft = String(Int(ceil(weeks)))
        weeklyImage.image = UIImage(named: "\(weeksLeft)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
