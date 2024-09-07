
import UIKit
import SDWebImage

final class WeatherViewController: UIViewController {
    
    private let mainLabel: UILabel = WeatherLabel(labelText: "Введите город", fontSize: 18, weight: .heavy)
    private var cityNameLabel: UILabel = WeatherLabel(labelText: "Дубай", color: .darkGray, fontSize: 18, weight: .medium)
    private var tempLabel: UILabel = WeatherLabel(fontSize: 20, weight: .semibold)
    private var feelsLikeLabel: UILabel = WeatherLabel(color: .gray, fontSize: 16, weight: .regular)
    private var descriptionLabel: UILabel = WeatherLabel(color: .darkGray, fontSize: 18, weight: .medium)
    private var errorLabel: UILabel = WeatherLabel(labelText: "Некорректно введен город", color: .systemRed, fontSize: 14, weight: .semibold, labelIsHidden: true)
    
    private var cityTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите город"
        textField.font = UIFont.boldSystemFont(ofSize: 16)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
   private var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var backBarButtonItem = MiniAppListViewController.createBackBarButtonItem(target: self, action: #selector(backBarButtonItemTapped))
    
    private var searchTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        cityTextField.delegate = self
        fetchFirstData()
    }
    
    private func fetchFirstData() {
        if Reachability.isConnectedToNetwork() {
            fetchData(for: "Дубай")
        } else {
            activityIndicator.stopAnimating()
            errorLabel.isHidden = false
            errorLabel.text = "Нет подключения к интернету"
        }
    }
    
    private func setupViews() {
        title = "Weather"
        view.backgroundColor = .systemGray6
        navigationItem.leftBarButtonItem = backBarButtonItem
        view.addSubview(mainLabel)
        view.addSubview(tempLabel)
        view.addSubview(feelsLikeLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(weatherIcon)
        view.addSubview(cityTextField)
        view.addSubview(activityIndicator)
        view.addSubview(errorLabel)
        view.addSubview(cityNameLabel)
    }
    
    @objc func backBarButtonItemTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            
            cityTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 20),
            cityTextField.widthAnchor.constraint(equalToConstant: view.bounds.width - 80),
            
            cityNameLabel.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 20),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            feelsLikeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feelsLikeLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 10),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: feelsLikeLabel.bottomAnchor, constant: 10),
            
            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherIcon.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            weatherIcon.widthAnchor.constraint(equalToConstant: 100),
            weatherIcon.heightAnchor.constraint(equalToConstant: 100),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

        ])
    }
    
    private func clearWeatherData() {
        tempLabel.text = ""
        feelsLikeLabel.text = ""
        descriptionLabel.text = ""
        weatherIcon.image = nil
        cityNameLabel.text = ""
    }

    private func fetchData(for city: String) {
        activityIndicator.startAnimating()
        errorLabel.isHidden = true

        APIManager().load(city: city) { [weak self] weather, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()

                if let error = error {
                    self.clearWeatherData()
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = error.localizedDescription
                    print("Ошибка: \(error.localizedDescription)")
                } else if let weather = weather {
                    self.updateUI(with: weather, city: city)
                } else {
                    self.clearWeatherData()
                    self.errorLabel.isHidden = false
                    self.errorLabel.text = "Не удалось загрузить данные"
                }
            }
        }
    }

    private func updateUI(with weather: Weather, city: String) {
        errorLabel.isHidden = true
        cityNameLabel.text = city
        tempLabel.text = "Температура: \(weather.main.temp)°C"
        feelsLikeLabel.text = "Ощущается как: \(weather.main.feelsLike)°C"
        if let weatherInfo = weather.weather?.first {
            descriptionLabel.text = weatherInfo.description?.capitalized
            if let icon = weatherInfo.icon {
                let iconURL = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
                weatherIcon.sd_setImage(with: iconURL, completed: nil)
            }
        }
    }

    private func handleNetworkError(_ message: String) {
        activityIndicator.stopAnimating()
        clearWeatherData()
        errorLabel.isHidden = false
        errorLabel.text = message
    }
}

extension WeatherViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        searchTimer?.invalidate()
        
        if currentText.trimmingCharacters(in: .whitespaces).isEmpty {
            activityIndicator.stopAnimating()
            clearWeatherData()
            errorLabel.isHidden = true
            return true
        }
        
        activityIndicator.startAnimating()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [weak self] _ in
            guard let self = self else { return }
            
            if Reachability.isConnectedToNetwork() {
                self.fetchData(for: currentText)
            } else {
                self.handleNetworkError("Нет подключения к интернету")
            }
        })
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

