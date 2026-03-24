import Foundation
import CoreBluetooth

let args = CommandLine.arguments
if args.count < 2 {
    print("ERROR: 请提供目标设备的 UUID 作为参数。")
    print("用法: ./ble_scanner_tool <UUID>")
    exit(1)
}

let targetDeviceID = args[1].uppercased()
let outputInterval: TimeInterval = 5.0

class BLEScanner: NSObject, CBCentralManagerDelegate {
    var centralManager: CBCentralManager!
    var lastSeen: Date?
    var latestRSSI: Int?
    var outputTimer: Timer?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: [CBCentralManagerOptionShowPowerAlertKey: true])
    }

    func emit() {
        if let lastSeen, let latestRSSI, Date().timeIntervalSince(lastSeen) <= outputInterval {
            print("\(latestRSSI)")
        } else {
            print("NONE")
        }
        fflush(stdout)
    }

    func emitAndExit() {
        outputTimer?.invalidate()
        outputTimer = nil
        emit()
        centralManager.stopScan()
        fflush(stdout)
        exit(0)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            /* print("INFO: 蓝牙已就绪，开始扫描目标设备 ID: \(targetDeviceID)...") */
            fflush(stdout)
            centralManager.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: true])

            outputTimer?.invalidate()
            outputTimer = Timer.scheduledTimer(withTimeInterval: outputInterval, repeats: false) { [weak self] _ in
                self?.emitAndExit()
            }
        } else {
            print("ERROR: 蓝牙未开启或无权限。状态码: \(central.state.rawValue)")
            fflush(stdout)
            exit(1)
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.identifier.uuidString.uppercased() == targetDeviceID {
            lastSeen = Date()
            latestRSSI = RSSI.intValue
            emitAndExit()
        }
    }
}

let scanner = BLEScanner()
RunLoop.main.run()
