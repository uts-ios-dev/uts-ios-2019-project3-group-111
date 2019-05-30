//
//  TodayDetail+CollectionViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 30/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit
struct abc {
    var name: String
    var color: UIColor
    var currentData: Float
    
}
private let reuseIdentifier = "ActivityDetailCell"

class TodayDetail_CollectionViewController: UICollectionViewController {
    
    var abcs: [abc] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        abcs.append(abc(name: <#T##String#>, color: <#T##UIColor#>, currentData: <#T##Float#>))

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let inset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
            let width = collectionView.frame.width - inset.left - inset.right
            let height = CGFloat(145.0)
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = inset
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let activityDetailCell = cell as? DetailData_CollectionViewCell {
            activityDetailCell.goalLabel.text = abcs[indexPath.row].name
            return activityDetailCell
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
