local Message = {}

function Message:Windows10(titleText, bodyText, callback)
    local player = game.Players.LocalPlayer
    local TweenService = game:GetService("TweenService")
    local PlayerGui = player:WaitForChild("PlayerGui")
    
    -- Ensure the dialog doesn't already exist
    if PlayerGui:FindFirstChild("MainWindow") then
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainWindow"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = screenGui
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.Size = UDim2.new(0, 258, 0, 163)
    MainFrame.BackgroundColor3 = Color3.fromRGB(136, 136, 136)
    MainFrame.BackgroundTransparency = 0
    MainFrame.ClipsDescendants = true

    local UIScale = Instance.new("UIScale", MainFrame)
    UIScale.Scale = 0

    -- Animation: open
    TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale = 1}):Play()

    local BoxTitle = Instance.new("Frame")
    BoxTitle.Name = "Box-Title"
    BoxTitle.Parent = MainFrame
    BoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BoxTitle.Size = UDim2.new(1, 0, 0, 30)

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "TitleLabel"
    TitleLabel.Parent = BoxTitle
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 5, 0, 0)
    TitleLabel.Size = UDim2.new(1, -35, 0, 30)
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Text = titleText
    TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.TextSize = 18
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = BoxTitle
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -30, 0, 0)
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.SourceSansBold
    CloseButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 80, 80)
    CloseButton.BorderSizePixel = 0

    local Frame = Instance.new("Frame")
    Frame.Parent = MainFrame
    Frame.BackgroundColor3 = Color3.fromRGB(196, 196, 196)
    Frame.BorderSizePixel = 0
    Frame.Position = UDim2.new(0, 0, 0.184, 0)
    Frame.Size = UDim2.new(1, 0, 0, 95)

    local Text = Instance.new("TextLabel")
    Text.Name = "Text"
    Text.Parent = Frame
    Text.BackgroundTransparency = 1
    Text.Position = UDim2.new(0, 5, 0, 5)
    Text.Size = UDim2.new(1, -10, 1, -10)
    Text.Font = Enum.Font.SourceSansBold
    Text.Text = bodyText
    Text.TextColor3 = Color3.fromRGB(0, 0, 0)
    Text.TextSize = 18
    Text.TextWrapped = true
    Text.TextXAlignment = Enum.TextXAlignment.Left
    Text.TextYAlignment = Enum.TextYAlignment.Top

    local ContentLayout = Instance.new("Frame")
    ContentLayout.Name = "ContentLayout"
    ContentLayout.Parent = MainFrame
    ContentLayout.BackgroundTransparency = 1
    ContentLayout.Position = UDim2.new(0, 0, 1, -35)
    ContentLayout.Size = UDim2.new(1, 0, 0, 35)

    local function createButton(name, pos)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = ContentLayout
        btn.Position = pos
        btn.Size = UDim2.new(0, 100, 0, 30)
        btn.Font = Enum.Font.SourceSansBold
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.BorderSizePixel = 0
        btn.TextSize = 18
        return btn
    end

    local YesBtn = createButton("Yes", UDim2.new(0, 20, 0, 2))
    local NoBtn = createButton("No", UDim2.new(1, -120, 0, 2))

    local function closeUI(response)
        if callback then callback(response) end
        local tween = TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0})
        tween:Play()
        tween.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end

    YesBtn.MouseButton1Click:Connect(function() closeUI("Yes") end)
    NoBtn.MouseButton1Click:Connect(function() closeUI("No") end)
    CloseButton.MouseButton1Click:Connect(function() closeUI("Closed") end)

    -- Drag
    local dragging, dragInput, dragStart, startPos
    local userInputService = game:GetService("UserInputService")

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    userInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)
end
function Message:Windows7(titleText, bodyText, callback)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "Windows7MsgBox"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = Player:WaitForChild("PlayerGui")

	local bg = Instance.new("Frame")
	bg.Name = "Bg"
	bg.Size = UDim2.new(0, 293, 0, 172)
	bg.Position = UDim2.new(0.364, 0, 0.333, 0)
	bg.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
	bg.BorderSizePixel = 0
	bg.Parent = screenGui

	local uiScale = Instance.new("UIScale", bg)

	local title = Instance.new("TextLabel")
	title.Name = "Title"
	title.Text = titleText or "Title"
	title.Font = Enum.Font.SourceSans
	title.TextSize = 14
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(0, 191, 0, 11)
	title.Position = UDim2.new(0.006, 0, 0.093, 0)
	title.Parent = bg

	local msgBox = Instance.new("Frame")
	msgBox.Name = "MsgBox"
	msgBox.Size = UDim2.new(0, 288, 0, 92)
	msgBox.Position = UDim2.new(0.007, 0, 0.229, 0)
	msgBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	msgBox.Parent = bg

	local msgText = Instance.new("TextLabel")
	msgText.Size = UDim2.new(0, 200, 0, 50)
	msgText.Position = UDim2.new(0.152, 0, 0.228, 0)
	msgText.Text = bodyText or "Your message here"
	msgText.TextColor3 = Color3.fromRGB(0, 0, 0)
	msgText.BackgroundTransparency = 1
	msgText.Font = Enum.Font.SourceSans
	msgText.TextSize = 14
	msgText.Parent = msgBox

	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 37, 0, 39)
	closeBtn.Position = UDim2.new(0.874, 0, 0, 0)
	closeBtn.Text = "X"
	closeBtn.Font = Enum.Font.SourceSans
	closeBtn.TextSize = 20
	closeBtn.BackgroundColor3 = Color3.fromRGB(178, 0, 0)
	closeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	closeBtn.Parent = bg

	local buttons = Instance.new("Frame")
	buttons.Size = UDim2.new(0, 288, 0, 34)
	buttons.Position = UDim2.new(0.007, 0, 0.767, 0)
	buttons.BackgroundColor3 = Color3.fromRGB(204, 204, 204)
	buttons.Parent = bg

	local view = Instance.new("Frame")
	view.Name = "ButtonsView"
	view.Size = UDim2.new(0, 165, 0, 34)
	view.Position = UDim2.new(0.426, 0, -0.002, 0)
	view.BackgroundColor3 = Color3.fromRGB(204, 204, 204)
	view.Parent = buttons

	local listLayout = Instance.new("UIListLayout", view)
	listLayout.FillDirection = Enum.FillDirection.Horizontal
	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
	listLayout.Padding = UDim.new(0, 5)

	local padding = Instance.new("UIPadding", view)
	padding.PaddingTop = UDim.new(0, 4)
	padding.PaddingBottom = UDim.new(0, 2)

	local function createBtn(text)
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 68, 0, 23)
		frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

		local btn = Instance.new("TextButton", frame)
		btn.Size = UDim2.new(1, 0, 1, 0)
		btn.Text = text
		btn.Font = Enum.Font.SourceSans
		btn.TextSize = 14
		btn.TextColor3 = Color3.fromRGB(0, 0, 0)
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

		frame.Parent = view

		return btn
	end

	local yesBtn = createBtn("Yes")
	local noBtn = createBtn("No")

	local function closeMessage()
		local tween = TweenService:Create(uiScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0})
		tween:Play()
		tween.Completed:Wait()
		screenGui:Destroy()
	end

	yesBtn.MouseButton1Click:Connect(function()
		if callback then callback("Yes") end
		closeMessage()
	end)

	noBtn.MouseButton1Click:Connect(function()
		if callback then callback("No") end
		closeMessage()
	end)

	closeBtn.MouseButton1Click:Connect(function()
		if callback then callback("No") end
		closeMessage()
	end)
end

return Message
