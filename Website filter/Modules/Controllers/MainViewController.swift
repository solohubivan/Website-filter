//
//  MainViewController.swift
//  Website filter
//
//  Created by Ivan Solohub on 28.01.2024.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var mainView: MainView = {
        let view = MainView(frame: .zero)
        view.presentingViewController = self
        return view
    }()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternetConnection()
        configureMainView()
    }
    // MARK: - Private methods
    
    private func checkInternetConnection() {
        if !NetworkMonitor.shared.isConnected {
            DispatchQueue.main.async {
                self.showNoInternetAlert()
            }
        }
    }
    
    private func configureMainView() {
        mainView.showAlert = { [weak self] in
            self?.showRequestFilteredAlert()
        }
    }
    
    private func showRequestFilteredAlert() {
        let cancelAction = AlertFactory.createAlertAction(
            title: AppConstants.Alerts.alertCancelAction,
            style: .cancel
        )
        let alertController = AlertFactory.createAlert(
            title: AppConstants.Alerts.requestFilteredAlertTitle,
            message: AppConstants.Alerts.requestFilteredAlertMessage,
            actions: [cancelAction]
        )
        present(alertController, animated: true)
    }
    
    private func showNoInternetAlert() {
        let cancelAction = AlertFactory.createAlertAction(
            title: AppConstants.Alerts.alertCancelAction,
            style: .cancel
        )
        let settingsAction = AlertFactory.createAlertAction(
            title: AppConstants.Alerts.alertSettingsAction,
            style: .default
        ) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        }

        let alertController = AlertFactory.createAlert(
            title: AppConstants.Alerts.noInternetAlertTitle,
            message: AppConstants.Alerts.noInternetAlertMessage,
            actions: [cancelAction, settingsAction]
        )

        present(alertController, animated: true)
    }
}
