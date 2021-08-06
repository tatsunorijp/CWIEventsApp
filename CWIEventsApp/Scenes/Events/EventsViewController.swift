//
//  EventsViewController.swift
//  CWIEventsApp
//
//  Created by Tatsu on 06/08/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// Ideia retirada de:
// https://github.com/tailec/ios-architecture/blob/master/mvvm-functions-subjects-observables/MVVMFunctionsSubjectsObservables/App/ReposScene/ReposViewController.swift
import RxCocoa
import RxSwift
import UIKit
import IGListKit

final class EventsViewController: BaseViewController {
    
    private let viewModel: EventsViewModelType
    private let router: EventsRouting
    
    private enum Consts {
        static let topCollectionViewMargin: CGFloat = 32
        static let bottomCollectionViewMaring: CGFloat = 32
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    lazy var adapter: ListAdapter = {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = collectionView
        adapter.dataSource = self
        return adapter
    }()
    
    private var events: [EventsViewModel.EventsDisplay] = []
    
    init(withViewModel viewModel: EventsViewModelType, router: EventsRouting) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CWI Eventos"
        prepareCollectionView()
        viewModel.input.onViewDidLoad.onNext(())
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.output.events
            .drive { [weak self] events in
                print(events)
                self?.events = events
                self?.adapter.performUpdates(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        viewModel.output.isLoading
            .drive(isLoading)
            .disposed(by: disposeBag)
        
        viewModel.output.error
            .drive(error)
            .disposed(by: disposeBag)
    }
    
    override func prepare() {
        super.prepare()
    }
    
    private func prepareCollectionView() {
        _ = adapter
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Asset.Colors.gray100.color
        collectionView.contentInset = UIEdgeInsets(
            top: Consts.topCollectionViewMargin,
            left: 0,
            bottom: Consts.bottomCollectionViewMaring,
            right: 0
        )
        collectionView.register(
            UINib(nibName: EventCell.nibName, bundle: EventCell.nibBundle),
            forCellWithReuseIdentifier: String(describing: EventCell.self))
    }
}

extension EventsViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var items: [ListDiffable] = []
        for event in events {
            items.append(DiffableBox(value: event, identifier: event.id as NSObjectProtocol))
        }
        return items
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return EventSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}
