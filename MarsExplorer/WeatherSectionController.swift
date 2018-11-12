//
//  WeatherSectionController.swift
//  Marslink
//
//  Created by Kelsey Young on 11/9/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class WeatherSectionController: IGListSectionController {
    var weather: Weather!
    var expanded = false
    override init() {
      super.init()
      inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
    }
}

extension WeatherSectionController: IGListSectionType {
  func didUpdate(to object: Any) {
    weather = object as? Weather
  }

  func numberOfItems() -> Int {
    return expanded ? 5 : 1
  }

  func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext else { return .zero }
    let width = context.containerSize.width
    if index == 0 {
      return CGSize(width: width, height: 70)
    } else {
      return CGSize(width: width, height: 40)
    }
  }

  func cellForItem(at index: Int) -> UICollectionViewCell {
    let cellClass: AnyClass = index == 0 ?  WeatherSummaryCell.self : WeatherDetailCell.self
    let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
    if let cell = cell as? WeatherSummaryCell {
      cell.setExpanded(self.expanded)
    } else if let cell = cell as? WeatherDetailCell {
      switch index {
      case 1:
        cell.titleLabel.text = "Sunrise"
        cell.detailLabel.text = "\(weather.sunrise)"
      case 2:
        cell.titleLabel.text = "Sunset"
        cell.detailLabel.text = "\(weather.sunset)"
      case 3:
        cell.titleLabel.text = "High"
        cell.detailLabel.text = "\(weather.high) C"
      case 4:
        cell.titleLabel.text = "Low"
        cell.detailLabel.text = "\(weather.low) C"
      default:
        cell.titleLabel.text = "Default"
        cell.detailLabel.text = "Default"
      }
    }
    return cell
  }

  func didSelectItem(at index: Int) {
    expanded = !expanded
    collectionContext?.reload(self)
  }
}
