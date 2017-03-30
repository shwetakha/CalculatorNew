//
//  ViewController.swift
//  Calculator
//
//  Created by Sachin Kesiraju on 6/3/14.
//  Copyright (c) 2014 Sachin Kesiraju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var resultLabel : UILabel?
    
    var userEnteringNumber :Bool = true
    var operandStack: NSMutableArray = []  //array containing two numbers to equate
    var operationSelected:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPressed(_ sender : AnyObject) {
        let digit: String = (sender.currentTitle)!!
        if(userEnteringNumber == true)
        {
          self.resultLabel!.text = self.resultLabel!.text! + (digit as String)
        }
        else
        {
          self.resultLabel!.text = digit as String
        }
    }

    @IBAction func operationPressed(_ sender : AnyObject) {
        
        if(self.userEnteringNumber == true)
        {
            let numberCurrentlyDisplayed:NSString = self.resultLabel!.text! as NSString
            operationSelected = (sender.currentTitle)!!
            self.pushOperand(numberCurrentlyDisplayed.doubleValue)
            self.resultLabel!.text = ""
        }
    }
    
    @IBAction func equatePressed(_ sender : AnyObject) {
        
        let numberShownBeforeEquate:NSString = self.resultLabel!.text! as NSString
        self.pushOperand(numberShownBeforeEquate.doubleValue)
        self.userEnteringNumber = false
        let result:Double = self.performOperation(operationSelected as NSString)
        let resultNumber:NSNumber = result as NSNumber
        self.resultLabel!.text = resultNumber.stringValue
    }
    
    @IBAction func clearScreen (_ sender :AnyObject)
    {
        self.resultLabel!.text = "0"
        operandStack.removeAllObjects()
    }
    
    func pushOperand (_ operand:Double) //Add numbers to array
    {
        operandStack.add(NSNumber(value: operand as Double))
    }
    
    func popOperand () -> Double //returns number to calculate with
    {
        let operandObject:NSNumber = self.operandStack.firstObject as! NSNumber
        self.operandStack.removeObject(at: 0)
        let operandObjectString:NSString = operandObject.stringValue as NSString
        return (operandObjectString.doubleValue)
    }
    
    func performOperation (_ operation:NSString) -> Double
    {
        var result:Double = 0
        switch operation
        {
            case "+": result = self.popOperand() + self.popOperand()
            case "-": result = self.popOperand() - self.popOperand()
            case "x": result = self.popOperand() * self.popOperand()
            case "/": result = self.popOperand() / self.popOperand()
            default: break
        }
        self.pushOperand(result)
        return result
    }
}

