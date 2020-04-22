//
//  DetailViewController.swift
//  mvvm-architect
//
//  Created by Nguyen Duc Huy on 4/21/20.
//  Copyright © 2020 sun. All rights reserved.
//

final class DetailViewController: UIViewController {
    @IBOutlet var addressLabel: UILabel!

    var viewModel: DetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Address"
        bindViewModel()
    }

    private func bindViewModel() {
        let input = DetailViewModel.Input(ready: rx.viewWillAppear.asDriver())
        let output = viewModel.transform(input: input)

        output.data
            .drive(onNext: { [weak self] data in
                guard let address = data?.location?.address,
                    let self = self else { return }
                self.addressLabel.text = address
            })
            .disposed(by: disposeBag)
    }
}

// MARK: StoryboardSceneBased

extension DetailViewController: StoryboardSceneBased {
    static var sceneStoryboard = UIStoryboard.main
}
