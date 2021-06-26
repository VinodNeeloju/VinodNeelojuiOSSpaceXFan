//
//  DetailsVCHeaderTableViewCell.swift
//  SpaceX Fan
//
//  Created by iOS Dev on 27/06/21.
//

import UIKit

class DetailsVCHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    
    var timer : Timer?
    
    public var rocketResponse : RocketResponse? {
        didSet {
            self.nameLabel.text = self.rocketResponse?.name
            let flickr = self.rocketResponse?.links?.flickr?.original
            self.pageController.numberOfPages = flickr?.count ?? 0
            self.flickrImages = flickr
            self.setTimerForAutoSwipe()
        }
    }
    
    func setTimerForAutoSwipe() {
        self.timer = nil
        self.timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (_ t) in
            guard var row = self.getVisibleIndexPath()?.row else { return }
            row += 1
            if row >= self.flickrImages?.count ?? 0 {
                row = 0
            }
            self.collectionView.scrollToItem(at: IndexPath(item: row, section: 0), at: .centeredVertically, animated: true)
        })
    }
    
    
    fileprivate var flickrImages : [String]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailsVCHeaderTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = self.flickrImages?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailVCImageCollectionViewCell", for: indexPath) as! DetailVCImageCollectionViewCell
        guard let imageURLString = self.flickrImages?[indexPath.row] else { return cell }
        cell.imageString = imageURLString
        cell.rocketImageView.addGradient(self.frame.size, [Constants.Colors.AppBlue!.cgColor, UIColor.clear.cgColor,  UIColor.clear.cgColor])
        return cell
    }
}

extension DetailsVCHeaderTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension DetailsVCHeaderTableViewCell : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageController.currentPage = self.getVisibleIndexPath()?.row ?? 0
    }
    
    func getVisibleIndexPath() -> IndexPath? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        return visibleIndexPath
    }
}
