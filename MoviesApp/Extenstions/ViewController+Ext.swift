//
//  UIViewController+Ext.swift
//  MoviesApp
//
//  Created by Mohamed Elkilany on 09/09/2021.
//

import UIKit

extension UIViewController {

func scrollToTop() {
       func scrollToTop(view: UIView?) {
           guard let view = view else { return }

           switch view {
           case let scrollView as UIScrollView:
               if scrollView.scrollsToTop == true {
                   scrollView.setContentOffset(CGPoint(x: 0.0, y: -scrollView.contentInset.top), animated: true)
                   return
               }
           default:
               break
           }

           for subView in view.subviews {
               scrollToTop(view: subView)
           }
       }
       scrollToTop(view: view)
   }

   var isScrolledToTop: Bool {
       if self is UITableViewController {
        return (self as! UITableViewController).tableView.contentOffset.y == 0
       }
    
       for subView in view.subviews {
           if let scrollView = subView as? UIScrollView {
               return (scrollView.contentOffset.y == 0)
           }
       }
       return true
   }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    
}
