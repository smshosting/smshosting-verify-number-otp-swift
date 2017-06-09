//
//  LoadingView.swift
//  PAT-BusinessAutomation
//
//  Created by Sviluppo 3 on 30/01/17.
//  Copyright © 2017 i-contact. All rights reserved.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.black.withAlphaComponent(0.65)
        
        let loader:UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        loader.backgroundColor = UIColor.clear
        loader.transform = CGAffineTransform.init(scaleX: 2.0, y: 2.0)
        self.addSubview(loader)
        loader.startAnimating()
        
    }
    
}
