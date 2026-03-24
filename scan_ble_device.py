import asyncio
from bleak import BleakScanner

async def run():
    print("正在搜索附近的 BLE 设备...")

    # 使用 return_adv=True 会返回一个字典
    # key 是地址，value 是 (BLEDevice, AdvertisementData) 的元组
    devices_dict = await BleakScanner.discover(return_adv=True)

    if not devices_dict:
        print("未发现任何设备。")
        return

    print(f"发现 {len(devices_dict)} 个设备:\n")
    print(f"{'名称 (Name)':<30} | {'UUID (Address)':<36} | {'信号 (RSSI)'}")
    print("-" * 85)

    # 遍历字典中的元组
    for address, (device, adv_data) in devices_dict.items():
        name = device.name if device.name else "Unknown"
        # 从 adv_data 中获取 rssi，如果拿不到则显示 "N/A"
        rssi = adv_data.rssi if adv_data.rssi is not None else "N/A"

        print(f"{name:<30} | {device.address:<36} | {rssi} dBm")

if __name__ == "__main__":
    try:
        asyncio.run(run())
    except KeyboardInterrupt:
        print("\n扫描已停止。")
