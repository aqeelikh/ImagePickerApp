//
//  TBTextFieldDelegate.swift
//  ImagePickerApp
//
//  Created by Khalid Aqeeli on 27/05/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import Foundation
import UIKit

class TBTextFieldDelegate: NSObject, UITextFieldDelegate  {
 
    var flag:Bool =  true
    
    func textFieldShouldBeginEditing(_ textField: UITextField)  -> Bool {
        if flag {
            textField.text = ""
            flag = false
        }
        return true
    }
    
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true;
      }
    
}
