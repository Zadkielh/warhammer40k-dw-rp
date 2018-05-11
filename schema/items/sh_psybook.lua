ITEM.name = "Psykana Occultis"
ITEM.desc = "Increases Psyniscience."
ITEM.price = 10
ITEM.model = "models/hpwrewrite/books/book1.mdl"
ITEM.category = "Other"
ITEM.functions.Read = {
	sound = "items/medshot4.wav",
	onRun = function(item)
		item.player:getChar():updateAttrib("psy", 10)
	end,
	icon = "icon16/book_open.png"
}