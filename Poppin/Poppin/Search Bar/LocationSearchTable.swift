//
//  LocationSearchTable.swift - Table presented by the mainNavigationController search bar when typing an address.
//  Poppin
//
//  Created by Manuel Alejandro Martin Callejo on 11/5/19.
//  Copyright © 2019 PoppinREPO. All rights reserved.
//

import UIKit
import MapKit

class LocationSearchTable: UITableViewController {
    
    let searchCompleter = MKLocalSearchCompleter()
    
    var suggestions: [MKLocalSearchCompletion]?
    
    var maxRegion: MKCoordinateRegion?
    
    /*
        MapSearchDelegate: since the LocationSearchTable has to later alter the main View Controller in order to...
        ...add the popsicle pin to the map, we make it a delegate of the map search protocol. In main view controller...
        ...we define the protocol and its functions. Since the LocationSearchTable is now delegate of this protocol, it can...
        ...call this function whenever it needs.
     */
    
    var MapSearchDelegate: MapSearchProtocol? = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // *** LOCATION SEARCH TABLE ADJUSTMENTS ***
        
        self.tableView.separatorStyle = .none
        
        searchCompleter.delegate = self
        
        searchCompleter.region = maxRegion!
        
        //searchCompleter.resultTypes = .address ---> Maybe for the future.
        
    }
    
    // Set the shouldAutorotate to False
    
    override open var shouldAutorotate: Bool {
        
        return false
        
    }
       
    // Specify the orientation.
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
           return .portrait
        
    }
    
    /*
     (LAST FUNCTION CALLED) This function is called once the user has picked a location suggestion
     from the locationSearchTable:
        - The row the user taps at is called a "suggestion".
        - MKLocalSearch takes this suggestion and searches for an actual real address (since the suggestion
          is simply an autocompleted String).
        - If it finds a unique location, it calls the "dropPinZoomIn" function from the mainViewController in order
          to set the address for the popsicle. Else, it throws an error since it is not precise enough.
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let suggestion = suggestions?[indexPath.row]
        
        let request = MKLocalSearch.Request(completion: suggestion!)
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            
            if (error == nil) {
                
                if (response?.mapItems.count == 1) {
                    
                    if (self.coordinateIsInRegion(coordinate: (response?.mapItems.first?.placemark.coordinate)!, region: self.maxRegion!)) {
                        
                        self.MapSearchDelegate?.dropPinZoomIn(placemark: (response?.mapItems.first?.placemark)!)
                        
                    } else {
                        
                        print("\nOFF CAMPUS EVENT\n")
                        
                    }
                    
                    self.dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    print("\nERROR: Location selected was too unprecise to process (more than one location with the same name was found).\n")
                    
                    self.dismiss(animated: true, completion: nil)
                    
                }
                
            } else {
                
                print("\n:ERROR: MKLocalSearch encountered an error: \(error!.localizedDescription).\n")
                
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
        
    }
    
    /*
     (CALLED EVERY TIME TABLE SIZE CHANGES) This function keeps track of the amount of elements
     on the table.
     */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return suggestions?.count ?? 0
        
    }
    
    /*
     (CALLED CONSTANTLY FOR EVERY ROW IN THE TABLE) This function styles every cell from the table:
        - A row is dequeued as well as a suggestion.
        - The cell is filled with the information from the suggestion.
        - The styled and filled cell is returned to the table.
     */

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "LocationSearchTableCell", for: indexPath) as! LocationSearchTableCell)

        let itemSelected = suggestions?[indexPath.row]
        
        // *** CELL STYLING ***
        
        cell.selectionStyle = .none
        
        cell.titleLabel.numberOfLines = 0
        
        cell.titleLabel.sizeToFit()
        
        cell.titleLabel.text = itemSelected?.title
        
        cell.subtitleLabel.numberOfLines = 0
        
        cell.subtitleLabel.sizeToFit()
        
        cell.subtitleLabel.text = itemSelected?.subtitle
        
        return cell
        
    }
    
    /*
     coordinateIsInRegion: private helper method used by the didSelectRowAt delegate function to tell whether a certain coordinate is...
     ...inside the desired region or not.
     */
    
    private func coordinateIsInRegion (coordinate: CLLocationCoordinate2D, region: MKCoordinateRegion) -> Bool {
        
        // Converts coordinate to MkMapPoint.
        
        let coordinatePoint = MKMapPoint(coordinate)
        
        // Converts region to MKMapRect.
        
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))

        let a = MKMapPoint(topLeft)
        
        let b = MKMapPoint(bottomRight)

        let regionRect = MKMapRect(origin: MKMapPoint(x:min(a.x,b.x), y:min(a.y,b.y)), size: MKMapSize(width: abs(a.x-b.x), height: abs(a.y-b.y)))
        
        // Returns whether the coordinate is in the region specified.
        
        return regionRect.contains(coordinatePoint)
        
    }
    
}

extension LocationSearchTable: MKLocalSearchCompleterDelegate {
    
    /*
     This function handles the suggestions:
        - Suggestions are simply autocompleted Strings or Strings that match what the user has written
          on the search bar so far.
        - MKLocalSearchCompleter is the one gathering up results from what the user types.
        - Thus, this function is called every time the user stops typing. MKLocalSearchCompleter returns
          a list of new suggestions that overwrite the current list of suggestions.
        - Finally, the table is updated (which means "numberOfRowsInSection" and "cellForRowAt" get called).
     */
    
    public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {

        suggestions = completer.results
        
        self.tableView.reloadData()
        
    }
    
    /*
     This function simply handles any errors encountered by the MKLocalSearchCompleter.
     */
    
    public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        
        if let error = error as NSError? {
            
            print("\nERROR: MKLocalSearchCompleter encountered an error: \(error.localizedDescription).\n")
            
        }
        
    }
    
}


extension LocationSearchTable : UISearchResultsUpdating {
    
    /*
     This function simply feeds the MKLocalSearchCompleter with the text typed by the user on the search bar.
        - It gets called every time the search bar is updated.
     */

    public func updateSearchResults(for searchController: UISearchController) {
        
        searchCompleter.queryFragment = searchController.searchBar.text ?? ""
        
    }
    
}
