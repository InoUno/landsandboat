-----------------------------------
-- Area: East_Sarutabaruta
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.EAST_SARUTABARUTA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389, -- Obtained: <item>.
        GIL_OBTAINED             = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET    = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7050, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7209, -- You can't fish here.
        DIG_THROW_AWAY           = 7222, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7224, -- You dig and you dig, but find nothing.
        SIGNPOST_OFFSET          = 7379, -- Southeast: South Tower, Horutoto Ruins Southwest: Windurst Woods
        TABY_CANATAHEY_DIALOG    = 7389, -- This is the entrrrance to Windurst. Please maintain orderrrly conduct while you'rrre in town.
        HEIH_PORHIAAP_DIALOG     = 7390, -- These grrrasslands make up East Sarutabaruta. Lately the number of monsters has drrramatically increased, causing us all sorts of trrrouble.
        SAMA_GOHJIMA_PREDIALOG   = 7392, -- The ministerrr of the Orastery is in the laborrratory beneath here. To get there, you should check the walls verrry carrrefully.
        SAMA_GOHJIMA_POSTDIALOG  = 7393, -- Were you able to find the laborrratory? There are many such hidden passages in the Horutoto Ruins.
        PLAYER_OBTAINS_ITEM      = 7570, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7571, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7572, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7573, -- You already possess that temporary item.
        NO_COMBINATION           = 7578, -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9938, -- New training regime registered!
    },
    mob =
    {
        SHARP_EARED_ROPIPI_PH =
        {
            [17252507] = 17252489, -- 363.152 -16.705 -326.213
            [17252506] = 17252489, -- 303.282 -17.642 -415.870
            [17252487] = 17252489, -- 224.258 -17.858 -486.256
            [17252488] = 17252489, -- 227.825 -16.978 -317.467
        },
        SPINY_SPIPI_PH =
        {
            [17252656] = 17252657
        },
        DUKE_DECAPOD   = 17252725,
    },
    npc =
    {
        CASKET_BASE = 17253005,
    },
}

return zones[xi.zone.EAST_SARUTABARUTA]
