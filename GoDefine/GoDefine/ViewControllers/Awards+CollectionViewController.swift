//
//  AwardsCollectionViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 26/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AwardCell"

struct AwardType {
    var name: String
    var color: UIColor
}

struct Award {
    var name: String
    var description: String
    var symbol: UIImage
    var bigSymbol: UIImage
    var achieved: Bool
}

class AwardsCollectionViewController: UICollectionViewController {
    
    var awards: [[Award]] = []
    var awardTypes: [AwardType] = []
    var currentIndex: IndexPath = IndexPath(row: 0, section: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemPerRow: CGFloat = 3
            let padding: CGFloat = 6
            let inset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 0)
            let totalPadding = padding * (itemPerRow - 1)
            let individualPadding = totalPadding / itemPerRow
            let width = (collectionView.frame.width - inset.left) / itemPerRow - individualPadding
            let height = 1.8 * width
            layout.itemSize = CGSize(width: width, height: height)
            layout.minimumLineSpacing = padding
            layout.minimumInteritemSpacing = padding
            layout.sectionInset = inset
        }
        
        awardTypes.append(AwardType(name: "Chanllenge", color: UIColor(displayP3Red: 0, green: 185/255, blue: 2/255, alpha: 1)))
        awardTypes.append(AwardType(name: "Competitions", color: UIColor(displayP3Red: 137/255, green: 95/255, blue: 1, alpha: 1)))
        awardTypes.append(AwardType(name: "Special Prizes", color: UIColor(displayP3Red: 246/255, green: 6/255, blue: 110/255, alpha: 1)))
        awards.append([
            Award(name: "Day Win", description: "Daily goals finished", symbol: UIImage(named: "awards_winaday")!, bigSymbol: UIImage(named: "awards_winaday-1")!, achieved: true),
            Award(name: "Month Win", description: "Monthly goals finished", symbol: UIImage(named: "awards_winamonth")!, bigSymbol: UIImage(named: "awards_winamonth-1")!, achieved: true),
            Award(name: "Week Win", description: "Weekly goals finished", symbol: UIImage(named: "awards_winaweek")!, bigSymbol: UIImage(named: "awards_winaweek-1")!, achieved: true)
            ])
        awards.append([
            Award(name: "First", description: "1st \"Jogging Week\"", symbol: UIImage(named: "awards_number1")!, bigSymbol: UIImage(named: "awards_number1-1")!, achieved: true),
            Award(name: "Second", description: "2nd \"Jumper Festival\"", symbol: UIImage(named: "awards_number2")!, bigSymbol: UIImage(named: "awards_number2-1")!, achieved: true),
            Award(name: "Third", description: "3rd \"Pushing Carnival\"", symbol: UIImage(named: "awards_number3")!, bigSymbol: UIImage(named: "awards_number3-1")!, achieved: true)
            ])
        awards.append([
            Award(name: "Stair King", description: "KING of the STAIRS", symbol: UIImage(named: "awards_kingstairs")!, bigSymbol: UIImage(named: "awards_kingstairs-1")!, achieved: true),
            Award(name: "Easter Week", description: "Easter Week Fighter", symbol: UIImage(named: "awards_easterweek")!, bigSymbol: UIImage(named: "awards_easterweek-1")!, achieved: false),
            Award(name: "Climbing King", description: "KING of the CLIMBING", symbol: UIImage(named: "awards_kingclimbing")!, bigSymbol: UIImage(named: "awards_kingclimbing-1")!, achieved: true),
            Award(name: "Best", description: "You are the “Best”", symbol: UIImage(named: "awards_youarethebest")!, bigSymbol: UIImage(named: "awards_youarethebest-1")!, achieved: true)
            ])
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let awardDetailViewController = segue.destination as? AwardDetail_ViewController {
            awardDetailViewController.award = awards[currentIndex.section][currentIndex.row]
        }
    }
    
    @IBAction func unwindToAwardsView(_ unwindSegue: UIStoryboardSegue) { }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return awardTypes.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return awards[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let awardCell = cell as? Award_CollectionViewCell {
            awardCell.awardSymbolImage.image = awards[indexPath.section][indexPath.row].bigSymbol
            awardCell.awardDescriptionLabel.text = awards[indexPath.section][indexPath.row].description
            return awardCell
        }
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AwardTypeHeader", for: indexPath) as! AwardsHeader_CollectionReusableView
        header.awardType = awardTypes[indexPath.section]
        return header
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath
        performSegue(withIdentifier: "ShowAwardDetail", sender: nil)
    }

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
