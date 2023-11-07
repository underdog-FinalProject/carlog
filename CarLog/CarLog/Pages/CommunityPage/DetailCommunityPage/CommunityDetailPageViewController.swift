//
//  CommunityDetailPageViewController.swift
//  CarLog
//
//  Created by t2023-m0075 on 11/1/23.
//

import FirebaseAuth
import SnapKit
import UIKit

class CommunityDetailPageViewController: UIViewController {
    var selectedPost: Post?
    let currentDate = Date()
    var commentData: [Comment] = []
    // 좋아요 버튼 설정
    private var isLiked = false {
        didSet {
            updateLikeButton()
        }
    }
    
    lazy var commentTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        return tableView
    }()
    
    lazy var communityDetailPageScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var communityDetailPageContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "달려라 달려라~"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua24, weight: .medium)
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var userNameLabel: UIButton = {
        let button = UIButton()
        button.setTitle("왕바우", for: .normal) // "게시"라는 텍스트 설정
        button.setTitleColor(.black, for: .normal) // 텍스트 색상 설정
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua16, weight: .medium) // 폰트와 크기 설정
        button.backgroundColor = .clear // 버튼의 배경색 설정
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.02"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: 12, weight: .medium)
        return label
    }()
    
    lazy var subTitleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userNameLabel, UIView(), dateLabel])
        stackView.customStackView(spacing: 0, axis: .horizontal, alignment: .center)
        
        return stackView
    }()
    
    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 361, height: 346)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CommunityDetailCollectionViewCell.self, forCellWithReuseIdentifier: "CommunityDetailCell")
        return collectionView
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "spaner"), for: .normal)
        button.setImage(UIImage(named: "spaner.fill"), for: .selected)
        button.tintColor = .red
        button.addTarget(CommunityDetailPageViewController.self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.text = "264"
        label.textColor = .lightGray
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        return label
    }()

    // textview 로 수정
    lazy var mainText: UILabel = {
        let label = UILabel()
        label.text = "카 \n로 \n그 \n언 \n더 \n독"
        label.textColor = .black
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua20, weight: .bold)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var commentUserNameLabel: UILabel = {
        let label = UILabel()
        label.text = "user1"
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글..."
        label.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    // 댓글
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundCoustomColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold)
        textView.layer.cornerRadius = Constants.cornerRadius
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        return textView
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("게시", for: .normal) // "게시"라는 텍스트 설정
        button.setTitleColor(.mainNavyColor, for: .normal) // 텍스트 색상 설정
        button.titleLabel?.font = UIFont.spoqaHanSansNeo(size: Constants.fontJua14, weight: .bold) // 폰트와 크기 설정
        button.backgroundColor = .clear // 버튼의 배경색 설정
        button.layer.cornerRadius = 5 // 버튼의 모서리 둥글게 설정
        button.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        return button
    }()

    private func setupUI() {
        view.addSubview(communityDetailPageScrollView)
        view.addSubview(containerView)
        communityDetailPageScrollView.addSubview(communityDetailPageContentView)
        communityDetailPageContentView.addSubview(titleLabel)
        communityDetailPageContentView.addSubview(subTitleStackView)
        communityDetailPageContentView.addSubview(photoCollectionView)
        communityDetailPageContentView.addSubview(likeButton)
        communityDetailPageContentView.addSubview(likeCount)
        communityDetailPageContentView.addSubview(mainText)
        communityDetailPageContentView.addSubview(line)
        communityDetailPageContentView.addSubview(commentTableView)
        containerView.addSubview(commentTextView)
        containerView.addSubview(button)
        
        commentTableView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        communityDetailPageScrollView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(containerView.snp.top).offset(-8) // 필요한 경우 scrollView와 textView 사이에 간격 추가
        }
        
        communityDetailPageContentView.snp.makeConstraints { make in
            make.edges.equalTo(communityDetailPageScrollView)
            make.width.equalTo(communityDetailPageScrollView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.rightMargin.equalToSuperview().offset(Constants.horizontalMargin)
        }
        
        subTitleStackView.snp.makeConstraints { make in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(subTitleStackView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 361, height: 346))
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        likeCount.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(photoCollectionView.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(56)
        }
        
        mainText.snp.makeConstraints { make in
            make.width.equalTo(361)
            make.top.equalTo(likeButton.snp.bottom).offset(12)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(mainText.snp.bottom).offset(20)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
            make.height.equalTo(1)
        }

        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-12)
        }
        // 댓글 레이아웃
        containerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leftMargin.equalToSuperview()
            make.rightMargin.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.leftMargin.equalToSuperview().offset(Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-12)
        }
        
        button.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(12)
            make.left.equalTo(commentTextView.snp.right).offset(Constants.horizontalMargin)
            make.rightMargin.equalToSuperview().offset(-Constants.horizontalMargin)
            make.bottomMargin.equalToSuperview().offset(-12)
        }
    }
    
    // dots 버튼 눌렸을때 동작(드롭다운 메뉴)

    @objc func dotsButtonTapped() {
        guard let user = Auth.auth().currentUser, let post = selectedPost else { return }  
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
         //현재 사용자가 포스트의 작성자가 일치하는지 확인
        if post.userEmail == user.email {
            let action1 = UIAlertAction(title: "삭제하기", style: .default) { _ in
                //삭제 기능 로직
                print("삭제 완료")
            }
            action1.setValue(UIColor.red, forKey: "titleTextColor")
            actionSheet.addAction(action1)
        } else {
            let action2 = UIAlertAction(title: "신고하기", style: .default) { _ in
                // 신고 기능 로직
                print("신고 완료")
            }
            let action3 = UIAlertAction(title: "차단하기", style: .default) { _ in
                //차단 기능 로직
                print("차단 완료")
            }
            action2.setValue(UIColor.red, forKey: "titleTextColor")
            action3.setValue(UIColor.red, forKey: "titleTextColor")
            actionSheet.addAction(action2)
            actionSheet.addAction(action3)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    // 좋아요 버튼 눌렀을 떄 동작 구현
    @objc func likeButtonTapped() {
        isLiked.toggle()
    }

    private func updateLikeButton() {
        likeButton.isSelected = isLiked
    }
           
    // MARK: - 댓글 기능
    
    @objc func commentButtonTapped() {
        print("눌렸습니다!")
        if let commentText = commentTextView.text, !commentText.isEmpty {
            addComment(comment: commentText)
            commentTableView.reloadData()
            updateCommentTableViewHeight() // 댓글이 추가된 후에 높이를 업데이트합니다.
            commentTextView.text = ""
        }
    }
    
    private func commentTextViewPlaceholder() {
        commentTextView.delegate = self
        commentTextView.text = "댓글쓰기"
        commentTextView.textColor = .lightGray
    }
    
    func updateCommentTableViewHeight() {
        let contentSize = commentTableView.contentSize
        commentTableView.snp.updateConstraints { make in
            make.height.equalTo(contentSize.height)
        }
    }
    
    func addComment(comment: String) {
        let timeStamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .long)
        guard let user = Auth.auth().currentUser, let userEmail = user.email else { return }

        FirestoreService.firestoreService.fetchNickName(userEmail: userEmail) { [weak self] nickName in
            guard let self = self, let postID = self.selectedPost?.id else { return }
            
            let userNickName = nickName
            let newComment = Comment(id: UUID().uuidString, content: comment, userName: userNickName, userEmail: userEmail, timeStamp: timeStamp)
            
            FirestoreService.firestoreService.saveComment(postID: postID, comment: newComment) { error in
                if let error = error {
                    print("Error saving comment: \(error.localizedDescription)")
                } else {
                    print("Comment saved successfully")
                    self.commentData.append(newComment)
                    self.commentData.sort { $0.timeStamp ?? "" > $1.timeStamp ?? "" }
                    
                    DispatchQueue.main.async {
                        self.commentTableView.reloadData()
                        self.updateCommentTableViewHeight()
                    }
                }
            }
        }
    }
}

extension CommunityDetailPageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundCoustomColor
        navigationController?.navigationBar.barTintColor = .backgroundCoustomColor
        tabBarController?.tabBar.isHidden = true
        
        // 네비게이션 바 버튼 이미지 설정
        let dotsImage = UIImage(named: "dots")?.withRenderingMode(.alwaysOriginal)
        let dotsButton = UIBarButtonItem(image: dotsImage, style: .plain, target: self, action: #selector(dotsButtonTapped))
        navigationItem.rightBarButtonItem = dotsButton
        
        // 컬렉션뷰 셀을 한장씩 넘기게 설정
        photoCollectionView.isPagingEnabled = true
        
        setupUI()
        setupNavigationBarButton()
        loadPost()
        loadComments()
        commentTextViewPlaceholder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCommentTableViewHeight()
    }
    
    private func setupNavigationBarButton() {
        navigationController?.navigationBar.tintColor = .mainNavyColor
        if let backImage = UIImage(systemName: "chevron.left") {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(didTapLeftBarButton))
        }
    }
       
    @objc func didTapLeftBarButton() {
        tabBarController?.tabBar.isHidden = false
        navigationController?.popViewController(animated: true)
    }

    private func loadPost() {
        if let post = selectedPost {
            FirestoreService.firestoreService.fetchNickName(userEmail: post.userEmail ?? "") { nickName in
                self.userNameLabel.setTitle(nickName, for: .normal)
                self.titleLabel.text = post.title
                self.dateLabel.text = post.timeStamp
                self.mainText.text = post.content
            }
        }
    }
    
    private func loadComments() {
        if let post = selectedPost {
            FirestoreService.firestoreService.getComments(forPostID: post.id!) { comments, error in
                if let error = error {
                    print("Error loading comments: \(error.localizedDescription)")
                } else if let comments = comments {
                    print("Loaded comments: \(comments)")
                    for comment in comments {
                        self.commentData.append(comment)
                        self.commentTableView.reloadData()
                    }
                }
            }
        }
    }
}
