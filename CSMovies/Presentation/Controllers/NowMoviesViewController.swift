//
//  NowMoviesViewController.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import UIKit
import RxSwift

class NowMoviesViewController: UIViewController {
    private let viewModel: NowPlayingMoviesViewModelProtocol 
    private let disposeBag = DisposeBag()
    
    init(viewModel: NowPlayingMoviesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        setup()
    }

    
    private func setup() {
        viewModel.getNowPlayingMovies().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            print(self.viewModel.movies)
        }).disposed(by: disposeBag)
    }
    
    
    
}
