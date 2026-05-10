-- Explicitly enable A2DP codecs (LDAC, aptX*, SBC-XQ, LC3) so PipeWire
-- offers them during BlueZ capability negotiation. AAC is omitted because
-- Ubuntu's PipeWire is built without FDK-AAC support (no spa-codec-bluez5-aac).

bluez_monitor.properties["bluez5.codecs"] =
  "[ ldac aptx aptx_hd aptx_ll aptx_ll_duplex sbc sbc_xq lc3 opus_05 opus_05_pro opus_05_71 ]"
bluez_monitor.properties["bluez5.enable-sbc-xq"] = true
bluez_monitor.properties["bluez5.enable-msbc"] = true
bluez_monitor.properties["bluez5.enable-hw-volume"] = true

table.insert(bluez_monitor.rules, {
  matches = {
    { { "device.name", "matches", "bluez_card.*" } },
  },
  apply_properties = {
    -- LDAC quality: auto = adaptive bitrate (default), hq = pinned 990 kbps,
    -- sq = 660 kbps, mq = 330 kbps. "auto" is best for stability over distance.
    ["bluez5.a2dp.ldac.quality"] = "auto",
  },
})
