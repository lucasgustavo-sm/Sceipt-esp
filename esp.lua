-- =========================================================
-- PAINEL ESP OFC V3: COMPLETO E CENTRALIZADO
-- Desenvolvido para: Lucas Gustavo
-- =========================================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

-- Configurações de funções
local EspAtivado = false       
local AimbotAtivado = false
local FovRaio = 50             

-- Limpeza para não duplicar telas
if PlayerGui:FindFirstChild("PainelEspOfc") then 
    PlayerGui.PainelEspOfc:Destroy() 
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelEspOfc"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false -- GARANTE QUE O PAINEL NÃO SUMA QUANDO VOCÊ MORRER

-- =========================================================
-- QUADRO PRINCIPAL (DESIGN PREMIUM ESP OFC)
-- =========================================================
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 250)
MainFrame.Position = UDim2.new(0.5, -115, 0.3, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 255, 255) -- Bordas Ciano Neon para o ESP OFC
MainStroke.Thickness = 1.5

-- Topo do Painel
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", TopBar)
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.Text = "ESP OFC"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1

-- Botão Minimizar (Voltando o Botão)
local MinBtn = Instance.new("TextButton", TopBar)
MinBtn.Size = UDim2.new(0, 24, 0, 24)
MinBtn.Position = UDim2.new(1, -62, 0, 7)
MinBtn.Text = "−"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)
local MinStroke = Instance.new("UIStroke", MinBtn)
MinStroke.Color = Color3.fromRGB(60, 60, 60)

-- Botão Fechar
local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Position = UDim2.new(1, -32, 0, 7)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
local CloseStroke = Instance.new("UIStroke", CloseBtn)
CloseStroke.Color = Color3.fromRGB(120, 40, 40)

-- Botão "L" Móvel e Centralizado
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0, 45, 0, 45)
OpenBtn.Position = UDim2.new(0.5, -22, 0.5, -22)
OpenBtn.Text = "L"
OpenBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
OpenBtn.Font = Enum.Font.GothamBold
OpenBtn.TextSize = 18
OpenBtn.Visible = false
OpenBtn.Active = true
OpenBtn.Draggable = true
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(0, 22)
local OpenStroke = Instance.new("UIStroke", OpenBtn)
OpenStroke.Color = Color3.fromRGB(0, 255, 255)
OpenStroke.Thickness = 2

-- Criador de Botões
local function CriarBotaoPremium(texto, pos, corFundo, corBorda)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(1, -24, 0, 38)
    btn.Position = pos
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(240, 240, 240)
    btn.BackgroundColor3 = corFundo
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = corBorda
    btnStroke.Thickness = 1
    
    return btn
end

local ToggleEspBtn = CriarBotaoPremium("ESP: DESATIVADO", UDim2.new(0, 12, 0, 55), Color3.fromRGB(25, 15, 15), Color3.fromRGB(150, 40, 40))
local ToggleAimBtn = CriarBotaoPremium("AIMBOT: DESATIVADO", UDim2.new(0, 12, 0, 105), Color3.fromRGB(25, 15, 15), Color3.fromRGB(150, 40, 40))
local OptBtn = CriarBotaoPremium("OTIMIZAR FPS", UDim2.new(0, 12, 0, 155), Color3.fromRGB(15, 25, 35), Color3.fromRGB(0, 120, 220))

-- =========================================================
-- CÍRCULO DO FOV (CORRIGIDO E SEPARADO)
-- =========================================================
local FovFrame = Instance.new("Frame")
FovFrame.Size = UDim2.new(0, FovRaio * 2, 0, FovRaio * 2)
FovFrame.BackgroundTransparency = 1
FovFrame.Visible = false
FovFrame.Parent = ScreenGui

local FovStroke = Instance.new("UIStroke", FovFrame)
FovStroke.Color = Color3.fromRGB(0, 255, 255)
FovStroke.Thickness = 1
Instance.new("UICorner", FovFrame).CornerRadius = UDim.new(1, 0)

-- Controles de Janela
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false; OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true; OpenBtn.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Otimizador de FPS
OptBtn.MouseButton1Click:Connect(function()
    local L = game:GetService("Lighting")
    L.GlobalShadows = false
    L.FogEnd = 9e9
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 end
    end
    OptBtn.Text = "SISTEMA OTIMIZADO"
    OptBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 20)
    OptBtn.UIStroke.Color = Color3.fromRGB(40, 180, 40)
end)

-- =========================================================
-- SISTEMA REAL DE ESP (CORRIGIDO)
-- =========================================================
local function LimparVisual(character)
    if character:FindFirstChild("ESPHighlight") then character.ESPHighlight:Destroy() end
    if character:FindFirstChild("Head") and character.Head:FindFirstChild("ESPTags") then character.Head.ESPTags:Destroy() end
end

local function CriarVisual(player)
    if player == LocalPlayer then return end
    task.spawn(function()
        while player and player.Parent and player.Character do
            local character = player.Character
            if not EspAtivado then
                LimparVisual(character)
                task.wait(0.5)
            else
                if character:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("Head") then
                    local highlight = character:FindFirstChild("ESPHighlight")
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
                        highlight.FillColor = Color3.fromRGB(0, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineColor = Color3.new(1, 1, 1)
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
                        
                        local t = Instance.new("TextLabel", billboard)
                        t.Name = "InfoText"
                        t.Size = UDim2.new(1, 0, 1, 0)
                        t.BackgroundTransparency = 1
                        t.TextColor3 = Color3.new(1, 1, 1)
                        t.TextSize = 13
                        t.Font = Enum.Font.GothamBold
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
        end
    end)
end

ToggleEspBtn.MouseButton1Click:Connect(function()
    EspAtivado = not EspAtivado
    if EspAtivado then
        ToggleEspBtn.Text = "ESP: ATIVADO"
        ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 15)
        ToggleEspBtn.UIStroke.Color = Color3.fromRGB(40, 180, 40)
        for _, p in pairs(Players:GetPlayers()) do CriarVisual(p) end
    else
        ToggleEspBtn.Text = "ESP: DESATIVADO"
        ToggleEspBtn.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
        ToggleEspBtn.UIStroke.Color = Color3.fromRGB(150, 40, 40)
        for _, p in pairs(Players:GetPlayers()) do if p.Character then LimparVisual(p.Character) end end
    end
end)

-- =========================================================
-- SISTEMA DO AIMBOT + FIX DE CENTRALIZAÇÃO DO FOV
-- =========================================================
local function ObterJogadorMaisProximo()
    local alvoMaisProximo = nil
    local menorDistanciaTela = FovRaio
    local centroDaTela = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Head") then
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local posicaoTela, visivel = Camera:WorldToViewportPoint(player.Character.Head.Position)
                if visivel then
                    local distanciaDoCentro = (Vector2.new(posicaoTela.X, posicaoTela.Y) - centroDaTela).Magnitude
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
    -- Mantém o FOV sempre perfeitamente centralizado na tela do celular
    local centroDaTela = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FovFrame.Position = UDim2.new(0, centroDaTela.X - FovRaio, 0, centroDaTela.Y - FovRaio)

    if AimbotAtivado then
        local alvo = ObterJogadorMaisProximo()
        if alvo then Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.Position) end
    end
end)

ToggleAimBtn.MouseButton1Click:Connect(function()
    AimbotAtivado = not AimbotAtivado
    if AimbotAtivado then
        ToggleAimBtn.Text = "AIMBOT: ATIVADO"
        ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(15, 25, 15)
        ToggleAimBtn.UIStroke.Color = Color3.fromRGB(40, 180, 40)
        FovFrame.Visible = true
    else
        ToggleAimBtn.Text = "AIMBOT: DESATIVADO"
        ToggleAimBtn.BackgroundColor3 = Color3.fromRGB(25, 15, 15)
        ToggleAimBtn.UIStroke.Color = Color3.fromRGB(150, 40, 40)
        FovFrame.Visible = false
    end
end)

-- Conexões de entrada de jogadores para o ESP
for _, p in pairs(Players:GetPlayers()) do
    if p.Character then CriarVisual(p) end
    p.CharacterAdded:Connect(function() task.wait(0.5); CriarVisual(p) end)
end
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function() task.wait(0.5); CriarVisual(p) end)
end)
