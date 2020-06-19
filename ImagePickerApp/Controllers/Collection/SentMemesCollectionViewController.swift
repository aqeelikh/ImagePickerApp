//
//  SentMemesCollectionViewController.swift
//  ImagePickerApp
//
//  Created by Khalid Aqeeli on 18/06/2020.
//  Copyright © 2020 Khalid Aqeeli. All rights reserved.
//

import UIKit


private let reuseIdentifier = "MemeCollectionViewCell"

class SentMemesCollectionViewController: UICollectionViewController {

    //MARK: Setup Outlets
    @IBOutlet var memeCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //MARK: Setup shared meme array
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
        

    // MARK: Life Cycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
         memeCollectionView!.reloadData()
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkDeviceOrientation()
        self.memeCollectionView.reloadData()
        
    }

    //MARK: Segue to MemeEditer
    @IBAction func CreateMeme(_ sender: Any) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! ViewController
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }

   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        let memeCell = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeCollectionImage.image = memeCell.memedImage
        
        return cell
    }
    
    //MARK: Check Devie Orientation
    func checkDeviceOrientation(){
           
           if UIDevice.current.orientation.isLandscape {
               let space:CGFloat = 1
               let dimension = (view.frame.size.height - (2 * space)) / 4.0

            flowLayout.minimumInteritemSpacing = space
            flowLayout.minimumLineSpacing = space
            flowLayout.itemSize = CGSize(width: dimension, height: dimension)
                    
           }
           else if UIDevice.current.orientation.isPortrait {
              let space:CGFloat = 3.0
              let dimension = (view.frame.size.width - (2 * space)) / 3.0

              flowLayout.minimumInteritemSpacing = space
              flowLayout.minimumLineSpacing = space
              flowLayout.itemSize = CGSize(width: dimension, height: dimension)
            }
            else if UIDevice.current.orientation.isFlat {
            
            }
            else if UIDevice.current.orientation.isValidInterfaceOrientation {

            }
    }

    // MARK: select Collection view item
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }



}
