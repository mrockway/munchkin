//
//  SecondViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var dueDate: String = ""
    var dueDateFromPicker = NSDate()
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var dueDateSelector: UIDatePicker!
    @IBOutlet weak var confirmDateButton: UIButton!
    @IBOutlet weak var enterDateLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePickerContainer: UIImageView!
    @IBOutlet weak var selectDateDescription: UILabel!
    @IBOutlet weak var dueDateBackgroundLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateSelector.hidden = true
        confirmDateButton.hidden = true
        setDateButton.hidden = false
        dueDateLabel.hidden = true
        setDateButton.layer.cornerRadius = 5
        confirmDateButton.layer.cornerRadius = 5
        cancelButton.layer.cornerRadius = 5
        datePickerContainer.layer.cornerRadius = 10
        dueDateBackgroundLabel.layer.cornerRadius = 10
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setInitialDate() {
        dueDateSelector.hidden = false
        dueDateSelector.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        dueDateLabel.hidden = false
        setDateButton.hidden = true
        confirmDateButton.hidden = false
    }
    
    
    
    // Set the due date 
    func datePickerChanged(datePicker:UIDatePicker) {
        let fourtyWeeks = NSDate(timeInterval: (24192000), sinceDate: NSDate())
        datePicker.minimumDate = NSDate()
        datePicker.maximumDate = fourtyWeeks
        setDateButton.hidden = true
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        dueDateFromPicker = datePicker.date
        dueDate = formatter.stringFromDate(dueDateFromPicker)
        dueDateLabel.text = "Due Date: \(dueDate)"
    }
    
    @IBAction func confirmDueDate() {
        if (dueDate == "") {
            let alert = UIAlertController(title: "Please enter the due date", message: "No never ending pregnancies allowed", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            dueDateSelector.hidden = true
            confirmDateButton.hidden = true
            defaults.setObject(dueDateFromPicker, forKey: "DueDate")
            defaults.setBool(true, forKey: "returningUser")
            scheduleNofifications()
        }
        
    }
    
    func scheduleNofifications() {
        // Check to see if User has allowed Notifications
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        // Send message to user about not allowing notifications
        if settings!.types == .None {
            let ac = UIAlertController(title: "Enable notifications to find out when you new comparison is ready", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        
        // Clear any existing notifications
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Set number of notifiations to schedule
        let weeksRemaining = Double(repeatNotifications())
        
        // Build notification
        let notification = UILocalNotification()
        
        // Loop to create notifications until the due date
        for var i:Double = 0; i <= weeksRemaining; i++ {
            notification.fireDate = NSDate(timeIntervalSinceNow: (604800 * i ))
            // notification.repeatInterval = NSCalendarUnit.Weekday
            notification.alertBody = "Check out your new picture"
            notification.alertAction = "View image"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    func repeatNotifications() -> Int {
        let weeks = dueDateFromPicker.timeIntervalSinceDate(NSDate())/604800
        let weeksLeft = Int(ceil(weeks))
        print("weeks left \(weeksLeft)")
        return weeksLeft
    }
    
    func adjustDueDate() {
        enterDateLabel.text = "Change the due date"
        setDateButton.setTitle("Edit Due Date", forState: .Normal)
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
