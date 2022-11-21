//
//  NowPlayingMoviesViewController.swift
//  CSMovies
//
//  Created by Amanda Calcic on 14/11/22.
//

import UIKit
import RxSwift

class NowPlayingMoviesViewController: UIViewController {
    private let viewModel: NowPlayingMoviesViewModelProtocol
    private let disposeBag = DisposeBag()
    
    private lazy var moviesTableView: UITableView = {
        var tableView = UITableView()
        tableView.register(NowPlayingMoviesViewCell.self, forCellReuseIdentifier: NowPlayingMoviesViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    init(viewModel: NowPlayingMoviesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setup()
    }
    
    private func setup() {
        viewModel.getNowPlayingMovies().observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.moviesTableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func setupUI() {
        title = "Novos Lançamentos"
        view.backgroundColor = .systemGray6
        
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        
        setupTableViewConstraints()
    }
    
    private func setuoNavigationBar() {
        
    }
    
    private func setupTableViewConstraints() {
        view.addSubview(moviesTableView)
        
        moviesTableView.setupAnchor(
            top: (anchor: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            leading: (anchor: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            trailing: (anchor: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            bottom: (anchor: view.safeAreaLayoutGuide.bottomAnchor, constant: 0))
    }
}

extension NowPlayingMoviesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = moviesTableView.dequeueReusableCell(withIdentifier: NowPlayingMoviesViewCell.identifier, for: indexPath) as? NowPlayingMoviesViewCell else { return UITableViewCell() }
        
        let movie = viewModel.movies[indexPath.row]
        cell.setup(movie: movie)
        
        return cell
    }
}
