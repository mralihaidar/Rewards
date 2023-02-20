
import Foundation
import Alamofire

class service {
    fileprivate var baseURL = ""
    init(baseURL: String){
        self.baseURL = baseURL
    }
    func getAllData(endPoint:String, completion:@escaping(_ list:RewardsResponse?, _ error:Error?)->Void){
        let url = baseURL+endPoint
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
        (responseData) in
            guard let data = responseData.data else {return}
            do{
                let APIDataResponse = try JSONDecoder().decode(RewardsResponse.self, from:data)
                completion(APIDataResponse, nil)
                print("APIDataResponse == \(APIDataResponse)")
            } catch {
                completion(nil, error)
                print("Error decoding == \(error)")
            }
        }
    }
    func getAllGames(endPoint:String, completion:@escaping(_ response:gamesResponse?, _ error:Error?)->Void){
        let url = baseURL+endPoint
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response {
            (responseData) in
            guard let data = responseData.data else {return}
        do{
            let APIDataResponse = try JSONDecoder().decode(gamesResponse.self, from:data)
            completion(APIDataResponse, nil)
            print("APIDataResponse == \(APIDataResponse)")
        } catch {
            completion(nil, error)
            print("Error decoding == \(error)")
            }
        }
    }
}
