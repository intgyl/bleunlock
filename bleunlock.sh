#!/bin/bash

# ===== 配置 =====
PASSWORD="passwd"
UUID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
SCAN_CMD="./ble_scanner_tool $UUID"
MISS_COUNT_MAX=10
LOCK_RSSI=-70
UNLOCK_RSSI=-60

miss_count=0
lock_flag=0 # 0:用户或超时锁定，检测到ble信号后不执行解锁 1:ble 设备信号弱或无信号锁定,检测到ble信号后执行解锁

# ===== 判断锁屏状态 =====
is_locked() {
	if ioreg -n Root -d1 | grep -q '"IOConsoleLocked" = Yes'; then
		echo "locked"
	else
		echo "unlocked"
	fi
}

# ===== 锁屏 =====
lock_screen() {
	if [[ "$(is_locked)" == "unlocked" ]]; then
		# echo "[ACTION] 锁屏"
		open -a ScreenSaverEngine
	# else
	#         echo "[INFO] 已经是锁屏状态"
	fi
}

# ===== 解锁 ====
unlock_screen() {
	if [[ "$(is_locked)" == "locked" ]]; then
		pmset wakenow &> /dev/null
		# 延迟2s
		caffeinate -u -t 2 &> /dev/null
		cliclick kp:arrow-up kp:arrow-up

		cliclick t:"$PASSWORD"
		sleep 0.2
		cliclick kp:enter kp:enter
	# else
	#         echo "[INFO] 已经是解锁状态"
	fi
}

# ===== 主循环 =====
while true; do
	RSSI=$($SCAN_CMD)

	# echo "[SCAN] RSSI=$RSSI"

	if [[ "$RSSI" == "NONE" ]]; then
		((miss_count++))
		# echo "[INFO] 未检测到设备，miss_count=$miss_count"

		if ((miss_count >= $MISS_COUNT_MAX)); then
			lock_flag=1
			lock_screen
		fi

	else
		miss_count=0

		# 转换为整数
		RSSI_INT=$RSSI

		if ((RSSI_INT < $LOCK_RSSI)); then
			lock_flag=1
			lock_screen

		elif ((RSSI_INT > $UNLOCK_RSSI)); then
			if ((lock_flag == 1)); then
				lock_flag=0
				unlock_screen
			fi
		fi
	fi

	sleep 1
done
