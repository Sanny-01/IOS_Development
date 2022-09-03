//
//  CountryWeatherViewController.swift
//  Sandro Giorgishvili 28
//
//  Created by TBC on 02.09.22.


import UIKit

protocol CountryWeatherDisplayLogic: AnyObject {
    func displaySelectedCountryWeather(viewModel: CountryWeather.ShowCountryWeather.ViewModel)
}

final class CountryWeatherViewController: UIViewController {
    // MARK: - Clean Components
    
    private let interactor: CountryWeatherBusinessLogic
    private let router: CountryWeatherRoutingLogic & CountryWeatherDataPassing
    
    // MARK: - View
    
    private let currentWeather: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        return view
    }()
    
    // MARK: - Object lifecycle
    
    init(interactor: CountryWeatherBusinessLogic, router: CountryWeatherRoutingLogic & CountryWeatherDataPassing) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        interactor.getCountryWeather()
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [currentWeather])
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.anchor(left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 12, paddingRight: 12)
        stackView.center(inView: view)
    }
}

// MARK: - CountryDetailsDisplayLogic

extension CountryWeatherViewController: CountryWeatherDisplayLogic {
    func displaySelectedCountryWeather(viewModel: CountryWeather.ShowCountryWeather.ViewModel) {
        self.currentWeather.text = viewModel.currentWeather
    }
}
