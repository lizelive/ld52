commoditymarket.register_market("market", {
	description = "Market",
	currency = {["default:dirt"] = 1},
	inventory_limit = 1000,
	sell_limit = 100,
	allow_item = function(item) return true end,
	anonymous = true
})
