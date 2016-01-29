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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateSelector.hidden = true
        confirmDateButton.hidden = true
        setDateButton.hidden = false
        dueDateLabel.hidden = true
        
        
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
        let today = NSDate()
        datePicker.minimumDate = NSDate()
        setDateButton.hidden = true
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        dueDateFromPicker = datePicker.date
        print("due date from picker \(dueDateFromPicker)")
        print(dueDateFromPicker.timeIntervalSinceDate(today))
        dueDate = formatter.stringFromDate(dueDateFromPicker)
        dueDateLabel.text = "Due Date: \(dueDate)"
        defaults.setObject(dueDateFromPicker, forKey: "DueDate")
    }
    
    @IBAction func confirmDueDate() {
        
        if (dueDate == "") {
            let alert = UIAlertController(title: "Please enter the due date", message: "No never ending pregnancies allowed", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
        dueDateSelector.hidden = true
        confirmDateButton.hidden = true
        }
        
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
