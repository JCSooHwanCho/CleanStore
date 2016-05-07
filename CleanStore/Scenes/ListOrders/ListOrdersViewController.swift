//
//  ListOrdersViewController.swift
//  CleanStore
//
//  Created by Raymond Law on 10/31/15.
//  Copyright (c) 2015 Raymond Law. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so you can apply
//  clean architecture to your iOS and Mac projects, see http://clean-swift.com
//

import UIKit

protocol ListOrdersViewControllerInput
{
  func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
}

protocol ListOrdersViewControllerOutput
{
  func fetchOrders(request: ListOrders.FetchOrders.Request)
  var orders: [Order]? { get }
}

class ListOrdersViewController: UITableViewController, ListOrdersViewControllerInput
{
  var output: ListOrdersViewControllerOutput!
  var router: ListOrdersRouter!
  var displayedOrders: [ListOrders.FetchOrders.ViewModel.DisplayedOrder] = []
  
  // MARK: Object lifecycle
  
  override func awakeFromNib()
  {
    super.awakeFromNib()
    ListOrdersConfigurator.sharedInstance.configure(self)
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    fetchOrdersOnLoad()
  }
  
  // MARK: Event handling
  
  func fetchOrdersOnLoad()
  {
    let request = ListOrders.FetchOrders.Request()
    output.fetchOrders(request)
  }
  
  // MARK: Display logic
  
  func displayFetchedOrders(viewModel: ListOrders.FetchOrders.ViewModel)
  {
    displayedOrders = viewModel.displayedOrders
    tableView.reloadData()
  }
  
  // MARK: Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int
  {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    return displayedOrders.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let displayedOrder = displayedOrders[indexPath.row]
    var cell = tableView.dequeueReusableCellWithIdentifier("OrderTableViewCell")
    if cell == nil {
      cell = UITableViewCell(style: .Value1, reuseIdentifier: "OrderTableViewCell")
    }
    cell?.textLabel?.text = displayedOrder.date
    cell?.detailTextLabel?.text = displayedOrder.total
    return cell!
  }
}
