--// JW SYSTEM - CODE SNIPER (Selector UI: 1-9 | Detección interna flexible hasta 17)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
while not player do
	task.wait(0.1)
	player = Players.LocalPlayer
end

local playerGui = player:WaitForChild("PlayerGui", 5)
if not playerGui then return end

if playerGui:FindFirstChild("JWSystem") then
	playerGui.JWSystem:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "JWSystem"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

local _k1 = string.char(67, 102, 103)
local _k2 = string.char(95, 55, 102)
local _k3 = string.char(75, 50, 57, 109, 81)
local _k4 = string.char(52, 120, 76, 56, 112, 78)
local _k5 = string.char(54, 118, 82, 51, 116, 90, 49)
local function _getRealKey() return _k1 .. _k2 .. _k3 .. _k4 .. _k5 end

local _fakeKeys = {
	[string.char(75, 69, 89, 95, 70, 82, 69, 69)] = true,
	[string.char(67, 70, 71, 95, 66, 89, 80, 65, 83, 83)] = true,
	[string.char(74, 87, 95, 83, 69, 67, 82, 69, 87)] = true,
	[string.char(84, 82, 65, 70, 65, 95, 75, 69, 89)] = true,
	[string.char(69, 88, 80, 76, 79, 105, 84, 95, 75, 69, 89)] = true
}

local sniperActivo = false
local autoSubmitActivo = true
local partesTotales = 4 
local parteActual = 0
local codigoAcumulado = ""
local _capturedParts = {}
local _seen = {}
local isExecuting = false
local intentosRestantes = 3

local vecesEnvioLoop = 1
local velocidadDelay = 0.0 -- Ajustado a 0.0 tal como pediste para ejecución instantánea
local codeIsTriggered = false

local Net = ReplicatedStorage:WaitForChild("Packages", 5) and ReplicatedStorage.Packages:FindFirstChild("Net")
local getupvalues = (debug and debug.getupvalues) or getupvalues
local getconns = getconnections or (debug and debug.getconnections)
local setupv = (debug and debug.setupvalue) or setupvalue
local setclip = setclipboard or toclipboard or syn_io_clipboard or (Clipboard and Clipboard.set)
local REDEEM_GUID = "7d14a912-1040-4867-b005-98838eb9acc4"
local RedeemRemote

-- Pantalla de Carga Inicial
local background = Instance.new("Frame")
background.Size = UDim2.fromScale(1, 1)
background.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
background.BorderSizePixel = 0
background.Parent = gui

local container = Instance.new("Frame")
container.AnchorPoint = Vector2.new(0.5, 0.5)
container.Position = UDim2.fromScale(0.5, 0.43)
container.Size = UDim2.fromScale(0.8, 0.4)
container.BackgroundTransparency = 1
container.Parent = background

local J = Instance.new("TextLabel")
J.AnchorPoint = Vector2.new(0.5, 0.5)
J.Position = UDim2.fromScale(-0.15, 0.5)
J.Size = UDim2.fromScale(0.25, 0.7)
J.BackgroundTransparency = 1
J.Text = "J"
J.TextColor3 = Color3.fromRGB(12, 12, 12)
J.TextStrokeColor3 = Color3.fromRGB(100, 100, 100)
J.TextStrokeTransparency = 0
J.Font = Enum.Font.GothamBlack
J.TextScaled = true
J.Parent = container

local stars = Instance.new("TextLabel")
stars.AnchorPoint = Vector2.new(0.5, 0.5)
stars.Position = UDim2.fromScale(-0.15, 0.5)
stars.Size = UDim2.fromScale(0.25, 0.7)
stars.BackgroundTransparency = 1
stars.Text = "✦  ✧\n  ✦\n✧    ✦"
stars.TextColor3 = Color3.fromRGB(235, 235, 235)
stars.Font = Enum.Font.GothamBold
stars.TextScaled = true
stars.ZIndex = 2
stars.Parent = container

local W = Instance.new("TextLabel")
W.AnchorPoint = Vector2.new(0.5, 0.5)
W.Position = UDim2.fromScale(1.15, 0.5)
W.Size = UDim2.fromScale(0.3, 0.7)
W.BackgroundTransparency = 1
W.Text = "W"
W.TextColor3 = Color3.fromRGB(255, 70, 10)
W.TextStrokeColor3 = Color3.fromRGB(130, 20, 0)
W.TextStrokeTransparency = 0
W.Font = Enum.Font.GothamBlack
W.TextScaled = true
W.Parent = container

local lava = Instance.new("TextLabel")
lava.AnchorPoint = Vector2.new(0.5, 0.5)
lava.Position = UDim2.fromScale(1.15, 0.5)
lava.Size = UDim2.fromScale(0.3, 0.7)
lava.BackgroundTransparency = 1
lava.Text = "≈ ≈ ≈"
lava.TextColor3 = Color3.fromRGB(255, 180, 20)
lava.Font = Enum.Font.GothamBlack
lava.TextScaled = true
lava.ZIndex = 2
lava.Parent = container

local welcome = Instance.new("TextLabel")
welcome.AnchorPoint = Vector2.new(0.5, 0.5)
welcome.Position = UDim2.fromScale(0.5, 0.78)
welcome.Size = UDim2.fromScale(0.8, 0.08)
welcome.BackgroundTransparency = 1
welcome.Text = "Bienvenido a JW, los primos inseparables"
welcome.TextColor3 = Color3.fromRGB(235, 235, 235)
welcome.TextTransparency = 1
welcome.Font = Enum.Font.GothamMedium
welcome.TextScaled = true
welcome.Parent = background

local loading = Instance.new("TextLabel")
loading.AnchorPoint = Vector2.new(0.5, 0.5)
loading.Position = UDim2.fromScale(0.5, 0.5)
loading.Size = UDim2.fromScale(0.5, 0.1)
loading.BackgroundTransparency = 1
loading.Text = "LOADING..."
loading.TextColor3 = Color3.fromRGB(235, 235, 235)
loading.TextTransparency = 1
loading.Font = Enum.Font.GothamBold
loading.TextScaled = true
loading.Parent = background

local introInfo = TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
TweenService:Create(J, introInfo, {Position = UDim2.fromScale(0.43, 0.5)}):Play()
TweenService:Create(stars, introInfo, {Position = UDim2.fromScale(0.43, 0.5)}):Play()
TweenService:Create(W, introInfo, {Position = UDim2.fromScale(0.57, 0.5)}):Play()
TweenService:Create(lava, introInfo, {Position = UDim2.fromScale(0.57, 0.5)}):Play()

task.wait(1.5)
local originalSize = container.Size
local pulse = TweenService:Create(container, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0.84, 0.42)})
pulse:Play()
pulse.Completed:Wait()
TweenService:Create(container, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {Size = originalSize}):Play()
task.wait(0.25)
TweenService:Create(welcome, TweenInfo.new(0.7, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
task.wait(2)

local disappearInfo = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
for _, obj in ipairs({J, W, stars, lava, welcome}) do
	TweenService:Create(obj, disappearInfo, {TextTransparency = 1}):Play()
end

task.wait(0.65)
container.Visible = false
welcome.Visible = false
loading.Visible = true
TweenService:Create(loading, TweenInfo.new(0.45, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
task.wait(1.5)
TweenService:Create(loading, TweenInfo.new(0.45, Enum.EasingStyle.Quad), {TextTransparency = 1}):Play()
task.wait(0.5)

background:Destroy()

-- KeySystem Frame
local keyMainFrame = Instance.new("Frame")
keyMainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
keyMainFrame.Position = UDim2.fromScale(0.5, 0.5)
keyMainFrame.Size = UDim2.fromOffset(340, 210)
keyMainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
keyMainFrame.BorderSizePixel = 0
keyMainFrame.BackgroundTransparency = 1
keyMainFrame.Parent = gui

local kmCorner = Instance.new("UICorner")
kmCorner.CornerRadius = UDim.new(0, 12)
kmCorner.Parent = keyMainFrame

local kmStroke = Instance.new("UIStroke")
kmStroke.Color = Color3.fromRGB(255, 60, 60)
kmStroke.Thickness = 2
kmStroke.Parent = keyMainFrame

TweenService:Create(keyMainFrame, TweenInfo.new(0.4), {BackgroundTransparency = 0}):Play()
task.wait(0.4)

local keyTitle = Instance.new("TextLabel")
keyTitle.Position = UDim2.new(0, 20, 0, 18)
keyTitle.Size = UDim2.new(1, -40, 0, 25)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "JW Sniper Keysystem"
keyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTitle.Font = Enum.Font.GothamBold
keyTitle.TextSize = 14
keyTitle.TextXAlignment = Enum.TextXAlignment.Left
keyTitle.Parent = keyMainFrame

local attemptsLabel = Instance.new("TextLabel")
attemptsLabel.Position = UDim2.new(0, 20, 0, 42)
attemptsLabel.Size = UDim2.new(1, -40, 0, 20)
attemptsLabel.BackgroundTransparency = 1
attemptsLabel.Text = "Intentos restantes: 3"
attemptsLabel.TextColor3 = Color3.fromRGB(200, 100, 100)
attemptsLabel.Font = Enum.Font.GothamMedium
attemptsLabel.TextSize = 11
attemptsLabel.TextXAlignment = Enum.TextXAlignment.Left
attemptsLabel.Parent = keyMainFrame

local keyBox = Instance.new("TextBox")
keyBox.Position = UDim2.new(0, 20, 0, 70)
keyBox.Size = UDim2.new(1, -40, 0, 42)
keyBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
keyBox.BorderSizePixel = 0
keyBox.Text = ""
keyBox.PlaceholderText = "Pega tu Key aquí..."
keyBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.GothamMedium
keyBox.TextSize = 13
keyBox.Parent = keyMainFrame

local kbCorner = Instance.new("UICorner")
kbCorner.CornerRadius = UDim.new(0, 8)
kbCorner.Parent = keyBox

local submitKeyBtn = Instance.new("TextButton")
submitKeyBtn.Position = UDim2.new(0, 20, 0, 130)
submitKeyBtn.Size = UDim2.new(0, 140, 0, 38)
submitKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
submitKeyBtn.Text = "Verificar Key"
submitKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitKeyBtn.Font = Enum.Font.GothamBold
submitKeyBtn.TextSize = 12
submitKeyBtn.Parent = keyMainFrame

local skCorner = Instance.new("UICorner")
skCorner.CornerRadius = UDim.new(0, 8)
skCorner.Parent = submitKeyBtn

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Position = UDim2.new(0, 175, 0, 130)
getKeyBtn.Size = UDim2.new(0, 145, 0, 38)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
getKeyBtn.Text = "Obtener Key"
getKeyBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 12
getKeyBtn.Parent = keyMainFrame

local gkCorner = Instance.new("UICorner")
gkCorner.CornerRadius = UDim.new(0, 8)
gkCorner.Parent = getKeyBtn

getKeyBtn.MouseButton1Click:Connect(function()
	if setclip then
		pcall(function() setclip("https://linkvertise.com/placeholder-jw-key") end)
		getKeyBtn.Text = "¡Link Copiado!"
		task.wait(1.5)
		getKeyBtn.Text = "Obtener Key"
	end
end)

-- Main Interface Frame
local mainFrame = Instance.new("Frame")
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.Position = UDim2.fromScale(0.5, 0.5)
mainFrame.Size = UDim2.fromOffset(320, 400)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.1
mainFrame.Visible = false
mainFrame.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 10)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 60, 60)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 35)
topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame

local dragging, dragInput, dragStart, startPos
topBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

topBar.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 10)
topCorner.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.Size = UDim2.new(0.7, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "  JW CODE SNIPER"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 25)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local mainToggleBtn = Instance.new("TextButton")
mainToggleBtn.AnchorPoint = Vector2.new(1, 0.5)
mainToggleBtn.Position = UDim2.new(0.95, 0, 0.5, 0)
mainToggleBtn.Size = UDim2.fromOffset(36, 18)
mainToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
mainToggleBtn.Text = ""
mainToggleBtn.Parent = topBar

local mtCorner = Instance.new("UICorner")
mtCorner.CornerRadius = UDim.new(1, 0)
mtCorner.Parent = mainToggleBtn

local mtCircle = Instance.new("Frame")
mtCircle.AnchorPoint = Vector2.new(0, 0.5)
mtCircle.Position = UDim2.new(0, 2, 0.5, 0)
mtCircle.Size = UDim2.fromOffset(14, 14)
mtCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mtCircle.Parent = mainToggleBtn

local mtcCorner = Instance.new("UICorner")
mtcCorner.CornerRadius = UDim.new(1, 0)
mtcCorner.Parent = mtCircle

-- Botones de Pestañas
local TabMain = Instance.new("TextButton")
TabMain.Name = "TabMain"
TabMain.Parent = mainFrame
TabMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabMain.Position = UDim2.new(0.05, 0, 0, 45)
TabMain.Size = UDim2.new(0, 130, 0, 28)
TabMain.Font = Enum.Font.SourceSansBold
TabMain.Text = "MAIN"
TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMain.TextSize = 14

local tmCorner = Instance.new("UICorner")
tmCorner.CornerRadius = UDim.new(0, 6)
tmCorner.Parent = TabMain

local TabConfig = Instance.new("TextButton")
TabConfig.Name = "TabConfig"
TabConfig.Parent = mainFrame
TabConfig.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabConfig.Position = UDim2.new(0.52, 0, 0, 45)
TabConfig.Size = UDim2.new(0, 130, 0, 28)
TabConfig.Font = Enum.Font.SourceSansBold
TabConfig.Text = "CONFIGURACIÓN"
TabConfig.TextColor3 = Color3.fromRGB(180, 180, 180)
TabConfig.TextSize = 14

local tcCorner = Instance.new("UICorner")
tcCorner.CornerRadius = UDim.new(0, 6)
tcCorner.Parent = TabConfig

-- Contenedor MAIN
local ContainerMain = Instance.new("ScrollingFrame")
ContainerMain.Name = "ContainerMain"
ContainerMain.Parent = mainFrame
ContainerMain.BackgroundTransparency = 1
ContainerMain.Position = UDim2.new(0, 0, 0, 85)
ContainerMain.Size = UDim2.new(1, 0, 1, -90)
ContainerMain.CanvasSize = UDim2.new(0, 0, 0, 350)
ContainerMain.ScrollBarThickness = 3
ContainerMain.Visible = true

-- Contenedor CONFIGURACIÓN
local ContainerConfig = Instance.new("ScrollingFrame")
ContainerConfig.Name = "ContainerConfig"
ContainerConfig.Parent = mainFrame
ContainerConfig.BackgroundTransparency = 1
ContainerConfig.Position = UDim2.new(0, 0, 0, 85)
ContainerConfig.Size = UDim2.new(1, 0, 1, -90)
ContainerConfig.CanvasSize = UDim2.new(0, 0, 0, 350)
ContainerConfig.ScrollBarThickness = 3
ContainerConfig.Visible = false

-- Consola de Estado
local consoleLog = Instance.new("TextLabel")
consoleLog.Position = UDim2.new(0, 15, 0, 218)
consoleLog.Size = UDim2.new(1, -30, 0, 120)
consoleLog.BackgroundTransparency = 1
consoleLog.Text = string.format("[Estado] Esperando 'Code is'...\nProgreso: 0 / %d\nCódigo: [Vacío]", partesTotales)
consoleLog.TextColor3 = Color3.fromRGB(100, 220, 255)
consoleLog.Font = Enum.Font.Code
consoleLog.TextSize = 11
consoleLog.TextXAlignment = Enum.TextXAlignment.Left
consoleLog.TextYAlignment = Enum.TextYAlignment.Top
consoleLog.TextWrapped = true
consoleLog.Parent = ContainerMain

local function createToggle(parentFrame, nameText, posY, callback)
	local bg = Instance.new("Frame")
	bg.Position = UDim2.new(0, 15, 0, posY)
	bg.Size = UDim2.new(1, -30, 0, 36)
	bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	bg.Parent = parentFrame
	
	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 6)
	bgCorner.Parent = bg
	
	local label = Instance.new("TextLabel")
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Size = UDim2.new(0.65, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = nameText
	label.TextColor3 = Color3.fromRGB(210, 210, 210)
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = bg
	
	local btn = Instance.new("TextButton")
	btn.AnchorPoint = Vector2.new(1, 0.5)
	btn.Position = UDim2.new(0.95, 0, 0.5, 0)
	btn.Size = UDim2.fromOffset(36, 18)
	btn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
	btn.Text = ""
	btn.Parent = bg
	
	local bCorner = Instance.new("UICorner")
	bCorner.CornerRadius = UDim.new(1, 0)
	bCorner.Parent = btn
	
	local circle = Instance.new("Frame")
	circle.AnchorPoint = Vector2.new(0, 0.5)
	circle.Position = UDim2.new(1, -16, 0.5, 0)
	circle.Size = UDim2.fromOffset(14, 14)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.Parent = btn
	
	local cCorner = Instance.new("UICorner")
	cCorner.CornerRadius = UDim.new(1, 0)
	cCorner.Parent = circle
	
	local active = true
	btn.MouseButton1Click:Connect(function()
		active = not active
		if active then
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 200, 50)}):Play()
			TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, 0)}):Play()
		else
			TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
			TweenService:Create(circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
		end
		if callback then callback(active) end
	end)
end

local function createRiddleSolverDisabled(parentFrame, posY)
	local bg = Instance.new("Frame")
	bg.Position = UDim2.new(0, 15, 0, posY)
	bg.Size = UDim2.new(1, -30, 0, 36)
	bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	bg.Parent = parentFrame
	
	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 6)
	bgCorner.Parent = bg
	
	local label = Instance.new("TextLabel")
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = "Riddle solver"
	label.TextColor3 = Color3.fromRGB(210, 210, 210)
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = bg
	
	local soonLabel = Instance.new("TextLabel")
	soonLabel.AnchorPoint = Vector2.new(1, 0.5)
	soonLabel.Position = UDim2.new(0.95, 0, 0.5, 0)
	soonLabel.Size = UDim2.new(0.4, 0, 1, 0)
	soonLabel.BackgroundTransparency = 1
	soonLabel.Text = "Próximamente"
	soonLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
	soonLabel.Font = Enum.Font.GothamBold
	soonLabel.TextSize = 11
	soonLabel.TextXAlignment = Enum.TextXAlignment.Right
	soonLabel.Parent = bg
end

local function createCounter(parentFrame, nameText, posY, initialVal, minVal, maxVal, callback)
	local bg = Instance.new("Frame")
	bg.Position = UDim2.new(0, 15, 0, posY)
	bg.Size = UDim2.new(1, -30, 0, 36)
	bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	bg.Parent = parentFrame
	
	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 6)
	bgCorner.Parent = bg
	
	local label = Instance.new("TextLabel")
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = nameText
	label.TextColor3 = Color3.fromRGB(210, 210, 210)
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = bg
	
	local val = initialVal
	local minusBtn = Instance.new("TextButton")
	minusBtn.AnchorPoint = Vector2.new(1, 0.5)
	minusBtn.Position = UDim2.new(0.72, 0, 0.5, 0)
	minusBtn.Size = UDim2.fromOffset(22, 22)
	minusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	minusBtn.Text = "-"
	minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	minusBtn.Font = Enum.Font.GothamBold
	minusBtn.TextSize = 12
	minusBtn.Parent = bg
	
	local mCorner = Instance.new("UICorner")
	mCorner.CornerRadius = UDim.new(0, 4)
	mCorner.Parent = minusBtn
	
	local valLabel = Instance.new("TextLabel")
	valLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	valLabel.Position = UDim2.new(0.81, 0, 0.5, 0)
	valLabel.Size = UDim2.fromOffset(25, 22)
	valLabel.BackgroundTransparency = 1
	valLabel.Text = tostring(val)
	valLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	valLabel.Font = Enum.Font.GothamBold
	valLabel.TextSize = 12
	valLabel.Parent = bg
	
	local plusBtn = Instance.new("TextButton")
	plusBtn.AnchorPoint = Vector2.new(0, 0.5)
	plusBtn.Position = UDim2.new(0.9, 0, 0.5, 0)
	plusBtn.Size = UDim2.fromOffset(22, 22)
	plusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	plusBtn.Text = "+"
	plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	plusBtn.Font = Enum.Font.GothamBold
	plusBtn.TextSize = 12
	plusBtn.Parent = bg
	
	local pCorner = Instance.new("UICorner")
	pCorner.CornerRadius = UDim.new(0, 4)
	pCorner.Parent = plusBtn
	
	minusBtn.MouseButton1Click:Connect(function()
		if val > minVal then
			val = val - 1
			valLabel.Text = tostring(val)
			if callback then callback(val) end
		end
	end)
	
	plusBtn.MouseButton1Click:Connect(function()
		if val < maxVal then
			val = val + 1
			valLabel.Text = tostring(val)
			if callback then callback(val) end
		end
	end)
end

createToggle(ContainerMain, "Auto submit", 0, function(state) autoSubmitActivo = state end)
createRiddleSolverDisabled(ContainerMain, 44)
createCounter(ContainerMain, "Digitos de código (1-9)", 88, 4, 1, 9, function(num) partesTotales = num end)
createToggle(ContainerMain, "Retype invalid", 132, function(state) end)

local resetBtnBg = Instance.new("Frame")
resetBtnBg.Position = UDim2.new(0, 15, 0, 175)
resetBtnBg.Size = UDim2.new(1, -30, 0, 32)
resetBtnBg.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
resetBtnBg.Parent = ContainerMain

local rbCorner = Instance.new("UICorner")
rbCorner.CornerRadius = UDim.new(0, 6)
rbCorner.Parent = resetBtnBg

local resetTriggerBtn = Instance.new("TextButton")
resetTriggerBtn.Size = UDim2.fromScale(1, 1)
resetTriggerBtn.BackgroundTransparency = 1
resetTriggerBtn.Text = "Restablecer Progreso (0/N)"
resetTriggerBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
resetTriggerBtn.Font = Enum.Font.GothamBold
resetTriggerBtn.TextSize = 11
resetTriggerBtn.Parent = resetBtnBg

local rejoinBtnBg = Instance.new("Frame")
rejoinBtnBg.Position = UDim2.new(0, 15, 0, 10)
rejoinBtnBg.Size = UDim2.new(1, -30, 0, 35)
rejoinBtnBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
rejoinBtnBg.Parent = ContainerConfig

local rjCorner = Instance.new("UICorner")
rjCorner.CornerRadius = UDim.new(0, 6)
rjCorner.Parent = rejoinBtnBg

local rejoinTriggerBtn = Instance.new("TextButton")
rejoinTriggerBtn.Size = UDim2.fromScale(1, 1)
rejoinTriggerBtn.BackgroundTransparency = 1
rejoinTriggerBtn.Text = "Rejoin (Reiniciar Servidor)"
rejoinTriggerBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
rejoinTriggerBtn.Font = Enum.Font.GothamBold
rejoinTriggerBtn.TextSize = 12
rejoinTriggerBtn.Parent = rejoinBtnBg

rejoinTriggerBtn.MouseButton1Click:Connect(function()
	consoleLog.Text = "[Estado] Reiniciando servidor..."
	pcall(function()
		TeleportService:Teleport(game.PlaceId, player)
	end)
end)

local NotaLabel = Instance.new("TextLabel")
NotaLabel.Parent = ContainerConfig
NotaLabel.BackgroundTransparency = 1
NotaLabel.Position = UDim2.new(0, 15, 0, 52)
NotaLabel.Size = UDim2.new(1, -30, 0, 60)
NotaLabel.Font = Enum.Font.SourceSans
NotaLabel.Text = "NOTA: El Rejoin sirve, porque al poner el código, la barra se cacha por la velocidad. Por favor reiniciar después de usar para que le funcione. Muchas gracias."
NotaLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
NotaLabel.TextSize = 11
NotaLabel.TextWrapped = true

local function createConfigNumberControl(parentFrame, nameText, posY, initialVal, step, isFloat, callback)
	local bg = Instance.new("Frame")
	bg.Position = UDim2.new(0, 15, 0, posY)
	bg.Size = UDim2.new(1, -30, 0, 38)
	bg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	bg.Parent = parentFrame
	
	local bgCorner = Instance.new("UICorner")
	bgCorner.CornerRadius = UDim.new(0, 6)
	bgCorner.Parent = bg
	
	local label = Instance.new("TextLabel")
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Size = UDim2.new(0.5, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = nameText
	label.TextColor3 = Color3.fromRGB(210, 210, 210)
	label.Font = Enum.Font.GothamMedium
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = bg
	
	local val = initialVal
	local minusBtn = Instance.new("TextButton")
	minusBtn.AnchorPoint = Vector2.new(1, 0.5)
	minusBtn.Position = UDim2.new(0.70, 0, 0.5, 0)
	minusBtn.Size = UDim2.fromOffset(22, 22)
	minusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	minusBtn.Text = "-"
	minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	minusBtn.Font = Enum.Font.GothamBold
	minusBtn.TextSize = 12
	minusBtn.Parent = bg
	
	local mCorner = Instance.new("UICorner")
	mCorner.CornerRadius = UDim.new(0, 4)
	mCorner.Parent = minusBtn
	
	local valLabel = Instance.new("TextLabel")
	valLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	valLabel.Position = UDim2.new(0.81, 0, 0.5, 0)
	valLabel.Size = UDim2.fromOffset(35, 22)
	valLabel.BackgroundTransparency = 1
	valLabel.Text = isFloat and string.format("%.1f", val) or tostring(val)
	valLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	valLabel.Font = Enum.Font.GothamBold
	valLabel.TextSize = 12
	valLabel.Parent = bg
	
	local plusBtn = Instance.new("TextButton")
	plusBtn.AnchorPoint = Vector2.new(0, 0.5)
	plusBtn.Position = UDim2.new(0.9, 0, 0.5, 0)
	plusBtn.Size = UDim2.fromOffset(22, 22)
	plusBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	plusBtn.Text = "+"
	plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	plusBtn.Font = Enum.Font.GothamBold
	plusBtn.TextSize = 12
	plusBtn.Parent = bg
	
	local pCorner = Instance.new("UICorner")
	pCorner.CornerRadius = UDim.new(0, 4)
	pCorner.Parent = plusBtn
	
	minusBtn.MouseButton1Click:Connect(function()
		local limit = isFloat and 0.0 or 1
		if val - step >= limit then
			val = val - step
			if isFloat then
				val = math.floor(val * 10 + 0.5) / 10
				valLabel.Text = string.format("%.1f", val)
			else
				valLabel.Text = tostring(val)
			end
			if callback then callback(val) end
		end
	end)
	
	plusBtn.MouseButton1Click:Connect(function()
		val = val + step
		if isFloat then
			val = math.floor(val * 10 + 0.5) / 10
			valLabel.Text = string.format("%.1f", val)
		else
			valLabel.Text = tostring(val)
		end
		if callback then callback(val) end
	end)
end

createConfigNumberControl(ContainerConfig, "Veces de envío (Loop)", 125, 1, 1, false, function(num)
	vecesEnvioLoop = num
end)

createConfigNumberControl(ContainerConfig, "Velocidad (Delay en s)", 175, 0.0, 0.1, true, function(num)
	velocidadDelay = num
end)

TabMain.MouseButton1Click:Connect(function()
	ContainerMain.Visible = true
	ContainerConfig.Visible = false
	TabMain.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabConfig.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TabConfig.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

TabConfig.MouseButton1Click:Connect(function()
	ContainerMain.Visible = false
	ContainerConfig.Visible = true
	TabConfig.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	TabConfig.TextColor3 = Color3.fromRGB(255, 255, 255)
	TabMain.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	TabMain.TextColor3 = Color3.fromRGB(180, 180, 180)
end)

local function aceCodeBox()
	local guiCodes = playerGui:FindFirstChild("Codes") or playerGui:FindFirstChild("CodeGui")
	if guiCodes then
		for _, obj in ipairs(guiCodes:GetDescendants()) do
			if obj:IsA("TextBox") then return obj end
		end
	end
	for _, obj in ipairs(playerGui:GetDescendants()) do
		if obj:IsA("TextBox") and not obj:IsDescendantOf(gui) and obj.Name:lower():find("code") then
			return obj
		end
	end
	for _, obj in ipairs(playerGui:GetDescendants()) do
		if obj:IsA("TextBox") and not obj:IsDescendantOf(gui) and obj.Parent.Name:lower():find("chat") == nil then
			return obj
		end
	end
	return nil
end

resetTriggerBtn.MouseButton1Click:Connect(function()
	_capturedParts = {}
	parteActual = 0
	codigoAcumulado = ""
	isExecuting = false
	codeIsTriggered = false
	local box = aceCodeBox()
	if box then box.Text = "" end
	consoleLog.Text = string.format("[Estado] RESTABLECIDO\nProgreso: 0 / %d\nCódigo: [Vacío]", partesTotales)
end)

mainToggleBtn.MouseButton1Click:Connect(function()
	sniperActivo = not sniperActivo
	if sniperActivo then
		TweenService:Create(mainToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 200, 50)}):Play()
		TweenService:Create(mtCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -16, 0.5, 0)}):Play()
		consoleLog.Text = string.format("[Estado] ACTIVO\nProgreso: %d / %d\nCódigo: %s", parteActual, partesTotales, codigoAcumulado ~= "" and codigoAcumulado or "[Vacío]")
	else
		TweenService:Create(mainToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
		TweenService:Create(mtCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, 0)}):Play()
		consoleLog.Text = string.format("[Estado] APAGADO")
	end
end)

submitKeyBtn.MouseButton1Click:Connect(function()
	local userInputKey = keyBox.Text
	local realKey = _getRealKey()
	
	if userInputKey == realKey then
		submitKeyBtn.Text = "¡Key Válida!"
		task.wait(0.5)
		
		TweenService:Create(kmStroke, TweenInfo.new(0.4), {Transparency = 1}):Play()
		TweenService:Create(keyMainFrame, TweenInfo.new(0.4), {Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1}):Play()
		task.wait(0.4)
		keyMainFrame:Destroy()
		
		mainFrame.Visible = true
		mainFrame.Size = UDim2.fromOffset(0, 0)
		mainFrame.BackgroundTransparency = 1
		TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(320, 400),
			BackgroundTransparency = 0.1
		}):Play()
	elseif _fakeKeys[userInputKey] then
		intentosRestantes = 0
		attemptsLabel.Text = "Acceso denegado."
		submitKeyBtn.Active = false
		submitKeyBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
		submitKeyBtn.Text = "Error"
		keyBox.Text = "Acceso denegado"
		keyBox.Editable = false
	else
		intentosRestantes = intentosRestantes - 1
		if intentosRestantes > 0 then
			attemptsLabel.Text = "Intentos restantes: " .. tostring(intentosRestantes)
			submitKeyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
			submitKeyBtn.Text = "Key Incorrecta"
			task.wait(1.2)
			submitKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
			submitKeyBtn.Text = "Verificar Key"
		else
			attemptsLabel.Text = "BLOQUEADO (Demasiados intentos)"
			submitKeyBtn.Active = false
			submitKeyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			submitKeyBtn.Text = "Bloqueado"
			keyBox.Text = "Reinicia el script"
			keyBox.Editable = false
		end
	end
end)

local function resolveAceRedeemRemote()
	if RedeemRemote and RedeemRemote.Parent then return RedeemRemote end
	if not Net then return nil end
	local ok, api = pcall(require, Net)
	if ok and type(api) == "table" then
		local rok, rf = pcall(function() return api:RemoteFunction(REDEEM_GUID) end)
		if rok and typeof(rf) == "Instance" then RedeemRemote = rf end
	end
	return RedeemRemote
end

local function killAceDebounce(fn)
	if not (fn and setupv and getupvalues) then return end
	local ok, ups = pcall(getupvalues, fn)
	if ok and type(ups) == "table" then
		for i, v in pairs(ups) do if type(v) == "boolean" then pcall(setupv, fn, i, false) end end
	end
end

local function aceRedeemViaBox(code)
	if not getconns then return false, "no getconnections" end
	local box = aceCodeBox()
	if not box then return false, "no codebox" end
	local ok, conns = pcall(getconns, box.FocusLost)
	if not ok or type(conns) ~= "table" or #conns == 0 then return false, "no connection" end
	local fired = false
	for _, c in ipairs(conns) do
		local fn; pcall(function() fn = c.Function end)
		killAceDebounce(fn)
		box.Text = code
		box.Active = true
		box.Selectable = true
		local fok = pcall(function() if c.Enabled ~= false then c:Fire(true) end end)
		fired = fired or fok
	end
	return fired, fired and "sent" or "fire failed"
end

local function aceRedeemViaRemote(code)
	local rf = resolveAceRedeemRemote()
	if not rf then return false, "no remote" end
	local ok, result = pcall(function() return rf:InvokeServer(code) end)
	if not ok then return false, tostring(result) end
	return true, result
end

local function aceRedeem(code)
	local ok, res = aceRedeemViaRemote(code)
	if ok then return true, res end
	return aceRedeemViaBox(code)
end

local function enviarAlJuego(codigoFinal)
	if not sniperActivo or isExecuting then return end
	if not codigoFinal or codigoFinal == "" then return end
	
	isExecuting = true
	consoleLog.Text = string.format("[ENVIANDO CÓDIGO] -> %s", codigoFinal)

	if not autoSubmitActivo then 
		isExecuting = false
		return 
	end

	task.spawn(function()
		for i = 1, vecesEnvioLoop do
			if velocidadDelay > 0 then
				task.wait(velocidadDelay)
			end
			
			local cajaEncontrada = aceCodeBox()
			if cajaEncontrada then 
				cajaEncontrada.Text = codigoFinal 
			end

			aceRedeem(codigoFinal)
		end

		task.wait(0.5)
		isExecuting = false
		
		_capturedParts = {}
		parteActual = 0
		codigoAcumulado = ""
		codeIsTriggered = false
		
		consoleLog.Text = string.format("[ESTADO] Esperando 'Code is'...\nProgreso: 0 / %d\nCódigo: [Vacío]", partesTotales)
	end)
end

local function procesarFragmentoTexto(fragmento)
	if not sniperActivo or not fragmento or fragmento == "" then return end

	table.insert(_capturedParts, fragmento)
	parteActual = #_capturedParts
	codigoAcumulado = table.concat(_capturedParts)

	if setclip then
		pcall(function() setclip(codigoAcumulado) end)
	end

	local box = aceCodeBox()
	if box then
		box.Text = codigoAcumulado
		pcall(function()
			box.CursorPosition = #codigoAcumulado + 1
			box.SelectionStart = #codigoAcumulado + 1
		end)
	end

	consoleLog.Text = string.format("Progreso: %d / %d\nFragmento: %s\nCódigo: %s", parteActual, partesTotales, fragmento, codigoAcumulado)

	if parteActual >= partesTotales then
		local codigoFinalCopia = codigoAcumulado
		enviarAlJuego(codigoFinalCopia)
	end
end

local function esFragmentoValido(texto)
	if #texto > 17 or #texto < 1 then return false end 
	if texto:find(" ") then return false end 
	local lower = texto:lower()
	
	if not codeIsTriggered then
		if lower == "hola" or lower == "gg" or lower == "pvp" or lower == "trade" or lower == "yes" or lower == "no" or lower == "code" or lower == "is" or lower == "hello" then
			return false
		end
	end
	
	return true
end

local ACE_POSITIONS = { Top = true, Bottom = true, Center = true, Middle = true, Left = true, Right = true }

local function isAceAnnouncement(...)
	local args = table.pack(...)
	if args.n == 0 or typeof(args[1]) ~= "string" then return false end
	for index = 2, args.n do
		local value = args[index]
		if typeof(value) == "string" and (value:find("Sounds%.") or value:find("rbxassetid") or ACE_POSITIONS[value]) then
			return true
		end
	end
	return false
end

local function aceStripRich(text)
	if type(text) ~= "string" then return tostring(text) end
	return (text:gsub("<[^>]->", ""))
end

local function aceTokenize(text)
	local words = {}
	for word in text:gmatch("[%w_]+") do
		words[#words + 1] = word
	end
	return words
end

local function verificarYProcesarTextoCompleto(textoLimpio)
	if not sniperActivo then return end

	local textoLower = textoLimpio:lower()

	if textoLower:find("code is%.") or textoLower:find("codigo es%.") or textoLower:find("codeis%.") or 
	   textoLower:find("code is%.%.") or textoLower:find("codigo es%.%.") or textoLower:find("codeis%.%.") or
	   textoLower:find("code is…") or textoLower:find("codigo es…") or textoLower:find("codeis…") or
	   textoLower:find("code is") or textoLower:find("codigo es") or textoLower:find("codeis") then
		if not codeIsTriggered then
			codeIsTriggered = true
			consoleLog.Text = "[Estado] ¡'Code is' detectado! Desbloqueado y capturando..."
		end
		return
	end

	if codeIsTriggered then
		for _, word in ipairs(aceTokenize(textoLimpio)) do
			if esFragmentoValido(word) and not _seen[word] then
				_seen[word] = true
				task.delay(1.5, function() _seen[word] = nil end)
				procesarFragmentoTexto(word)
			end
		end
	end
end

local function aceRemotesFromFunction(fn)
	if not getupvalues then return {} end
	local ok, values = pcall(getupvalues, fn)
	local remotes = {}
	if ok and type(values) == "table" then
		for _, value in pairs(values) do
			if typeof(value) == "Instance" and (value:IsA("RemoteEvent") or value:IsA("RemoteFunction")) and (Net and value.Parent == Net) then
				table.insert(remotes, value)
			end
		end
	end
	return remotes
end

local function resolveAceNotifyRemote()
	local ok, controller = pcall(function()
		return require(ReplicatedStorage.Controllers:FindFirstChild("NotificationController", true))
	end)
	if ok and type(controller) == "table" and type(controller.Start) == "function" then
		local remotes = aceRemotesFromFunction(controller.Start)
		if #remotes > 0 then return remotes[1] end
	end
    return nil
end

task.spawn(function()
	pcall(function()
		local aceNotifyRemote = resolveAceNotifyRemote()
		if aceNotifyRemote then
			aceNotifyRemote.OnClientEvent:Connect(function(...)
				if not sniperActivo or not isAceAnnouncement(...) then return end
				pcall(function(...)
					local text = aceStripRich(tostring((...) or "")):match("^%s*(.-)%s*$") or ""
					verificarYProcesarTextoCompleto(text)
				end, ...)
			end)
		end
	end)

	pcall(function()
		TextChatService.MessageReceived:Connect(function(textChatMessage)
			if sniperActivo and textChatMessage and textChatMessage.Text then
				local limpio = aceStripRich(textChatMessage.Text):match("^%s*(.-)%s*$")
				verificarYProcesarTextoCompleto(limpio)
			end
		end)
	end)

	pcall(function()
		local chatEvents = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
		if chatEvents then
			local onMessageDoneFiltering = chatEvents:FindFirstChild("OnMessageDoneFiltering")
			if onMessageDoneFiltering then
				onMessageDoneFiltering.OnClientEvent:Connect(function(messageData)
					if sniperActivo and messageData and messageData.Message then
						local limpio = aceStripRich(messageData.Message):match("^%s*(.-)%s*$")
						verificarYProcesarTextoCompleto(limpio)
					end
				end)
			end
		end
	end)
end)
