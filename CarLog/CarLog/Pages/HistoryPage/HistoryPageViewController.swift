import SnapKit
import UIKit

class HistoryPageViewController: UIViewController {
    
    var dummy = [
        Driving(timeStamp: "2023.10.15", departDistance: 222222, arriveDistance: 222223, driveDistance: 1),
        Driving(timeStamp: "2023.10.15", departDistance: 17778, arriveDistance: 17788, driveDistance: 10),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
        Driving(timeStamp: "2023.10.16", departDistance: 17788, arriveDistance: 17900, driveDistance: 112),
    ]
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["주행 기록", "주유 내역"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(didChangeValue(segment:)), for: .valueChanged)
        segmentedControl.selectedSegmentTintColor = .primaryColor
        
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Constants.fontJua20 ?? UIFont(), .foregroundColor: UIColor.darkGray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: Constants.fontJua20 ?? UIFont(), .foregroundColor: UIColor.white], for: .selected)
        return segmentedControl
    }()
    
    lazy var drivingCollectionView: DrivingView = {
        let drivingCollectionView = DrivingView()
        drivingCollectionView.drivingCollectionView.dataSource = self
        drivingCollectionView.drivingCollectionView.delegate = self
        return drivingCollectionView
    }()
    
    lazy var fuelingCollectionView: FuelingView = {
        let fuelingCollectionView = FuelingView()
        return fuelingCollectionView
    }()
    
    var shouldHideFirstView: Bool? {
        didSet {
            guard let shouldHideFirstView = self.shouldHideFirstView else { return }
            self.drivingCollectionView.isHidden = shouldHideFirstView
            self.fuelingCollectionView.isHidden = !self.drivingCollectionView.isHidden
        }
    }
    
    lazy var floatingButtonStackView: FloatingButtonStackView = {
        let floatingButtonStackView = FloatingButtonStackView()
        floatingButtonStackView.navigationController = self.navigationController
        return floatingButtonStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        setupUI()
        
        self.didChangeValue(segment: self.segmentedControl)
        
        buttonActions()
    }
    
    @objc private func didChangeValue(segment: UISegmentedControl) {
        self.shouldHideFirstView = segment.selectedSegmentIndex != 0
    }
    
    func setupUI() {
        view.addSubview(segmentedControl)
        view.addSubview(drivingCollectionView)
        view.addSubview(fuelingCollectionView)
        view.addSubview(floatingButtonStackView)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(Constants.horizontalMargin)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.height.equalTo(50)
        }
        
        drivingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        fuelingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        floatingButtonStackView.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-Constants.horizontalMargin)
        }
        
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let driveDetailViewController = DriveDetailViewController()
        self.navigationController?.pushViewController(driveDetailViewController, animated: true)
    }
    
    func buttonActions() {
        
        floatingButtonStackView.floatingButton.addAction(UIAction(handler: {_ in
            self.isActive.toggle()
        }), for: .touchUpInside)
        
        floatingButtonStackView.fuelingButton.addAction(UIAction(handler: {_ in
            self.navigationController?.present(AddFuelingViewController(), animated: true)
            self.navigationController?.modalPresentationStyle = .fullScreen
        }), for: .touchUpInside)
        
        floatingButtonStackView.drivingButton.addAction(UIAction(handler: {_ in
            self.navigationController?.present(AddDrivingViewController(), animated: true)
            self.navigationController?.modalPresentationStyle = .fullScreen
        }), for: .touchUpInside)
        
    }
    
    private var animation: UIViewPropertyAnimator?
    
    private var isActive: Bool = false {
        didSet {
            showActionButtons()
        }
    }
    
    private func showActionButtons() {
        popButtons()
        rotateFloatingButton()
    }
    
    private func popButtons() {
        if isActive {
            floatingButtonStackView.fuelingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.fuelingButton.layer.transform = CATransform3DIdentity
                floatingButtonStackView.fuelingButton.alpha = 1.0
            })
            
            floatingButtonStackView.drivingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 1)
            UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.3, options: [.curveEaseInOut], animations: { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.drivingButton.layer.transform = CATransform3DIdentity
                floatingButtonStackView.drivingButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.fuelingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                floatingButtonStackView.fuelingButton.alpha = 0.0
            }
            
            UIView.animate(withDuration: 0.15, delay: 0.2, options: []) { [weak self] in
                guard let self = self else { return }
                floatingButtonStackView.drivingButton.layer.transform = CATransform3DMakeScale(0.4, 0.4, 0.1)
                floatingButtonStackView.drivingButton.alpha = 0.0
            }
        }
    }
    
    private func rotateFloatingButton() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let fromValue = isActive ? 0 : CGFloat.pi / 4
        let toValue = isActive ? CGFloat.pi / 4 : 0
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = 0.3
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        floatingButtonStackView.floatingButton.layer.add(animation, forKey: nil)
    }
    
    
    
}

extension HistoryPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrivingCollectionViewCell.identifier, for: indexPath) as! DrivingCollectionViewCell
        
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = Constants.cornerRadius
        
        cell.layer.borderColor = UIColor.systemGray5.cgColor
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.3
        
        cell.writeDateLabel.text = dummy[indexPath.row].timeStamp
        cell.driveDistenceLabel.text = String("\(dummy[indexPath.row].driveDistance)km")
        cell.departDistenceLabel.text = String("\(dummy[indexPath.row].departDistance)km")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - Constants.horizontalMargin * 4), height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let driveDetailViewController = DriveDetailViewController()
        navigationController?.pushViewController(driveDetailViewController, animated: true)
    }
    
    
}
