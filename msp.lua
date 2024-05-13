local msp_proto = Proto("msp", "MSP Protocol")

local fields = {
    header = ProtoField.char("msp.header", "Header"),
    version = ProtoField.char("msp.version", "Protocol version"),
    direction = ProtoField.char("msp.direction", "Direction"),
    length = ProtoField.uint8("msp.length", "Length", base.DEC),
    cmd = ProtoField.uint8("msp.cmd", "Command", base.HEX),
    payload = ProtoField.bytes("msp.payload", "Payload"),
    crc = ProtoField.uint8("msp.crc", "CRC", base.HEX)
}

msp_proto.fields = fields

msp_commands = {
    [1] = "MSP_API_VERSION",
    [2] = "MSP_FC_VARIANT",
    [3] = "MSP_FC_VERSION",
    [4] = "MSP_BOARD_INFO",
    [5] = "MSP_BUILD_INFO",
    [10] = "MSP_NAME",
    [11] = "MSP_SET_NAME",
    [32] = "MSP_BATTERY_CONFIG",
    [33] = "MSP_SET_BATTERY_CONFIG",
    [34] = "MSP_MODE_RANGES",
    [35] = "MSP_SET_MODE_RANGE",
    [36] = "MSP_FEATURE_CONFIG",
    [37] = "MSP_SET_FEATURE_CONFIG",
    [38] = "MSP_BOARD_ALIGNMENT_CONFIG",
    [39] = "MSP_SET_BOARD_ALIGNMENT_CONFIG",
    [40] = "MSP_CURRENT_METER_CONFIG",
    [41] = "MSP_SET_CURRENT_METER_CONFIG",
    [42] = "MSP_MIXER_CONFIG",
    [43] = "MSP_SET_MIXER_CONFIG",
    [44] = "MSP_RX_CONFIG",
    [45] = "MSP_SET_RX_CONFIG",
    [46] = "MSP_LED_COLORS",
    [47] = "MSP_SET_LED_COLORS",
    [48] = "MSP_LED_STRIP_CONFIG",
    [49] = "MSP_SET_LED_STRIP_CONFIG",
    [50] = "MSP_RSSI_CONFIG",
    [51] = "MSP_SET_RSSI_CONFIG",
    [52] = "MSP_ADJUSTMENT_RANGES",
    [53] = "MSP_SET_ADJUSTMENT_RANGE",
    [54] = "MSP_CF_SERIAL_CONFIG",
    [55] = "MSP_SET_CF_SERIAL_CONFIG",
    [56] = "MSP_VOLTAGE_METER_CONFIG",
    [57] = "MSP_SET_VOLTAGE_METER_CONFIG",
    [58] = "MSP_SONAR_ALTITUDE",
    [59] = "MSP_PID_CONTROLLER",
    [60] = "MSP_SET_PID_CONTROLLER",
    [61] = "MSP_ARMING_CONFIG",
    [62] = "MSP_SET_ARMING_CONFIG",
    [64] = "MSP_RX_MAP",
    [65] = "MSP_SET_RX_MAP",
    [68] = "MSP_REBOOT",
    [70] = "MSP_DATAFLASH_SUMMARY",
    [71] = "MSP_DATAFLASH_READ",
    [72] = "MSP_DATAFLASH_ERASE",
    [75] = "MSP_FAILSAFE_CONFIG",
    [76] = "MSP_SET_FAILSAFE_CONFIG",
    [77] = "MSP_RXFAIL_CONFIG",
    [78] = "MSP_SET_RXFAIL_CONFIG",
    [79] = "MSP_SDCARD_SUMMARY",
    [80] = "MSP_BLACKBOX_CONFIG",
    [81] = "MSP_SET_BLACKBOX_CONFIG",
    [82] = "MSP_TRANSPONDER_CONFIG",
    [83] = "MSP_SET_TRANSPONDER_CONFIG",
    [84] = "MSP_OSD_CONFIG",
    [85] = "MSP_SET_OSD_CONFIG",
    [86] = "MSP_OSD_CHAR_READ",
    [87] = "MSP_OSD_CHAR_WRITE",
    [88] = "MSP_VTX_CONFIG",
    [89] = "MSP_SET_VTX_CONFIG",
    [90] = "MSP_ADVANCED_CONFIG",
    [91] = "MSP_SET_ADVANCED_CONFIG",
    [92] = "MSP_FILTER_CONFIG",
    [93] = "MSP_SET_FILTER_CONFIG",
    [94] = "MSP_PID_ADVANCED",
    [95] = "MSP_SET_PID_ADVANCED",
    [96] = "MSP_SENSOR_CONFIG",
    [97] = "MSP_SET_SENSOR_CONFIG",
    [98] = "MSP_CAMERA_CONTROL",
    [99] = "MSP_SET_ARMING_DISABLED",

    [101] = "MSP_STATUS",
    [102] = {"MSP_RAW_IMU", function(buf) return string.format("AccX: %d, AccY: %d, AccZ: %d, GyroX: %d, GyroY: %d, GyroZ: %d, MagX: %d, MagY: %d, MagZ: %d", buf(0, 2):le_int(), buf(2, 2):le_int(), buf(4, 2):le_int(), buf(6, 2):le_int(), buf(8, 2):le_int(), buf(10, 2):le_int(), buf(12, 2):le_int(), buf(14, 2):le_int(), buf(16, 2):le_int()) end },
    [103] = "MSP_SERVO",
    [104] = "MSP_MOTOR",
    [105] = "MSP_RC",
    [106] = "MSP_RAW_GPS",
    [107] = "MSP_COMP_GPS",
    [108] = {"MSP_ATTITUDE", function(buf) return string.format("Roll: %.1f, Pitch: %.1f, Yaw: %.1f", buf(0, 2):le_int(), buf(2, 2):le_int(), buf(4, 2):le_int()) end },
    [109] = "MSP_ALTITUDE",
    [110] = "MSP_ANALOG",
    [111] = "MSP_RC_TUNING",
    [112] = "MSP_PID",

    [116] = "MSP_BOXNAMES",
    [117] = "MSP_PIDNAMES",
    [118] = "MSP_WP",
    [119] = "MSP_BOXIDS",
    [120] = "MSP_SERVO_CONFIGURATIONS",
    [121] = "MSP_NAV_STATUS",
    [122] = "MSP_NAV_CONFIG",
    [124] = "MSP_MOTOR_3D_CONFIG",
    [125] = "MSP_RC_DEADBAND",
    [126] = "MSP_SENSOR_ALIGNMENT",
    [127] = "MSP_LED_STRIP_MODECOLOR",
    [128] = "MSP_VOLTAGE_METERS",
    [129] = "MSP_CURRENT_METERS",
    [130] = "MSP_BATTERY_STATE",
    [131] = "MSP_MOTOR_CONFIG",
    [132] = "MSP_GPS_CONFIG",
    [134] = "MSP_ESC_SENSOR_DATA",
    [135] = "MSP_GPS_RESCUE",
    [136] = "MSP_GPS_RESCUE_PIDS",
    [137] = "MSP_VTXTABLE_BAND",
    [138] = "MSP_VTXTABLE_POWERLEVEL",
    [139] = "MSP_MOTOR_TELEMETRY",
    
    [140] = "MSP_SIMPLIFIED_TUNING",
    [141] = "MSP_SET_SIMPLIFIED_TUNING",
    [142] = "MSP_CALCULATE_SIMPLIFIED_PID",
    [143] = "MSP_CALCULATE_SIMPLIFIED_GYRO",
    [144] = "MSP_CALCULATE_SIMPLIFIED_DTERM",
    [145] = "MSP_VALIDATE_SIMPLIFIED_TUNING",

    [150] = "MSP_STATUS_EX",
    [160] = "MSP_UID",
    [164] = "MSP_GPSSVINFO",
    [166] = "MSP_GPSSTATISTICS",
        
    [170] = "MSP_ENABLE_RAW_AMGLES",
    [171] = "MSP_GET_RAW_ANGLES",
    [172] = "MSP_SET_RAW_AMGLES",
    [180] = "MSP_OSD_VIDEO_CONFIG",
    [181] = "MSP_SET_OSD_VIDEO_CONFIG",
    [182] = "MSP_DISPLAYPORT",
    [183] = "MSP_COPY_PROFILE",
    [184] = "MSP_BEEPER_CONFIG",
    [185] = "MSP_SET_BEEPER_CONFIG",
    [186] = "MSP_SET_TX_INFO",
    [187] = "MSP_TX_INFO",
    [200] = "MSP_SET_RAW_RC",
    [201] = "MSP_SET_RAW_GPS",
    [202] = "MSP_SET_PID",
    [204] = "MSP_SET_RC_TUNING",
    [205] = "MSP_ACC_CALIBRATION",
    [206] = "MSP_MAG_CALIBRATION",
    [208] = "MSP_RESET_CONF",
    [209] = "MSP_SET_WP",
    [210] = "MSP_SELECT_SETTING",
    [211] = "MSP_SET_HEADING",
    [212] = "MSP_SET_SERVO_CONFIGURATION",
    [214] = "MSP_SET_MOTOR",
    [215] = "MSP_SET_NAV_CONFIG",
    [217] = "MSP_SET_MOTOR_3D_CONFIG",
    [218] = "MSP_SET_RC_DEADBAND",
    [220] = "MSP_SET_SENSOR_ALIGNMENT",
    [221] = "MSP_SET_LED_STRIP_MODECOLOR",
    [222] = "MSP_SET_MOTOR_CONFIG",
    [223] = "MSP_SET_GPS_CONFIG",
    [225] = "MSP_SET_GPS_RESCUE",
    [226] = "MSP_SET_GPS_RESCUE_PIDS",
    [227] = "MSP_SET_VTXTABLE_BAND",
    [228] = "MSP_SET_VTXTABLE_POWERLEVEL",
    [250] = "MSP_EEPROM_WRITE",
    [251] = "MSP_RESERVE_1",
    [252] = "MSP_RESERVE_2",
    [253] = "MSP_DEBUGMSG",
    [254] = "MSP_DEBUG",
    [255] = "MSP_V2_FRAME",
    [150] = "MSP_STATUS_EX",
    [160] = "MSP_UID",
    [164] = "MSP_GPSSVINFO",
    [166] = "MSP_GPSSTATISTICS",
    [230] = "MSP_MULTIPLE_MSP",
    [238] = "MSP_MODE_RANGES_EXTRA",
    [240] = "MSP_ACC_TRIM",
    [239] = "MSP_SET_ACC_TRIM",
    [241] = "MSP_SERVO_MIX_RULES",
    [242] = "MSP_SET_SERVO_MIX_RULE",
    [245] = "MSP_SET_PASSTHROUGH",
    [246] = "MSP_SET_RTC",
    [247] = "MSP_RTC",
    [248] = "MSP_SET_BOARD_INFO",
    [249] = "MSP_SET_SIGNATURE"
}


function msp_proto.dissector(buffer, pinfo, tree)
    pinfo.cols.protocol:set("MSP")
    local subtree = tree:add(msp_proto, buffer(), "MSP Protocol Data")

    subtree:add(fields.header, buffer(0, 1))
    subtree:add(fields.version, buffer(1, 1)):append_text(" (" .. "Version 2" .. ")")
    subtree:add(fields.direction, buffer(2, 1)):append_text(" (" .. (buffer(2, 1):uint() == 60 and "To FC" or "From FC") .. ")")

    local payload_length = buffer(3, 1):uint()
    local command = buffer(4, 1):uint()
    local payload_buffer = buffer(5, payload_length)
    local crc_offset = 3 + payload_length
    local crc_value = buffer(crc_offset, 1):uint()

    subtree:add(fields.length, payload_length)
    local cmd_field = subtree:add(fields.cmd, command)
    if msp_commands[command] then
        if type(msp_commands[command]) == "string" then
            cmd_field:append_text(" (" .. msp_commands[command] .. ")")
        else
            cmd_field:append_text(" (" .. msp_commands[command][1] .. ")")
        end
    else 
        cmd_field:append_text(" (Unknown command -" .. command ..")")
    end
    if payload_length > 0 then
        local field_payload = subtree:add(fields.payload, payload_buffer)
        if msp_commands[command] and type(msp_commands[command]) == "table" then
            field_payload:append_text(" (" .. msp_commands[command][2](payload_buffer) .. ")")
        end
    end
    subtree:add(fields.crc, crc_value)

--     -- Verify the CRC
--     if verify_crc(payload_buffer:bytes(), crc_value) then
--         subtree:add(fields.crc, crc_value)
--     else
--         -- CRC check failed
--         subtree:add_expert_info(PI_MALFORMED, PI_ERROR, "CRC verification failed")
--     end
end

-- Register the protocol
local tcp_port = DissectorTable.get("tcp.port")
tcp_port:add(5761, msp_proto)
tcp_port:add(5762, msp_proto)
