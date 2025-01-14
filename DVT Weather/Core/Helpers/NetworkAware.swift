//
//  NetworkAware.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 14/01/2025.
//
import Foundation
import Network
import Combine

open class NetworkAware: NSObject{
    
    @Published var networkAvailable = false
    private var cancellable = Set<AnyCancellable>()
    
    override init(){
        super.init()
        startNetworkObservation()
    }
    
    private func startNetworkObservation(){
        NWPathMonitor()
            .publisher()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] status in
                self?.networkAvailable = status == .satisfied
            }
            .store(in: &cancellable)
    }
    
}


extension NWPathMonitor {
    class NetworkStatusSubscription<S: Subscriber>: Subscription where S.Input == NWPath.Status {
            
          private let subscriber: S?
          
          private let monitor: NWPathMonitor
          private let queue: DispatchQueue
            
          init(subscriber: S,
               monitor: NWPathMonitor,
               queue: DispatchQueue) {

              self.subscriber = subscriber
              self.monitor = monitor
              self.queue = queue
          }
      
      func request(_ demand: Subscribers.Demand) {
          monitor.pathUpdateHandler = { [weak self] path in
              guard let self = self else { return }
              _ = self.subscriber?.receive(path.status)
          }

          monitor.start(queue: queue)
      }
      
      func cancel() {
          monitor.cancel()
      }
        
    }
}

extension NWPathMonitor {

    struct NetworkStatusPublisher: Publisher {
        
        typealias Output = NWPath.Status
        typealias Failure = Never
        
        private let monitor: NWPathMonitor
        private let queue: DispatchQueue = DispatchQueue(label: "Monitor")
        
        init(monitor: NWPathMonitor) {
            self.monitor = monitor
        }
        
        func receive<S>(subscriber: S) where S : Subscriber,
                        Never == S.Failure, NWPath.Status == S.Input {
                    
            // 1
            let subscription = NetworkStatusSubscription(
                subscriber: subscriber,
                monitor: monitor,
                queue: queue
            )
            
            // 2
            subscriber.receive(subscription: subscription)
        }
    }
    
    func publisher() -> NWPathMonitor.NetworkStatusPublisher {
        
        return NetworkStatusPublisher(monitor: self)
    }
}
