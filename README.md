<div align="center">
  
# bleunlock
根据ble设备信号强弱自动锁定/解锁MacOS
</div>

# 使用说明
## 安装cliclick
```
brew install cliclick

```
## 扫描ble设备
```
python3 scan_ble_device.py
正在搜索附近的 BLE 设备...
发现 35 个设备:

名称 (Name)                      | UUID (Address)                       | 信号 (RSSI)
-------------------------------------------------------------------------------------
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -67 dBm
Redmi Buds 4 Pro               | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -61 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -65 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -54 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -57 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -56 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -63 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -56 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -66 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -66 dBm
NGOLKVbest982i1BOsWIGRJho      | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -60 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -61 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -63 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -60 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -68 dBm
ESP32                          | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -63 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -71 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -66 dBm
2606 LaserJet Tank             | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -65 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -72 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -66 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -69 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -68 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -65 dBm
Unknown                        | xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | -69 dBm

```

找到要用的设备UUID
## 修改参数
```
bleunlock.sh

PASSWORD="passwd"  # 替换为你的MacOS密码
UUID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"  # 替换为你的设备UUID

以下参数可根据实际情况调整
MISS_COUNT_MAX=10 # 信号丢失次数上限
LOCK_RSSI=-70 # 锁定时的信号强度
UNLOCK_RSSI=-60 # 解锁时的信号强度

```
## 设置权限
【设置】- 【隐私与安全性】- 【辅助功能】添加所用的终端

## 运行
```
chmod +x bleunlock.sh
./bleunlock.sh
```
## 注意事项
如果ble_scanner_tool无法执行可重新编译，执行./build.sh
