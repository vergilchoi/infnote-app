//
//  DiscoveryViewController.swift
//  infnote
//
//  Created by Vergil Choi on 2018/8/10.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class DiscoveryViewController: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        settings.style.buttonBarItemFont = UIFont(name: DEFAULT_FONT_DEMI_BOLD, size: 16)!
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = .black
        settings.style.selectedBarBackgroundColor = MAIN_COLOR
        settings.style.buttonBarHeight = 44
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [storyboard!.instantiateViewController(withIdentifier: NSStringFromClass(TopicCollectionViewController.self)), storyboard!.instantiateViewController(withIdentifier: NSStringFromClass(TopicCollectionViewController.self))]
    }
    
}
