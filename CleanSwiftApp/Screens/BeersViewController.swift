//
//  ViewController.swift
//  CleanSwiftApp
//
//  Created by Yuriy Pashkov on 10/1/21.
//

import UIKit

protocol BeersDisplayLogic: AnyObject { //  AnyObject нужен для слабых ссылок
    func showBeers(data: [BeerModel])
    func showError()
}

class BeersViewController: UIViewController {

    // IB Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    let activityIndicatorView = UIActivityIndicatorView()
    private var beers: [BeerModel] = []
    
    private var interactor: BeersInteractorLogic?
    var router: BeersRoutingLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        
        // запускаем VIP-цикл (VC - Interactor - Presenter)
        // интерактор - грузи информацию
        interactor?.getBeers()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // конфигурируем модуль
    private func setup() {
        
        let viewController = self
        let presenter = BeersPresenter()
        let interactor = BeersInteractor()
        let router = BeersRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
    }
    
    // конфигурируем UI
    private func setUI() {
        tableView.tableFooterView = UIView(frame: .zero)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .red
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

}

extension BeersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell") as? BeerCell {
            cell.setCell(beer: beers[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    // роутер открывает контроллер с подробной информацией по тапу на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        router?.navigateToBeer(beer: beers[indexPath.row])
    }
    
    
}

extension BeersViewController: BeersDisplayLogic {
    
    func showError() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.errorLabel.alpha = 1
            self.errorLabel.text = "Проблема с получением данных. Повторите попытку позже."
        }
    }
    
    
    func showBeers(data: [BeerModel]) {
        beers.removeAll()
        beers.append(contentsOf: data)
        
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.tableView.reloadData()
        }
        
    }
    
}

