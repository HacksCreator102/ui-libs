# ui-libs

# How to use Windows10 Message Pop Up?
In this readme u wil find all ui libs that I collected!
```lua
local Message = loadstring(game:Httpget("https://raw.githubusercontent.com/HacksCreator102/ui-libs/refs/heads/main/src.lua"))()

Message:Windows10("Title", "Text", function(response)
    if response == "Yes" then
        print("User confirmed deletion.")
    elseif response == "No" then
        print("User canceled.")
    end
end)
```
# How to use Windows 7 Message Pop up
```lua
local Message = loadstring(game:Httpget("https://raw.githubusercontent.com/HacksCreator102/ui-libs/refs/heads/main/src.lua"))()

Message:Windows7("Confirm", "Do you want to proceed?", function(response)
	if response == "Yes" then
		print("User chose YES")
	else
		print("User chose NO")
	end
end)
```
