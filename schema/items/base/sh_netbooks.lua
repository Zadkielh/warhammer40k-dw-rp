ITEM.name = "40k Book Base"
ITEM.desc = "A book."
ITEM.category = "literature"
ITEM.model = "models/props/prop_book.mdl"
ITEM.contents = ""
ITEM.functions.Read = {
	onClick = function(item)
		local frame = vgui.Create("DFrame")
		frame:SetSize(540, 680)
		frame:SetTitle(item.name)
		frame:MakePopup()
		frame:Center()

		frame.html = frame:Add("DHTML")
		frame.html:Dock(FILL)
		frame.html:OpenURL( item.url )
	end,
	onRun = function(item)
		return false
	end,
	icon = "icon16/book_open.png"
}
ITEM.permit = "lit"