//
//  InterfaceController.swift
//  BitWatch WatchKit Extension
//
//  Created by Lewis W. Johnson on 8/30/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//
import BitWatchKit
import WatchKit
import Foundation


class InterfaceController: WKInterfaceController
{

    @IBAction func refreshTapped()
    {
        
    }
    
    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    
    let tracker = Tracker()
    var updating = false
    
    override func awakeWithContext(context: AnyObject?)
    {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        updatePrice(tracker.cachedPrice())
    }

    override func willActivate()
    {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        update()
    }

    override func didDeactivate()
    {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    private func updatePrice(price: NSNumber)
    {
        priceLabel.setText(Tracker.priceFormatter.stringFromNumber(price))
    }
    
    private func update() {
        // 1
        if !updating {
            updating = true
            // 2
            let originalPrice = tracker.cachedPrice()
            // 3
            tracker.requestPrice { (price, error) -> () in
                // 4
                if error == nil {
                    self.updatePrice(price!)
                }
                self.updating = false
            }
        }
    }

}
