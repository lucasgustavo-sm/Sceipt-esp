-- =========================================================
-- PAINEL ESP OFC: ESTILO DARK NEON PREMIUM
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
local FovRaio = 100 -- Ajuste o tamanho do círculo aqui

-- Remove painel anterior se existir
if PlayerGui:FindFirstChild("PainelEspOfc") then
    PlayerGui.PainelEspOfc:Destroy()
end

-- GUI Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PainelEspOfc"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- Quadro Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 230, 0, 250)
MainFrame.Position = UDim2.new(0.5, -115, 0.3, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
MainFrame.Name = "MainFrame"

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "ESP OFC"
Title.TextColor3 = Color3.fromRGB(0, 255, 255) -- Cor Neon
Title.Font = Enum.Font.CodeBold
Title.TextSize = 20
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- Círculo FOV Visual
local FovFrame = Instance.new("Frame")
FovFrame.Size = UDim2.new(0, FovRaio * 2, 0, FovRaio * 2)
FovFrame.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
FovFrame.BackgroundTransparency = 0.8
FovFrame.BorderSizePixel = 1
FovFrame.Visible = true
FovFrame.Parent = ScreenGui
local UICorner = Instance.new("UICorner", FovFrame)
UICorner.CornerRadius = UDim.new(1, 0)

-- Ajuste centralizado do FOV
RunService.RenderStepped:Connect(function()
    local centroDaTela = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    FovFrame.Position = UDim2.new(0, centroDaTela.X - FovRaio, 0, centroDaTela.Y - FovRaio)
end)

-- Função do Aimbot corrigida
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

-- Loop de mira
RunService.RenderStepped:Connect(function()
    if AimbotAtivado then
        local alvo = ObterJogadorMaisProximo()
        if alvo then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.Position)
        end
    end
end)

