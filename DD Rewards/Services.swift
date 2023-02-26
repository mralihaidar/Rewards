
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
    
    func postRequestWithURL( UrlPath:String, params:[String:Any] = [:], completion:@escaping (_ response : Any, _ error : Error?) -> Void){
        let completeURL: URL? = URL(string: "\(UrlPath)")
        AF.request(completeURL?.absoluteString ?? "",
                    method: .post,
                    parameters:params,
                   encoding:JSONEncoding.default,
                    headers:nil).responseData(completionHandler: { response in

            switch response.result {
            case .success(_):
                do {
                    if let data = response.data{
                        print(data)
                        completion(data, nil)
                    }

                }
                break
            case .failure(let error):
                print("failed case \(error.localizedDescription)")
                completion( "", error)
            }
            })
        
        }
    
    
}
