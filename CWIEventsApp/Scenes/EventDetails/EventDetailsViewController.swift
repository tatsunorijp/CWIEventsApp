//
//  EventDetailsViewController.swift
//  CWIEventsApp
//
//  Created by Tatsu on 07/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit
import MapKit

final class EventDetailsViewController: BaseViewController {
    
    private let viewModel: EventDetailsViewModelType
    private let router: EventDetailsRouting
    
    @IBOutlet private weak var eventContentView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var checkinButton: PrimaryButton!
    @IBOutlet private weak var shareButton: PrimaryButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var priceImageView: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var locationImageView: UIImageView!
    @IBOutlet private weak var locationButton: UIButton!
    
    private var eventTitle = ""
    
    init(withViewModel viewModel: EventDetailsViewModelType, router: EventDetailsRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.input.onViewDidLoad.onNext(())
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        viewModel.output.eventDetails
            .drive { [weak self] eventDetails in
                guard let self = self else { return }
                self.imageView.kf.setImage(
                    with: URL(string: eventDetails.imageURL),
                    placeholder: Asset.Assets.cwiLogo.image
                )
                
                self.titleLabel.text = eventDetails.title
                self.descriptionLabel.text = eventDetails.description
                self.dateLabel.text = eventDetails.date
                self.priceLabel.text = eventDetails.price
                
                self.eventTitle = eventDetails.title
            }
            .disposed(by: disposeBag)
        
        viewModel.output.coordinate
            .drive { [weak self] coordinate in
                self?.openMapWith(
                    longitude: coordinate.longitud,
                    latitude: coordinate.latitude
                )
            }
            .disposed(by: disposeBag)
        
        viewModel.output.eventIDToCheckIn
            .drive { [weak self] eventID in
                self?.router.navigateToCheckIn(eventID: eventID)
            }
            .disposed(by: disposeBag)
        
        shareButton.rx.tap
            .bind { _ in
                let fact = self.eventContentView.snapshot()
                let activityViewController = UIActivityViewController(
                    activityItems: [fact],
                    applicationActivities: nil
                )
                self.present(activityViewController, animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        checkinButton.rx.tap
            .bind { _ in
                self.viewModel.input.onCheckInChange.onNext(())
            }
            .disposed(by: disposeBag)
    }
    
    override func prepare() {
        super.prepare()
        prepareLayout()
        prepareLocation()
    }
    
    private func prepareLayout() {
        checkinButton.isEnabled = true
        checkinButton.setTitle(L10n.EventDetails.Button.checkIn, for: .normal)
        
        shareButton.isEnabled = true
        shareButton.setTitle(L10n.EventDetails.Button.share, for: .normal)
        shareButton.addIcon(icon: Asset.Assets.share.image)
        
        imageView.layer.cornerRadius = 15
        
        locationButton.setTitle(L10n.EventDetails.Label.localization, for: .normal)
    }
    
    private func prepareLocation() {
        locationButton.addTarget(self,
                                 action: #selector(requestLocalization(_:)),
                                 for: .touchUpInside)
    }
    
    @objc private func requestLocalization(_ sender: UITapGestureRecognizer) {
        viewModel.input.onCoordinatesRequested.onNext(())
    }
}

extension EventDetailsViewController {
    private func openMapWith(longitude: CLLocationDegrees, latitude: CLLocationDegrees) {
        
        let regionDistance: CLLocationDistance = 10_000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = eventTitle
        mapItem.openInMaps(launchOptions: options)
    }
}
