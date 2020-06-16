//
//  HomeViewController.swift
//  Zomato_Rx
//
//  Created by Nguyen Duc Huy on 6/13/20.
//  Copyright © 2020 nguyen.duc.huyb. All rights reserved.
//

final class HomeViewController: UIViewController {
    @IBOutlet private var skipButton: UIButton!
    @IBOutlet private var foodCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        skipButton.setShadow()
    }
}
