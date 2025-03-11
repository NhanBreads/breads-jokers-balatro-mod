assert(SMODS.load_file('global.lua'))()

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
    config = { extra = {

    }
    },

}

-- LEGENDDUOKEEPER
local ldk = SMODS.Joker{
    key = 'ldk',
    rarity = 3,
    cost = 8,
    atlas = 'Jokers',
    pos = {x = 0, y = 0},
    config = { extra = {
        Xmult = 2
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.Xmult}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                card = card,
                Xmult = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
        
        if context.setting_blind and context.blind.boss then
            if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function ()
                        local new_joker = pseudorandom_element(LDK_Random.ldk_random_pool, pseudoseed('legend'))

                        SMODS.add_card({key=new_joker})
                        return true
                    end
                }))
            end
        end    
    end    
}

-- BEOULVE
local beoulve = SMODS.Joker{
    key = 'beoulve',
    rarity = 2,
    cost = 6,
    atlas = 'Jokers',
    pos = {x = 1, y = 0},
    config = { extra = {
        chips = 20,
        chip_mod = 0
    }
    },
    loc_vars = function(self,info_queue,center)
        return {vars = {center.ability.extra.chips,center.ability.extra.chip_mod}}
    end,
    calculate = function(self,card,context)
        local seals = 0
        for k,v in ipairs(G.playing_cards) do
            if v.seal then
                seals = seals + 1
            end
        end
        card.ability.extra.chip_mod = card.ability.extra.chips * seals
        if context.individual and context.cardarea == 'unscored' and context.other_card:get_id() == 2 then
            _card = context.other_card
            local args = {guaranteed = true}
            local seal_type = SMODS.poll_seal(args)
            _card:set_seal(seal_type, true)
        end

        if context.joker_main and card.ability.extra.chip_mod > 0 then
            return {
                chip_mod = card.ability.extra.chip_mod,
                card = card,
                message = '+' .. card.ability.extra.chip_mod,
                colour = G.C.BLUE
            }
        end
    end
}

-- DaleWillFail
local dwl = SMODS.Joker{
    key = 'dwl',
    rarity = 3,
    cost = 7,
    atlas = 'Jokers',
    pos = {x = 4, y = 0},
    config = {extra = {pokerhand = "Four of a Kind", xmult = 1.00, xmult_mod = 0.25, odds = 6}},
    loc_vars = function(self,info_queue,center)
        info_queue[#info_queue+1] = G.P_CENTERS.p_spectral_normal_1
        return {vars = {center.ability.extra.pokerhand, center.ability.extra.xmult, center.ability.extra.xmult_mod, ''..(G.GAME and G.GAME.probabilities.normal or 1)}}
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main then
                if next(context.poker_hands["Four of a Kind"]) then
                    if pseudorandom('ultimatemove') < G.GAME.probabilities.normal/card.ability.extra.odds then
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                                play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                                add_tag(Tag('tag_ethereal'))
                                return {
                                    message = "Take this for your travels!"
                                }
                            end)
                        }))
                    else
                        return {
                            message = "Ouch!"
                        }
                    end
                end
            end
        end
        if context.open_booster then
            if SMODS.OPENED_BOOSTER.config.center.kind == "Spectral" then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
            end
        end
        if context.joker_main then
            if card.ability.extra.xmult > 1.00 then
                return {
                    message = "MY ULTIMATE MOVE!",
                    Xmult = card.ability.extra.xmult,
                }
            end
        end
    end
}

-- BB-BonusDale
local ddwl = SMODS.Joker{
    key = 'ddwl',
    rarity = 3,
    cost = 6,
    atlas = 'Jokers',
    pos = {x = 2, y = 0},
    config = {extra = {plus_levels = 1, mult = 6, current_mult = 0, planets_used = 0}},
    loc_vars = function(self, info_queue, center)
        local total_levels = 0
        for _, hand in pairs(G.GAME.hands) do
            if hand.visible then
                total_levels = total_levels + hand.level
            end
        end
        return {vars = {
            center.ability.extra.plus_levels,
            center.ability.extra.mult,
            center.ability.extra.current_mult,
            center.ability.extra.planets_used
        }}
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
          local text = context.consumeable.ability.hand_type
          if type(text) == "string" then
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, 
                              level = G.GAME.hands[text].level})
            level_up_hand(card, text, nil, card.ability.extra.plus_levels)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
          end
          local planets_used = 0
          for k, v in pairs(G.GAME.consumeable_usage) do
              if v.set == 'Planet' then planets_used = planets_used + 1 end
          end
          card.ability.extra.planets_used = planets_used
        end
        if context.cardarea == G.jokers and context.scoring_hand then
            if context.joker_main and card.ability.extra.planets_used > 0 then
              card.ability.extra.current_mult = card.ability.extra.planets_used * card.ability.extra.mult
              return { 
                mult = card.ability.extra.current_mult
              }
            end
        end
    end
} 


-- KINTROL ALT DEGREEK
local greek = SMODS.Joker{
    key = 'greek',
    rarity = 3,
    cost = 7,
    atlas = 'Jokers',
    pos = {x = 3, y = 0},
    config = { extra = {
        prob = 1,
        mainprob = 1,
        prob_one = 5,
        moneyget = 7,
        prob_two = 7,
        chipget = 77,
        prob_three = 8,
        Xmultmod = 0.14,
        prob_four = 10,
        Xmult = 1
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.prob,
            ''..(G.GAME and G.GAME.probabilities.normal or 1),
            center.ability.extra.prob_one,
            center.ability.extra.moneyget,
            center.ability.extra.prob_two,
            center.ability.extra.chipget,
            center.ability.extra.prob_three,
            center.ability.extra.Xmultmod,
            center.ability.extra.prob_four,
            center.ability.extra.Xmult
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then 
            local ret = {}
            ret.Xmult = card.ability.extra.Xmult
            if pseudorandom('greek') < ((G.GAME.probabilities.normal * card.ability.extra.mainprob) / card.ability.extra.prob_one) then
                ret.dollars = card.ability.extra.moneyget
            end
            if pseudorandom('greek') < ((G.GAME.probabilities.normal * card.ability.extra.mainprob) / card.ability.extra.prob_two) then
                ret.chips = card.ability.extra.chipget
            end
            return ret
        end
        if context.before then
            for _, cards in ipairs(context.scoring_hand) do
                if cards:get_id() == 7 then
                    card.ability.extra.mainprob = card.ability.extra.mainprob + card.ability.extra.prob
                end
            end
            if pseudorandom('greek') < ((G.GAME.probabilities.normal * card.ability.extra.mainprob) / card.ability.extra.prob_four) then
                repeatcards = true
            end
            if pseudorandom('greek') < ((G.GAME.probabilities.normal * card.ability.extra.mainprob) / card.ability.extra.prob_three) then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmultmod
            end
        end
        if context.repetition and context.cardarea == G.play and repeatcards == true then
            return {
                repetitions = 1
            }
        end
        if context.after then
            repeatcards = false
            card.ability.extra.mainprob = 1
        end
    end
}

local will = SMODS.Joker{
    key = 'will',
    rarity = 3,
    cost = 8,
    atlas = 'Jokers',
    pos = {x = 5, y = 0},
    config = { extra = {
        xmult = 2.5,
        xmult_mod = 0.2,
        odds = 1
    }},
    loc_vars = function(self,info_queue,center)
        return {vars = {
            center.ability.extra.xmult,
            center.ability.extra.xmult_mod,
            center.ability.extra.odds
        }}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if pseudorandom('will') < 1/2 then
                return {
                    card = G.joker,
                    message = "Hell Yeah! Heads!",
                    Xmult = card.ability.extra.xmult,
                    repetitions = 4,
                    colour = G.C.MULT
                }
            else
                card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_mod
                return {
                    message = "Damn... Tails...",
                    colour = G.C.MULT
                }
            end
            if card.ability.extra.xmult <= 1.00 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = "GOODBYE!"
                }
            end
        end
    end
}


----------------------------------------------
------------MOD CODE END----------------------
    