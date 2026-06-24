-- PAINEL ESP OFC - COMPLETO E CORRIGIDO
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local EspAtivado = false
local AimbotAtivado = false
local FovRaio = 100

-- Limpeza
if PlayerGui:FindFirstChild("PainelEspOfc") then PlayerGui.PainelEspOfc:Destroy() end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "PainelEspOfc"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 200)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "ESP OFC"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

-- Botões
local function criarBtn(nome, pos, cor)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = pos
    btn.Text = nome
    btn.BackgroundColor3 = cor
    Instance.new("UICorner", btn)
    return btn
end

local BtnEsp = criarBtn("ESP: DESATIVADO", UDim2.new(0, 10, 0, 40), Color3.fromRGB(150, 0, 0))
local BtnAim = criarBtn("AIMBOT: DESATIVADO", UDim2.new(0, 10, 0, 90), Color3.fromRGB(150, 0, 0))
local BtnOpt = criarBtn("OTIMIZAR FPS", UDim2.new(0, 10, 0, 140), Color3.fromRGB(0, 100, 200))

-- Círculo FOV
local FovCircle = Instance.new("Frame", ScreenGui)
FovCircle.Size = UDim2.new(0, FovRaio*2, 0, FovRaio*2)
FovCircle.BackgroundTransparency = 1
FovCircle.Visible = false
Instance.new("UIStroke", FovCircle).Color = Color3.new(1, 1, 1)
Instance.new("UICorner", FovCircle).CornerRadius = UDim.new(1, 0)

-- Lógica
BtnEsp.MouseButton1Click:Connect(function()
    EspAtivado = not EspAtivado
    BtnEsp.Text = EspAtivado and "ESP: ATIVADO" or "ESP: DESATIVADO"
    BtnEsp.BackgroundColor3 = EspAtivado and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

BtnAim.MouseButton1Click:Connect(function()
    AimbotAtivado = not AimbotAtivado
    BtnAim.Text = AimbotAtivado and "AIMBOT: ATIVADO" or "AIMBOT: DESATIVADO"
    BtnAim.BackgroundColor3 = AimbotAtivado and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    FovCircle.Visible = AimbotAtivado
end)

BtnOpt.MouseButton1Click:Connect(function()
    settings().Rendering.QualityLevel = 1
    BtnOpt.Text = "OTIMIZADO!"
end)

-- Loop Centralização
RunService.RenderStepped:Connect(function()
    local c = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
    FovCircle.Position = UDim2.new(0, c.X - FovRaio, 0, c.Y - FovRaio)
    
    if AimbotAtivado then
        local alvo = nil
        local menorDist = FovRaio
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                local pos, vis = Camera:WorldToViewportPoint(p.Character.Head.Position)
                if vis then
                    local dist = (Vector2.new(pos.X, pos.Y) - c).Magnitude
                    if dist < menorDist then alvo = p.Character.Head; menorDist = dist end
                end
            end
        end
        if alvo then Camera.CFrame = CFrame.new(Camera.CFrame.Position, alvo.Position) end
    end
end)
