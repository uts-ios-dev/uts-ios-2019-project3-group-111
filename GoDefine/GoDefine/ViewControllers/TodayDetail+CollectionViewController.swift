//
//  TodayDetail+CollectionViewController.swift
//  GoDefine
//
//  Created by Yang Qijun on 30/5/19.
//  Copyright © 2019 Yang Qijun. All rights reserved.
//

import UIKit

struct ActivityData {
    var name: String
    var bgColor: UIColor
    var fgColor: UIColor
    var todayData: Float
    var weeklyData: Float
    var monthlyData: Float
    var unit: String
}

private let reuseIdentifier = "ActivityDetailCell"

class TodayDetail_CollectionViewController: UICollectionViewController {
    
    var activityDataList: [ActivityData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        // prepare the activity data
        // template ----------------------------------------------------------------------
        activityDataList.append(self.getActiveEnergyBurned())

        activityDataList.append(self.getFlightClimbedData())
        
        activityDataList.append(self.getStandingData())
        
        activityDataList.append(self.getWalkingData())
        
        activityDataList.append(self.getStepsData())


        // template end ------------------------------------------------------------------

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let inset = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0)
            let width = collectionView.frame.width - inset.left - inset.right
            let height = CGFloat(145.0)
            layout.itemSize = CGSize(width: width, height: height)
            layout.sectionInset = inset
        }
    }
    
    private func getActiveEnergyBurned() -> ActivityData {
        let group = DispatchGroup()
        group.enter()
        var count = 0
        var today = 0.0
        var lastMonth = 0.0
        var lastWeek = 0.0
        
        ActiveEnergyDataStore.shared.getTodayActiveEnergy { (steps) in
            today = steps
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        ActiveEnergyDataStore.shared.getTheLastRecentWeekActiveEnergy { (steps) in
            lastWeek = steps
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        ActiveEnergyDataStore.shared.getTheLastRecentMonthActiveEnergy{ (steps) in
            lastMonth = steps
            count += 1
            
            if count == 3{
                group.leave()
            }
            
        }
        group.wait()
        
        // prepare the activity data
        // template ----------------------------------------------------------------------
        
        return ActivityData(
            name: "Active energy",
            bgColor: UIColor(red:0.00, green:0.73, blue:0.01, alpha:1.0),
            fgColor: UIColor(red:0.75, green:1.00, blue:0.75, alpha:1.0),
            todayData: Float(today),
            weeklyData: Float(lastWeek),
            monthlyData: Float(lastMonth),
            unit: "kCal")
    }
    
    private func getFlightClimbedData() -> ActivityData {
        let group = DispatchGroup()
        group.enter()
        var count = 0
        var today = 0.0
        var lastMonth = 0.0
        var lastWeek = 0.0
        
        FlightsClimbedDataStore.shared.getTodayFlightsClimbed { (steps) in
            today = steps
            count += 1
            if count == 3{
                group.leave()
            }
        }

        FlightsClimbedDataStore.shared.getTheLastRecentWeekFlightsClimbed { (steps) in
            lastWeek = steps
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        FlightsClimbedDataStore.shared.getTheLastRecentMonthFlightsClimbed { (steps) in
            lastMonth = steps
            count += 1
            
            if count == 3{
                group.leave()
            }
            
        }
        group.wait()
        
        // prepare the activity data
        // template ----------------------------------------------------------------------
        
        return ActivityData(
            name: "Flights Climbed",
            bgColor: UIColor(red:0.18, green:1.00, blue:0.88, alpha:1.0),
            fgColor: UIColor(red:0.81, green:1.00, blue:0.97, alpha:1.0),
            todayData: Float(today),
            weeklyData: Float(lastWeek),
            monthlyData: Float(lastMonth),
            unit: "floors")
    }
    
    private func getStandingData() -> ActivityData {
        let group = DispatchGroup()
        group.enter()
        var count = 0
        var today = 0.0
        var lastMonth = 0.0
        var lastWeek = 0.0
        
        StandHourDataStore.shared.getTodayStandHour { (hour) in
            today = hour
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        StandHourDataStore.shared.getTheLastRecentWeekStandHour{ (hour) in
            lastWeek = hour
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        StandHourDataStore.shared.getTheLastRecentMonthStandHour{ (hour) in
            lastMonth = hour
            count += 1
            if count == 3{
                group.leave()
            }
            
        }
        group.wait()
        
        // prepare the activity data
        // template ----------------------------------------------------------------------
        
        return ActivityData(
            name: "Standing Hour",
            bgColor: UIColor(red:0.54, green:0.37, blue:1.00, alpha:1.0),
            fgColor: UIColor(red:0.80, green:0.73, blue:1.00, alpha:1.0),
            todayData: Float(today),
            weeklyData: Float(lastWeek),
            monthlyData: Float(lastMonth),
            unit: "hours")
    }
    
    private func getWalkingData() -> ActivityData {
        let group = DispatchGroup()
        group.enter()
        var count = 0
        var today = 0.0
        var lastMonth = 0.0
        var lastWeek = 0.0
        
        WalkingDataStore.shared.getTodayWalkingDistance { (hour) in
            today = hour
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        WalkingDataStore.shared.getTheLastRecentWeekWalkingDistance{ (hour) in
            lastWeek = hour
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        WalkingDataStore.shared.getTheLastRecentMonthWalkingDistance{ (hour) in
            lastMonth = hour
            count += 1
            if count == 3{
                group.leave()
            }
            
        }
        group.wait()
        
        // prepare the activity data
        // template ----------------------------------------------------------------------
        
        return ActivityData(
            name: "Walking",
            bgColor: UIColor(red:1.00, green:0.42, blue:0.00, alpha:1.0),
            fgColor: UIColor(red:1.00, green:0.82, blue:0.76, alpha:1.0),
            todayData: Float(toKilometer(meter: today)),
            weeklyData: Float(toKilometer(meter: lastWeek)),
            monthlyData: Float(toKilometer(meter: lastMonth)),
            unit: "km")
    }
    
    private func getStepsData() -> ActivityData {
        let group = DispatchGroup()
        group.enter()
        var count = 0
        var today = 0.0
        var lastMonth = 0.0
        var lastWeek = 0.0
        
        SteptCountDataStore.shared.getTodayStepCount{ (hour) in
            today = hour
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        SteptCountDataStore.shared.getTheLastRecentWeekStepCount{ (hour) in
            lastWeek = hour
            count += 1
            if count == 3{
                group.leave()
            }
        }
        
        SteptCountDataStore.shared.getTheLastRecentMonth{ (hour) in
            lastMonth = hour
            count += 1
            if count == 3{
                group.leave()
            }
            
        }
        group.wait()
        
        // prepare the activity data
        // template ----------------------------------------------------------------------
        
        return ActivityData(
            name: "Step Count",
            bgColor: UIColor(displayP3Red: 181/255, green: 0, blue: 1, alpha: 1),
            fgColor: UIColor(displayP3Red: 244/255, green: 217/255, blue: 1, alpha: 1),
            todayData: Float(today),
            weeklyData: Float(lastWeek),
            monthlyData: Float(lastMonth),
            unit: "steps")
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
    
    private func toKilometer(meter: Double) -> Double{
        return round(meter*1000 / 1000.0) / 1000.0
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return activityDataList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let activityDetailCell = cell as? DetailData_CollectionViewCell {
            activityDetailCell.activityData = activityDataList[indexPath.row]
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
