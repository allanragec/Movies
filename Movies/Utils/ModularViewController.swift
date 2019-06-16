//
//  ModularViewController.swift
//  Movies
//
//  Created by Allan Melo on 15/06/19.
//  Copyright © 2019 Allan Melo. All rights reserved.
//

import UIKit

class ModularViewController<T : ModularViewModel> : UIViewController, UITableViewDataSource, UITableViewDelegate {

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ModularViewController.refresh), for: .valueChanged)

        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let tableView = getTableView() else { return }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)

        if getViewModel().isCollapsibleHeaderView() {
            setupHeaderView(tableView: tableView)
        }

        getViewModel().viewDidLoad()
    }

    @objc func refresh() {
        getViewModel().refresh()
    }

    func getViewModel() -> T {
        fatalError("you need to implement your viewModel")
    }

    func getTableView() -> UITableView? {
        fatalError("you need to implement your tableView")
    }

    //MARK: UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return getViewModel().isCollapsibleHeaderView() ? 2 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getViewModel().isCollapsibleHeaderView() && section == 0 {
            return 1
        }

        return getViewModel().getItems().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if getViewModel().isCollapsibleHeaderView() && indexPath.section == 0 {
            return UITableViewCell()
        }

        return getViewModel().createCell(for: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let collapsibleHeaderView = getViewModel().getAsCollapsibleHeaderView(),
            indexPath.section == 0 else {

            return UITableView.automaticDimension
        }

        return collapsibleHeaderView.getScrollableHeaderSize()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getViewModel().isCollapsibleHeaderView() ? UIView() : nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let collapsibleHeaderView = getViewModel().getAsCollapsibleHeaderView() else {
            return 0
        }

        return section == 0 ? 0 : collapsibleHeaderView.getPinnedHeaderSize()
    }

    //MARK: UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getViewModel().open(for: indexPath)
    }

    //MARK: Collapsible HeaderView

    private func setupHeaderView(tableView: UITableView) {
        getViewModel()
            .getAsCollapsibleHeaderView()?
            .getHeaderView()?
            .isUserInteractionEnabled = false

        updateHeader(tableView)
    }

    private func updateHeader(_ scrollView: UIScrollView) {
        guard let collapsibleHeaderView = getViewModel().getAsCollapsibleHeaderView() else {
            return
        }

        let y = scrollView.contentOffset.y

        let minimumHeaderView: CGFloat = collapsibleHeaderView.getPinnedHeaderSize()
        let maximumHeaderView: CGFloat = collapsibleHeaderView.getMaximumHeaderSize()

        collapsibleHeaderView.getHeaderHeightConstraint()?.constant =
            max(minimumHeaderView, maximumHeaderView - y)
    }

    private func setPosition(_ scrollView: UIScrollView) {
        guard let collapsibleHeaderView = getViewModel().getAsCollapsibleHeaderView() else { return }

        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }

            if scrollView.contentOffset.y > 0 && scrollView.contentOffset.y < collapsibleHeaderView.getHalfHeaderSize() {

                scrollView.contentOffset = .zero
                strongSelf.updateHeader(scrollView)
                strongSelf.view.layoutIfNeeded()
            }
            else if scrollView.contentOffset.y >= collapsibleHeaderView.getHalfHeaderSize()
                && scrollView.contentOffset.y <= collapsibleHeaderView.getMaximumHeaderSize() {

                scrollView.contentOffset.y = collapsibleHeaderView.getScrollableHeaderSize()
                strongSelf.updateHeader(scrollView)
                strongSelf.view.layoutIfNeeded()
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeader(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setPosition(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            setPosition(scrollView)
        }
    }
}

