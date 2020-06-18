//
//  MemeDetailViewController.swift
//  ImagePickerApp
//
//  Created by Khalid Aqeeli on 19/06/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    // MARK: Properties
    var meme: Meme!
    
    // MARK: Outlets
    @IBOutlet weak var memeImageView: UIImageView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memedImage
    }
    
}
