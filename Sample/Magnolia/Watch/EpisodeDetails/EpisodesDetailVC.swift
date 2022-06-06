//
//  EpisodesDetailVC.swift
//  Sample
//
//  Created by Ramya K on 26/05/22.
//



import UIKit
import AVFoundation

final class EpisodesDetailVC: UIViewController{
    
    @IBOutlet weak private var videoView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var ShowTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    var player: AVPlayer?
    var playerLayer : AVPlayerLayer?
    var isPlaying = false
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ImageLiteralsEnum.pauseSymbol.rawValue)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    lazy var forwardButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ImageLiteralsEnum.goforwardSymbol.rawValue)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(btnForwardAction), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    lazy var backwardButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ImageLiteralsEnum.gobackwardSymbol.rawValue)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.addTarget(self, action: #selector(btnBackwardAction), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    let EnterFullScreenButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ImageLiteralsEnum.enterFullScreenSymbol.rawValue)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(rotateTapped), for: .touchUpInside)
        button.tintColor = .white
        button.isHidden = true
        return button
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(systemName: ImageLiteralsEnum.thumbImageSymbol.rawValue), for: .normal)
        slider.tintColor = .white
        slider.isHidden = true
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    let viewModel = EpisodeDetailVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
        addControllsContainerView()
        viewModel.fetchData { [weak self ] sucess in
            self?.updateView(showTitleL: nil, episodeTitle: nil, description: nil)
            self?.collectionView.delegate = self
            self?.collectionView.dataSource = self
            self?.collectionView.register(cell: SeasonsCVCell.self)
            self?.collectionView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player?.replaceCurrentItem(with: nil)
    }
    private func updateView(showTitleL: String?, episodeTitle: String?, description: String?) {
        
        if let showTitleL = showTitleL,
           let episodeTitle = episodeTitle,
           let description = description {
            
            self.ShowTitleLabel.text = showTitleL
            self.episodeTitleLabel.text = episodeTitle
            self.descriptionLabel.text = description
            self.setUpNavBar(episodeTitle: episodeTitle, showTitle: showTitleL)
        }
        else {
            self.ShowTitleLabel.text = viewModel.episodeHeaderData[0].showTitle
            self.episodeTitleLabel.text = "\(viewModel.episodeHeaderData[0].seasonEpisodeNumber) .  \(viewModel.episodeHeaderData[0].episodeTitle)"
            self.descriptionLabel.text = viewModel.episodeHeaderData[0].description
            self.setUpNavBar(episodeTitle: viewModel.episodeHeaderData[0].episodeTitle, showTitle: viewModel.episodeHeaderData[0].showTitle)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        controlsContainerView.frame = CGRect(x: 0, y: 0, width: videoView.frame.size.width, height: videoView.frame.size.height)
    }
    
    private func playVideo() {
        let urlString = UrlString.videoUrl.rawValue
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url as URL)
            playerLayer = AVPlayerLayer(player: player)
            guard let playerLayer = playerLayer else {
                return
            }
            //playerLayer.videoGravity = AVLayerVideoGravity.resize
            playerLayer.frame = videoView.layer.bounds
            //playerLayer.frame = CGRect(x: 0, y: 0, width: videoView.frame.size.width, height: videoView.frame.size.height)
            videoView.layer.addSublayer(playerLayer)
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            player?.play()
        }
    }
    
    @objc private func handlePause() {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(systemName: ImageLiteralsEnum.playSymbol.rawValue), for: .normal)
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(systemName: ImageLiteralsEnum.pauseSymbol.rawValue), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    private func hideVideoControlItems() {
        pausePlayButton.isHidden = true
        forwardButton.isHidden = true
        backwardButton.isHidden = true
        //isPlaying = false
        videoLengthLabel.isHidden = true
        currentTimeLabel.isHidden = true
        videoSlider.isHidden = true
        EnterFullScreenButton.isHidden = true
    }
    
    private func showVideoControlItems() {
        pausePlayButton.isHidden = false
        forwardButton.isHidden = false
        backwardButton.isHidden = false
        isPlaying = true
        videoLengthLabel.isHidden = false
        currentTimeLabel.isHidden = false
        videoSlider.isHidden = false
        EnterFullScreenButton.isHidden = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //this is when the player is ready and rendering frames
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            showVideoControlItems()
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
                
                //pausePlayButton.setImage(UIImage(systemName: ImageLiteralsEnum.pauseSymbol.rawValue), for: .normal)
                
                let interval = CMTime(value: 1, timescale: 2)
                player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                    
                    let seconds = CMTimeGetSeconds(progressTime)
                    //print(seconds.truncatingRemainder(dividingBy: 60))
                    let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                    let minutesString = String(format: "%02d", Int(seconds/60))
                    
                    self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
                    
                    if let duration = self.player?.currentItem?.duration {
                        let durationSeconds = CMTimeGetSeconds(duration)
                        
                        self.videoSlider.value = Float(seconds / durationSeconds)
                    }
                })
            }
        }
    }
    
    @objc private func btnForwardAction(_ sender: UIButton) {
        guard let duration = player?.currentItem?.duration else { return }
        
        if let player = player {
            let currentTime = CMTimeGetSeconds(player.currentTime())
            let newTime = currentTime + 5.0
            if newTime < (CMTimeGetSeconds(duration) - 5.0){
                let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
                player.seek(to: time)
            }
        }
    }
    
    @objc private func btnBackwardAction(_ sender: UIButton) {
        guard let player = player  else { return }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 5.0
        if newTime < 0{
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        player.seek(to: time)
        
    }
    
    @objc private func handleSliderChange() {
        print(videoSlider.value)
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in 
            })
        }
    }
    
    @objc private  func rotateTapped() {
        var value  = UIInterfaceOrientation.landscapeRight.rawValue
        if UIApplication.shared.statusBarOrientation == .landscapeLeft || UIApplication.shared.statusBarOrientation == .landscapeRight {
            value = UIInterfaceOrientation.portrait.rawValue
        }
        UIDevice.current.setValue(value, forKey: "orientation")
        UIViewController.attemptRotationToDeviceOrientation()
        controlsContainerView.frame = CGRect(x: 0, y: 0, width: videoView.frame.size.width, height: videoView.frame.size.height)
        playerLayer?.frame = CGRect(x: 0, y: 0, width: videoView.frame.size.width, height: videoView.frame.size.height)
    }
    
    private func addControllsContainerView() {
        //controlsContainerView.frame = videoView.frame
        controlsContainerView.frame = CGRect(x: 0, y: 0, width: videoView.frame.size.width, height: videoView.frame.size.height)
        
        controlsContainerView.backgroundColor = .none
        videoView.addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: videoView.centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant:150).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        controlsContainerView.addSubview(forwardButton)
        forwardButton.centerXAnchor.constraint(equalTo: videoView.centerXAnchor,constant: 70).isActive = true
        forwardButton.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        forwardButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        forwardButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        controlsContainerView.addSubview(backwardButton)
        backwardButton.centerXAnchor.constraint(equalTo: videoView.centerXAnchor,constant: -70).isActive = true
        backwardButton.centerYAnchor.constraint(equalTo: videoView.centerYAnchor).isActive = true
        backwardButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        backwardButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: videoView.rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: videoView.bottomAnchor,constant: -16).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: videoView.leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: videoView.bottomAnchor,constant: -14).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: videoView.bottomAnchor,constant: -20).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor,constant: 10).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        controlsContainerView.addSubview(EnterFullScreenButton)
        EnterFullScreenButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        EnterFullScreenButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        EnterFullScreenButton.rightAnchor.constraint(equalTo: videoView.rightAnchor,constant: -30).isActive = true
        EnterFullScreenButton.topAnchor.constraint(equalTo: videoView.topAnchor, constant: 20).isActive = true
    }
    
    private func setUpNavBar(episodeTitle: String, showTitle: String) {
        let label = UILabel()
        label.numberOfLines = 0
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Times New Roman Bold", size: 18), NSAttributedString.Key.foregroundColor : UIColor.white]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "Times New Roman", size: 16), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attributedString1 = NSMutableAttributedString(string:showTitle, attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"\n \(episodeTitle)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        attributedString1.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributedString1.length))
        label.attributedText = attributedString1
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.leftItemsSupplementBackButton = true
    }
    
}


extension EpisodesDetailVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodesShelfData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SeasonsCVCell = collectionView.dequeueReusableCell(for: indexPath)
        let data = viewModel.episodesShelfData[indexPath.row]
        
        cell.setProperties(imageURL: data.imageURL , episodeName: "\(data.seasonEpisodeNumber) . \(data.episodeTitle)", duration: "\(data.duration/60)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        player?.replaceCurrentItem(with: nil)
        playVideo()
        addControllsContainerView()
        videoSlider.value = 0
        hideVideoControlItems()
        pausePlayButton.setImage(UIImage(systemName: ImageLiteralsEnum.pauseSymbol.rawValue), for: .normal)
        let data = viewModel.episodesShelfData[indexPath.row]
        let episode = "\(data.seasonEpisodeNumber) . \(data.episodeTitle)"
        updateView(showTitleL: data.showTitle, episodeTitle: episode, description:data.description)
    }
    
}
