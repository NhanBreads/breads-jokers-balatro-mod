-- Mod Prefix _breadjokers_

return {
    descriptions = {
        Joker = {
            j_breadjokers_ldk = {
                name = 'LegendDuoKeeper',
                text = {
                    'When Boss Blind is selected,',
                    'summon one of the {C:attention}members{}.',
                    '{X:mult,C:white}X#1#{} Mult',
                    '{C:inactive}(Must have room)'
                }
            },
            j_breadjokers_beoulve = {
                name = 'Stamp of Approval',
                text = {
                    'If played hand contains',
                    'an unscored {C:attention}2{}, apply',
                    'a random {C:attention}Seal{} to it.',
                    '{C:inactive}-{}',
                    '{C:chips}+#1#{} Chips for every {C:attention}sealed{}',
                    'card in your {C:attention}full deck{}.',
                    '{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)',
                    "{C:inactive}'I approve of this concept!' -Beoulve"
                }
            },
            j_breadjokers_ddwl = {
                name = 'B-B-BonusDale!',
                text = {
                    '{C:planet}Planet{} cards grant',
                    '{C:attention}1{} additional level.',
                    '{C:inactive}-{}',
                    'For every unique {C:planet}Planet{} card used,',
                    'permanently gain {C:mult}+#2#{} mults.',
                    '{C:inactive}(Currently {C:mult}+#3#{C:inactive} mults)',
                    '{C:inactive}-{}',
                    "{C:inactive}'BWAAAH!' -Dale"
                }
            },
            j_breadjokers_dwl = {
                name = 'DaleWillFail',
                text = {
                    'When you play a {C:attention}Four of a Kind{},',
                    'there is a {C:green}#4# in 6{} chance to obtain a',
                    '{C:blue}Ethereal{} Tag.',
                    '{C:inactive}-{}',
                    'When opening {C:blue}Spectral{} packs, this {C:attention}Joker{}',
                    'gains {X:mult,C:white}X#3#{} mult.',
                    '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)',
                    "{C:inactive}'It's time for my ULTIMATE MOVE!' -Dale"
                }
            },
            j_breadjokers_greek = {
                name = 'Kintrol Alt De Greek',
                text = {
                    'For each scoring {C:attention}7{} in played hand,',
                    'increase the {C:green,E:1,S:1.1}probabilities{} of the following',
                    'chances by {C:green}#1#{}. Resets {C:green,E:1,S:1.1}probabilities{} after',
                    'every hand played.',
                    '{C:inactive}-{}',
                    '{C:green}#2# in #3#{}: Earn {C:money}$#4#{}.',
                    '{C:green}#2# in #5#{}: {C:chips}+#6#{} Chips when a {C:attention}7{} is played and scored.',
                    '{C:green}#2# in #7#{}: This joker permanently gains {X:mult,C:white}X#8#{}.',
                    '{C:green}#2# in #9#{}: Retrigger all {C:attention}scoring{} cards.',
                    '{C:inactive}(Currently {X:mult,C:white}X#10#{C:inactive} Mult)'
                }
            },
            j_breadjokers_will = {
                name = 'Supercommandostumpy',
                text = {
                    'There is a {C:green}#3# in 2{} chance this joker',
                    'scores {X:mult,C:white}X#1#{} Mult. Repeat this until fail.',
                    '{C:inactive}-{}',
                    'If the above chance {C:mult}fails{}, this joker',
                    'loses {X:mult,C:white}X#2#{} Mult.',
                    '{C:inactive}-{}',
                    'If this joker reaches {X:mult,C:white}X1.0{} Mult or lower,',
                    'destroy this card and summon their {C:attention}alter-ego{}.',
                    '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
                    "{C:inactive}Probability can't be affected from outside sources{}",
                    "{C:inactive}'Nibwurrvsdmcan derfive simmsis' -Supercommandostumpy{}"
                }
            }
        },
        Other = {
            p_breadjokers_legendserver = {
                name = "Legend Pack",
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:joker} Joker{} cards",
                }
            }
        }
    }
}