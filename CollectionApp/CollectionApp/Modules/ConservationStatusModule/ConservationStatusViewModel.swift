//
//  ConservationStatusViewModel.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

final class ConservationStatusViewModel {
    
    private let birdConservationData: ConservationViewData
    private weak var controller: ConservationStatusViewController?
    private var router: ConservationStatusRouter
    private var timer: Timer?
    
    private var conservation: BirdConservation? {
        didSet {
            guard let controller, let conservation else { return }
            controller.setupConservationStatusView(with: conservation.conservationStatus, description: conservation.conservationStatusDescription)
            startTimer()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    private var lastStatusUpdate: String {
        dateFormatter.string(from: Date())
    }
    
    // MARK: - Inits
    
    init(router: ConservationStatusRouter, birdConservationData: ConservationViewData) {
        self.router = router
        self.birdConservationData = birdConservationData
    }
    
    deinit {
        stopTimer()
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
// MARK: - Timer methods

private extension ConservationStatusViewModel {
    func startTimer() {
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc
    func updateView() {
        controller?.setupStatusUpdate(with: lastStatusUpdate)
    }
}
