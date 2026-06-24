-- PAINEL COMPLETO: ESP + AIMBOT COM FOV + MINIMIZAR
-- Desenvolvido para: Lucas Gustavo

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Controles de Ativação
local EspAtivado = true
local AimbotAtivado = false
local FovRaio = 100 -- Tamanho do círculo de mira no meio da tela

-- Limpeza de segurança
if PlayerGui:FindFirstChild("PainelLucasCompleto") then
    PlayerGui.PainelLucasCompleto:Destroy()
end

-- =========================================================
-- INTERFACE GRÁFICA (UI COM MINIMIZAR)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelLucasCompleto"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Quadro Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 220, 0, 190)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, -95)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Topo do Painel
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Lucas Gustavo"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Botão Minimizar (-)
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinBtn

-- Botão Fechar (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

-- Botão abrir quando minimizado (Fica flutuando discreto)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 40, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -20)
OpenBtn.Text = "L"
OpenBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.TextSize = 18
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 20)
OpenCorner.Parent = OpenBtn

-- Botão Liga/Desliga ESP
local ToggleEspBtn = Instance.new("TextButton")
ToggleEspBtn.Size = UDim2.new(1, -20, 0, 40)
ToggleEspBtn.Position = UDim2.new(0, 10, 0, 50)
ToggleEspBtn.Text = "ESP: ATIVADO"
ToggleEspBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ToggleEspBtn.TextSize = 14
ToggleEspBtn.Font = Enum.Font.SourceSansBold
ToggleEspBtn.Parent = MainFrame

local EspCorner = Instance.new("UICorner")
EspCorner.CornerRadius = UDim.new(0, 6)
EspCorner.Parent = ToggleEspBtn

-- Botão Liga/Desliga AIMBOT
local ToggleAimBtn = Instance.new("TextButton")
ToggleAimBtn.Size = UDim2.new(1, -20, 0, 40)
ToggleAimBtn.Position = UDim2.new(0, 10, 0, 100)
ToggleAimBtn.Text = "AIMBOT: DESATIVADO"
ToggleAimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleAimBtn.TextSize = 14
ToggleAimBtn.Font = Enum.Font.SourceSansBold
ToggleAimBtn.Parent = MainFrame

local AimCorner = Instance.new("UICorner")
AimCorner.CornerRadius = UDim.new(0, 6)
AimCorner.Parent = ToggleAimBtn

-- Círculo Visual do FOV no centro da tela
local FovFrame = Instance.new("Frame")
FovFrame.Size = UDim2.new(0, FovRaio * 2, 0, FovRaio * 2)
FovFrame.Position = UDim2.new(0.5, -FovRaio, 0.5, -FovRaio)
FovFrame.BackgroundTransparency = 1
FovFrame.Visible = false
FovFrame.Parent = ScreenGui

local FovStroke = Instance.new("UIStroke")
FovStroke.Color = Color3.fromRGB(255, 255, 255)
FovStroke.Thickness = 1
FovStroke.Transparency = 0.5
FovStroke.Parent = FovFrame

local FovCorner = Instance.new("UICorner")
FovCorner.CornerRadius = UDim.new(1, 0) -- Transforma o quadrado em círculo completo
FovCorner.Parent = FovFrame

-- Lógica de Minimizar
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- =========================================================
-- LÓGICA DO ESP (RAIO-X, NOME E DISTÂNCIA)
-- =========================================================
local function LimparVisual(character)
    if character:FindFirstChild("ESPHighlight") then character.ESPHighlight:Destroy() end
    if character:FindFirstChild("Head") and character.Head:FindFirstChild("ESPTags") then
        character.Head.ESPTags:Destroy()
    end
end

local function CriarVisual(player)
    if player == LocalPlayer then return end
    task.spawn(function()
        while player and player.Parent and EspAtivado do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
                
                local highlight = character:FindFirstChild("ESPHighlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "ESPHighlight"
                    highlight.FillColor = Color3.fromRGB(255, 140, 0)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.Parent = character
                end

                local head = character.Head
                local billboard = head:FindFirstChild("ESPTags")
                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "ESPTags"
                    billboard.Size = UDim2.new(0, 150, 0, 40)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Parent = head

                    local textLabel = Instance.new("TextLabel")
                    textLabel.Name = "InfoText"
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextSize = 13
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextStrokeTransparency = 0
                    textLabel.Parent = billboard
                end

                local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetRoot = character.HumanoidRootPart
                if localRoot and targetRoot and billboard:FindFirstChild("InfoText") then
                    local dist = math.floor((localRoot.Position - targetRoot.Position).Magnitude)
                    billboard.InfoText.Text = player.DisplayName .. " [" .. dist .. "m]"
                end
            end
            task.wait(0.1)
        end
    end)
end

-- =========================================================
-- LÓGICA DO AIMBOT COM CÁLCULO DE CÍRCULO FOV
-- =========================================================
local function ObterJogadorMaisProximoDoCentro()
    local alvoMaisProximo = nil
    local menorDistanciaTela = FovRaio

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") then
            -- Verifica se o inimigo está vivo
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                -- Converte a posição 3D da cabeça do alvo para a posição 2D da tela do celular
                local posicaoTela, visivel naTela = Camera:WorldToViewportPoint(player.Character.Head.Position)
                
                if visivel then
                    -- Calcula a distância entre o centro da tela e o jogador inimigo
                    local centroTela = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local distanciaDoCentro = (Vector2.new(posicaoTela.X, posicaoTela.Y) - centroTela).Magnitude
                    
                    -- Se estiver dentro do raio do círculo (FOV) e for o mais perto do meio
                    if distanciaDoCentro < menorDistanciaTela then
                        menorDistanciaTela = distanciaDoCentro
                        alvoMaisProximo = player.Character.Head
                    end
                end
            end
        end
    end
    return alvoMaisProximo
end

-- Loop de execução contínua do Aimbot
RunService.RenderStepped:Connect(function()
    if AimbotAtivado then
        local alvo = ObterJogadorMaisProximoDoCentro()
        if alvo then
            -- Suaviza e aponta a câmera do jogo diretamente para a cabeça do alvo interno do círculo
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.Position)
        end
    end
end)

-- =========================================================
-- FUNÇÕES DOS BOTÕES DE COUTROLE
-- =========================================================
ToggleEspBtn.MouseButton1Click:Connect(function()
    EspAtivado = not EspAtivado
    if EspAtivado then
        ToggleEspBtn.Text = "ESP: ATIVADO"
        ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        for _, p in pairs(Players:GetPlayers()) do CriarVisual(p) end
    else
        ToggleEspBtn.Text = "ESP: DESATIVADO"
        ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then LimparVisual(p.Character) end
        end
    end
end)

ToggleAimBtn.MouseButton1Click:Connect(function()
    AimbotAtivado = not AimbotAtivado
    if AimbotAtivado then
        ToggleAimBtn.Text = "AIMBOT: ATIVADO"
        ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        FovFrame.Visible = true -- Mostra o círculo na tela
    else
        ToggleAimBtn.Text = "AIMBOT: DESATIVADO"
        ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        FovFrame.Visible = false -- Esconde o círculo
    end
end)

-- Iniciar monitoramento inicial de players para o ESP
for _, p in pairs(Players:GetPlayers()) do CriarVisual(p) end
Players.PlayerAdded:Connect(CriarVisual)
