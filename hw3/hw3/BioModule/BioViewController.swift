//
//  BioViewController.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit

final class BioViewController: UIViewController {
    
    private var bioInfo = Bio.createSampleData()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureInfoStackView()
        setupBioView()
    }
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var educationInfo: UILabel!
    
    @IBOutlet weak var hometown: UILabel!
    
    @IBOutlet weak var birthDate: UIDatePicker!
    
    @IBOutlet weak var infoStackView: UIStackView!
    
    

    private func setupBioView() {
        photo.image = UIImage(named: bioInfo.image)
        fullName.text = bioInfo.name + " " + bioInfo.surname
        educationInfo.text = bioInfo.education
        birthDate.date = bioInfo.birthDate
    }
    
    private func configureInfoStackView() {
        infoStackView.layer.cornerRadius = 15
        infoStackView.clipsToBounds = true
        infoStackView.layer.borderColor = UIColor.black.cgColor
        infoStackView.layer.borderWidth = 1.3
        infoStackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        infoStackView.isLayoutMarginsRelativeArrangement = true
    }
}
