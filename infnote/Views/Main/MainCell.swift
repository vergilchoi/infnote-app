//
//  MainCell.swift
//  infnote
//
//  Created by Vergil Choi on 2018/8/2.
//  Copyright © 2018 Vergil Choi. All rights reserved.
//

import UIKit
import WebKit
import Down

class MainCell: UITableViewCell, WKNavigationDelegate {

    let avatarView = UIImageView()
    let nicknameLabel = UILabel()
    let categoryLabel = UILabel()
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let imageStackView = ImageStackView()
    let timeLabel = UILabel()
    let commentLabel = UILabel()

    var reusing = false
    
    func prepareViews(note: Note) {
        if (!reusing) {
            self.addSubview(avatarView)
            self.addSubview(nicknameLabel)
            self.addSubview(categoryLabel)
            self.addSubview(titleLabel)
            self.addSubview(contentLabel)
            self.addSubview(imageStackView)
            self.addSubview(timeLabel)
            self.addSubview(commentLabel)
            reusing = true
        }
        
        avatarView.image = #imageLiteral(resourceName: "default-avatar")
        avatarView.layer.cornerRadius = 20
        avatarView.layer.masksToBounds = true
        avatarView.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(ViewConst.horizontalMargin)
            make.top.equalToSuperview().offset(ViewConst.horizontalMargin)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        nicknameLabel.text = note.user.nickname == "anonymous" ? __("anonymous") : note.user.nickname
        nicknameLabel.font = UIFont(name: DEFAULT_FONT_REGULAR, size: 14)
        nicknameLabel.snp.remakeConstraints { make in
            make.left.equalTo(avatarView.snp.right).offset(ViewConst.lineSpace)
            make.centerY.equalTo(avatarView.snp.centerY)
        }
        
        /*
        categoryLabel.text = "区块链"
        categoryLabel.font = UIFont(name: DEFAULT_FONT_REGULAR, size: 12)
        categoryLabel.textColor = .white
        categoryLabel.textAlignment = .center
        categoryLabel.backgroundColor = MAIN_COLOR
        categoryLabel.sizeToFit()
        categoryLabel.frame.size.width = categoryLabel.frame.width + 40
        categoryLabel.frame.size.height = categoryLabel.frame.height + 10
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
        categoryLabel.layer.masksToBounds = true
        categoryLabel.snp.remakeConstraints { make in
            make.width.equalTo(categoryLabel.frame.width)
            make.height.equalTo(categoryLabel.frame.height)
            make.right.equalToSuperview().offset(-ViewConst.horizontalMargin)
            make.centerY.equalTo(nicknameLabel.snp.centerY)
        }
         */
        
//        titleLabel.text = note.title
//        titleLabel.font = UIFont(name: DEFAULT_FONT_DEMI_BOLD, size: 18)
//        titleLabel.lineBreakMode = .byTruncatingMiddle
//        titleLabel.snp.remakeConstraints { make in
//            make.left.equalToSuperview().offset(ViewConst.horizontalMargin)
//            make.right.equalToSuperview().offset(-ViewConst.horizontalMargin)
//            make.top.equalTo(avatarView.snp.bottom).offset(ViewConst.verticalMargin)
//        }
        contentLabel.attributedText = note.attrubutedContent
        contentLabel.numberOfLines = 0
        contentLabel.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(ViewConst.horizontalMargin)
            make.right.equalToSuperview().offset(-ViewConst.horizontalMargin)
            make.top.equalTo(nicknameLabel.snp.bottom).offset(ViewConst.verticalMargin * 4)
        }
        
//        imageStackView.backgroundColor = MAIN_COLOR
//        imageStackView.snp.remakeConstraints { make in
//            make.left.equalToSuperview().offset(ViewConst.horizontalMargin)
//            make.right.equalToSuperview().offset(-ViewConst.horizontalMargin)
//            make.top.equalTo(contentLabel.snp.bottom).offset(ViewConst.verticalMargin)
//            make.height.equalTo(imageStackView.calculatedHeigh)
//        }
        
        timeLabel.text = note.date.formatted
        timeLabel.font = UIFont(name: DEFAULT_FONT_REGULAR, size: 14)
        timeLabel.textColor = .darkGray
        timeLabel.snp.remakeConstraints { make in
            make.left.equalToSuperview().offset(ViewConst.horizontalMargin)
            make.bottom.equalToSuperview().offset(-ViewConst.verticalMargin)
            make.top.equalTo(contentLabel.snp.bottom)
        }
        
        commentLabel.text = String.localizedStringWithFormat(__("comment"), note.replies!)
        commentLabel.font = UIFont(name: DEFAULT_FONT_REGULAR, size: 14)
        commentLabel.textColor = .darkGray
        commentLabel.snp.remakeConstraints { make in
            make.right.equalToSuperview().offset(-ViewConst.horizontalMargin)
            make.bottom.equalToSuperview().offset(-ViewConst.verticalMargin)
//            make.top.equalTo(timeLabel.snp.bottom).offset(ViewConst.verticalMargin)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
