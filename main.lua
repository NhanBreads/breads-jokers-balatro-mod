assert(SMODS.load_file('global.lua'))()
assert(SMODS.load_file('Items/jokers.lua'))()


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

-- Template
local base = SMODS.Joker{
    key = 'base',
    rarity = 1,
    cost = 1,
    atlas = 'Jokers',
    pos = {x = 1, y = 1},
    soul_pos = { x = 0, y = 1},
    yes_pool_flag="carbanana_mutate",
    config = { extra = {

    }
    },

}

----------------------------------------------
------------MOD CODE END----------------------
    