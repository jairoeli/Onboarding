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
      
      let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor: color])
      
      attributedText.append(NSAttributedString(string: "\n\n\(page.message)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: color]))
      
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      
      let length = attributedText.string.characters.count
      attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: length))
      
      textView.attributedText = attributedText
    }
  }
  
  // MARK: - Properties
  
  let imageView = UIImageView {
    $0.image = #imageLiteral(resourceName: "page1")
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  let textView = UITextView {
    $0.text = "SAMPLE TEXT FOR NOW"
    $0.isEditable = false
    $0.contentInset = UIEdgeInsets(top: 14, left: 0, bottom: 0, right: 0)
  }
  
  let lineSeperatorView = UIView {
    $0.backgroundColor = UIColor(white: 0.9, alpha: 1)
  }
  
  // MARK: - Setup
  func setupViews() {
    
    addSubview(imageView)
    addSubview(textView)
    addSubview(lineSeperatorView)
    
    imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    
    textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
    
    textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    
    lineSeperatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
    lineSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
  }
  
}
