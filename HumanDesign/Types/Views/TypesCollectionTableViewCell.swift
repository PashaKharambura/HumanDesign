//
//  TypesCollectionTableViewCell.swift
//  HumanDesign
//
//  Created by Pavlo Kharambura on 12/17/18.
//  Copyright © 2018 Pavlo Kharambura. All rights reserved.
//

import UIKit

protocol TypesCollectionViewDelegate: class {
    func selectType(index: Int)
}

class TypesCollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: TypesCollectionViewDelegate?
    var state: TypeInfoState = .type
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TypeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TypeCollectionViewCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch state {
        case .type:
            return UserProfileTypeManager.getTypesCount()
        case .profile:
            return UserProfileTypeManager.getProfilesCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypeCollectionViewCell", for: indexPath) as? TypeCollectionViewCell else {return UICollectionViewCell()}
        switch state {
        case .type:
            let type = UserProfileTypeManager.types[indexPath.row]
            cell.titleLabel.text = type.name
            cell.subtitleLabel.text = type.peoples
            cell.imageView.image = type.image
        case .profile:
            let profile = UserProfileTypeManager.profiles[indexPath.row]
            cell.titleLabel.text = profile.name
            cell.subtitleLabel.text = profile.peoples
            cell.imageView.image = profile.image
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectType(index: indexPath.row)
        switch state {
        case .type:
            UserProfileTypeManager.state = .type
            UserProfileTypeManager.selectedType = UserProfileTypeManager.types[indexPath.row]
        case .profile:
            UserProfileTypeManager.state = .profile
            UserProfileTypeManager.selectedProfile = UserProfileTypeManager.profiles[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = self.frame.size.width/2 - 10
        return CGSize(width: itemSize, height: itemSize*1.25)
    }
    
}


