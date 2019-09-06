//
//  ViewController.swift
//  MADNasa
//
//  Created by Mariia Cherniuk on 06/09/2019.
//  Copyright © 2019 Mariia Cherniuk. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    private var model: ItemsListInterface
    
    //  MARK: - Init
    init(model: ItemsListInterface) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.fetch()
    }
}
