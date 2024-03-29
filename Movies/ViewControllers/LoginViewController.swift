//
//  LoginViewController.swift
//  Movies
//
//  Created by Allan Melo on 13/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import RxSwift
import NSObject_Rx
import WebKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var wkwebView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        wkwebView?.navigationDelegate = self

        let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

        loadingIndicator?.startAnimating()

        CreateRequestTokenInteractor()
            .execute()
            .subscribeOn(backgroundThread)
            .observeOn(MainScheduler.instance)
            .subscribe(
            onNext: { [weak self] result in
                guard let url = URL(string: "https://www.themoviedb.org/authenticate/\(result.requestToken)")
                    else { return }
                
                print(result.requestToken)
                self?.wkwebView?.load(URLRequest(url: url))
                self?.wkwebView?.isHidden = false
            },
            onError: { error in
                print(error)
            },
            onCompleted: { [weak self] in
                self?.loadingIndicator?.stopAnimating()
            })
            .disposed(by: rx.disposeBag)
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension LoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        guard let currentUrl = webView.url,
        let requestToken = Settings.requestToken?.requestToken else {
            return
        }

        let authenticateRequest = "https://www.themoviedb.org/authenticate/\(requestToken)"

        if currentUrl.absoluteString == authenticateRequest.appending("/allow") {
            let backgroundThread = ConcurrentDispatchQueueScheduler(qos: .background)

            loadingIndicator?.startAnimating()

            CreateSessionInteractor()
                .execute()
                .flatMap { _ in GetAccountInteractor().execute() }
                .subscribeOn(backgroundThread)
                .observeOn(MainScheduler.instance)
                .subscribe(
                onNext: { [weak self] result in
                    self?.dismiss(animated: true)
                },
                onError: { error in
                    print(error)
                },
                onCompleted: { [weak self] in
                    self?.loadingIndicator?.stopAnimating()
                })
                .disposed(by: rx.disposeBag)
        }
        else if currentUrl.absoluteString == authenticateRequest.appending("/deny") {
            dismiss(animated: true)
        }
    }
}
