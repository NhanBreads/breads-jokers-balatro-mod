assert(SMODS.load_file('global.lua'))()
assert(SMODS.load_file('Items/jokers.lua'))()
assert(SMODS.load_file('Items/booster.lua'))()
assert(SMODS.load_file('Items/statuseffects.lua'))()



SMODS.current_mod.optional_features = {
    retrigger_joker = true,
    post_trigger = true,
}

SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
})

SMODS.Atlas({
    key = "status_effects",
    path = "statuseffects.png",
    px = 71,
    py = 95
})

----------------------------------------------
------------MOD CODE END----------------------
    