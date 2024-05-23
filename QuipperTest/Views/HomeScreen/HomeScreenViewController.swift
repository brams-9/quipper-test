//
//  HomeScreenViewController.swift
//  QuipperTest
//
//  Created by Rahman Bramantya on 23/05/24.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    var viewModel: HomeScreenViewModelProtocol?
    
    init(viewModel: HomeScreenViewModelProtocol? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    lazy var headerLabel: UILabel = {
        let headerLabel: UILabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = "Quipper"
        headerLabel.textColor = .mainTextColor
        headerLabel.font = UIFont.systemFont(ofSize: 32)
        
        return headerLabel
    }()

    lazy var headerView: UIView = {
        let headerView: UIView = UIView()
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    lazy var videoTableView: UITableView = {
        let videoTableView: UITableView = UITableView()
        videoTableView.register(VideoItemCell.self, forCellReuseIdentifier: "CellID")
        videoTableView.dataSource = self
        videoTableView.delegate = self
        videoTableView.separatorStyle = .none
        videoTableView.translatesAutoresizingMaskIntoConstraints = false


        return videoTableView
    }()
    
    private var videoPlaylist: [PlaylistModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(headerView)

        headerView.topAnchor.constraint(equalTo: view.topAnchor,constant: 20).isActive = true
        headerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 20).isActive = true

        headerView.addSubview(headerLabel)
        headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true

        self.view.addSubview(videoTableView)
        videoTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 10).isActive = true
        videoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        videoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        videoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        loadData()
        bindViewModel()
    }
    
    func loadData() {
        Task {
            await viewModel?.getVideoPlaylist()
        }
    }
    
    func bindViewModel() {
        guard var viewModel = viewModel, viewModel is HomeScreenViewModel else { return }
        viewModel.onDataUpdate = { [self] in
            
            DispatchQueue.main.async {
                self.videoPlaylist.append(contentsOf: viewModel.videoPlaylists)
                self.videoTableView.reloadData()
            }
        }
    }

}


extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageHeight: CGFloat = 190
        let titleTextHeight: CGFloat = 14
        let presenterTextHeight: CGFloat = 14
        let cellMargin: CGFloat = 42
        
        return imageHeight + titleTextHeight + presenterTextHeight + cellMargin
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoPlaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewCell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath) as? VideoItemCell else { return UITableViewCell() }
        
        viewCell.setData(videoItemData: videoPlaylist[indexPath.row])
        
        return viewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(VideoDetailWiframe().getViewController(playlistData: videoPlaylist[indexPath.row]), animated: true)
    }
}
