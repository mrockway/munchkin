//
//  ImageViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var WelcomeTour: UIButton!
    @IBOutlet weak var weeklyImage: UIImageView!
    @IBOutlet weak var comparisonText: UILabel!
    @IBOutlet weak var weekNumber: UILabel!
    @IBOutlet weak var staticComapreText: UILabel!
    @IBOutlet weak var backgroundColor: UIImageView!
    
    
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
            backgroundColor.hidden = true
            settings.hidden = true
            weekNumber.hidden = true
            comparisonText.hidden = true
            staticComapreText.hidden = true
            instagramButton.hidden = true
            weeklyImage.hidden = true
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
            let weeksLeft = Int(ceil(weeks))
            print("weeks \(weeks)")
            print("days left is \(dueDate.timeIntervalSinceDate(today)/86400)")
            print("weeksLeft \(weeksLeft), due date \(dueDate)")
            weekNumber.text = "Your baby is in week \( 40 - weeksLeft )"
            weeklyImage.image = UIImage(named: "\(String(weeksLeft))")
            comparisonText.text = "\(data[weeksLeft].comparison)"
        } else {
            let weeks = today.timeIntervalSinceDate(dueDate)/604800
            let weeksLeft = Int(floor(weeks))
            let weeksOver = weeksLeft + 40
            print(weeksOver)
            print("else days left is \(today.timeIntervalSinceDate(dueDate)/86400)")
            print("else weeks \(weeks)")
            print("else weeksLeft \(weeksOver), due date \(dueDate)")
            if (weeksLeft == 0) {
                weekNumber.text = "Your baby is due this week!"
                weeklyImage.image = UIImage(named: "\(String(weeksLeft ))")
                staticComapreText.hidden = true
                comparisonText.text = "It is the size of \(data[weeksLeft].comparison)"
            } else {
                weekNumber.text = "Your baby is in week \( weeksOver )"
                weeklyImage.image = UIImage(named: "\(String(weeksOver ))")
                comparisonText.text = "\(data[weeksOver].comparison)"
            }
        }
    }

    @IBAction func shareInstagram(sender: AnyObject) {
        print("button clicked")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTimeUser()
        // findWeek()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Fetal growth data and comparisons
    let data = [
        (week: "40", length: "20.16 inches", weight: "7.63 pounds", comparison: "a rack of ribs"),
        (week: "39", length: "19.96 inches", weight: "7.25 pounds", comparison: "week 39"),
        (week: "38", length: "19.61 inches", weight: "6.80 pounds", comparison: "Indy's fedora"),
        (week: "37", length: "19.13 inches", weight: "6.30 pounds", comparison: "week 37"),
        (week: "36", length: "18.66 inches", weight: "5.78 pounds", comparison: "week 36"),
        (week: "35", length: "18.19 inches", weight: "5.25 pounds", comparison: "week 35"),
        (week: "34", length: "17.72 inches", weight: "4.73 pounds", comparison: "a baseball glove"),
        (week: "33", length: "17.20 inches", weight: "4.23 pounds", comparison: "week 33"),
        (week: "32", length: "16.69 inches", weight: "3.75 pounds", comparison: "drumsticks"),
        (week: "31", length: "16.18 inches", weight: "3.31 pounds", comparison: "stock rims"),
        (week: "30", length: "15.71 inches", weight: "2.91 pounds", comparison: "a baseball hat"),
        (week: "29", length: "15.20 inches", weight: "2.54 pounds", comparison: "a hammer"),
        (week: "28", length: "14.80 inches", weight: "2.22 pounds", comparison: "a steering wheel"),
        (week: "27", length: "14.41 inches", weight: "1.93 pound", comparison: "a 15in computer"),
        (week: "26", length: "14.02 inches", weight: "1.68 pound", comparison: "Thor's hammer"),
        (week: "25", length: "13.62 inches", weight: "1.46 pound", comparison: "adragon egg"),
        (week: "24", length: "11.81 inches", weight: "1.32 pound", comparison: "a footlong sub"),
        (week: "23", length: "11.38 inches", weight: "1.10 pound", comparison: "a football"),
        (week: "22", length: "10.94 inches", weight: "5.17 ounces", comparison: "a lightsaber hilt"),
        (week: "21", length: "10.51 inches", weight: "2.70 ounces", comparison: "week 21"),
        (week: "20", length: "10.08 inches", weight: "0.58 ounces", comparison: "a beer bottle"),
        (week: "19", length: "6.02 inches",	weight: "8.47 ounces", comparison: "a hot dog"),
        (week: "18", length: "5.59 inches",	weight: "6.70 ounces", comparison: "a cigar"),
        (week: "17", length: "5.12 inches",	weight: "4.94 ounces", comparison: "week 17"),
        (week: "16", length: "4.57 inches",	weight: "3.53 ounces", comparison: "a NES controller"),
        (week: "15", length: "3.98 inches",	weight: "2.47 ounces", comparison: "a travel size deodorant"),
        (week: "14", length: "3.42 inches",	weight: "1.52 ounce", comparison: "a Rubix cube"),
        (week: "13", length: "2.91 inches",	weight: "0.81 ounce", comparison: "a hockey puck"),
        (week: "12", length: "2.13 inches",	weight: "0.49 ounce", comparison: "a shot glass"),
        (week: "11", length: "1.61 inch",	weight: "0.25 ounce", comparison: "a Lego mini figure"),
        (week: "10", length: "1.22 inch",	weight: "0.14 ounce", comparison: "a poker chip"),
        (week: "9", length: "0.90 inch", weight: "0.07 ounce", comparison: "a lugnut"),
        (week: "8", length: "0.63 inch", weight: "0.04 ounce", comparison: "a cufflink"),
        (week: "7", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "6", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "5", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "4", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "3", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "2", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "1", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "0", length: "N/A",	weight: "N/A", comparison: ""),
        (week: "41", length: "20.35 inches", weight: "7.93 pounds", comparison: "week 41"),
        (week: "42", length: "20.28 inches", weight: "8.12 pounds", comparison: "week 42")]
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
