//
//  ViewController.swift
//  StockSearch
//
//  Created by 郑杨平 on 4/20/16.
//  Copyright © 2016 郑杨平. All rights reserved.
//

import UIKit
import CCAutocomplete
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON


class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var textInput: UITextField!
  @IBOutlet weak var NavControlBar: UINavigationItem!
  
  var stockDetail: Array<Dictionary<String, String>> = Array<Dictionary<String, String>>()
  var autoCompleteViewController: AutoCompleteViewController!
  var isFirstLoad: Bool = true
  
  var haveSelectedItem: Bool = false
  
  var stockDetailLoaded: Bool = false


  @IBAction func hitQuoteButton(sender: AnyObject) {
    textInput.resignFirstResponder()
    if textInput.text == nil || textInput.text == "" {
      let alert: UIAlertController = UIAlertController(title: "Please Enter a Stock Name or Symbol", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
      let action: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
    }
    else if haveSelectedItem == false {
      let alert: UIAlertController = UIAlertController(title: "Invalid Symbol", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
      let action: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
    }
    else {
      let queryResult = Alamofire.request(.GET, "http://steel-utility-127007.appspot.com", parameters: ["symbol": textInput.text!]).responseJSON()
      let jsonData = JSON(data: queryResult.data!)
  
      textInput.text = ""
      haveSelectedItem = false
      
      
      if jsonData["Status"].string! == "SUCCESS" {
        stockDetail.removeAll()
        stockDetail.append(["Name" : jsonData["Name"].string!])
        stockDetail.append(["Symbol" : jsonData["Symbol"].string!])
        stockDetail.append(["LastPrice" : String(jsonData["LastPrice"].double!)])
        stockDetail.append(["Change" : String(jsonData["Change"].double!)])
        stockDetail.append(["ChangePercent" : String(jsonData["ChangePercent"].double!)])
        stockDetail.append(["Timestamp" : jsonData["Timestamp"].string!])
        stockDetail.append(["MSDate" : String(jsonData["MSDate"].double!)])
        stockDetail.append(["MarketCap" : String(jsonData["MarketCap"].double!)])
        stockDetail.append(["Volume" : String(jsonData["Volume"].double!)])
        stockDetail.append(["ChangeYTD" : String(jsonData["ChangeYTD"].double!)])
        stockDetail.append(["ChangePercentYTD" : String(jsonData["ChangePercentYTD"].double!)])
        stockDetail.append(["High" : String(jsonData["High"].double!)])
        stockDetail.append(["Low" : String(jsonData["Low"].double!)])
        stockDetail.append(["Open" : String(jsonData["Open"].double!)])
        
        stockDetailLoaded = true
      }
//      print(stockDetail[0]["Name"])
    }
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
    self.navigationController?.navigationBarHidden = true
  }
  
  override func viewWillAppear(animated: Bool) {
    self.navigationController?.navigationBarHidden = true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let detail: StockDetailViewController = segue.destinationViewController as! StockDetailViewController
    if segue.identifier == "OptToStockDetail" && stockDetailLoaded == true{
      detail.stockDetail = stockDetail
      stockDetailLoaded = false
    }
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    if self.isFirstLoad {
      self.isFirstLoad = false
      Autocomplete.setupAutocompleteForViewcontroller(self)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension ViewController: AutocompleteDelegate {
  func autoCompleteTextField() -> UITextField {
    return self.textInput
  }
  func autoCompleteThreshold(textField: UITextField) -> Int {
    return 2
  }
  
  func autoCompleteItemsForSearchTerm(term: String) -> [AutocompletableOption] {
    let queryResult = Alamofire.request(.GET, "http://steel-utility-127007.appspot.com", parameters: ["input": term]).responseJSON()
    let jsonData = JSON(data: queryResult.data!)
    var autocompleteList: Array<AutocompletableOption> = Array<AutocompletableOption>()
    for i in 0 ..< jsonData.count {
      let item: String = jsonData[i]["Symbol"].string! + "-" + jsonData[i]["Name"].string! + "-" + jsonData[i]["Exchange"].string!
      let cellData = AutocompleteCellData(text: item, image: nil)
      autocompleteList.append(cellData)
    }
    return autocompleteList
  }
  
  func autoCompleteHeight() -> CGFloat {
    return CGRectGetHeight(self.view.frame) / 3.0
  }
  
  func heightForCells() -> CGFloat {
    return 35.0
  }
  
  
  func didSelectItem(item: AutocompletableOption) {
//    self.textInput.text = item.text.inde
    let index = item.text.characters.indexOf("-")?.predecessor()
    self.textInput.text = item.text[item.text.startIndex...index!]
    self.haveSelectedItem = true
  }
}

