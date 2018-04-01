//
//  LoginController.swift
//  Onboarding
//
//  Created by Jairo Eli de Leon on 2/6/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  // MARK: - Properties
  
  fileprivate let cellId = "cellId"
  fileprivate let loginCellId = "loginCellId"
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.backgroundColor = .white
    cv.delegate = self
    cv.dataSource = self
    cv.isPagingEnabled = true
    return cv
  }()
  
  var pages: [Page] = {
    let firstPage = Page(title: "Add", message: "Easily add all your cellared beers into a single, easy to manage list.", imageName: "page1")
    
    let secondPage = Page(title: "Track", message: "See how many uniques, mulitples, and yearly release you have, at any time.", imageName: "page2")
    
    let thirdPage = Page(title: "Share", message: "Automatically update your social networks when you drink one of your white whales.", imageName: "page3")
    
    return [firstPage, secondPage, thirdPage]
  }()
  
  var pageControlBottomAnchor: NSLayoutConstraint?
  var skipButtonTopAnchor: NSLayoutConstraint?
  var nextButtonTopAnchor: NSLayoutConstraint?
  
  // MARK: - UI Elements

  let container = UILayoutGuide()
  
  lazy var pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.pageIndicatorTintColor = .lightGray
    pc.currentPageIndicatorTintColor = UIColor.rgb(red: 43, green: 46, blue: 74)
    pc.numberOfPages = self.pages.count + 1
    return pc
  }()
  
  lazy var skipButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Skip", for: .normal)
    button.setTitleColor(UIColor.rgb(red: 43, green: 46, blue: 74), for: .normal)
    button.addTarget(self, action: #selector(skip), for: .touchUpInside)
    return button
  }()
  
  lazy var nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Next", for: .normal)
    button.setTitleColor(UIColor.rgb(red: 43, green: 46, blue: 74), for: .normal)
    button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.showsHorizontalScrollIndicator = false

    let subviews: [UIView] = [collectionView, pageControl, skipButton, nextButton]
    view.add(subviews)
    view.addLayoutGuide(container)
    
    observeKeyboardNotificaitons()
    layoutAnchors()
    collectionView.activate(constraint(edgesTo: self.view))

    registerCells()
  }
  
  // MARK: - Register Cells
  
  fileprivate func registerCells() {
    collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
  }
  
  // MARK: - Anchors
  
  fileprivate func layoutAnchors() {
      pageControlBottomAnchor = pageControl.anchors(
        top: nil,
        left: view.leftAnchor,
        bottom: view.safeAreaLayoutGuide.bottomAnchor,
        right: view.rightAnchor,
        heightConstant: 40
      )[1]

      skipButtonTopAnchor = skipButton.anchors(
        top: nil,
        left: nil,
        bottom: view.safeAreaLayoutGuide.bottomAnchor,
        right: nil,
        widthConstant: 60,
        heightConstant: 40
      ).first

      nextButtonTopAnchor = nextButton.anchors(
        top: nil,
        left: nil,
        bottom: view.safeAreaLayoutGuide.bottomAnchor,
        right: view.safeAreaLayoutGuide.rightAnchor,
        widthConstant: 60,
        heightConstant: 40
      ).first
  }
  
  // MARK: - Collection view data source
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count + 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    // we're rendering our last login cell
    if indexPath.item == pages.count {
      let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
      loginCell.delegate = self
      return loginCell
    }
    
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PageCell else { return UICollectionViewCell() }
    
    let page = pages[indexPath.item]
    cell.page = page
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
  
}
