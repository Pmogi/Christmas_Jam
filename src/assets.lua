local Assets = {}

local assets = {}

-- font
assets["font"] = love.graphics.newFont("assets/fontstuck.ttf")

graphics = love.graphics


-- Kitchen images
assets["kitchenBG"] = graphics.newImage("assets/image/kitchen/kitchenbg.png")
assets["kitchenAtticDoor1"] = graphics.newImage("assets/image/kitchen/kitchenatticdoor1.png") -- closed state
assets["kitchenAtticDoor2"] = graphics.newImage("assets/image/kitchen/kitchenatticdoor2.png")






-------- Images
--- Living Room



assets["endScreen"] = love.graphics.newImage("assets/endingscreen.png")

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

-- Living Room
assets["LivingRoomBG"] = love.graphics.newImage("assets/image/livingroombg.png")

assets["ClosedDrawer1"]     = love.graphics.newImage("assets/image/livingroomdrawer1.png")
assets["OpenDrawer1"]       = love.graphics.newImage("assets/image/livingroomdrawer1open.png")

assets["ClosedDrawer2"]     = love.graphics.newImage("assets/image/livingroomdrawer2.png")
assets["OpenDrawer2"]       = love.graphics.newImage("assets/image/livingroomdrawer2open.png")

assets["Painting1"]         = love.graphics.newImage("assets/image/puzzleevilgodpainting1.png")
assets["Painting2"]         = love.graphics.newImage("assets/image/puzzleevilgodpainting2.png")

assets["Sofa"]  = love.graphics.newImage("assets/image/livingroomsofa.png")
assets["Table"] = love.graphics.newImage("assets/image/livingroomtable.png")

assets["Calender"] = love.graphics.newImage("assets/image/puzzlecalender1.png")


-- Calender Screen
assets["CalenderRoom1"] = love.graphics.newImage("assets/image/puzzlecalender2.png")
assets["CalenderRoom2"] = love.graphics.newImage("assets/image/puzzlecalender3.png")

--- Bathroom
assets["BathRoomBG"] = graphics.newImage("assets/image/bathroombg.png")
assets["Toilet1"]    = graphics.newImage("assets/image/bathroomtoilet1.png")
assets["Toilet2"]    = graphics.newImage("assets/image/bathroomtoilet2.png")


assets["Glue"] = graphics.newImage("assets/image/iconglue.png")
assets["GlueGlow"] = graphics.newImage("assets/image/iconglueglow.png")


assets["Necro1"] = graphics.newImage("assets/image/puzzlenecronomicon1.png")
assets["Necro2"] = graphics.newImage("assets/image/puzzlenecronomicon2.png")
assets["Necro3"] = graphics.newImage("assets/image/puzzlenecronomicon3.png")

--- Basement

assets["BasementBG"] = graphics.newImage("assets/image/basementbg.png")

assets["Table_B"] = graphics.newImage("assets/image/basementtable.png")

assets["Bill1"] = graphics.newImage("assets/image/puzzlebill1.png")
assets["Bill2"] = graphics.newImage("assets/image/puzzlebill2.png")

assets["Clothes"] = graphics.newImage("assets/image/basementmessyclothes.png")

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