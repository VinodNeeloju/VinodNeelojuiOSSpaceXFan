//
//  PullToRefreshController.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 28/06/21.
//

import UIKit

class PullToRefreshController: UIRefreshControl {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var delegate : PulltoRefreshProtocal?
   
    private override init() {
        super.init()
    }
    init(with delegate : PulltoRefreshProtocal, title : String) {
        super.init()
        self.delegate = delegate
        self.tintColor = .white
        self.attributedTitle = NSMutableAttributedString().normal(title, 13, .white)
        
        self.addTarget(self, action: #selector(refreshStarted), for: .valueChanged)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
    }
    
    @objc func refreshStarted() {
        self.delegate?.refreshStatrted(refreshController: self)
    }
    
}

protocol PulltoRefreshProtocal {
    
    func refreshStatrted(refreshController : UIRefreshControl)
    
}
