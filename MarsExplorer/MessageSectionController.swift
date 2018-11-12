//
//  Message.swift
//  Marslink
//
//  Created by Kelsey Young on 11/8/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class MessageSectionController: IGListSectionController {
  var entry: Message!

  override init() {
    super.init()
    inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
  }
}

extension MessageSectionController: IGListSectionType {
  func numberOfItems() -> Int {
    return 2
  }

  func sizeForItem(at index: Int) -> CGSize {
    guard let context = collectionContext, let entry = entry else { return .zero }
    let width = context.containerSize.width
    return MessageCell.cellSize(width: width, text: entry.text)
  }

  func cellForItem(at index: Int) -> UICollectionViewCell {
    let cell: MessageCell = collectionContext!.dequeueReusableCell(of: MessageCell.self, for: self, at: index) as! MessageCell
    cell.titleLabel.text = entry.user.name
    cell.messageLabel.text = entry.text
    return cell
  }

  func didUpdate(to object: Any) {
    entry = object as! Message
  }

  func didSelectItem(at index: Int) {}
}
