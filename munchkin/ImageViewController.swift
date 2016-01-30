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
    
    func findWeek() {
        let today = NSDate()
        let defaults = NSUserDefaults.standardUserDefaults()
        let dueDate = defaults.objectForKey("DueDate")
        print("due date from storage \(dueDate)")
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        print(Int(ceil((dueDate!.timeIntervalSinceDate(today))/604800)))
        let weeksLeft = String(Int(ceil(dueDate!.timeIntervalSinceDate(today)/604800)))
        weeklyImage.image = UIImage(named: "\(weeksLeft)")
    }
    
    let data = [(week: 1, weight: "8lbs", length: "20in"), (week: 2, weight: "223b", length: "20ins"), (week: 3, weight: "223b", length: "20ins"), (week: 4, weight: "223b", length: "20ins"), (week: 5, weight: "223b", length: "20ins"), (week: 6, weight: "223b", length: "20ins")]
    
    
    
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
