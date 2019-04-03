//
//  PostDetailsViewController.swift
//  Posts
//
//  Created by Xinghou Liu on 02/04/2019.
//  Copyright © 2019 Xmart Soft Ltd. All rights reserved.
//

import UIKit
import Models

public final class PostDetailsViewController: BaseViewController {

    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelAuthor: UILabel!
    @IBOutlet private weak var labelBody: UILabel!
    @IBOutlet private weak var labelComment: UILabel!
    
    private let post: Post
    private var author: User?
    private let comments: [Comment]
    
    public init(with postInfo: PostInformation) {
        self.post = postInfo.0
        self.author = postInfo.1
        self.comments = postInfo.2
        super.init(nibName: String(describing: PostDetailsViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = Texts.ViewTitles.postDetails
        self.setupAccessibilityIds()
        self.setupContent()
    }
 
    private func setupAccessibilityIds() {
        self.labelTitle.accessibilityIdentifier = AccessibilityIDs.detailsTitle
        self.labelBody.accessibilityIdentifier = AccessibilityIDs.detailsBody
        self.labelComment.accessibilityIdentifier = AccessibilityIDs.detailsComment
        self.labelAuthor.accessibilityIdentifier = AccessibilityIDs.detailsAuthor
    }
    
    private func setupContent() {
        self.labelTitle.text = self.post.title
        self.labelBody.text = self.post.body
        
        self.labelComment.text = "Comments: \(self.comments.count)"
        
        if let author = self.author {
            self.labelAuthor.text = "By \(author.name)\n"
        }
        else {
            self.labelAuthor.text = "\n"
        }
    }
}
