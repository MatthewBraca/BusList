//
//  ViewController.swift
//  GetOnTheBus
//
//  Created by Matthew Bracamonte on 4/5/16.
//  Copyright © 2016 Matthew Bracamonte. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var busTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var busStops = [BusRoute]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string:"https://s3.amazonaws.com/mmios8week/bus.json")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data, response, error) in
            do {
                let JSONdata = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                let busStops = JSONdata["row"] as! [Dictionary<String, AnyObject>]
                for busStop in busStops {
                    let busStop = BusRoute.init(propertyDict: busStop)
                    self.busStops.append(busStop)
                    self.addPinToMap(busStop.latitude!, longitude: busStop.longitude!, name: busStop.cta_stop_name!)
                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.busTableView.reloadData()
                self.defaultView()
            })
        }
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busStops.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = (tableView .dequeueReusableCellWithIdentifier("BusCell", forIndexPath: indexPath))
        let busStop = busStops[indexPath.row]
        let busRoute =  busStop.routes
        cell.textLabel?.text = busStop.cta_stop_name
        cell.textLabel?.textColor = UIColor.blueColor()
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "Available Routes:\n\(busRoute!)"
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        return cell
    }

    @IBAction func mapButtonPressed(sender: UIButton) {
        mapView.hidden = false
        busTableView.hidden = true
    }

    @IBAction func busListButtonPressed(sender: UIButton) {
        busTableView.hidden = false
        mapView.hidden = true
    }
    
    func addPinToMap(latitude:String, longitude:String, name: String) {
        let latitude = Double(latitude)
        let longitude = Double(longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        annotation.title = name
        mapView.addAnnotation(annotation)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        pin.canShowCallout = true
        pin.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        return pin
    }
    
    func defaultView() {
        let latitude = 41.8689148
        let longitude = -87.678654
        let span = MKCoordinateSpanMake(0.35, 0.35)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegueWithIdentifier("annotationSegue", sender: view)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "annotationSegue" {
            let vc = segue.destinationViewController as! BusStopDetailViewController
            vc.busStopName = (((sender as! MKAnnotationView).annotation?.title)!)!
        }
    }
    
    
}


