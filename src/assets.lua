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
assets["denture"] = graphics.newImage("assets/image/livingRoom/itemdentures.png")
assets["dentureicon"] = graphics.newImage("assets/image/livingRoom/icondentures1.png")
assets["dentureiconglow"] = graphics.newImage("assets/image/livingRoom/icondentures2.png")
assets["hook"] = graphics.newImage("assets/image/livingRoom/itemattichook.png")
assets["hookicon"] = graphics.newImage("assets/image/livingRoom/attichook1.png")
assets["hookiconglow"] = graphics.newImage("assets/image/livingRoom/attichook2.png")

-- Backyard image
assets["backyardBG"] = graphics.newImage("assets/image/backyard/backyardbg.png")
assets["backyardShed1"] = graphics.newImage("assets/image/backyard/backyardshed1.png")
assets["backyardShed2"] = graphics.newImage("assets/image/backyard/backyardshed2.png")

assets["decoration"]    = graphics.newImage("assets/image/backyard/itemdecorations.png")
assets["decorationicon"] = graphics.newImage("assets/image/backyard/icondecorations1.png")
assets["decorationiconglow"] = graphics.newImage("assets/image/backyard/icondecorations2.png")



-- Bedroom assets
local b = "assets/image/bedroom/"
assets["bedroomBG"]    = graphics.newImage(b .. "bedroombg.png")

assets["recordPlayer1"] = graphics.newImage(b .. "bedroomrecordplayer1.png")
assets["recordPlayer2"] = graphics.newImage(b .. "bedroomrecordplayer2.png")

assets["prune"] = graphics.newImage(b .. "itemprunes.png")
assets["pruneicon"] = graphics.newImage(b .. "iconprune1.png")
assets["pruneiconglow"] = graphics.newImage(b .. "iconprune2.png")

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
assets["sugaricon"] = graphics.newImage("assets/image/kitchen/iconsugar1.png")
assets["sugariconglow"] = graphics.newImage("assets/image/kitchen/iconsugar2.png")

assets["raisins"] = graphics.newImage("assets/image/kitchen/itemraisins.png")
assets["raisinsicon"] = graphics.newImage("assets/image/kitchen/iconraisin1.png")
assets["raisinsiconglow"] = graphics.newImage("assets/image/kitchen/iconraisin2.png")

assets["oats"] = graphics.newImage("assets/image/kitchen/itemoatmeal.png")
assets["oatsicon"] = graphics.newImage("assets/image/kitchen/iconoatmeal1.png")
assets["oatsiconglow"] = graphics.newImage("assets/image/kitchen/iconoatmeal2.png")

assets["bowl"] = graphics.newImage("assets/image/kitchen/itembowl.png")
assets["bowlicon"] = graphics.newImage("assets/image/kitchen/iconfullbowl1.png")
assets["bowliconglow"] = graphics.newImage("assets/image/kitchen/iconfullbowl2.png")

assets["cookbook"] = graphics.newImage("assets/image/kitchen/itemcookbook.png")
assets["cookiesicon"] = graphics.newImage("assets/image/kitchen/iconcookies1.png")
assets["cookiesiconglow"] = graphics.newImage("assets/image/kitchen/iconcookies2.png")

assets["arrow"] = graphics.newImage("assets/image/kitchen/pointyarrow.png")


-- Attic
assets["record"] = graphics.newImage("assets/image/attic/itemrecord.png")
assets["recordicon"] = graphics.newImage("assets/image/attic/iconrecord1.png")
assets["recordiconglow"] = graphics.newImage("assets/image/attic/iconrecord2.png")
assets["key"] = graphics.newImage("assets/image/attic/itemkey.png")
assets["keyicon"] = graphics.newImage("assets/image/attic/iconkey1.png")
assets["keyiconglow"] = graphics.newImage("assets/image/attic/iconkey2.png")


-------- Images
--- Living Room

-- Cutscene images
assets["introScreen"] = graphics.newImage("assets/image/cutsceneImages/intro.png")
assets["endScreen"]   = love.graphics.newImage("assets/image/cutsceneImages/endingscreen.png")

local e = "assets/image/cutsceneImages/"

assets["endingAnim1"] = {graphics.newImage(e.."endingcandle1.png"), 
                         graphics.newImage(e.."endingcandle2.png")}

    

assets["endingAnim2"] = {graphics.newImage(e.."endingcandle1.png"),
                         graphics.newImage(e.."endingcandle2.png"),
                         graphics.newImage(e.."endingcandle3.png"),
                         graphics.newImage(e.."endingcandle4.png"),
                         graphics.newImage(e.."endingcandle5.png"),
                         graphics.newImage(e.."endingcandle6.png"),
                         graphics.newImage(e.."endingcandle7.png"),
                         graphics.newImage(e.."endingcandle7.png")}



-- Audio
assets["Touch"] = love.audio.newSource("assets/audio/woodClick.wav", "static")
assets["Grab"] = love.audio.newSource("assets/audio/grab.wav", "static")
assets["Grab"]:setVolume(0.4)
assets["FanFare"] = love.audio.newSource("assets/audio/fanfare.wav", "static")
assets["Open"] = love.audio.newSource("assets/audio/open.wav", "static")
assets["Bloop"] = love.audio.newSource("assets/audio/bloop.wav", "static")
assets["AtticDoor"] = love.audio.newSource("assets/audio/atticDoor.wav", "static")
assets["Cabinet"] = love.audio.newSource("assets/audio/cabinet.wav", "static")
assets["Box"] = love.audio.newSource("assets/audio/box.wav", "static")
assets["ShedDoor"] = love.audio.newSource("assets/audio/shedDoor.wav", "static")
assets["Hmm"] = love.audio.newSource("assets/audio/hmm.wav", "static")
assets["Hmm"]:setVolume(0.5)
assets["GlassKnock"] = love.audio.newSource("assets/audio/glassKnock.wav", "static")
assets["GlassKnock"]:setVolume(0.7)
assets["FridgeDoor"] = love.audio.newSource("assets/audio/fridgeDoor.wav", "static")
assets["FridgeDoor"]:setVolume(0.7)
assets["GrannyLaugh"] = love.audio.newSource("assets/audio/grannyLaugh.wav", "static")
assets["GrannyLaugh"]:setVolume(0.7)
assets["GrannyRelief"] = love.audio.newSource("assets/audio/grannyRelief.wav", "static")
assets["GrannyRelief"]:setVolume(0.7)
assets["GrannyStartled"] = love.audio.newSource("assets/audio/grannyStartled.wav", "static")
assets["GrannyStartled"]:setVolume(0.7)
assets["GrannySurprise"] = love.audio.newSource("assets/audio/grannySurprise.wav", "static")
assets["GrannySurprise"]:setVolume(0.7)

---- MUSIC ----
assets["menuMusic"] = love.audio.newSource("assets/audio/bgm/MenuAndIntro.ogg", "static")
assets["menuMusic"]:setLooping(true)
assets["menuMusic"]:setVolume(1.5)

assets["mainBGM"]   = love.audio.newSource("assets/audio/bgm/mainBGM.ogg", "static")
assets["mainBGM"]:setLooping(true)

assets["recordBGM"]   = love.audio.newSource("assets/audio/bgm/record.ogg", "static")

assets["endingBGM"]   = love.audio.newSource("assets/audio/bgm/Ending.ogg", "static")

--assets[""]

Assets["rand"] = love.math.newRandomGenerator()

function Assets.getAsset(key)
    return assets[key]
end

function Assets.playAudio(key)
    local source = Assets.getAsset(key)
    source:setPitch(1.0)
    source:play()
end

function Assets.playAudioRandomPitch(key, lowMult, highMult)
    local source = Assets.getAsset(key)
    source:setPitch(Assets["rand"]:random() * (highMult - lowMult) + lowMult)
    source:play()
end

function Assets.playAudioPitch(key, mult)
    local source = Assets.getAsset(key)
    source:setPitch(mult)
    source:play()
end

return Assets
