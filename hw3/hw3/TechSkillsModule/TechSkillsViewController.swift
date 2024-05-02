//
//  TechSkillsViewController.swift
//  hw3
//
//  Created by Catarina Polakowsky on 29.04.2024.
//

import UIKit


final class TechSckillsViewController: UIViewController {
    
    private var techSkillsView: TechSkillsView {return self.view as! TechSkillsView}
    private var techSkills = TechSkill.createSampleData()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardBehavior()
        setupInputAccessoryViewForTextView()
        techSkillsView.update(techSkills)
        
    }
    
    override func loadView() {
        self.view = TechSkillsView()
    }
}


// MARK: - Keyboard handaling

extension TechSckillsViewController {
    
    private func setupKeyboardBehavior() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandeling), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHandeling), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupInputAccessoryViewForTextView() {
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tapDone))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: Layout.width,
                                              height: 44.0))
        toolBar.setItems([flexible, doneItem], animated: true)
        techSkillsView.textView.inputAccessoryView = toolBar
    }
    
    @objc
    func keyboardHandeling(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardFrame = self.view.convert(keyboardSize, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification {
            techSkillsView.textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            techSkillsView.textView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: keyboardFrame.height, right: 5)
            techSkillsView.textView.scrollIndicatorInsets =  techSkillsView.textView.contentInset
        }
        techSkillsView.textView.scrollRangeToVisible( techSkillsView.textView.selectedRange)
    }
    
    @objc
    func tapDone() {
        techSkillsView.textView.endEditing(true)
    }
}
