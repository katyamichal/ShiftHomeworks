//
//  ConservationStatusViewModel.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

final class Observable<T> {
    
    init(data: T) {
        self.data = data
    }
    
    var data: T {
        didSet {
            self.notify?(self.data)
        }
    }
    
    private var notify: ((T) -> Void)?
    
    func setNotify(notify: ((T) -> Void)?) {
        self.notify = notify
    }
}

final class ConservationStatusViewModel {
    
    private var birdConservationData: ConservationViewData
    private weak var controller: ConservationStatusViewController?
    private var router: ConservationStatusRouter

    private var conservation: BirdConservation? {
        didSet {
            guard let controller, let conservation else { return }
            controller.setupConservationStatusView(with: conservation.conservationStatus, description: conservation.conservationStatusDescription)
            updateView()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
   
    lazy var lastStatusUpdate: Observable<String> = Observable<String>(data: dateFormatter.string(from: conservation?.dueDate ?? Date()))
    
    // MARK: - Inits
    
    init(router: ConservationStatusRouter, birdConservationData: ConservationViewData) {
        self.router = router
        self.birdConservationData = birdConservationData
    }

    // MARK: - Public methods
    public func getData() {
        conservation = birdConservationData.getData()
    }
    
    public func setupController(_ controller: ConservationStatusViewController) {
        self.controller = controller
    }
    
    public func dismissView() {
        self.router.goBack()
    }
}
// MARK: - Update view method

private extension ConservationStatusViewModel {
    func updateView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.birdConservationData.setData(dueDate: Date())
            DispatchQueue.main.async { [weak self] in
                guard let newDate = self?.birdConservationData.getData().dueDate,   let dateString = self?.dateFormatter.string(from: newDate) else { return }
                self?.lastStatusUpdate.data = dateString
            }
        }
    }
}
