-- Script ESP (Ver Jogadores através de paredes)
-- Otimizado para Arceus X / Mobile
-- Criado para: Lucas Gustavo

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Função que aplica o efeito de raio-X no personagem
local function AplicarEsp(player)
    if player == LocalPlayer then return end -- Não aplica em você mesmo

    local function CriarHighlight(character)
        -- Evita duplicar se o efeito já existir
        if character:FindFirstChild("ESPHighlight") then
            character.ESPHighlight:Destroy()
        end

        local highlight = Instance.new("Highlight")
        highlight.Name = "ESPHighlight"
        highlight.FillColor = Color3.fromRGB(255, 140, 0) -- Cor Laranja por dentro
        highlight.FillTransparency = 0.5 -- Transparência do preenchimento (0 a 1)
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- Borda Branca
        highlight.OutlineTransparency = 0 -- Borda totalmente visível
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Faz aparecer através das paredes
        highlight.Parent = character
    end

    -- Aplica se o personagem já existir
    if player.Character then
        CriarHighlight(player.Character)
    end

    -- Aplica toda vez que o jogador morrer e renascer
    player.CharacterAdded:Connect(CriarHighlight)
end

-- Aplica o ESP em todo mundo que já está na partida
for _, player in pairs(Players:GetPlayers()) do
    AplicarEsp(player)
end

-- Monitora se novos jogadores entrarem na partida para aplicar neles também
Players.PlayerAdded:Connect(AplicarEsp)

print("ESP Lucas Gustavo carregado com sucesso!")
