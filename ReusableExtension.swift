//
//  ReusableExtension.swift
//  HitList
//
//  Created by Appinventiv on 25/02/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import Foundation
import UIKit
  
  //extending UIView to add function that gets superview
  extension UIView{
    
    var getTableCell: UITableViewCell?{
      
      var subview = self
      
      while !(subview is UITableViewCell){
        
        guard let view = subview.superview else { return nil}
        subview = view
      }
      
      return subview as? UITableViewCell
  }

}


//view mode of display page
enum ListViewMode{
  
  case isInPreviewMode
  case isInEditMode
  case addNew
  
}
