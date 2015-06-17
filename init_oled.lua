--===========================================================
--OLED Weather Display(Weplaio) 
--
--Init Program
--Author: Martin Han
--Date: 2015-6-15
--
--
--
--
--==========================================================

function Init_oled(sda,scl,sla)

   i2c.setup(0, sda, scl, i2c.SLOW)
   disp = u8g.ssd1306_128x64_i2c(sla)

   disp:setFont(u8g.font_6x10)
   disp:setFontRefHeightExtendedText()
   disp:setDefaultForegroundColor()
   disp:setFontPosTop()

end

function  First_Screen()

   disp:firstPage()
local heap = tostring(node.heap())
 repeat
   disp:drawStr(0,0, "WiFi Mode...[STATION]")     
   disp:drawStr(0,12,"RAM Buffer....["..heap.."]")  
   disp:drawStr(0,24,"Initializing.....[OK]")
   disp:drawStr(0,36,"OLED Initing.....[OK]")
   disp:drawStr(0,48,"Loading Lib......[OK]")
 until disp:nextPage() == false
 
end
