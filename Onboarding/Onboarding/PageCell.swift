//
//  PageCell.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    attachViews()
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Property Observer
  
  var page: Page? {
    didSet {
      guard let page = page else { return }
      
      var imageName = page.imageName
      
      if UIDevice.current.orientation.isLandscape {
        imageName += "_landscape"
      }
      
      imageView.image = UIImage(named: imageName)
      
      let color = UIColor.rgb(red: 43, green: 46, blue: 74)
      
      let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: DeviceSize.adjust(20, for: [.large: 22, .plus: 26]), weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: color])
      
      attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: DeviceSize.adjust(16, for: [.large: 18, .plus: 20])), NSAttributedStringKey.foregroundColor: color]))
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      
      let length = attributedText.string.count
      attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
      
      textView.attributedText = attributedText
    }
  }
  
  // MARK: - Properties

  let container = UILayoutGuide()
  
  let imageView = UIImageView {
//    $0.image = #imageLiteral(resourceName: "page1")
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
    $0.backgroundColor = .red
  }
  
  let textView = UITextView {
//    $0.text = "SAMPLE TEXT FOR NOW"
    $0.isEditable = false
    $0.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
  }
  
  let lineSeperatorView = UIView {
    $0.backgroundColor = UIColor(white: 0.9, alpha: 1)
  }

  private func attachViews() {
    let subviews: [UIView] = [imageView, textView, lineSeperatorView]
    add(subviews)
    addLayoutGuide(container)
  }
  
  // MARK: - Setup
  private func setupViews() {
    container.activate(
      constraint(edgesTo: self.layoutMarginsGuide)
    )

    imageView.activate([
      constraint(same: \.topAnchor, as: container),
      constraint(same: \.leadingAnchor, as: container),
      constraint(same: \.trailingAnchor, as: container),
      constraint(\.bottomAnchor, to: \.topAnchor, of: textView)
    ])

    textView.activate([
      constraint(same: \.leadingAnchor, as: container, offset: 16),
      constraint(same: \.trailingAnchor, as: container, offset: -16),
      constraint(same: \.bottomAnchor, as: container),
    ])

    textView.heightAnchor.constraint(
      equalTo: heightAnchor,
      multiplier: DeviceSize.adjust(0.3, for: [.iphoneX: 0.2])
    ).isActive = true

    lineSeperatorView.activate([
      constraint(same: \.leadingAnchor, as: self),
      constraint(same: \.trailingAnchor, as: self),
      constraint(\.bottomAnchor, to: \.topAnchor, of: textView),
      constraint(\.heightAnchor, to: 1)
    ])
  }
  
}
