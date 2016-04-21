//
//  ViewController.swift
//  StockSearch
//
//  Created by 郑杨平 on 4/20/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import UIKit
import CCAutocomplete

class ViewController: UIViewController, UITextFieldDelegate, AutocompleteDelegate{

  @IBOutlet weak var textInput: UITextField!
  @IBAction func hitQuoteButton(sender: AnyObject) {
    textInput.resignFirstResponder()
  }
  
  func autoCompleteTextField() -> UITextField {
    return textInput
  }
  
  func autoCompleteThreshold(textField: UITextField) -> Int {
    return 1
  }
  
  func autoCompleteItemsForSearchTerm(term: String) -> [AutocompletableOption] {
    
  }
  
  func autoCompleteHeight() -> CGFloat {
    
  }
  
  func didSelectItem(item: AutocompletableOption) -> Void {
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool { //hit the 'Done' on the keyboard
    self.textInput.resignFirstResponder()
    return true
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { //hit the view, then jump out of keyboard
    view.endEditing(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

