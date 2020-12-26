local Assets = {}

local assets = {}

graphics = love.graphics

-- font
assets["font"] = love.graphics.newFont("assets/fontstuck.ttf")

assets["UI_backpack"] = graphics.newImage("assets/image/UI/backpack.png")



-- Kitchen images
assets["kitchenBG"] = graphics.newImage("assets/image/kitchen/kitchenbg.png")
assets["kitchenAtticDoor1"] = graphics.newImage("assets/image/kitchen/kitchenatticdoor1.png") -- closed state
assets["kitchenAtticDoor2"] = graphics.newImage("assets/image/kitchen/kitchenatticdoor2.png")

assets["kitchencabinet1"] = graphics.newImage("assets/image/kitchen/kitchencabinet1.png")
assets["kitchencabinet2"] = graphics.newImage("assets/image/kitchen/kitchencabinet2.png")

assets["kitchenFridge1"]  = graphics.newImage("assets/image/kitchen/kitchenfridge1.png")
assets["kitchenFridge2"]  = graphics.newImage("assets/image/kitchen/kitchenfridge2.png")

assets["kitchenCookbook"] = graphics.newImage("assets/image/kitchen/itemcookbook.png")




-- Attic images
local a = "assets/image/attic/"
assets["atticBG"] = graphics.newImage(a .. "atticbg.png")
assets["atticRecordBox1"] = graphics.newImage("assets/image/attic/atticrecordbox1.png")
assets["atticRecordBox2"] = graphics.newImage("assets/image/attic/atticrecordbox2.png")


-- Living Room images
assets["livingRoomBG"] = graphics.newImage("assets/image/livingRoom/livingroombg.png")

-- Backyard image
assets["backyardBG"] = graphics.newImage("assets/image/backyard/backyardbg.png")
assets["backyardShed1"] = graphics.newImage("assets/image/backyard/backyardshed1.png")
assets["backyardShed2"] = graphics.newImage("assets/image/backyard/backyardshed2.png")

-- Bedroom assets
local b = "assets/image/bedroom/"
assets["bedroomBG"]    = graphics.newImage(b .. "bedroombg.png")

assets["recordPlayer1"] = graphics.newImage(b .. "bedroomrecordplayer1.png")
assets["recordPlayer2"] = graphics.newImage(b .. "bedroomrecordplayer2.png")

assets["prune"] = graphics.newImage(b .. "itemprunes.png")

assets["grannyFrames"] = {graphics.newImage(b .. "bedroombedandlady1.png"),
                          graphics.newImage(b .. "bedroombedandlady2.png") }

assets["candleFrames"] = {graphics.newImage(b .. "bedroomcandleleft.png")  ,
                          graphics.newImage(b .. "bedroomcandleneutral.png"),
                          graphics.newImage(b .. "bedroomcandleright.png") ,
                          graphics.newImage(b .. "bedroomcandleneutral.png") }


assets["prune"]  = graphics.newImage("assets/image/bedroom/itemprunes.png")

assets["cookies"] = graphics.newImage(b .. "itemcookies.png")
assets["deco1"]  = graphics.newImage(b .. "itemdecoration1.png") -- pillow
assets["deco2"]  = graphics.newImage(b .. "itemdecoration2.png") -- wreath
assets["deco3"]  = graphics.newImage(b .. "itemdecoration3.png") -- tree


-- Living Room assets
local l = "assets/image/livingRoom/"

assets["livingRoomBG"] = graphics.newImage(l .. "livingroombg.png")


-- Recipe assets
assets["recipeBook"] = graphics.newImage("assets/image/recipe/recipePage.png")

-- Items

-- Kitchen

assets["sugar"]  = graphics.newImage("assets/image/kitchen/itemsugar.png")
assets["sugaricon"] = graphics.newImage("assets/image/kitchen/itemsugaricon.png")

assets["raisins"] = graphics.newImage("assets/image/kitchen/itemraisins.png")
assets["raisinsicon"] = graphics.newImage("assets/image/kitchen/itemraisinsicon.png")

assets["oats"] = graphics.newImage("assets/image/kitchen/itemoatmeal.png")
assets["oatsicon"] = graphics.newImage("assets/image/kitchen/itemoatmealicon.png")

assets["bowl"] = graphics.newImage("assets/image/kitchen/itembowl.png")
assets["bowlicon"] = graphics.newImage("assets/image/kitchen/itembowlicon.png")

assets["cookbook"] = graphics.newImage("assets/image/kitchen/itemcookbook.png")

-- Living Room
assets["dentures"] = graphics.newImage("assets/image/livingRoom/itemdentures.png")
assets["denturesicon"] = graphics.newImage("assets/image/livingRoom/itemdenturesicon.png")
assets["atticHook"] = graphics.newImage("assets/image/livingRoom/itemattichook.png")
assets["attickHookicon"] = graphics.newImage("assets/image/livingRoom/itemattichookicon.png")

-- Attic
assets["record"] = graphics.newImage("assets/image/attic/itemrecord.png")







-------- Images
--- Living Room



assets["endScreen"] = love.graphics.newImage("assets/endingscreen.png")

--[[
-- inv items
assets["EraserItem"]   =    love.graphics.newImage("assets/image/itemeraser.png")
assets["BlanketItem"]  =    love.graphics.newImage("assets/image/itemblanket.png")
assets["ScissorsItem"]     = love.graphics.newImage("assets/image/itemscissors.png")
assets["DuckItem"]         = love.graphics.newImage("assets/image/itemducky.png")

assets["ToothbrushItem"] =  love.graphics.newImage("assets/image/itemtoothbrush.png")

assets["GlueItem"]         = graphics.newImage("assets/image/itemglue.png")
assets["MustacheItem"]     = graphics.newImage("assets/image/itemstache.png")

assets["SelfHelpItem1"]    = graphics.newImage("assets/image/itemselfhelpbook1.png")
assets["SelfHelpItem2"]    = graphics.newImage("assets/image/itemselfhelpbook2.png")

-- assets[""]

-- Icons for inventory
assets["Eraser"]       = love.graphics.newImage("assets/image/iconeraser.png")
assets["EraserGlow"]   = love.graphics.newImage("assets/image/iconeraserglow.png")

assets["Duck"]         = love.graphics.newImage("assets/image/iconducky.png")
assets["DuckGlow"]     = love.graphics.newImage("assets/image/iconduckyglow.png")

assets["Scissors"]       = love.graphics.newImage("assets/image/iconscissors.png")
assets["ScissorsGlow"]   = love.graphics.newImage("assets/image/iconscissorsglow.png")

assets["Blanket"]       = love.graphics.newImage("assets/image/iconblanket.png")
assets["BlanketGlow"]   = love.graphics.newImage("assets/image/iconblanketglow.png")

assets["Toothbrush"] = love.graphics.newImage("assets/image/icontoothbrush.png")
assets["ToothbrushGlow"] = love.graphics.newImage("assets/image/icontoothbrushglow.png")

assets["Mustache"] = love.graphics.newImage("assets/image/iconstache.png")
assets["MustacheGlow"] = love.graphics.newImage("assets/image/iconstacheglow.png")

assets["Mustache"] = love.graphics.newImage("assets/image/iconstache.png")
assets["MustacheGlow"] = love.graphics.newImage("assets/image/iconstacheglow.png")

assets["HelpBook"] = love.graphics.newImage("assets/image/iconselfhelp.png")
assets["HelpBookGlow"] = love.graphics.newImage("assets/image/iconselfhelpglow.png")
-- HelpBook, one left
]]
-- Living Room
--
-- Audio
assets["Touch"] = love.audio.newSource("assets/audio/touch.wav", "static")
assets["Grab"] = love.audio.newSource("assets/audio/grab.wav", "static")
assets["FanFare"] = love.audio.newSource("assets/audio/fanfare.wav", "static")
assets["Open"] = love.audio.newSource("assets/audio/open.wav", "static")
assets["Bloop"] = love.audio.newSource("assets/audio/bloop.wav", "static")


assets["endScreen"] = love.graphics.newImage("assets/endingscreen.png")

--assets[""]



function Assets.getAsset(key)
    return assets[key]
end

return Assets
