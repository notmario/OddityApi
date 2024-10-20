--- STEAMODDED HEADER
--- MOD_NAME: Oddity API
--- MOD_ID: OddityAPI
--- PREFIX: odd
--- MOD_AUTHOR: [AutumnMood (it/she/they), Lyman, notmario]
--- MOD_DESCRIPTION: Adds support for the Oddity consumeable type
--- BADGE_COLOR: 826390
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0909a]
--- VERSION: 1.0.0
--- PRIORITY: -1048576

OddityAPI = {
	config = {
		enable_packs = true,
		enable_tags = true,
	}
}

SMODS.Atlas({ 
  key = "odd_pack", 
  atlas_table = "ASSET_ATLAS", 
  path = "odd_pack.png", 
  px = 71, 
  py = 95 
})

SMODS.Atlas({ 
  key = "odd_tag", 
  atlas_table = "ASSET_ATLAS", 
  path = "odd_tag.png", 
  px = 34, 
  py = 34 
})

SMODS.Atlas({ 
  key = "modicon", 
  atlas_table = "ASSET_ATLAS", 
  path = "odd_icon.png", 
  px = 34, 
  py = 34 
})

SMODS.ConsumableType({
  key = "Oddity",
  primary_colour = HEX("826390"),
  secondary_colour = HEX("826390"),
  collection_rows = { 5, 5 },
  shop_rate = 3.0,
  loc_txt = {},
})

SMODS.UndiscoveredSprite {
	key = "Oddity",
	atlas = "odd_pack",
	pos = {
		x = 0,
		y = 1,
	}
}

if OddityAPI.config.enable_tags then
	SMODS.Tag {
		name = "Oddity Tag",
		key = "oddity",
		set = "Tag",
		config = {type = "new_blind_choice"},
		pos = {x = 0, y = 0},
		atlas = "odd_tag",
		discovered = false,
		apply = function(self, context)
			--print("yo")
			--if context.type == 'new_blind_choice' then
				local lock = self.ID
				G.CONTROLLER.locks[lock] = true
				self:yep('+', G.C.SECONDARY_SET.Oddity, function() 
					local key = 'p_odd_oddity_mega_'..(math.random(1,2))
					local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
					G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
					card.cost = 0
					card.from_tag = true
					G.FUNCS.use_card({config = {ref_table = card}})
					card:start_materialize()
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				self.triggered = true
				return true
			--end
		end,
		loc_vars = function(_c, info_queue)
			-- info_queue[#info_queue+1] = G.P_CENTERS.p_oddity_mega_1
			return {vars = {}}
		end,
	}

	SMODS.Tag {
		name = "Heirloom Tag",
		key = "heirloom",
		set = "Tag",
		config = {type = "immediate", spawn_oddities = 1},
		pos = {x = 1, y = 0},
		atlas = "odd_tag",
		discovered = false,
		apply = function(self, context)
			--print("yo")
			--if context.type == 'immediate' then
				local lock = self.ID
				G.CONTROLLER.locks[lock] = true
				self:yep('+', G.C.PURPLE,function() 
					for i = 1, self.config.spawn_oddities do
						if G.consumeables and #G.consumeables.cards < G.consumeables.config.card_limit then
							local card = create_card('Oddity', G.consumeables, true, nil, nil, nil, nil, 'heirloomtag')
							card:add_to_deck()
							G.consumeables:emplace(card)
						end
					end
					G.CONTROLLER.locks[lock] = nil
					return true
				end)
				self.triggered = true
				return true
			--end
		end,
		loc_vars = function() return {vars = {}} end,
	}
end

-- REPLACE THIS WHEN AND IF A REAL PACK API IS MADE
if OddityAPI.config.enable_packs then
	local minId = table_length(G.P_CENTER_POOLS['Booster']) + 1
	local id = 0
	local i = 0
	i = i + 1
	-- Prepare some Datas
	id = i + minId

	local booster_objs = {
		{discovered = true, name = "Oddity Pack", set = "Booster", order = id, key = "oddity_normal_1", pos = {x = 1, y = 0}, cost = 4, config = {extra = 3, choose = 1}, weight = 1, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Oddity Pack", set = "Booster", order = id, key = "oddity_normal_2", pos = {x = 2, y = 0}, cost = 4, config = {extra = 3, choose = 1}, weight = 1, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Oddity Pack", set = "Booster", order = id, key = "oddity_normal_3", pos = {x = 3, y = 0}, cost = 4, config = {extra = 3, choose = 1}, weight = 1, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Oddity Pack", set = "Booster", order = id, key = "oddity_normal_4", pos = {x = 4, y = 0}, cost = 4, config = {extra = 3, choose = 1}, weight = 1, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Jumbo Oddity Pack", set = "Booster", order = id, key = "oddity_jumbo_1", pos = {x = 1, y = 1}, cost = 6, config = {extra = 5, choose = 1}, weight = 1, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Jumbo Oddity Pack", set = "Booster", order = id, key = "oddity_jumbo_2", pos = {x = 2, y = 1}, cost = 6, config = {extra = 5, choose = 1}, weight = 1, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Mega Oddity Pack", set = "Booster", order = id, key = "oddity_mega_1", pos = {x = 3, y = 1}, cost = 8, config = {extra = 5, choose = 2}, weight = 0.25, kind = "Oddity",atlas = "odd_pack"},
		{discovered = true, name = "Mega Oddity Pack", set = "Booster", order = id, key = "oddity_mega_2", pos = {x = 4, y = 1}, cost = 8, config = {extra = 5, choose = 2}, weight = 0.25, kind = "Oddity",atlas = "odd_pack"},
	}
	for _, v in ipairs(booster_objs) do
		SMODS.Booster({
      key = v["key"],
      kind = "Oddity",
      atlas = "odd_pack",
      pos = v["pos"],
      config = v["config"],
      cost = v["cost"],
      weight = v["weight"],
      unlocked = true,
      discovered = true,
      create_card = function(self, card)
        local n_card = create_card("Oddity", G.pack_cards, nil, nil, true, true, nil, "oddity_pack")
        return n_card
      end,
      ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Oddity)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Oddity, special_colour = G.C.BLACK, contrast = 2 })
      end,
      loc_vars = function(self, info_queue, card)
        return { vars = { card.config.center.config.choose, card.ability.extra } }
      end,
      group_key = "k_oddity_pack",
    })
	end
end

-- copied from morefluff which was copied from cryptid
G.FUNCS.can_reserve_card = function(e)
	if #G.consumeables.cards < G.consumeables.config.card_limit then
		e.config.colour = G.C.GREEN
		e.config.button = "reserve_card"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end
G.FUNCS.reserve_card = function(e)
	local c1 = e.config.ref_table
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 0.1,
		func = function()
			c1.area:remove_card(c1)
			c1:add_to_deck()
			if c1.children.price then
				c1.children.price:remove()
			end
			c1.children.price = nil
			if c1.children.buy_button then
				c1.children.buy_button:remove()
			end
			c1.children.buy_button = nil
			remove_nils(c1.children)
			G.consumeables:emplace(c1)
			G.GAME.pack_choices = G.GAME.pack_choices - 1
			if G.GAME.pack_choices <= 0 then
				G.FUNCS.end_consumeable(nil, delay_fac)
			end
			return true
		end,
	}))
end

local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons
function G.UIDEF.use_and_sell_buttons(card)
	if (card.area == G.pack_cards and G.pack_cards) and card.ability.consumeable then --Add a use button
		if card.ability.set == "Oddity" then
			return {
				n = G.UIT.ROOT,
				config = { padding = -0.1, colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							ref_table = card,
							r = 0.08,
							padding = 0.1,
							align = "bm",
							minw = 0.5 * card.T.w - 0.15,
							minh = 0.7 * card.T.h,
							maxw = 0.7 * card.T.w - 0.15,
							hover = true,
							shadow = true,
							colour = G.C.UI.BACKGROUND_INACTIVE,
							one_press = true,
							button = "use_card",
							func = "can_reserve_card",
						},
						nodes = {
							{
								n = G.UIT.T,
								config = {
									text = localize("b_take"),
									colour = G.C.UI.TEXT_LIGHT,
									scale = 0.55,
									shadow = true,
								},
							},
						},
					},
				},
			}
		end
	end
	return G_UIDEF_use_and_sell_buttons_ref(card)
end