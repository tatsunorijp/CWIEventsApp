//
//  EventCell.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//

import UIKit
import IGListKit
import Kingfisher

final class EventCell: UICollectionViewCell, NibLoadable {
    static let defaultHeight: CGFloat = 128
    
    private enum Consts {
        static let cornerRadius: CGFloat = 5
    }
    
    @IBOutlet private weak var imageContentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var cellContentView: UIView!
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepare()
    }
    
    func setup(with model: EventsViewModel.EventsDisplay) {
        titleLabel.text = model.title
        price.text = model.price
        dateLabel.text = model.date
        imageView.kf.setImage(
            with: URL(string: model.imageURL),
            placeholder: Asset.Assets.cwiLogo.image
        )
    }
    
    private func prepare() {
        cellContentView.layer.cornerRadius = Consts.cornerRadius
        cellContentView.clipsToBounds = true
        cellContentView.layer.masksToBounds = true
        
        imageView.layer.cornerRadius = Consts.cornerRadius
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        
        imageContentView.clipsToBounds = false
        imageContentView.layer.cornerRadius = Consts.cornerRadius
        imageContentView.layer.shadowColor = Asset.Colors.black.color.cgColor
        imageContentView.layer.shadowOpacity = 1
        imageContentView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        imageContentView.layer.shadowRadius = Consts.cornerRadius
        imageContentView.layer.shadowPath = UIBezierPath(
            roundedRect: imageContentView.bounds,
            cornerRadius: Consts.cornerRadius
        ).cgPath
    }

}

final class EventSectionController: ListSectionController {
    var event: EventsViewModel.EventsDisplay!
    let didSelectEvent: (String) -> Void
    
    init(didSelectEvent: @escaping (String) -> Void) {
        self.didSelectEvent = didSelectEvent
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        guard let event = object as? DiffableBox<EventsViewModel.EventsDisplay> else { return }
        self.event = event.value
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext else { fatalError() }
        let cell = context.dequeueReusableCell(
            withNibName: EventCell.nibName,
            bundle: EventCell.nibBundle,
            for: self,
            at: index
        ) as! EventCell
        
        cell.setup(with: event)
        
        return cell
    }
    
    override func didSelectItem(at index: Int) {
        super.didSelectItem(at: index)
        didSelectEvent(event.id)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(
            width: collectionContext!.containerSize.width,
            height: EventCell.defaultHeight
        )
    }
}
