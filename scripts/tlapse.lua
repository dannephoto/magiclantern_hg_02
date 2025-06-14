-- movie tlapse & rec_delay

--[[
Dedicated movie preset intervalometer
--]]

  config = {}
  local config = require("config")
  console.hide()
  menu.close()

if camera.model_short ~= "EOSM" then
   display.notify_box("Only eosm for now")
   do return end
end

  displaybox = 0
  interval = 0
  delay_value1 = 0
  stop_value1 = 0
  delay_value2 = 0
  stop_value2 = 0
  stop_after = 0
  loop_this = 0

-- loop this function
function restart()
  main()
end

function restart2()
  main2()
end

function main()
  console.hide()
  menu.close()
  interval =  mymenu.submenu["interval"].value + 1
  delay_value1 = mymenu.submenu["rec delay"].value + 1
  stop_value1 = mymenu.submenu["recording time"].value

-- warning 
if camera.mode ~= MODE.MOVIE then
  display.notify_box("enable MOVIE mode")
  do return end  
end

-- if rec delay set
 if delay_value1 > 1 then
  display.notify_box("push display to disable rec delay")
  msleep(1000)
  display.notify_box("push display to disable rec delay")
  msleep(1000)
 end

-- rec delay set?
    while delay_value1 > 1 do
      if menu.visible then
      do return end
      end
      delay_value1 = delay_value1 - 1
      display.notify_box("recording delay "..delay_value1)
      msleep(1000)
    end

-- when liveview find itself sleeping
 if lv.enabled == false then
  lv.start()
  msleep(1000)
 end

  menu.set("RAW video", "Rec trigger", "Half-shutter: pre only")
  msleep(1000)
  menu.set("RAW video", "Pre-record", "1 frame")
  display.notify_box("push rec to disable")
  msleep(1000)
  display.notify_box("push rec to disable")
  msleep(1000)
  key.press(KEY.REC)
--start recording
      while movie.recording == false and menu.visible == false do
      msleep(1000)
      end

-- starting the timelapse loop
 while interval > 0 do 

      interval = interval - 1
      msleep(1000)

   -- share displaybox with stop function  
     if displaybox < 8 then
      display.notify_box("interval "..interval)
   -- check if stop function is enabled
      if stop_value1 > 0 then displaybox = displaybox + 1 end
     end

      if interval == 0 then
   -- reload interval
      interval =  mymenu.submenu["interval"].value + 1
      key.press(KEY.HALFSHUTTER)
      key.press(KEY.UNPRESS_HALFSHUTTER)
      end

      if movie.recording == false then
      menu.set("RAW video", "Rec trigger", "OFF")
       if mymenu.submenu["loop this"].value < 1 then 
	 do return end 
       end
      end

-- stop function
   if stop_value1 > 0 then
      stop_value1 = stop_value1 - 1

   -- share displaybox with interval function 
     if displaybox > 7 then
      display.notify_box("recording time "..stop_value1)
      displaybox = displaybox + 1
      if displaybox == 16 then
      displaybox = 0
      end
     end

      if stop_value1 == 0  and mymenu.submenu["recording time"].value > 0 then
      msleep(1000)
      displaybox = 0
      key.press(KEY.REC)
      msleep(1000)
--stop recording
      while movie.recording == true and menu.visible == false do
      msleep(1000)
      end
        menu.set("RAW video", "Rec trigger", "OFF")
        msleep(1000)
        if mymenu.submenu["loop this"].value > 0 then
        mymenu.submenu["loop this"].value = mymenu.submenu["loop this"].value - 1
        restart() 
        else
        do return end
	end
      end
   end
 end

end


mymenu = menu.new
{
    parent = "Movie",
    name = "intervalometer",
    help = "Movie preset intervalometer",
    submenu =
    {
        {
            name = "interval",
            min = 0,
            max = 600,
	    value = 10,
            unit = UNIT.TIME,
            update = function(this) mymenu.value = this.value end,
	    help = "default is 10 seconds",
        },
        {
            name = "run halfshutter trigger",
	    select = function(this) task.create(main) end,
	    help = "records single frames in a MLV chunk. enables REC trigger mode",
        },
        {
            name = "rec delay",
            min = 0,
            max = 10000,
            unit = UNIT.TIME,
            update = function(recd) recd.value = recd.value end,
	    help = "start recording with a delay",
        },
        {
            name = "recording time",
            min = 0,
            max = 10000,
            unit = UNIT.TIME,
	    help = "stop recording after specified amount of time",
        },
        {
            name = "loop this",
            min = 0,
            max = 10000,
            unit = UNIT.DEC,
	    help = "loop this setup x many times, need recording time enabled",
        },
    },
}

config.create_from_menu(mymenu)

-- starts movie recording after a delay

function recdelay_main()
  console.hide()
  menu.close()
  delay_value1 = recdelay_menu.submenu["rec delay"].value
  stop_value1 = recdelay_menu.submenu["recording time"].value
  delay_value2 = recdelay_menu.submenu["rec delay"].value
  stop_value2 = recdelay_menu.submenu["recording time"].value
  loop_this = recdelay_menu.submenu["loop this"].value - 1

-- rec delay needs to be specified
if delay_value1 == 0 then
  display.notify_box("set rec delay")
  msleep(1000)
  display.notify_box("set rec delay")
  msleep(1000)
  display.notify_box("set rec delay")
  msleep(1000)
do return end
end

-- rec delay set?
    while delay_value1 > 0 do
      msleep(1000)
      if menu.visible then
      do return end
      end
      delay_value1 = delay_value1 - 1
      display.notify_box("recording delay "..delay_value1)
    end

-- when liveview find itself sleeping
 if lv.enabled == false then
  lv.start()
  msleep(1000)
 end

   key.press(KEY.REC)
--start recording
      while movie.recording == false and menu.visible == false do
      msleep(1000)
      end

    while stop_value1 > 0 do
      msleep(1000)
      if movie.recording == false then
      do return end
      end
      stop_value1 = stop_value1 - 1
      display.notify_box("recording time "..stop_value1)

      if stop_value1 == 0 then
      key.press(KEY.REC)
--stop recording
      while movie.recording == true and menu.visible == false do
      msleep(1000)
      end
      end
    end

-- check for loop this
 while loop_this > 0 and stop_value2 > 0 do

-- rec delay set?
    while delay_value2 > 0 do
      msleep(1000)
      if menu.visible then
      do return end
      end
      delay_value2 = delay_value2 - 1
      display.notify_box("recording delay "..delay_value2)
    end

-- when liveview find itself sleeping
 if lv.enabled == false then
  lv.start()
  msleep(1000)
 end

   key.press(KEY.REC)
--start recording
      while movie.recording == false and menu.visible == false do
      msleep(1000)
      end

    while stop_value2 > 0 do
      msleep(1000)
      if movie.recording == false then
      do return end
      end
      stop_value2 = stop_value2 - 1
      display.notify_box("recording time "..stop_value2)

      if stop_value2 == 0 then
	-- when liveview find itself sleeping
 	   if lv.enabled == false then
  	   lv.start()
  	   msleep(1000)
 	   end
      key.press(KEY.REC)
--stop recording
      while movie.recording == true and menu.visible == false do
      msleep(1000)
      end
      end
    end

-- reset for next loop
   delay_value2 = recdelay_menu.submenu["rec delay"].value
   stop_value2 = recdelay_menu.submenu["recording time"].value

-- check for loop this
  loop_this = loop_this - 1
  display.notify_box("loops left "..loop_this)
  msleep(500)
 end

end

recdelay_menu = menu.new
{
    parent = "Movie",
    name = "recording delay",
    help = "start movie recording after a delay",
    submenu =
    {
        {
            name = "rec delay",
            min = 0,
            max = 10000,
            unit = UNIT.TIME,
            update = function(recd) recd.value = recd.value end,
	    help = "start recording with a delay",
        },
        {
            name = "recording time",
            min = 0,
            max = 10000,
            unit = UNIT.TIME,
	    help = "stop recording after specified amount of time",
        },
        {
            name = "loop this",
            min = 0,
            max = 10000,
            unit = UNIT.DEC,
	    help = "loop this setup x many times, need recording time enabled",
        },
        {
            name = "Run",
            select = function(this) task.create(recdelay_main) end,
            help = "start the delay count down now",
        },
    },
}
