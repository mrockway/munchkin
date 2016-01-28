//
//  SecondViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/28/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var dueDate: String = ""
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var setDateButton: UIButton!
    @IBOutlet weak var dueDateSelector: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // dueDateSelector.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        dueDateSelector.hidden = true
        if(dueDate == "") {
            setDateButton.hidden = false
            dueDateLabel.hidden = true
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func setInitialDate() {
        dueDateSelector.hidden = false
        dueDateSelector.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        dueDateLabel.hidden = false
        setDateButton.hidden = true
    }
    
    
    func datePickerChanged(datePicker:UIDatePicker) {
        var dueDateFromPicker = NSDate()
        setDateButton.hidden = true
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        dueDateFromPicker = datePicker.date
        dueDate = formatter.stringFromDate(dueDateFromPicker)
        dueDateLabel.text = "Due Date: \(dueDate)"
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
