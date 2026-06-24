-- PAINEL ESP ULTRA ESTÁVEL PARA ARCEUS X
-- Desenvolvido para: Lucas Gustavo (Correção de Interface)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- Controle do Script
local EspAtivado = true

-- Limpeza de segurança
if PlayerGui:FindFirstChild("PainelLucasESP") then
    PlayerGui.PainelLucasESP:Destroy()
end

-- =========================================================
-- CRIAÇÃO DA INTERFACE GRÁFICA (UI SEGURA)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelLucasESP"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Quadro Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 220, 0, 110) -- Tamanho otimizado
MainFrame.Position = UDim2.new(0.5, -110, 0.3, -55)
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
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Lucas Gustavo"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.TextSize = 15
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Botão Fechar
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

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão Liga/Desliga o ESP (Garante renderização antes das funções)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -20, 0, 45)
ToggleBtn.Position = UDim2.new(0, 10, 0, 50)
ToggleBtn.Text = "ESP: ATIVADO"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Verde vibrante
ToggleBtn.TextSize = 14
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- =========================================================
-- LÓGICA DO ESP EM SEGUNDO PLANO (PROTEGIDA CONTRA ERROS)
-- =========================================================

local function LimparVisual(character)
    if character:FindFirstChild("ESPHighlight") then character.ESPHighlight:Destroy() end
    if character:FindFirstChild("Head") and character.Head:FindFirstChild("ESPTags") then
        character.Head.ESPTags:Destroy()
    end
end

local function CriarVisual(player)
    if player == LocalPlayer then return end

    local function LoopDeAtualizacao()
        while player and player.Parent and EspAtivado do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
                
                -- 1. Cria ou Mantém o Highlight (Raio-X)
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

                -- 2. Cria ou Mantém o Nome e Distância
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

                -- Atualiza a distância em metros
                local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local targetRoot = character.HumanoidRootPart
                if localRoot and targetRoot and billboard:FindFirstChild("InfoText") then
                    local dist = math.floor((localRoot.Position - targetRoot.Position).Magnitude)
                    billboard.InfoText.Text = player.DisplayName .. " [" .. dist .. "m]"
                end
            end
            task.wait(0.1) -- Loop leve para não dar lag no celular
        end
    end

    task.spawn(LoopDeAtualizacao)
end

-- Monitoramento seguro de players
local function AtivarParaJogador(player)
    if player.Character then CriarVisual(player) end
    player.CharacterAdded:Connect(function(char)
        task.wait(0.5)
        if EspAtivado then CriarVisual(player) end
    end)
end

-- Inicializa o ESP de forma segura
task.spawn(function()
    for _, p in pairs(Players:GetPlayers()) do AtivarParaJogador(p) end
    Players.PlayerAdded:Connect(AtivarParaJogador)
end)

-- Alternar o Botão Liga/Desliga
ToggleBtn.MouseButton1Click:Connect(function()
    EspAtivado = not EspAtivado
    if EspAtivado then
        ToggleBtn.Text = "ESP: ATIVADO"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        -- Força reativar para quem está no mapa
        for _, p in pairs(Players:GetPlayers()) do CriarVisual(p) end
    else
        ToggleBtn.Text = "ESP: DESATIVADO"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        -- Limpa o mapa imediatamente
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then LimparVisual(p.Character) end
        end
    end
end)
