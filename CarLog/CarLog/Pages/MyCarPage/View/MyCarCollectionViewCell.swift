//
//  MyPageTableViewCell.swift
//  CarLog
//
//  Created by t2023-m0056 on 2023/10/11.
//

import UIKit
import SnapKit

class MyCarCollectionViewCell: UICollectionViewCell {
    static var identifier = "MyCarTableViewCell"
    
    private var collectionViewImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "photo")
        return view
    }()
    
    private var collectionViewTitle: UILabel = {
        var label = UILabel()
        label.customLabel(text: "이름", textColor: .black, font: Constants.fontJua16 ?? UIFont.systemFont(ofSize: 16), alignment: .left)
        return label
    }()

    lazy private var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .thirdColor
        view.progressTintColor = .primaryColor
        view.progress = 0.1
        return view
    }()
    
    private var collectionViewPeriod: UILabel = {
        var label = UILabel()
        label.customLabel(text: "기간", textColor: .systemGray, font: Constants.fontJua10 ?? UIFont.systemFont(ofSize: 10), alignment: .left)
        return label
    }()
    
    private let clickedIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrowtriangle.right.fill")
        view.tintColor = .primaryColor
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
 
 required init?(coder: NSCoder) {
     fatalError("init(coder:) has not been implemented")
 }
    
    private func setupUI() {
        contentView.addSubview(collectionViewImage)
        contentView.addSubview(clickedIcon)
        contentView.addSubview(collectionViewTitle)
        contentView.addSubview(progressView)
        contentView.addSubview(collectionViewPeriod)
        
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .thirdColor
        
        contentView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(Constants.horizontalMargin)
            $0.height.equalTo(100)
        }
        
        collectionViewImage.snp.makeConstraints {
            $0.leading.equalTo(contentView).inset(Constants.horizontalMargin)
            $0.width.height.equalTo(60)
            $0.centerY.equalTo(contentView)
        }
        
        collectionViewTitle.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView).inset(Constants.verticalMargin)
            $0.leading.equalTo(collectionViewImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(clickedIcon.snp.leading).inset(-Constants.horizontalMargin)
        }
        
        progressView.snp.makeConstraints {
            $0.top.equalTo(collectionViewTitle.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(collectionViewImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(clickedIcon.snp.leading).inset(-Constants.horizontalMargin)
            $0.centerY.equalTo(contentView)
        }
        
        collectionViewPeriod.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).inset(-Constants.verticalMargin)
            $0.leading.equalTo(collectionViewImage.snp.trailing).inset(-Constants.horizontalMargin)
            $0.trailing.equalTo(clickedIcon.snp.leading).inset(-Constants.horizontalMargin)
            $0.bottom.equalTo(contentView).inset(Constants.verticalMargin)
        }
        
        clickedIcon.snp.makeConstraints {
            $0.trailing.equalTo(contentView).inset(Constants.horizontalMargin)
            $0.centerY.equalTo(contentView)
            $0.width.equalTo(15)
            $0.height.equalTo(20)
        }
    }
    
    func bind(text: String, period: String, icon: UIImage) {
        collectionViewTitle.text = text
        collectionViewPeriod.text = period
        collectionViewImage.image = icon
    }

}