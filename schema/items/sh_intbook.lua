ITEM.name = "Book of Five Spheres"
ITEM.desc = "Increases Intelligence"
ITEM.price = 5
ITEM.model = "models/hpwrewrite/books/book1.mdl"
ITEM.category = "Other"
ITEM.functions.Read = {
	sound = "items/medshot4.wav",
	onRun = function(item)
		item.player:getChar():updateAttrib("intelligence", 10)
	end,
	icon = "icon16/book_open.png"
}