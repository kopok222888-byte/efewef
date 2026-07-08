-- Создаём основной экран
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BeautifulUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Главное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Скругление углов
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Тень
local shadow = Instance.new("Shadow")
shadow.Size = UDim.new(1, 10)
shadow.Position = UDim.new(0, 0, 0, 10)
shadow.Color = Color3.fromRGB(0, 0, 0)
shadow.Transparency = 0.5
shadow.Parent = mainFrame

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "UI Library Test"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Контейнер для элементов (скролл, если нужно)
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -60)
scroll.Position = UDim2.new(0, 10, 0, 50)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 110)
scroll.Parent = mainFrame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Top
layout.Parent = scroll

-- === КНОПКА ===
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 200, 0, 40)
btn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
btn.BorderSizePixel = 0
btn.Text = "Нажми меня"
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextSize = 18
btn.Font = Enum.Font.GothamSemibold
btn.Parent = scroll

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = btn

-- Анимация наведения
btn.MouseEnter:Connect(function()
	btn.BackgroundColor3 = Color3.fromRGB(90, 150, 255)
end)
btn.MouseLeave:Connect(function()
	btn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
end)
btn.MouseButton1Click:Connect(function()
	print("Кнопка нажата! Тест пройден.")
end)

-- === ПОЛЗУНОК ===
local sliderContainer = Instance.new("Frame")
sliderContainer.Size = UDim2.new(0, 200, 0, 50)
sliderContainer.BackgroundTransparency = 1
sliderContainer.Parent = scroll

local sliderLabel = Instance.new("TextLabel")
sliderLabel.Size = UDim2.new(0, 100, 0, 20)
sliderLabel.Position = UDim2.new(0, 0, 0, 0)
sliderLabel.BackgroundTransparency = 1
sliderLabel.Text = "Значение: 50"
sliderLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
sliderLabel.TextSize = 14
sliderLabel.Font = Enum.Font.Gotham
sliderLabel.Parent = sliderContainer

local slider = Instance.new("Frame")
slider.Size = UDim2.new(0, 180, 0, 6)
slider.Position = UDim2.new(0, 10, 0, 25)
slider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
slider.BorderSizePixel = 0
slider.Parent = sliderContainer

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 3)
sliderCorner.Parent = slider

local fill = Instance.new("Frame")
fill.Size = UDim2.new(0.5, 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
fill.BorderSizePixel = 0
fill.Parent = slider
local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim.new(0, 3)
fillCorner.Parent = fill

local thumb = Instance.new("TextButton")
thumb.Size = UDim2.new(0, 18, 0, 18)
thumb.Position = UDim2.new(0.5, -9, 0.5, -9)
thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
thumb.BorderSizePixel = 0
thumb.Text = ""
thumb.Parent = slider
local thumbCorner = Instance.new("UICorner")
thumbCorner.CornerRadius = UDim.new(0, 9)
thumbCorner.Parent = thumb

-- Логика ползунка (простейшая)
local function updateSlider(input)
	local relX = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
	fill.Size = UDim2.new(relX, 0, 1, 0)
	thumb.Position = UDim2.new(relX, -9, 0.5, -9)
	local val = math.round(relX * 100)
	sliderLabel.Text = "Значение: " .. val
end

thumb.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		updateSlider(input)
		local connection
		connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				updateSlider(input)
			end
		end)
		input:GetPropertyChangedSignal("UserInputState"):Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()
			end
		end)
	end
end)

-- === ПЕРЕКЛЮЧАТЕЛЬ (TOGGLE) ===
local toggleContainer = Instance.new("Frame")
toggleContainer.Size = UDim2.new(0, 200, 0, 40)
toggleContainer.BackgroundTransparency = 1
toggleContainer.Parent = scroll

local toggleLabel = Instance.new("TextLabel")
toggleLabel.Size = UDim2.new(0, 100, 0, 30)
toggleLabel.Position = UDim2.new(0, 0, 0, 5)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "Toggle"
toggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
toggleLabel.TextSize = 16
toggleLabel.Font = Enum.Font.Gotham
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
toggleLabel.Parent = toggleContainer

local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 50, 0, 28)
toggleBtn.Position = UDim2.new(0, 150, 0, 6)
toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
toggleBtn.BorderSizePixel = 0
toggleBtn.Text = ""
toggleBtn.Parent = toggleContainer
local toggleBtnCorner = Instance.new("UICorner")
toggleBtnCorner.CornerRadius = UDim.new(0, 14)
toggleBtnCorner.Parent = toggleBtn

local toggleIndicator = Instance.new("Frame")
toggleIndicator.Size = UDim2.new(0, 22, 0, 22)
toggleIndicator.Position = UDim2.new(0, 2, 0, 3)
toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleIndicator.BorderSizePixel = 0
toggleIndicator.Parent = toggleBtn
local toggleIndCorner = Instance.new("UICorner")
toggleIndCorner.CornerRadius = UDim.new(0, 11)
toggleIndCorner.Parent = toggleIndicator

local toggleState = false
toggleBtn.MouseButton1Click:Connect(function()
	toggleState = not toggleState
	if toggleState then
		toggleBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 255)
		toggleIndicator.Position = UDim2.new(0, 26, 0, 3)
	else
		toggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
		toggleIndicator.Position = UDim2.new(0, 2, 0, 3)
	end
	print("Toggle state:", toggleState)
end)

-- === ТЕКСТОВОЕ ПОЛЕ ===
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 35)
textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
textBox.BorderSizePixel = 0
textBox.Text = "Введите текст..."
textBox.TextColor3 = Color3.fromRGB(200, 200, 200)
textBox.TextSize = 16
textBox.Font = Enum.Font.Gotham
textBox.ClearTextOnFocus = false
textBox.Parent = scroll
local tbCorner = Instance.new("UICorner")
tbCorner.CornerRadius = UDim.new(0, 6)
tbCorner.Parent = textBox

textBox.Focused:Connect(function()
	if textBox.Text == "Введите текст..." then textBox.Text = "" end
end)
textBox.FocusLost:Connect(function()
	if textBox.Text == "" then textBox.Text = "Введите текст..." end
	print("Введено:", textBox.Text)
end)

-- === ВЫПАДАЮЩИЙ СПИСОК ===
local dropdownContainer = Instance.new("Frame")
dropdownContainer.Size = UDim2.new(0, 200, 0, 40)
dropdownContainer.BackgroundTransparency = 1
dropdownContainer.Parent = scroll

local dropdownBtn = Instance.new("TextButton")
dropdownBtn.Size = UDim2.new(1, 0, 0, 35)
dropdownBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 58)
dropdownBtn.BorderSizePixel = 0
dropdownBtn.Text = "Выберите опцию"
dropdownBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
dropdownBtn.TextSize = 16
dropdownBtn.Font = Enum.Font.Gotham
dropdownBtn.Parent = dropdownContainer
local ddCorner = Instance.new("UICorner")
ddCorner.CornerRadius = UDim.new(0, 6)
ddCorner.Parent = dropdownBtn

local dropdownList = Instance.new("Frame")
dropdownList.Size = UDim2.new(1, 0, 0, 0)
dropdownList.Position = UDim2.new(0, 0, 0, 35)
dropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
dropdownList.BorderSizePixel = 0
dropdownList.ClipsDescendants = true
dropdownList.Visible = false
dropdownList.Parent = dropdownContainer
local ddListCorner = Instance.new("UICorner")
ddListCorner.CornerRadius = UDim.new(0, 6)
ddListCorner.Parent = dropdownList

local options = {"Опция 1", "Опция 2", "Опция 3"}
local ddLayout = Instance.new("UIListLayout")
ddLayout.Padding = UDim.new(0, 4)
ddLayout.Parent = dropdownList

for _, opt in ipairs(options) do
	local optBtn = Instance.new("TextButton")
	optBtn.Size = UDim2.new(1, 0, 0, 30)
	optBtn.BackgroundTransparency = 1
	optBtn.Text = opt
	optBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
	optBtn.TextSize = 14
	optBtn.Font = Enum.Font.Gotham
	optBtn.Parent = dropdownList
	optBtn.MouseEnter:Connect(function()
		optBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
	end)
	optBtn.MouseLeave:Connect(function()
		optBtn.BackgroundTransparency = 1
	end)
	optBtn.MouseButton1Click:Connect(function()
		dropdownBtn.Text = opt
		dropdownList.Visible = false
		dropdownList.Size = UDim2.new(1, 0, 0, 0)
		print("Выбрано:", opt)
	end)
end

dropdownBtn.MouseButton1Click:Connect(function()
	dropdownList.Visible = not dropdownList.Visible
	if dropdownList.Visible then
		local count = #dropdownList:GetChildren() - 1 -- минус UIListLayout
		dropdownList.Size = UDim2.new(1, 0, 0, count * 34 + 4)
	else
		dropdownList.Size = UDim2.new(1, 0, 0, 0)
	end
end)

-- Адаптация размера скролла под содержимое
layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
end)