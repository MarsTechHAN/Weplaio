 --===========================================================
--OLED Weather Display(Weplaio) 
--
--Refresh OLED
--Author: Martin Han
--Date: 2015-6-15
--
--
--==========================================================

local data

local du_C = string.char(0x00,0x4C,0x52,0x20,0x20,0x20,0x1C,0x00)

local function Refresh()

   disp:setFontRefHeightExtendedText()
   disp:setDefaultForegroundColor()
   disp:setFontPosTop()

    disp:firstPage()
    
    local _temp = dofile(data["Weather"]..".lc")

    collectgarbage()

    print(node.heap())

    local drawStr = disp.drawStr
    
    repeat
        disp:setFont(u8g.font_chikita)
        disp:drawStr(10,60, data["Time"])    
        disp:setFont(u8g.font_6x10)
        disp:drawStr(64,10, "Temperature:") 
        disp:drawStr(64,20, tostring(data["LTemp"]).."  ~ "..tostring(data["HTemp"])) 
        disp:drawBitmap( 78, 12, 1, 8, du_C )
        disp:drawBitmap( 112, 12, 1, 8, du_C )
        disp:drawStr(64,33, "Humi: "..tostring(data["Humi"]).."%")
        disp:drawStr(64,46, "PM2.5: "..tostring(data["PM25"])) 

        disp:drawBitmap( 0, 0, 8, 64, _temp )


    until disp:nextPage() == false
    
    sent_flag = true

 end
        conn = net.createConnection(net.TCP, false)

        sent_flag = true

        conn:on("receive",function(conn,pl)
        print("Data received")
        local i,j,k

       -- conn:close()

        i = pl:find("{")
        k,j = pl:find("}")

        k = nil

        if i== nil or j==nil then
                return -1
        end

        data = cjson.decode(pl:sub(i,j))

        print("Json decode done!")

        Refresh()

        end)



        conn:on("disconnection",function()
        print("Connection Broken")
        print("Restart System...") 
        node.restart()
        end)

        conn:on("sent",function() 
        sent_flag = false
        end)

        conn:on("connection",function()
        print("Connection Get!")
    
        conn:send("GET http://680.sshsweixin.sinaapp.com/index.php HTTP/1.1\r\n"..
         "Host: api.map.baidu.com\r\n"..
         "Connection: keep-alive\r\n\r\n")

        end)

function Reload()

    if sent_flag then
        if fis == nil then
        conn:connect(80,"680.sshsweixin.sinaapp.com")  
        fis = true 
        else
        conn:send("GET http://680.sshsweixin.sinaapp.com/index.php HTTP/1.1\r\n"..
         "Host: api.map.baidu.com\r\n"..
         "Connection: keep-alive\r\n\r\n")
         end  
    else
        print("Too Frequent Request...Waiting for receive.") 
    end

end
