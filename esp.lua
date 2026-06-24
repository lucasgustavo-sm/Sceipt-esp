-- PAINEL ULTIMATE: ESP CORRIGIDO + AIMBOT + MINIMIZAR + FPS BOOST
-- Desenvolvido para: Lucas Gustavo

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Controles Globais
local EspAtivado = false
local AimbotAtivado = false
local FovRaio = 50 

-- Limpeza de segurança para não duplicar telas
if PlayerGui:FindFirstChild("PainelLucasCompleto") then 
    PlayerGui.PainelLucasCompleto:Destroy() 
end

-- =========================================================
-- INTERFACE GRÁFICA (UI NATIVA)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelLucasCompleto"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 240)
MainFrame.Position = UDim2.new(0.5, -110, 0.3, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Lucas Gustavo"
Title.TextColor3 = Color3.fromRGB(255, 140, 0)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 40, 0, 40)
OpenBtn.Position = UDim2.new(0, 10, 0.5, -20)
OpenBtn.Text = "L"
OpenBtn.TextColor3 = Color3.fromRGB(255, 140, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 18
OpenBtn.Visible = false
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 20)

-- Criador de Botões Dinâmicos
local function CriarBotao(texto, pos, cor)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = pos
    btn.Text = texto
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = cor
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local ToggleEspBtn = CriarBotao("ESP: ATIVADO", UDim2.new(0, 10, 0, 50), Color3.fromRGB(0, 150, 0))
local ToggleAimBtn = CriarBotao("AIMBOT: DESATIVADO", UDim2.new(0, 10, 0, 100), Color3.fromRGB(150, 0, 0))
local OptBtn = CriarBotao("OTIMIZAR FPS", UDim2.new(0, 10, 0, 150), Color3.fromRGB(0, 100, 200))

-- Círculo Visual do FOV para o Aimbot
local FovFrame = Instance.new("Frame")
FovFrame.Size = UDim2.new(0, FovRaio * 2, 0, FovRaio * 2)
FovFrame.Position = UDim2.new(0.5, -FovRaio, 0.5, -FovRaio)
FovFrame.BackgroundTransparency = 1
FovFrame.Visible = false
FovFrame.Parent = ScreenGui

local FovStroke = Instance.new("UIStroke", FovFrame)
FovStroke.Color = Color3.new(1, 1, 1)
FovStroke.Thickness = 1
FovStroke.Transparency = 0.5
Instance.new("UICorner", FovFrame).CornerRadius = UDim.new(1, 0)

-- Controles de Janela (Minimizar / Abrir / Fechar)
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- =========================================================
-- FUNÇÃO DO BOOSTER DE FPS
-- =========================================================
OptBtn.MouseButton1Click:Connect(function()
    local L = game:GetService("Lighting")
    L.GlobalShadows = false
    L.FogEnd = 9e9
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 end
    end
    OptBtn.Text = "JOGO OTIMIZADO!"
    OptBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

-- =========================================================
-- LÓGICA COMPLETA E CORRIGIDA DO ESP
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
        while player and player.Parent and player.Character do
            local character = player.Character
            
            -- Se o ESP global estiver desligado, limpa os efeitos e espera
            if not EspAtivado then
                LimparVisual(character)
                task.wait(0.5)
            else
                if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
                    -- 1. Cria/Mantém a Silhueta Laranja
                    local highlight = character:FindFirstChild("ESPHighlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
                        highlight.FillColor = Color3.fromRGB(255, 140, 0)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.new(1, 1, 1)
                        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        highlight.Parent = character
                    end

                    -- 2. Cria/Mantém as Tags de Distância e Nome
                    local head = character.Head
                    local billboard = head:FindFirstChild("ESPTags")
                    if not billboard then
                        billboard = Instance.new("BillboardGui")
                        billboard.Name = "ESPTags"
                        billboard.Size = UDim2.new(0, 150, 0, 40)
                        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Parent = head

                        local textLabel = Instance.new("TextLabel", billboard)
                        textLabel.Name = "InfoText"
                        textLabel.Size = UDim2.new(1, 0, 1, 0)
                        textLabel.BackgroundTransparency = 1
                        textLabel.TextColor3 = Color3.new(1, 1, 1)
                        textLabel.TextSize = 13
                        textLabel.Font = Enum.Font.SourceSansBold
                        textLabel.TextStrokeTransparency = 0
                    end

                    -- Atualização das métricas de distância
                    local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local targetRoot = character.HumanoidRootPart
                    if localRoot and targetRoot and billboard:FindFirstChild("InfoText") then
                        local dist = math.floor((localRoot.Position - targetRoot.Position).Magnitude)
                        billboard.InfoText.Text = player.DisplayName .. " [" .. dist .. "m]"
                    end
                end
                task.wait(0.1) -- Taxa estável de atualização
            end
        end
    end)
end

-- Gerenciamento de ativação do botão ESP
ToggleEspBtn.MouseButton1Click:Connect(function()
    EspAtivado = not EspAtivado
    if EspAtivado then
        ToggleEspBtn.Text = "ESP: ATIVADO"
        ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        -- Recria os efeitos para os jogadores atuais
        for _, p in pairs(Players:GetPlayers()) do CriarVisual(p) end
    else
        ToggleEspBtn.Text = "ESP: DESATIVADO"
        ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        -- Remove imediatamente os efeitos de todo mundo
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then LimparVisual(p.Character) end
        end
    end
end)

-- =========================================================
-- LÓGICA DO AIMBOT COM CÁLCULO DE FOV
-- =========================================================
local function ObterJogadorMaisProximo()
    local alvoMaisProximo = nil
    local menorDistanciaTela = FovRaio

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local posicaoTela, visivel = Camera:WorldToViewportPoint(player.Character.Head.Position)
                
                if visivel then
                    local centroTela = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    local distanciaDoCentro = (Vector2.new(posicaoTela.X, posicaoTela.Y) - centroTela).Magnitude
                    
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

RunService.RenderStepped:Connect(function()
    if AimbotAtivado then
        local alvo = ObterJogadorMaisProximo()
        if alvo then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.Position)
        end
    end
end)

ToggleAimBtn.MouseButton1Click:Connect(function()
    AimbotAtivado = not AimbotAtivado
    if AimbotAtivado then
        ToggleAimBtn.Text = "AIMBOT: ATIVADO"
        ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        FovFrame.Visible = true
    else
        ToggleAimBtn.Text = "AIMBOT: DESATIVADO"
        ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        FovFrame.Visible = false
    end
end)

-- Inicialização e conexões de entrada de jogadores
for _, p in pairs(Players:GetPlayers()) do
    if p.Character then CriarVisual(p) end
    p.CharacterAdded:Connect(function() task.wait(0.5); CriarVisual(p) end)
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() task.wait(0.5); CriarVisual(p) end)
end)
