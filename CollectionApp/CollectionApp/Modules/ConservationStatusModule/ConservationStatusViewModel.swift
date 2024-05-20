//
//  ConservationStatusViewModel.swift
//  CollectionApp
//
//  Created by Catarina Polakowsky on 20.05.2024.
//

import UIKit

final class ConservationStatusViewModel {

    private let birdConservationData: ConservationViewData
    private var conservation: BirdConservation
    private weak var controller: ConservationStatusViewController?
    private var timer: Timer?

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

    init(birdConservationData: ConservationViewData) {
        self.birdConservationData = birdConservationData
    }

    deinit {
        stopTimer()
    }
    
     func getData(){
         conservation = birdConservationData.getData()
    }

    // MARK: - Public methods

    public func setupController(_ controller: ConservationStatusViewController) {
        defer {
            controller.setupConservationStatusView(with: conservation.conservationStatus, description: conservation.conservationStatusDescription)
            startTimer()
        }
        self.controller = controller
    }

        func dismissView() {
            self.controller?.dismiss(animated: true, completion: nil)
        }

    // MARK: - Private methods

    private func startTimer() {
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateView), userInfo: nil, repeats: true)
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    @objc
    private func updateView() {
        controller?.setupStatusUpdate(with: lastStatusUpdate)
    }
}
