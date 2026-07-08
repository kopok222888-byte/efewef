-- UILib.lua
local UILib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local function create(className, properties)
    local instance = Instance.new(className)
    for prop, value in pairs(properties or {}) do
        instance[prop] = value
    end
    return instance
end

function UILib:CreateWindow(config)
    config = config or {}
    local title = config.Title or "Menu"
    local font = config.Font or Enum.Font.SourceSans
    local accent = config.Accent or Color3.fromRGB(65, 130, 255)

    local gui = create("ScreenGui", {
        Name = title,
        Parent = (config.Parent or Players.LocalPlayer:WaitForChild("PlayerGui"))
    })

    local mainFrame = create("Frame", {
        Name = "Main",
        Size = UDim2.new(0, 540, 0, 340),
        Position = UDim2.new(0.5, -270, 0.5, -170),
        BackgroundColor3 = Color3.fromRGB(25, 25, 25),
        BorderSizePixel = 0,
        Parent = gui
    })
    local corner = create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = mainFrame})

    local topBar = create("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = topBar})
    create("Frame", {
        Name = "BottomLine",
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Parent = topBar
    })

    local titleLabel = create("TextLabel", {
        Name = "Title",
        Text = title,
        FontFace = Font.new(font.Name, Enum.FontWeight.Bold),
        TextSize = 16,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 1, 0),
        Position = UDim2.new(0, 12, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = topBar
    })

    local tabContainer = create("Frame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 130, 1, -36),
        Position = UDim2.new(0, 0, 0, 36),
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        BorderSizePixel = 0,
        Parent = mainFrame
    })
    create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = tabContainer})
    local tabList = create("UIListLayout", {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 4),
        Parent = tabContainer
    })
    create("UIPadding", {PaddingTop = UDim.new(0, 8), Parent = tabContainer})

    local contentArea = create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -130, 1, -36),
        Position = UDim2.new(0, 130, 0, 36),
        BackgroundTransparency = 1,
        Parent = mainFrame
    })

    local tabs = {}
    local currentTab = nil

    local function switchTab(tab)
        if currentTab then
            currentTab.button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            currentTab.frame.Visible = false
        end
        currentTab = tab
        tab.button.BackgroundColor3 = accent
        tab.frame.Visible = true
    end

    function UILib:CreateTab(name, iconId)
        local tabFrame = create("Frame", {
            Name = name .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = contentArea
        })
        local scroll = create("ScrollingFrame", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = accent,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Parent = tabFrame
        })
        local list = create("UIListLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8),
            Parent = scroll
        })
        create("UIPadding", {PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12), Parent = scroll})

        local tabButton = create("TextButton", {
            Name = name,
            Text = "",
            FontFace = Font.new(font.Name, Enum.FontWeight.SemiBold),
            TextSize = 14,
            TextColor3 = Color3.fromRGB(240, 240, 240),
            BackgroundColor3 = Color3.fromRGB(35, 35, 35),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -12, 0, 32),
            Position = UDim2.new(0, 0, 0, 0),
            Parent = tabContainer
        })
        local btnCorner = create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = tabButton})

        if iconId then
            local icon = create("ImageLabel", {
                Image = "rbxassetid://" .. tostring(iconId),
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(0, 8, 0.5, -10),
                BackgroundTransparency = 1,
                Parent = tabButton
            })
            local textLabel = create("TextLabel", {
                Text = name,
                FontFace = Font.new(font.Name, Enum.FontWeight.SemiBold),
                TextSize = 14,
                TextColor3 = Color3.fromRGB(240, 240, 240),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -36, 1, 0),
                Position = UDim2.new(0, 32, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = tabButton
            })
        else
            local textOnly = create("TextLabel", {
                Text = name,
                FontFace = Font.new(font.Name, Enum.FontWeight.SemiBold),
                TextSize = 14,
                TextColor3 = Color3.fromRGB(240, 240, 240),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -12, 1, 0),
                Position = UDim2.new(0, 6, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = tabButton
            })
        end

        local tabData = {button = tabButton, frame = tabFrame, scroll = scroll, list = list}
        table.insert(tabs, tabData)

        tabButton.MouseButton1Click:Connect(function()
            switchTab(tabData)
        end)

        if #tabs == 1 then
            switchTab(tabData)
        end

        return {
            AddButton = function(self, text, callback)
                local btn = create("TextButton", {
                    Text = text,
                    FontFace = Font.new(font.Name, Enum.FontWeight.SemiBold),
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = accent,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, -24, 0, 36),
                    Parent = scroll
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btn})
                btn.MouseButton1Click:Connect(callback)
                scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
                return btn
            end,
            AddSlider = function(self, text, min, max, default, callback)
                local frame = create("Frame", {
                    Size = UDim2.new(1, -24, 0, 50),
                    BackgroundTransparency = 1,
                    Parent = scroll
                })
                local label = create("TextLabel", {
                    Text = text .. ": " .. tostring(default),
                    FontFace = Font.new(font.Name, Enum.FontWeight.Regular),
                    TextSize = 13,
                    TextColor3 = Color3.fromRGB(200, 200, 200),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = frame
                })
                local sliderFrame = create("Frame", {
                    Size = UDim2.new(1, 0, 0, 20),
                    Position = UDim2.new(0, 0, 0, 24),
                    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                    BorderSizePixel = 0,
                    Parent = frame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = sliderFrame})
                local fill = create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = accent,
                    BorderSizePixel = 0,
                    Parent = sliderFrame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 4), Parent = fill})
                local knob = create("TextButton", {
                    Text = "",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7),
                    BorderSizePixel = 0,
                    Parent = sliderFrame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 7), Parent = knob})

                local dragging = false
                knob.MouseButton1Down:Connect(function()
                    dragging = true
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local pos = math.clamp((input.Position.X - sliderFrame.AbsolutePosition.X) / sliderFrame.AbsoluteSize.X, 0, 1)
                        local val = math.floor(min + (max - min) * pos)
                        fill.Size = UDim2.new(pos, 0, 1, 0)
                        knob.Position = UDim2.new(pos, -7, 0.5, -7)
                        label.Text = text .. ": " .. tostring(val)
                        callback(val)
                    end
                end)
                scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
                return frame
            end,
            AddToggle = function(self, text, default, callback)
                local frame = create("Frame", {
                    Size = UDim2.new(1, -24, 0, 36),
                    BackgroundTransparency = 1,
                    Parent = scroll
                })
                local label = create("TextLabel", {
                    Text = text,
                    FontFace = Font.new(font.Name, Enum.FontWeight.Regular),
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, -44, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = frame
                })
                local toggleFrame = create("Frame", {
                    Size = UDim2.new(0, 36, 0, 20),
                    Position = UDim2.new(1, -36, 0.5, -10),
                    BackgroundColor3 = default and accent or Color3.fromRGB(70, 70, 70),
                    BorderSizePixel = 0,
                    Parent = frame
                })
                local toggleCorner = create("UICorner", {CornerRadius = UDim.new(0, 10), Parent = toggleFrame})
                local dot = create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = toggleFrame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 8), Parent = dot})
                local state = default
                toggleFrame.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        state = not state
                        TweenService:Create(dot, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
                        toggleFrame.BackgroundColor3 = state and accent or Color3.fromRGB(70, 70, 70)
                        callback(state)
                    end
                end)
                scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
                return frame
            end,
            AddDropdown = function(self, text, options, callback)
                local frame = create("Frame", {
                    Size = UDim2.new(1, -24, 0, 40),
                    BackgroundTransparency = 1,
                    Parent = scroll
                })
                local label = create("TextButton", {
                    Text = text .. ": " .. (options[1] or ""),
                    FontFace = Font.new(font.Name, Enum.FontWeight.Regular),
                    TextSize = 14,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 36),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = frame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = label})
                local expanded = false
                local dropdownFrame = create("Frame", {
                    Size = UDim2.new(1, 0, 0, #options * 30),
                    Position = UDim2.new(0, 0, 1, 4),
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    BorderSizePixel = 0,
                    Visible = false,
                    Parent = frame
                })
                create("UICorner", {CornerRadius = UDim.new(0, 6), Parent = dropdownFrame})
                local dropList = create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Parent = dropdownFrame})
                for i, option in ipairs(options) do
                    local optBtn = create("TextButton", {
                        Text = option,
                        FontFace = Font.new(font.Name, Enum.FontWeight.Regular),
                        TextSize = 13,
                        TextColor3 = Color3.fromRGB(200, 200, 200),
                        BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 30),
                        Parent = dropdownFrame
                    })
                    optBtn.MouseButton1Click:Connect(function()
                        label.Text = text .. ": " .. option
                        dropdownFrame.Visible = false
                        expanded = false
                        callback(option)
                    end)
                end
                label.MouseButton1Click:Connect(function()
                    expanded = not expanded
                    dropdownFrame.Visible = expanded
                end)
                scroll.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y)
                return frame
            end,
        }
    end

    -- Insert hotkey toggle
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.Insert then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    return UILib
end

return UILib
