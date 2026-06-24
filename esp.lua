-- PAINEL ESP COMPLETO NATIVO PARA ARCEUS X
-- Desenvolvido para: Lucas Gustavo

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")

-- Configurações de Controle
local EspAtivado = true

-- Deletar versões antigas da interface para não acumular na tela
if PlayerGui:FindFirstChild("PainelLucasESP") then
    PlayerGui.PainelLucasESP:Destroy()
end

-- =========================================================
-- INTERFACE GRÁFICA (UI NATIVA PARA CELULAR)
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelLucasESP"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Janela Principal do Menu
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Size = UDim2.new(0, 240, 0, 130)
MainFrame.Position = UDim2.new(0.5, -120, 0.2, -65) -- Posicionado na parte superior/central
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Você pode arrastar o painel pela tela do celular
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

-- Barra de Título (Laranja)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 8)
TopCorner.Parent = TopBar

-- Texto do Nome
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "Lucas Gustavo"
Title.TextColor3 = Color3.fromRGB(255, 140, 0) -- Laranja
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Botão de Minimizar/Fechar (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Botão para Alternar ESP (Ligar/Desligar)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(1, -20, 0, 40)
ToggleBtn.Position = UDim2.new(0, 10, 0, 55)
ToggleBtn.Text = "ESP: ATIVADO"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 0) -- Começa verde (Ativado)
ToggleBtn.TextSize = 15
ToggleBtn.Font = Enum.Font.SourceSansMedium
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = ToggleBtn

-- =========================================================
-- LÓGICA DO ESP (RAIO-X, NOME E DISTÂNCIA)
-- =========================================================

-- Limpa os efeitos visuais do jogador
local function RemoverVisualEsp(character)
    if character:FindFirstChild("ESPHighlight") then character.ESPHighlight:Destroy() end
    if character:FindFirstChild("Head") and character.Head:FindFirstChild("ESPTags") then
        character.Head.ESPTags:Destroy()
    end
end

-- Cria ou atualiza os efeitos visuais no jogador
local function CriarVisualEsp(player)
    if player == LocalPlayer then return end

    local function Atualizar()
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Head") then 
            return 
        end

        -- Se o ESP global estiver desligado, remove tudo e para
        if not EspAtivado then
            RemoverVisualEsp(character)
            return
        end

        -- 1. Efeito Highlight (Silhueta através da parede)
        local highlight = character:FindFirstChild("ESPHighlight")
        if not highlight then
            highlight = Instance.new("Highlight")
            highlight.Name = "ESPHighlight"
            highlight.FillColor = Color3.fromRGB(255, 140, 0)
            highlight.FillTransparency = 0.6
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.OutlineTransparency = 0
            highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            highlight.Parent = character
        end

        -- 2. Nome e Distância (Texto em cima da cabeça)
        local head = character.Head
        local billboard = head:FindFirstChild("ESPTags")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "ESPTags"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0) -- Distância acima da cabeça
            billboard.AlwaysOnTop = true -- Visível através de paredes
            billboard.Parent = head

            local textLabel = Instance.new("TextLabel")
            textLabel.Name = "InfoText"
            textLabel.Size = UDim2.new(1, 0, 1, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.TextSize = 14
            textLabel.Font = Enum.Font.SourceSansBold
            textLabel.TextStrokeTransparency = 0 -- Borda preta no texto para ler melhor
            textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            textLabel.Parent = billboard
        end

        -- Atualiza o cálculo da distância em tempo real
        local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetRoot = character.HumanoidRootPart
        if localRoot and targetRoot and billboard:FindFirstChild("InfoText") then
            local distancia = math.floor((localRoot.Position - targetRoot.Position).Magnitude)
            billboard.InfoText.Text = player.DisplayName .. " [" .. distancia .. "m]"
        end
    end

    -- Conexão contínua para atualizar a distância a cada frame do jogo
    local conexao
    conexao = RunService.RenderStepped:Connect(function()
        if player and player.Parent and player.Character then
            Atualizar()
        else
            conexao:Disconnect() -- Desconecta se o jogador sair ou resetar
        end
    end)
end

-- Monitora a entrada e o spawn de novos personagens
local function MonitorarJogador(player)
    if player.Character then CriarVisualEsp(player) end
    player.CharacterAdded:Connect(function()
        task.wait(0.5) -- Pequena pausa para garantir o carregamento do corpo
        CriarVisualEsp(player)
    end)
end

-- Ativa o monitoramento para quem já está e quem for entrar
for _, p in pairs(Players:GetPlayers()) do MonitorarJogador(p) end
Players.PlayerAdded:Connect(MonitorarJogador)

-- =========================================================
-- FUNCIONALIDADE DO BOTÃO DE LIGAR/DESLIGAR
-- =========================================================
ToggleBtn.MouseButton1Click:Connect(function()
    EspAtivado = not EspAtivado
    if EspAtivado then
        ToggleBtn.Text = "ESP: ATIVADO"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 0) -- Verde
    else
        ToggleBtn.Text = "ESP: DESATIVADO"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(140, 0, 0) -- Vermelho
        -- Força a remoção visual imediata de todo mundo no mapa
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then RemoverVisualEsp(p.Character) end
        end
    end
end)

print("Painel Atualizado com Sucesso!")
