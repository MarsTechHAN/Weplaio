--===========================================================
--OLED Weather Display(Weplaio) 
--
--Main Program
--Author: Martin Han
--Date: 2015-6-15
--
--
--
--
--==========================================================

require("init_oled")

Init_oled(2,1,0x3c)
First_Screen()

--package.loaded["init_oled"]=nil

Init_oled = nil
First_Screen = nil

collectgarbage()

wifi.setmode(wifi.STATION)
wifi.sta.config("MARtinT3CH","hansh990518")
wifi.sta.connect()

dofile("refresh.lc")

tmr.alarm(0,1000,1,function() 

    if wifi.sta.getip() ~= nil then
    print("WiFi Connect OK")
        tmr.stop(0)
        tmr.alarm(0,20000,1,function() 
        print("Reload")
        Reload() 
        end)
        
        
        Reload()
        else
        print("Waiting For WiFi...")
    end

end)
