swiftc ble_scanner.swift  -o ble_scanner_tool   -Xlinker -sectcreate -Xlinker __TEXT -Xlinker __info_plist -Xlinker ble_scanner.plist

#swiftc ble_scanner.swift -o ble_scanner_tool
