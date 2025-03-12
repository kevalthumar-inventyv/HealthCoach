//
//  BluetoothManager .swift
//  HealthCoach
//
//  Created by Keval Thumar on 06/03/25.
//
import CoreBluetooth

class BluetoothManager: NSObject, CBCentralManagerDelegate {
    static let shared = BluetoothManager()
    
    private var centralManager: CBCentralManager?
    private var isBluetoothOn: Bool = false

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
        // ✅ Simulate Bluetooth ON in the simulator
        #if targetEnvironment(simulator)
        isBluetoothOn = true
        #endif
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        // ✅ Skip real Bluetooth check in simulator
        #if !targetEnvironment(simulator)
        isBluetoothOn = (central.state == .poweredOn)
        #endif
    }

    func checkBluetoothStatus(completion: @escaping (Bool) -> Void) {
        completion(isBluetoothOn)
    }
}
