//
//  EventsAPI.swift
//  Pictogram
//
//  Created by mac on 4/17/17.
//  Copyright © 2017 obrien. All rights reserved.
//

import Alamofire


class EventsAPI {
    
   static let shared = EventsAPI()

    private let skiddleApiKey = "ebe90cba2f024c168e814bce7950a423"
    
    func fetchEvents() {
        let ApiEndpoint  = "https://www.skiddle.com/api/v1/events/search/?api_key=\(skiddleApiKey)&latitude=53.4839&longitude=-2.2446&radius=5&eventcode=LIVE&order=distance&description=1"
        if let url = URL(string: ApiEndpoint) {
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Event API returned error", error)
                }
                
                print("Succesfully fetched events from Skiddle")
                
                
                if let data = data {
                    do {
                         let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                        guard let resultset = dictionary?["results"] as? NSArray else {return}
                        guard let event = resultset[0] as? Dictionary<String,Any> else {return}
                        
                        print(event)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                }.resume()
        }
        
    }
    
    func fetchAllEvents(completion: @escaping (_ events: [String:Array<Event>]) -> ()) {
        let apiEndpoint  = "https://www.skiddle.com/api/v1/events/search/?api_key=\(skiddleApiKey)&latitude=53.8008&longitude=-1.5491&radius=15&order=distance&description=1&limit=100"
        
        var eventsDictionary = [String:Array<Event>]()
        
        Alamofire.request(apiEndpoint).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let response = response.result.value as? Dictionary<String,Any> else {return}
//                print(response["results"])
                
                guard let resultset = response["results"] as? Array<Any> else {return}
                
                print(resultset.count)
                for result in resultset {
                    if let eventDictionary = result as? Dictionary<String,Any> {
                        let event = Event(dictionary: eventDictionary)
                        
                        if eventsDictionary[event.code] != nil {
                            eventsDictionary[event.code]?.append(event)
                        }else {
                            var eventCategory = [Event]()
                            eventCategory.append(event)
                            print("added \(event.code)")
                            eventsDictionary[event.code] = eventCategory
                        }
                    }
                }
                
                completion(eventsDictionary)
                print("\(eventsDictionary.count)")
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
