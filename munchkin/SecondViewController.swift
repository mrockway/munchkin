//
//  SecondViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // get user defaults from storage
    let defaults = NSUserDefaults.standardUserDefaults()
    
    // declare variables
    var dueDate: String = ""
    var dueDateFromPicker = NSDate()
    let formatter = NSDateFormatter()
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var dueDateSelector: UIDatePicker!
    @IBOutlet weak var confirmDateButton: UIButton!
    @IBOutlet weak var enterDateLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var datePickerContainer: UIImageView!
    @IBOutlet weak var selectDateDescription: UILabel!
    @IBOutlet weak var dueDateBackgroundLabel: UIImageView!
    @IBOutlet weak var dueDateStatic: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide date picker and confirm buttons
        dueDateSelector.hidden = true
        confirmDateButton.hidden = true
        setDateButton.hidden = false
        
        // if there is a saved date from a return user 
        // set that date as the label text
        // otherwise hide the label
        if let savedDueDate = defaults.objectForKey("DueDate") {
            dueDateSelector.setDate(savedDueDate as! NSDate, animated: true)
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            dueDateLabel.text = "\(formatter.stringFromDate(savedDueDate as! NSDate))"
        } else {
        
            dueDateStatic.hidden = true
        }
        
        // call style function
        setStyleAttributes()
        // Do any additional setup after loading the view.
    }
    
    func setStyleAttributes() {
        
        // Set up shadow attributes
        let rgb: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let black: [CGFloat]   = [0, 0, 0, 1]
        
        // border color for containers
        let borderColor = UIColor(red:154/255.0, green:154/255.0, blue:147/255.0, alpha: 1.0).CGColor
        
        // Styling for adding a date button
        setDateButton.layer.cornerRadius = 5
        setDateButton.layer.borderColor = borderColor
        setDateButton.layer.borderWidth = 3
        setDateButton.layer.shadowOffset = CGSizeMake(-2, 2)
        setDateButton.layer.shadowRadius = 5
        setDateButton.layer.shadowColor = CGColorCreate(rgb, black)
        setDateButton.layer.shadowOpacity = 1
        
        // Styling for confirming date button
        confirmDateButton.layer.cornerRadius = 5
        confirmDateButton.layer.borderColor = borderColor
        confirmDateButton.layer.borderWidth = 3
        confirmDateButton.layer.shadowOffset = CGSizeMake(-2, 2)
        confirmDateButton.layer.shadowRadius = 5
        confirmDateButton.layer.shadowColor = CGColorCreate(rgb, black)
        confirmDateButton.layer.shadowOpacity = 1
        
        // X button to go back to image screen
        cancelButton.layer.cornerRadius = 5
        
        // style date picker container
        datePickerContainer.layer.borderWidth = 5
        datePickerContainer.layer.borderColor = borderColor
        datePickerContainer.layer.cornerRadius = 10
        datePickerContainer.layer.shadowRadius = 5
        datePickerContainer.layer.shadowColor = CGColorCreate(rgb, black)
        datePickerContainer.layer.shadowOpacity = 1
        datePickerContainer.layer.shadowOffset = CGSizeMake(-2,2)
        
        // style upper portion of date picker view
        dueDateBackgroundLabel.layer.borderWidth = 5
        dueDateBackgroundLabel.layer.borderColor = borderColor
        dueDateBackgroundLabel.layer.cornerRadius = 10
        dueDateBackgroundLabel.layer.shadowRadius = 5
        dueDateBackgroundLabel.layer.shadowColor = CGColorCreate(rgb, black)
        dueDateBackgroundLabel.layer.shadowOpacity = 1
        dueDateBackgroundLabel.layer.shadowOffset = CGSizeMake(-2,2)
    }
    
    // setup datepicker layout after selecting add date button
    @IBAction func setInitialDate() {
        dueDateSelector.hidden = false
        dueDateSelector.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        dueDateLabel.hidden = false
        setDateButton.hidden = true
        confirmDateButton.hidden = false
        
        // get saved date from storage if it exists and set it as the default picker value
        if let savedDueDate = defaults.objectForKey("DueDate") {
            dueDateSelector.setDate(savedDueDate as! NSDate, animated: true)
            formatter.dateStyle = NSDateFormatterStyle.LongStyle
            dueDateLabel.text = "\(formatter.stringFromDate(savedDueDate as! NSDate))"
        }
    }
    
    
    
    // Set the due date 
    func datePickerChanged(datePicker:UIDatePicker) {
        
        // give datepicker parameters to only include current date to 40 weeks from current date
        let fourtyWeeks = NSDate(timeInterval: (24192000), sinceDate: NSDate())
        datePicker.minimumDate = NSDate()
        datePicker.maximumDate = fourtyWeeks
        
        // hide add date button
        setDateButton.hidden = true
        
        // format date to a readable format and convert into string
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        dueDateFromPicker = datePicker.date
        dueDate = formatter.stringFromDate(dueDateFromPicker)
        dueDateLabel.text = "\(dueDate)"
    }
    
    @IBAction func confirmDueDate() {
        
        // no date is selected show alert message otherwise save the due date and a boolean to show user has visited site into storage
        // schedule notifications
        // perform segue into image view
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
        
        // Clear any existing notifications before setting new ones
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        // Set number of notifiations to schedule
        let weeksRemaining = Double(repeatNotifications())
        
        // Build notification
        let notification = UILocalNotification()
        
        // Loop to create weekly notifications until the due date
        for var i:Double = 0; i <= weeksRemaining; i++ {
            notification.fireDate = NSDate(timeIntervalSinceNow: (604800 * i ))
            notification.alertBody = "Check out your new picture"
            notification.alertAction = "View image"
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    // finds how many weeks until due date and returns that number
    func repeatNotifications() -> Int {
        let weeks = dueDateFromPicker.timeIntervalSinceDate(NSDate())/604800
        let weeksLeft = Int(ceil(weeks))
        return weeksLeft
    }
    
    // change button text
    func adjustDueDate() {
        enterDateLabel.text = "Change the due date"
        setDateButton.setTitle("Edit Due Date", forState: .Normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // setup app to handle motion events
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // On shake event the phone displays a helpful message
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            let ac = UIAlertController(title: "Careful", message: "Dont't shake the baby!", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "You have been warned", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
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
