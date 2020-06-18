//
//  SentMemesTableViewController.swift
//  ImagePickerApp
//
//  Created by Khalid Aqeeli on 16/06/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var memeTableView: UITableView!
     
    // MARK: Properties
    let cellIdentifier: String = "MemeCell"
    var memes: [Meme]! {
         let object = UIApplication.shared.delegate
         let appDelegate = object as! AppDelegate
         return appDelegate.memes
     }
    
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeTableView.reloadData()
    }
    
    // MARK: Table View Data Source
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.memes.count
     }
    
    func image( _ image:UIImage, withSize newSize:CGSize) -> UIImage {

        UIGraphicsBeginImageContext(newSize)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!.withRenderingMode(.automatic)
    }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        guard let memeCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)! as? MemeTableViewCell else {
            return UITableViewCell()
        }
         let meme = self.memes[(indexPath as NSIndexPath).row]
        
        memeCell.memeText?.text = "\(meme.topText!)  \(meme.bottomText!)"
        memeCell.memeImage?.image = meme.memedImage
        
        return memeCell
     }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
           let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! MemeDetailViewController
           detailController.meme = self.memes[(indexPath as NSIndexPath).row]
           self.navigationController!.pushViewController(detailController, animated: true)
       }
    
    
    @IBAction func CreateMeme(_ sender: Any) {
    
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! ViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }

  
}
