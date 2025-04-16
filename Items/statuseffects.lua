-- Poison
SMODS.Enhancement ({
    key = "poison",
    atlas = "status_effects",
    pos = {x = 0, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
    loc_txt = {
        name = "Poisoned Card",
        text = {"Gives {X:red,C:white}X0.8{} Mult when scored",}
    },
    config = { x_mult = 0.8 },
})

-- Paralyze
SMODS.Enhancement ({
    key = "paralyze",
    atlas = "status_effects",
    pos = {x = 1, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
    loc_txt = {
        name = "Paralyzed Card",
        text = {"{C:green}1 in 3{} chance to not score",}
    },
    config = { extra = { odds = 3 }},
    calculate = function(self, card, context, effect)
        if pseudorandom('paralyze') < ((G.GAME and G.GAME.probabilities.normal or 1) / card.ability.extra.odds) then
            if context.before and context.cardarea == G.play then
                card:set_debuff(true)
            end
        end
    end
})

-- Sleep
SMODS.Enhancement ({
    key = "sleep",
    atlas = "status_effects",
    pos = {x = 2, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
    loc_txt = {
        name = "Sleepy Card",
        text = {"If this card is held in hand,","debuff itself"}
    },
    calculate = function(self, card, context, effect)
        if context.cardarea == G.hand and context.main_scoring then
            card:set_debuff(true)
        end
    end
})

-- Burn
SMODS.Enhancement ({
    key = "burned",
    atlas = "status_effects",
    pos = {x = 3, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
    loc_txt = {
        name = "Burned Card",
        text = {"Lose {C:money}$2{} when this","card is scored",}
    },
    config = { p_dollars = -2 },
})

-- Frozen
SMODS.Enhancement ({
    key = "frozen",
    atlas = "status_effects",
    pos = {x = 4, y = 0},
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
    shatters = true,
    loc_txt = {
        name = "Frozen Card",
        text = {"{C:chips}-60{} chips","{C:inactive}(Yeah, goes into negatives){}"}
    },
    config = {chips = -60},
    calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
            return {
                chips = card.ability.chips
            }
        end
    end
})

-- Petrify
SMODS.Enhancement ({
    key = "petrify",
    atlas = "status_effects",
    pos = {x = 5, y = 0},
    replace_base_card = true,
    no_suit = true,
    no_rank = true,
    always_scores = false,
    loc_txt = {
        name = "Petrified Card",
        text = {"No rank.","No suit.","No {C:chips}chips{}.",}
    },
})
