//
//  SegueFromLeft.swift
//  Pokedex
//
//  Created by Bill Gao on 2017/4/25.
//  Copyright © 2017年 Yunpeng Gao. All rights reserved.
//

import UIKit

class SegueFromLeft: UIStoryboardSegue {
override func perform()
{
    let src = self.source
    let dst = self.destination
    
    src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
    dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
    
    
    
    UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseIn, .curveEaseOut], animations: {
        dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
    }, completion: { finished in src.present(dst, animated: false, completion: nil) }
    )
}

}
