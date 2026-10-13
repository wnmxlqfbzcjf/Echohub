-- // Made by wnmxlqfbzcjf
-- Routes by string PlaceId / GameId; no top-level return.
-- Each game is loadstring'd so it gets its own locals budget (Luau 200 limit)
-- without nesting huge functions (Luraph freezes on those).

local loadstring = loadstring or load
local PlaceIdStr = tostring(game.PlaceId)
local GameIdStr = tostring(game.GameId)

local FootballFusionPlaces = {
	["82866880824588"] = true,
	["81310542478972"] = true,
	["93201274415679"] = true,
	["140541044364039"] = true,
	["8204899140"] = true,
	["8206123457"] = true,
	["8206126987"] = true,
	["13520900351"] = true,
	["17541256525"] = true,
}

local CFBPlaceNames = {
	["14839650434"] = "College",
	["14783490031"] = "Training Facility",
	["15201655003"] = "Event Hall",
	["15358039559"] = "3s",
	["15720676770"] = "Tossup Warriors",
	["18768066477"] = "StadiumViewer",
	["71905624214428"] = "High School",
	["72118582190041"] = "Larger Servers",
}

local BasketballLegendsPlaces = {
	["71832465156084"] = true,
	["14386691987"] = true,
	["17652853807"] = true,
}

local PlaygroundPlaces = {
	["81821727610515"] = true,
	["106392426844067"] = true,
	["18474349316"] = true,
	["18474347948"] = true,
	["18517967096"] = true,
}

local RivalsPlaces = {
	["17625359962"] = true,
	["17625359963"] = true,
}

local function IsFF()
	return FootballFusionPlaces[PlaceIdStr] == true
end

local function IsCFB()
	if CFBPlaceNames[PlaceIdStr] then
		return true
	end
	return GameIdStr == "5113572498"
end

local function IsClutch()
	return PlaceIdStr == "120530433711650"
end

local function IsBasketballLegends()
	return BasketballLegendsPlaces[PlaceIdStr] == true
end

local function IsPlayground()
	return PlaygroundPlaces[PlaceIdStr] == true
end

local function IsStreetLife()
	return PlaceIdStr == "71600459831333"
end

local function IsOT7()
	return PlaceIdStr == "105935731955936"
end

local function IsRivals()
	if RivalsPlaces[PlaceIdStr] == true then
		return true
	end
	return GameIdStr == "6035872082"
end

local function IsDaHood()
	if PlaceIdStr == "111862645293891" or PlaceIdStr == "108633778163247" or PlaceIdStr == "2788229376" then
		return true
	end
	return GameIdStr == "1008451066"
end

local function IsNFLUniverse()
	return PlaceIdStr == "14801724413" or PlaceIdStr == "2338325648" or PlaceIdStr == "4940687511" or GameIdStr == "184199275"
end

print("[Echo Hub] PlaceId=" .. PlaceIdStr .. " GameId=" .. GameIdStr)

if IsFF() then
-- Echo Hub: Football Fusion
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Made by wnmxlqfbzcjf
--
-- Football Fusion only. Luarmor-safe: string PlaceId checks, no top-level return,
-- no IIFE (Luraph often breaks huge wrappers). Wrong game = no-op.

local PlaceIdStr = tostring(game.PlaceId)

local FootballFusionPlaces = {
    ["82866880824588"] = true, -- FF3 Main
    ["81310542478972"] = true, -- FF3 Practice
    ["93201274415679"] = true, -- FF3 Realistic
    ["140541044364039"] = true, -- FF3 Bigger Servers
    ["8204899140"] = true, -- FF2 Main
    ["8206123457"] = true, -- FF2 Practice
    ["8206126987"] = true, -- FF2 Bigger Servers
    ["13520900351"] = true, -- FF2 Testing
    ["17541256525"] = true, -- FF2 Realistic
}

print("[Echo] FF PlaceId=" .. PlaceIdStr .. " match=" .. tostring(FootballFusionPlaces[PlaceIdStr] == true))

if FootballFusionPlaces[PlaceIdStr] then

local LoadTick = os.clock()
local cloneref = cloneref or function(Value) return Value end

-- Only clear OUR leftover Scoot UI — never touch a live CFB menu mid-load.
do
    local uiRoot = game:GetService("CoreGui")
    for _, gui in ipairs(uiRoot:GetChildren()) do
        if gui:IsA("ScreenGui") and (gui.Name == "EchoHUD" or gui.Name == "ZyroCARDS" or gui.Name == "EchoMobile" or gui.Name == "EchoScoreboard") then
            pcall(function() gui:Destroy() end)
        end
    end
end

local Library = (function()
    if getgenv().__EchoSametScootLib then
        return getgenv().__EchoSametScootLib
    end
    local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sametexe001/sametlibs/refs/heads/main/Scoot/Library.lua"))()
    getgenv().__EchoSametScootLib = Lib
    return Lib
end)()
local Window = Library:Window({
    Logo = "77218680285262",
    FadeTime = 0.05,
})

-- // Services
local Services = setmetatable({}, {
    __index = function(_, Service)
        return cloneref(game:GetService(Service))
    end
})

local Players = Services.Players
local Workspace = Services.Workspace
local ReplicatedStorage = Services.ReplicatedStorage
local TweenService = Services.TweenService
local RunService = Services.RunService
local UserInputService = Services.UserInputService
local VirtualInputManager = game:GetService("VirtualInputManager")

-- // Mobile Detection
local IsMobile = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled)

-- // Variables
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Mouse = LocalPlayer:GetMouse()

-- // Instances — do NOT CharacterAdded:Wait() here; that freezes load in menus / late spawns.
local Character = LocalPlayer.Character
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

local function RefreshCharacterRefs(newCharacter)
    Character = newCharacter
    Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:FindFirstChild("Humanoid")
    HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not Humanoid or not HumanoidRootPart then
        task.defer(function()
            if Character ~= newCharacter then return end
            Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid", 5)
            HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character:WaitForChild("HumanoidRootPart", 5)
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    RefreshCharacterRefs(newChar)
end)

local RemotesFolder = ReplicatedStorage:FindFirstChild("Remotes") or ReplicatedStorage:WaitForChild("Remotes", 5)
if not RemotesFolder then
    warn("[Echo] FF: Remotes folder missing — aborting FF load only")
else
local Remote = RemotesFolder:FindFirstChild("CharacterSoundEvent") or RemotesFolder:WaitForChild("CharacterSoundEvent", 5)
if not Remote then
    warn("[Echo] FF: CharacterSoundEvent missing — aborting FF load only")
else

local Camera = workspace.CurrentCamera

local ThrowingDirection = Vector3.new(0, 0, 0)
local ClosestPlayer

local Part = Instance.new("Part")
Part.Transparency = 0.5
Part.Anchored = true
Part.CanCollide = false
Part.CastShadow = false

local PartV2 = Instance.new("Part")
PartV2.Transparency = 0.5
PartV2.Anchored = true
PartV2.CanCollide = false
PartV2.CastShadow = false

-- // Utilities
local Echo = {
    ACBypass = {
        Callback = 0
    },

    Catching = {
        Magnets = false,
        ShowMagHitbox = false,
        FakeBall = false,

        CustomizableRadius = 60,
        CustomizableDelay = 0,
        TweenSpeed = 0,

        PullVector = false,
        PullVectorSpeed = 0,
        PullVectorRadius = 0,

        MagnetsV2 = false,
        ShowMagHitboxV2 = false,
        CustomizableRadiusV2 = 15,
        CustomizableDelayV2 = 0,

        PullVectorV2 = false,
        PullVectorTypeV2 = "Drag",
        PullVectorSpeedV2 = 3,
        PullVectorRadiusV2 = 25,

        DiveVector = false,
        DiveVectorRadius = 30,
    },

    Player = {
        JumpPower = false,
        JP = 50,

        AngleEnhancer = false,
        AngleEnhancerValue = 50,

        WalkSpeed = false,
        WSSpeed = 20,

        CFrameSpeed = false,
        CFSpeed = 0,

        Fly = false,
        FlySpeed = 50,
    },

    Physics = {
        ClickTackleAimbot = false,
        ClickTackleAimbotRadius = 15,

        QuickTP = false,
        QuickTPSpeed = 0,

        ThrowPredictions = false,
        JumpPredictions = false,

        AntiBlock = false,
        AntiJam = false,
        NoJumpCooldown = false,

        BigHead = false,
        BigHeadSize = 5,

        AntiOOB = false,
        NoFreeze = false,

        BlockExtender = false,
        BlockExtenderReach = 10,
        BlockExtenderTransparency = 1,

        ResetOnCatch = false,
        ResetOnCatchDuration = 0.5,

        AntiTackle = false,
        AntiDown   = false,
    },

    Automatics = {
        AutoQB = false,
        AutoQBType = "Legit",

        AutoCaptain = false,
        AutoCatch = false,
        AutoCatchRadius = 0,

        AutoSwat = false,
        AutoSwatRadius = 0,

        AutoKick = false,
        AutoKickPower = 0,
        AutoKickAccuracy = 0,

        AutoRush = false,
        AutoRushDelay = 0,

        AutoBoost = false,
        AutoBoostPower = 50,
    },

    Visuals = {
        NoTextures = false,
        CameraZoom = false,
    },

    QBAimbot = {
        Enabled = false,
        AutoAngle = true,
        BeamMode = false,
        AutoChooseThrowType = false,
        Use95PowerMode = false,

        ThrowAngle = 45,
        BulletAngle = 25,
        NormalPower = 50,
        AutoPower = true,
        HighestPowerMode = false,
        CustomLead = 0,
        PredictionColor = Color3.fromRGB(55, 55, 55),

        -- Targeting
        FOV = 500,
        ShowFOV = false,
        TargetPriority = "Closest To Mouse",
        TargetLock = false,
        LockedTarget = nil,

        -- Receiver ESP
        ReceiverESP = false,
        ShowRoutes = false,
        ShowDistance = false,

        -- Automation
        AutoHike = false,
        AutoThrow = false,
        AutoThrowDelay = 0.5,
        ScrambleMode = false,
        ScrambleSpeed = 25,

        -- Anti-INT
        InterceptionAvoidance = false,
        MinOpenDistance = 15,

        -- Smoothing
        SmoothEnabled = false,
        SmoothFactor = 5,
    },

    Gamepasses = {
        UnlockAll = false,
    },
}

local Threads = {}
local Hooks = {}
local HandshakeIntegers = {}

-- Kill loops from previous executions of this script so they can't fight the new ones
getgenv().EchoGeneration = (getgenv().EchoGeneration or 0) + 1
local EchoGen = getgenv().EchoGeneration
local function EchoAlive()
    return getgenv().EchoGeneration == EchoGen
end
-- Disable every toggle of previous executions' config tables so their
-- still-running loops (which capture their own Echo upvalue) go idle.
local PrevConfig = getgenv().EchoConfig
if PrevConfig and PrevConfig ~= Echo then
    pcall(function()
        for _, category in pairs(PrevConfig) do
            if type(category) == "table" then
                for key, value in pairs(category) do
                    if type(value) == "boolean" then
                        category[key] = false
                    end
                end
            end
        end
    end)
end
getgenv().EchoConfig = Echo

-- // Beam tracking
local currentBeam = nil
local currentAttachment0 = nil
local currentAttachment1 = nil

-- // Block extender part
local BlockExtenderPart = nil

-- // Fly objects
local FlyBodyVelocity = nil
local FlyBodyGyro = nil

-- // Fake ball
local FakeBallPart = nil

-- // AC Bypass — ViseHub-FF3 core/ac_bypass (Cooler FF3 bypass)
-- Exact logic from ViseHub; wrapped in a function so fail/return cannot abort the FF chunk.
local function init_ac_bypass()
    if game.PlaceId ~= 82866880824588 then
        return
    end

    if getgenv().bypass_loaded then
        return warn("[+] already loaded bypass")
    end
    getgenv().bypass_loaded = true

    local local_player = LocalPlayer
    local target_remote = Remote
    local run_service = RunService

    -- ViseHub services wait for character before ac_bypass.init(); PlayerModule must be in getgc.
    if not local_player.Character then
        local_player.CharacterAdded:Wait()
    end
    task.wait(0.15)

    local script_context = cloneref and cloneref(game:GetService("ScriptContext")) or game:GetService("ScriptContext")
    local is_setup = false
    local bypass_state = true

    local shuffle_function = nil
    local handshake_function = nil

    local function fail(code, message)
        local_player:Kick(string.format("[0x%02X]: %s", code, message))
        task.wait(1.50)
    end

    for _, value in next, getgc() do
        if type(value) ~= "function" or not islclosure(value) then
            continue
        end

        local ok, err = pcall(function()
            local script_info = getrenv().debug.info(value, "s")
            if not script_info or not string.find(script_info, "PlayerModule") then
                return
            end

            local constants = getconstants(value)
            if table.find(constants, 90001) then
                shuffle_function = value
            end
        end)

        if not ok and err then
            continue
        end
    end

    if not shuffle_function then
        fail(0x01, "failed to retrieve shuffle function.")
        return
    end

    for _, value in next, getgc() do
        if type(value) ~= "function" or not islclosure(value) then
            continue
        end

        local ok_src, src = pcall(getrenv().debug.info, value, "s")
        if not ok_src or not src or not string.find(src, "PlayerModule") then
            continue
        end

        local ok_upvs, upvs = pcall(getupvalues, value)
        if not ok_upvs or not upvs then
            continue
        end

        local has_secondary_remote = false
        local has_add_shuffle = false

        for _, uv in next, upvs do
            local ok_t, t = pcall(typeof, uv)
            if not ok_t then
                continue
            end

            if t == "Instance" then
                local ok_cls, cls = pcall(function() return uv.ClassName end)
                if ok_cls and cls == "RemoteEvent" and uv ~= target_remote then
                    has_secondary_remote = true
                end
            elseif t == "function" and islclosure(uv) then
                local ok_c, consts = pcall(getconstants, uv)
                if ok_c and consts and table.find(consts, 90001) then
                    has_add_shuffle = true
                end
            end

            if has_secondary_remote and has_add_shuffle then
                break
            end
        end

        if has_secondary_remote and has_add_shuffle then
            handshake_function = value
            break
        end
    end

    if not handshake_function then
        fail(0x02, "failed to retrieve handshake function via getgc.")
        return
    end

    local content_uri = nil
    do
        local ok_c, consts = pcall(getconstants, handshake_function)
        if ok_c and consts then
            for _, c in next, consts do
                if type(c) == "string" and #c > 5 and string.byte(c, 1) == 240 then
                    content_uri = c
                    break
                end
            end
        end
    end

    local handshake_upvalues = getupvalues(handshake_function)

    local ac_long_string = nil
    local secondary_shuffle = nil
    local secondary_remote = nil
    local pass_table = nil
    local fail_table_a = nil
    local fail_table_b = nil

    local hs_large = {}
    local hs_small = {}
    local remote_events = {}

    for index, value in next, handshake_upvalues do
        local ok, t = pcall(typeof, value)
        if not ok then
            continue
        end

        if t == "string" then
            if #value > 1000000 and not ac_long_string then
                ac_long_string = value
            end
        elseif t == "Instance" then
            local ok_cls, cls = pcall(function() return value.ClassName end)
            if ok_cls and cls == "RemoteEvent" and value ~= target_remote then
                table.insert(remote_events, value)
            end
        elseif t == "function" and islclosure(value) then
            if value ~= shuffle_function then
                local ok_c, consts = pcall(getconstants, value)
                if ok_c and consts and table.find(consts, 90001) and not secondary_shuffle then
                    secondary_shuffle = value
                end
            end
        elseif t == "table" then
            local ok_mt, mt = pcall(getrawmetatable, value)
            if not ok_mt or type(mt) ~= "table" then
                continue
            end

            local ok_fn, call_fn = pcall(rawget, mt, "__call")
            if not ok_fn or type(call_fn) ~= "function" then
                continue
            end

            local ok_cc, call_consts = pcall(getconstants, call_fn)
            if not ok_cc or not call_consts or not table.find(call_consts, 90001) then
                continue
            end

            local ok_in, inner = pcall(rawget, value, 1)
            if not ok_in or type(inner) ~= "table" then
                continue
            end

            local ok_19, val19 = pcall(rawget, inner, 19)
            if not ok_19 or type(val19) ~= "number" then
                continue
            end

            if val19 >= 1000000 then
                table.insert(hs_large, { index = index, tbl = value })
            else
                table.insert(hs_small, { index = index, tbl = value })
            end
        end
    end

    for _, connection in next, getconnections(script_context.Error) do
        connection:Disable()
    end

    secondary_remote = remote_events[1]
    pass_table = hs_large[1] and hs_large[1].tbl
    fail_table_a = hs_small[1] and hs_small[1].tbl
    fail_table_b = hs_small[2] and hs_small[2].tbl

    if not content_uri then
        fail(0x03, "failed to retrieve marker string from constants.")
        return
    end

    if not ac_long_string then
        fail(0x07, "failed to retrieve ac marker string upvalue.")
        return
    end

    if not secondary_remote then
        fail(0x04, "failed to retrieve secondary remote.")
        return
    end

    if not secondary_shuffle then
        fail(0x05, "failed to retrieve secondary shuffle.")
        return
    end

    if not pass_table or not fail_table_a or not fail_table_b then
        fail(0x06, "failed to retrieve HS tables.")
        return
    end

    local old_sub = nil
    old_sub = hookfunction(getrenv().string.sub, function(...)
        local arguments = { ... }

        if not checkcaller() then
            if arguments[2] == -3 and arguments[3] == -3 then
                return "i"
            end

            if arguments[2] == -1 then
                return " "
            end
        end

        return old_sub(...)
    end)

    local clean_sequences = {
        { 1750, 1750, 1655, 1761, 1888, 1767 },
        { 1645, 1765, 1623, 1714, 1881, 1656 },
        { 1650, 1749, 1853, 1741, 1761, 1856 },
    }

    local primary_shuffle = nil
    primary_shuffle = hookfunction(shuffle_function, function(...)
        local arguments = { ... }

        if rawlen(arguments) >= 9 then
            local p3 = arguments[3]
            local p4 = arguments[4]
            local p5 = arguments[5]
            local p7 = arguments[7]
            local p8 = arguments[8]
            local p9 = arguments[9]

            for _, seq in next, clean_sequences do
                if p3 == seq[1] and p4 == seq[2] and p5 == seq[3]
                    and p7 == seq[4] and p8 == seq[5] and p9 == seq[6] then
                    return primary_shuffle(...)
                end
            end

            return task.wait(9e9)
        end

        return primary_shuffle(...)
    end)

    local dummy_event = Instance.new("BindableEvent").Event
    local setupvalue_fn = debug and debug.setupvalue or setupvalue

    for _, value in next, getgc() do
        if type(value) ~= "function" or not islclosure(value) then
            continue
        end

        local ok, err = pcall(function()
            local script_info = getrenv().debug.info(value, "s")
            if not script_info or not string.find(script_info, "PlayerModule") then
                return
            end

            local upvalues = getupvalues(value)
            if not upvalues then
                return
            end

            for i, upvalue in next, upvalues do
                if typeof(upvalue) == "RBXScriptSignal" then
                    if upvalue == run_service.Heartbeat
                        or upvalue == run_service.RenderStepped
                        or upvalue == run_service.Stepped then
                        setupvalue_fn(value, i, dummy_event)
                    end
                end
            end
        end)

        if not ok and err then
            continue
        end
    end

    for _, value in next, getgc() do
        if type(value) ~= "function" or not islclosure(value) then
            continue
        end

        local ok_src, src = pcall(getrenv().debug.info, value, "s")
        if not ok_src or not src or not string.find(src, "PlayerModule") then
            continue
        end

        local ok_upvs, upvs = pcall(getupvalues, value)
        if not ok_upvs or not upvs then
            continue
        end

        for i, uv in next, upvs do
            if typeof(uv) == "boolean" and uv == false then
                local has_remote_in_closure = false
                for _, uv2 in next, upvs do
                    local ok2, t2 = pcall(typeof, uv2)
                    if ok2 and t2 == "Instance" then
                        local ok3, cls = pcall(function() return uv2.ClassName end)
                        if ok3 and (cls == "RemoteEvent" or cls == "RemoteFunction") then
                            has_remote_in_closure = true
                            break
                        end
                    end
                end

                if has_remote_in_closure then
                    pcall(setupvalue_fn, value, i, true)
                end
            end
        end
    end

    local update_function = nil
    local renv_rawget = getrenv().rawget
    local renv_rawset = getrenv().rawset

    for _, value in next, getgc() do
        if type(value) ~= "function" or not islclosure(value) or value == handshake_function then
            continue
        end

        local ok_src, src = pcall(getrenv().debug.info, value, "s")
        if not ok_src or not src or not string.find(src, "PlayerModule") then
            continue
        end

        local ok_upvs, upvs = pcall(getupvalues, value)
        if not ok_upvs or not upvs then
            continue
        end

        local has_rawget_upval = false
        local has_rawset_upval = false
        local has_shuffle = false

        for _, uv in next, upvs do
            if uv == renv_rawget then
                has_rawget_upval = true
            elseif uv == renv_rawset then
                has_rawset_upval = true
            elseif type(uv) == "function" and islclosure(uv) then
                local ok_c, consts = pcall(getconstants, uv)
                if ok_c and consts and table.find(consts, 90001) then
                    has_shuffle = true
                end
            end
        end

        if has_rawget_upval and has_rawset_upval and not has_shuffle then
            update_function = value
            break
        end
    end

    local function replicate_handshake()
        task.wait()

        shuffle_function(ac_long_string, pass_table, 1750, 1750, 1655, ac_long_string, 1761, 1888, 1767)
        shuffle_function(ac_long_string, pass_table, 1645, 1765, 1623, ac_long_string, 1714, 1881, 1656)

        secondary_remote.Name = target_remote.Name
        secondary_remote:FireServer(
            content_uri,
            secondary_shuffle(ac_long_string, bypass_state and fail_table_a or fail_table_b, 1767, 1676, 1854, ac_long_string, 1689, 1775, 1776),
            nil
        )

        target_remote:FireServer(
            content_uri,
            shuffle_function(ac_long_string, bypass_state and pass_table or fail_table_a, 1750, 1750, 1655, ac_long_string, 1761, 1888, 1767),
            nil
        )

        shuffle_function(ac_long_string, pass_table, 1650, 1749, 1853, ac_long_string, 1741, 1761, 1856)

        secondary_remote.Name = ""
    end

    local old_handshake = nil
    old_handshake = hookfunction(handshake_function, function(identifier, ...)
        if not is_setup then
            return old_handshake(identifier, ...)
        end

        if identifier ~= content_uri then
            return
        end

        replicate_handshake()
    end)

    if update_function then
        local old_update = nil
        old_update = hookfunction(update_function, function(identifier, new_state, new_vals)
            if not is_setup then
                return old_update(identifier, new_state, new_vals)
            end

            if identifier ~= content_uri then
                return old_update(identifier, new_state, new_vals)
            end

            if type(new_vals) == "table" and pass_table then
                local inner = rawget(pass_table, 1)
                if inner then
                    for i = 1, #new_vals do
                        rawset(inner, i + 1, new_vals[i])
                    end
                end
            end

            return old_update(identifier, new_state, new_vals)
        end)
    end

    is_setup = true
end

init_ac_bypass()
task.wait()

-- // Gamepass Unlock hook
task.spawn(function()
    local ok, LocalSave = pcall(require, cloneref(game:GetService("ReplicatedFirst")):WaitForChild("LocalSave", 10))
    if not ok or not LocalSave then return end
    local _old_owns = LocalSave.PlayerOwnsPass
    LocalSave.PlayerOwnsPass = function(self, passId, ...)
        if Echo.Gamepasses.UnlockAll then return true end
        return _old_owns(self, passId, ...)
    end
end)

-- // Anti Down — delayed namecall hook (sync hookmetamethod at boot crashes Potassium)
task.defer(function()
    task.wait(2)
    if typeof(hookmetamethod) ~= "function" or typeof(getnamecallmethod) ~= "function" then
        warn("[Echo] AntiDown hook unavailable")
        return
    end
    local ok, err = pcall(function()
        local _nd_old
        local handler = function(self, ...)
            local method = getnamecallmethod()
            if (method == "fireServer" or method == "FireServer")
               and rawequal(self, Remote)
               and Echo.Physics.AntiDown then
                local a1, a2 = ...
                if a1 == "Game" and a2 == "AutoDown" then
                    return
                end
            end
            return _nd_old(self, ...)
        end
        if newcclosure then
            handler = newcclosure(handler)
        end
        _nd_old = hookmetamethod(game, "__namecall", handler)
    end)
    if not ok then
        warn("[Echo] AntiDown hook skipped:", err)
    end
end)

-- // Utility Functions
local function GetCatchParts()
    local parts = {}
    if not Character then return parts end

    local names
    if (game.PlaceId == 81310542478972) then
        names = { "CatchRight", "CatchLeft" }
    else
        names = { "CatchR", "CatchL" }
    end

    for _, n in ipairs(names) do
        local p = Character:FindFirstChild(n)
        if p then parts[#parts + 1] = p end
    end
    return parts
end

local function GetRandomCatchPart()
    local parts = GetCatchParts()
    if #parts == 0 then return nil end
    return parts[math.random(1, #parts)]
end

-- The game's server handler expects "catch " (with a trailing space, matching the
-- game's own GameControls client). Fire both spellings for cross-place safety.
local function FireCatchRemote()
    pcall(function()
        Remote:FireServer("PlayerActions", "catch ")
        Remote:FireServer("PlayerActions", "catch")
    end)
end

local function GetClosestFootball()
    local ClosestFootball = nil
    local ClosestDistance = math.huge

    for _, Object in next, Workspace:GetDescendants() do
        if Object.Name == "Football" then
            local Part = nil
            if Object:IsA("BasePart") then
                Part = Object
            elseif Object:IsA("Tool") or Object:IsA("Model") then
                Part = Object:FindFirstChild("Handle") or Object:FindFirstChildWhichIsA("BasePart")
            end

            if Part then
                local dist = (Part.Position - HumanoidRootPart.Position).Magnitude

                if dist < ClosestDistance then
                    ClosestFootball = Part
                    ClosestDistance = dist
                end
            end
        end
    end

    return ClosestFootball
end

local function IsBot(Name)
    return string.find(Name, "bot 1") or string.find(Name, "bot 3")
end

local function IsVector3Valid(Position)
    return Position.X == Position.X and Position.Y == Position.Y and Position.Z == Position.Z
end

local function GetScreenPosition(Object)
    local ScreenPoint, OnScreen = Camera:WorldToViewportPoint(Object.Position)
    return Vector2.new(ScreenPoint.X, ScreenPoint.Y), OnScreen
end

local function GetFieldOrientation(PlayerPosition)
    return (PlayerPosition.Z > 0) and 1 or -1
end

local function GetFieldOrientationX(PlayerPosition)
    return (PlayerPosition.X > 0) and 1 or -1
end

local function GetPower(Range, Gravity)
    return math.sqrt(Range * Gravity)
end

local function BeamProjectile(g, v0, x0, t1)
    local c = 0.5 * 0.5 * 0.5
    local p3 = 0.5 * g * t1 * t1 + v0 * t1 + x0
    local p2 = p3 - (g * t1 * t1 + v0 * t1) / 3
    local p1 = (c * g * t1 * t1 + 0.5 * v0 * t1 + x0 - c * (x0 + p3)) / (3 * c) - p2

    local curve0 = (p1 - x0).Magnitude
    local curve1 = (p2 - p3).Magnitude

    local r1 = (p1 - x0).Unit
    local r2 = (p2 - p3).Unit
    local worldUp = Vector3.new(0, 1, 0)

    -- Build an independent orthonormal basis for each end using its own r as the X (Right) axis.
    -- Roblox Beam places control points via: B1 = A0 + c0*A0.Right, B2 = A1 - c1*A1.Right
    -- so Right must equal r1/r2 exactly. Sharing a single b between both CFrames breaks
    -- orthonormality for cf2 whenever r2 diverges from r1 (i.e. any curved trajectory).
    local b1 = math.abs(r1:Dot(worldUp)) < 0.999 and r1:Cross(worldUp).Unit or r1:Cross(Vector3.new(1,0,0)).Unit
    local u1 = b1:Cross(r1).Unit

    local b2 = math.abs(r2:Dot(worldUp)) < 0.999 and r2:Cross(worldUp).Unit or r2:Cross(Vector3.new(1,0,0)).Unit
    local u2 = b2:Cross(r2).Unit

    local cf1 = CFrame.new(
        x0.X, x0.Y, x0.Z,
        r1.X, u1.X, b1.X,
        r1.Y, u1.Y, b1.Y,
        r1.Z, u1.Z, b1.Z
    )

    local cf2 = CFrame.new(
        p3.X, p3.Y, p3.Z,
        r2.X, u2.X, b2.X,
        r2.Y, u2.Y, b2.Y,
        r2.Z, u2.Z, b2.Z
    )

    return curve0, -curve1, cf1, cf2
end

local BeamCreatedAt = 0

function DestroyTrajectoryBeam()
    if currentBeam then
        pcall(function() currentBeam:Destroy() end)
        currentBeam = nil
    end
    if currentAttachment0 then
        pcall(function() currentAttachment0:Destroy() end)
        currentAttachment0 = nil
    end
    if currentAttachment1 then
        pcall(function() currentAttachment1:Destroy() end)
        currentAttachment1 = nil
    end
end

-- Sweep beams left behind by previous executions of this script
for _, obj in ipairs(workspace.Terrain:GetChildren()) do
    if (obj:IsA("Beam") and obj.Name == "GroundBeam")
        or (obj:IsA("Attachment") and (obj.Name == "Attachment0" or obj.Name == "Attachment1")) then
        pcall(function() obj:Destroy() end)
    end
end

function CreateBeamFromCFrames(cf1, cf2, curve0, curve1, color)
    DestroyTrajectoryBeam()
    BeamCreatedAt = tick()

    local a0 = Instance.new("Attachment")
    a0.WorldCFrame = cf1
    a0.Name = "Attachment0"
    a0.Parent = workspace.Terrain

    local a1 = Instance.new("Attachment")
    a1.WorldCFrame = cf2
    a1.Name = "Attachment1"
    a1.Parent = workspace.Terrain

    local baseColor = color or Color3.fromRGB(255, 40, 0)
    local h, s, v = Color3.toHSV(baseColor)
    local midColor = Color3.fromHSV(h, math.max(s - 0.2, 0), math.min(v + 0.15, 1))
    local tipColor = Color3.fromHSV(h, math.max(s - 0.5, 0), 1)

    local beam = Instance.new("Beam")
    beam.Attachment0 = a0
    beam.Attachment1 = a1
    beam.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,    baseColor),
        ColorSequenceKeypoint.new(0.45, midColor),
        ColorSequenceKeypoint.new(1,    tipColor),
    })
    beam.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0,   0),
        NumberSequenceKeypoint.new(0.6, 0.05),
        NumberSequenceKeypoint.new(1,   0.35),
    })
    beam.Width0 = 4.5
    beam.Width1 = 1.2
    beam.CurveSize0 = curve0
    beam.CurveSize1 = curve1
    beam.FaceCamera = true
    beam.Segments = 1750
    beam.LightEmission = 1
    beam.Brightness = 8
    beam.TextureSpeed = 3
    beam.Texture = "rbxassetid://18527302693"
    beam.Name = "GroundBeam"
    beam.Parent = workspace.Terrain

    currentBeam = beam
    currentAttachment0 = a0
    currentAttachment1 = a1

    return beam, a0, a1
end

local function CreateBillboard(text, position)
    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 100, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.Adornee = nil
    billboard.AlwaysOnTop = true

    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Text = text
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true

    local part = Instance.new("Part")
    part.Anchored = true
    part.CanCollide = false
    part.Size = Vector3.new(1, 1, 1)
    part.Position = position
    part.Transparency = 1
    part.Name = "BillboardPart"
    part.Parent = workspace

    billboard.Adornee = part
    billboard.Parent = part

    return part
end

--// QB Aimbot HUD — top-center panel styled after the Scoot menu theme
local EchoHUDGui = Instance.new("ScreenGui")
EchoHUDGui.Name = "EchoHUD"
EchoHUDGui.ResetOnSpawn = false
EchoHUDGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
EchoHUDGui.Parent = gethui and gethui() or game:GetService("CoreGui")
EchoHUDGui.Enabled = false -- only while holding football

local HUD = {}

do
    -- Same palette as the Scoot library ("Preset" theme)
    local BG          = Color3.fromRGB(14, 17, 15)
    local BORDER      = Color3.fromRGB(12, 12, 12)
    local ELEMENT     = Color3.fromRGB(30, 36, 31)
    local INLINE      = Color3.fromRGB(20, 24, 21)
    local OUTLINE     = Color3.fromRGB(42, 49, 45)
    local TEXT_MAIN   = Color3.fromRGB(235, 235, 235)
    local TEXT_DIM    = Color3.fromRGB(150, 155, 150)
    local ACCENT      = Color3.fromRGB(202, 243, 255)
    local OPEN_GREEN  = Color3.fromRGB(130, 220, 140)
    local COVERED_RED = Color3.fromRGB(225, 105, 105)
    local FONT        = Enum.Font.Code

    local panel = Instance.new("Frame")
    panel.Name = "TargetCard"
    panel.AnchorPoint = Vector2.new(0.5, 0)
    panel.Position = UDim2.new(0.5, 0, 0, 12)
    panel.Size = UDim2.new(0, 640, 0, 96)
    panel.BackgroundColor3 = BG
    panel.BorderSizePixel = 0
    panel.Parent = EchoHUDGui

    local panelStroke = Instance.new("UIStroke")
    panelStroke.Color = BORDER
    panelStroke.Thickness = 1
    panelStroke.Parent = panel

    -- 1px accent strip across the top, like the menu window
    local accentLine = Instance.new("Frame")
    accentLine.Name = "AccentLine"
    accentLine.Position = UDim2.new(0, 0, 0, 0)
    accentLine.Size = UDim2.new(1, 0, 0, 1)
    accentLine.BackgroundColor3 = ACCENT
    accentLine.BorderSizePixel = 0
    accentLine.Parent = panel

    -- header strip
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Position = UDim2.new(0, 1, 0, 1)
    header.Size = UDim2.new(1, -2, 0, 22)
    header.BackgroundColor3 = INLINE
    header.BorderSizePixel = 0
    header.Parent = panel

    local title = Instance.new("TextLabel")
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Size = UDim2.new(0, 250, 1, 0)
    title.BackgroundTransparency = 1
    title.Text = "echo — qb aimbot"
    title.Font = FONT
    title.TextSize = 13
    title.TextColor3 = ACCENT
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header

    local lockLabel = Instance.new("TextLabel")
    lockLabel.Name = "Lock"
    lockLabel.AnchorPoint = Vector2.new(1, 0)
    lockLabel.Position = UDim2.new(1, -10, 0, 0)
    lockLabel.Size = UDim2.new(0, 120, 1, 0)
    lockLabel.BackgroundTransparency = 1
    lockLabel.Text = ""
    lockLabel.Font = FONT
    lockLabel.TextSize = 12
    lockLabel.TextColor3 = ACCENT
    lockLabel.TextXAlignment = Enum.TextXAlignment.Right
    lockLabel.Parent = header

    local function AddOutline(frame)
        local s = Instance.new("UIStroke")
        s.Color = OUTLINE
        s.Thickness = 1
        s.Parent = frame
        return s
    end

    -- avatar box
    local avatarBox = Instance.new("Frame")
    avatarBox.Name = "AvatarBox"
    avatarBox.Position = UDim2.new(0, 10, 0, 31)
    avatarBox.Size = UDim2.new(0, 56, 0, 56)
    avatarBox.BackgroundColor3 = ELEMENT
    avatarBox.BorderSizePixel = 0
    avatarBox.Parent = panel
    AddOutline(avatarBox)

    local avatar = Instance.new("ImageLabel")
    avatar.Name = "Avatar"
    avatar.Position = UDim2.new(0, 1, 0, 1)
    avatar.Size = UDim2.new(1, -2, 1, -2)
    avatar.BackgroundTransparency = 1
    avatar.Image = ""
    avatar.Parent = avatarBox

    local avatarFallback = Instance.new("TextLabel")
    avatarFallback.Name = "Fallback"
    avatarFallback.Size = UDim2.new(1, 0, 1, 0)
    avatarFallback.BackgroundTransparency = 1
    avatarFallback.Text = "bot"
    avatarFallback.Font = FONT
    avatarFallback.TextSize = 14
    avatarFallback.TextColor3 = TEXT_DIM
    avatarFallback.Visible = false
    avatarFallback.Parent = avatarBox

    -- name block
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "TargetName"
    nameLabel.Position = UDim2.new(0, 76, 0, 36)
    nameLabel.Size = UDim2.new(0, 148, 0, 22)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "no target"
    nameLabel.Font = FONT
    nameLabel.TextSize = 17
    nameLabel.TextColor3 = TEXT_MAIN
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
    nameLabel.Parent = panel

    local subLabel = Instance.new("TextLabel")
    subLabel.Name = "TargetSub"
    subLabel.Position = UDim2.new(0, 76, 0, 60)
    subLabel.Size = UDim2.new(0, 148, 0, 16)
    subLabel.BackgroundTransparency = 1
    subLabel.Text = ""
    subLabel.Font = FONT
    subLabel.TextSize = 12
    subLabel.TextColor3 = TEXT_DIM
    subLabel.TextXAlignment = Enum.TextXAlignment.Left
    subLabel.TextTruncate = Enum.TextTruncate.AtEnd
    subLabel.Parent = panel

    local function MakeStatBox(x, width, titleText)
        local box = Instance.new("Frame")
        box.Position = UDim2.new(0, x, 0, 31)
        box.Size = UDim2.new(0, width, 0, 56)
        box.BackgroundColor3 = ELEMENT
        box.BorderSizePixel = 0
        box.Parent = panel
        AddOutline(box)

        local boxTitle = Instance.new("TextLabel")
        boxTitle.Position = UDim2.new(0, 0, 0, 6)
        boxTitle.Size = UDim2.new(1, 0, 0, 14)
        boxTitle.BackgroundTransparency = 1
        boxTitle.Text = titleText
        boxTitle.Font = FONT
        boxTitle.TextSize = 11
        boxTitle.TextColor3 = TEXT_DIM
        boxTitle.TextXAlignment = Enum.TextXAlignment.Center
        boxTitle.Parent = box

        local value = Instance.new("TextLabel")
        value.Position = UDim2.new(0, 2, 0, 24)
        value.Size = UDim2.new(1, -4, 0, 24)
        value.BackgroundTransparency = 1
        value.Text = "-"
        value.Font = FONT
        value.TextSize = 18
        value.TextColor3 = TEXT_MAIN
        value.TextXAlignment = Enum.TextXAlignment.Center
        value.TextTruncate = Enum.TextTruncate.AtEnd
        value.Parent = box

        return value
    end

    local modeValue   = MakeStatBox(236, 96,  "mode")
    local powerValue  = MakeStatBox(340, 80,  "power")
    local angleValue  = MakeStatBox(428, 88,  "angle")
    local statusValue = MakeStatBox(524, 106, "status")

    HUD.Avatar = avatar
    HUD.AvatarFallback = avatarFallback
    HUD.Name = nameLabel
    HUD.Sub = subLabel
    HUD.Mode = modeValue
    HUD.Power = powerValue
    HUD.Angle = angleValue
    HUD.Status = statusValue
    HUD.Lock = lockLabel
    HUD.OpenColor = OPEN_GREEN
    HUD.CoveredColor = COVERED_RED
    HUD.MainColor = TEXT_MAIN
end

local LastAvatarUserId = nil

local function UpdateAimbotCards(throwType, power, angleDeg, flightTime, isOpen, playerName)
    local holdingBall = Character and Character:FindFirstChild("Football") ~= nil
    if not Echo.QBAimbot.Enabled or not holdingBall then
        EchoHUDGui.Enabled = false
        return
    end

    EchoHUDGui.Enabled = true

    local target = ClosestPlayer
    local displayName = playerName or "No Target"
    local subText = ""
    local userId = nil

    pcall(function()
        if target and target:IsA("Player") then
            displayName = target.DisplayName or target.Name
            subText = "@" .. target.Name
            userId = target.UserId
        elseif target then
            displayName = target.Name
            subText = "bot"
        end
    end)

    HUD.Name.Text = displayName
    HUD.Sub.Text = subText

    if userId and userId > 0 then
        if LastAvatarUserId ~= userId then
            LastAvatarUserId = userId
            HUD.Avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. userId .. "&w=48&h=48"
        end
        HUD.Avatar.ImageTransparency = 0
        HUD.AvatarFallback.Visible = false
    else
        LastAvatarUserId = nil
        HUD.Avatar.Image = ""
        HUD.Avatar.ImageTransparency = 1
        HUD.AvatarFallback.Visible = true
    end

    HUD.Mode.Text = tostring(throwType)
    HUD.Power.Text = tostring(power)
    HUD.Angle.Text = tostring(angleDeg) .. "\194\176"

    if isOpen then
        HUD.Status.Text = "open"
        HUD.Status.TextColor3 = HUD.OpenColor
    else
        HUD.Status.Text = "covered"
        HUD.Status.TextColor3 = HUD.CoveredColor
    end

    HUD.Lock.Text = (Echo.QBAimbot.TargetLock and Echo.QBAimbot.LockedTarget) and "[ locked ]" or ""
end

local function CreateAimbotCard(throwType, power, angleDeg, flightTime, cardPosition, isOpen, playerName)
    UpdateAimbotCards(throwType, power, angleDeg, flightTime, isOpen, playerName)
    return nil
end

-- // FOV Circle state
local FOVCircle = nil
local FOVCircleFrame = nil
local HasDrawingAPI = pcall(function() return Drawing end)

local function UpdateFOVCircle()
    local fov = Echo.QBAimbot.FOV
    local show = Echo.QBAimbot.ShowFOV and Echo.QBAimbot.Enabled

    if HasDrawingAPI then
        if show then
            if not FOVCircle then
                FOVCircle = Drawing.new("Circle")
                FOVCircle.Thickness = 1.5
                FOVCircle.NumSides = 64
                FOVCircle.Filled = false
                FOVCircle.Transparency = 0.8
            end
            FOVCircle.Visible = true
            FOVCircle.Radius = fov
            FOVCircle.Color = Echo.QBAimbot.PredictionColor
            FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y)
        else
            if FOVCircle then
                FOVCircle.Visible = false
            end
        end
    else
        if show then
            if not FOVCircleFrame or not FOVCircleFrame.Parent then
                local gui = Instance.new("ScreenGui")
                gui.Name = "FOVCircleGui"
                gui.ResetOnSpawn = false
                gui.IgnoreGuiInset = true
                gui.Parent = LocalPlayer.PlayerGui

                FOVCircleFrame = Instance.new("Frame")
                FOVCircleFrame.Name = "FOVCircle"
                FOVCircleFrame.BackgroundTransparency = 1
                FOVCircleFrame.BorderSizePixel = 0
                FOVCircleFrame.Parent = gui

                local stroke = Instance.new("UIStroke")
                stroke.Thickness = 1.5
                stroke.Color = Echo.QBAimbot.PredictionColor
                stroke.Transparency = 0.2
                stroke.Parent = FOVCircleFrame

                local corner = Instance.new("UICorner")
                corner.CornerRadius = UDim.new(0.5, 0)
                corner.Parent = FOVCircleFrame
            end
            local diam = fov * 2
            FOVCircleFrame.Size = UDim2.new(0, diam, 0, diam)
            FOVCircleFrame.Position = UDim2.new(0, Mouse.X - fov, 0, Mouse.Y - fov)
            FOVCircleFrame.Visible = true
            local stroke = FOVCircleFrame:FindFirstChildOfClass("UIStroke")
            if stroke then stroke.Color = Echo.QBAimbot.PredictionColor end
        else
            if FOVCircleFrame then
                FOVCircleFrame.Visible = false
            end
        end
    end
end

-- // Receiver ESP state
local ReceiverESPGuis = {}

local function CleanupReceiverESP()
    for _, gui in pairs(ReceiverESPGuis) do
        pcall(function() gui:Destroy() end)
    end
    ReceiverESPGuis = {}
end

local function GetClosestDefenderToReceiver(Receiver)
    local receiverHRP
    if IsBot(Receiver.Name) then
        receiverHRP = Receiver:FindFirstChild("HumanoidRootPart")
    else
        receiverHRP = Receiver.Character and Receiver.Character:FindFirstChild("HumanoidRootPart")
    end
    if not receiverHRP then return math.huge end

    local closestDist = math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
            pcall(function()
                local defChar = player.Character
                if defChar then
                    local defHRP = defChar:FindFirstChild("HumanoidRootPart")
                    if defHRP then
                        local dist = (defHRP.Position - receiverHRP.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                        end
                    end
                end
            end)
        end
    end
    return closestDist
end

local function IsReceiverOpen(Receiver)
    return GetClosestDefenderToReceiver(Receiver) > Echo.QBAimbot.MinOpenDistance
end

local function GatherAllReceivers()
    local receivers = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team == LocalPlayer.Team then
            local Char = player.Character
            if Char and Char:FindFirstChild("HumanoidRootPart") then
                table.insert(receivers, { Target = player, IsBot = false, HRP = Char:FindFirstChild("HumanoidRootPart") })
            end
        end
    end

    for _, bot in pairs(workspace:GetChildren()) do
        if bot.Name == "npcwr" then
            pcall(function()
                local stationA = bot:FindFirstChild("a")
                local stationB = bot:FindFirstChild("b")
                if stationA then
                    local bot1 = stationA:FindFirstChild("bot 1")
                    if bot1 and bot1:FindFirstChild("HumanoidRootPart") then
                        table.insert(receivers, { Target = bot1, IsBot = true, HRP = bot1:FindFirstChild("HumanoidRootPart") })
                    end
                end
                if stationB then
                    local bot2 = stationB:FindFirstChild("bot 3")
                    if bot2 and bot2:FindFirstChild("HumanoidRootPart") then
                        table.insert(receivers, { Target = bot2, IsBot = true, HRP = bot2:FindFirstChild("HumanoidRootPart") })
                    end
                end
            end)
        end
    end

    return receivers
end

local function GetClosestPlayerToMouse()
    -- Target Lock: return locked target if valid
    if Echo.QBAimbot.TargetLock and Echo.QBAimbot.LockedTarget then
        local locked = Echo.QBAimbot.LockedTarget
        local valid = false
        pcall(function()
            if IsBot(locked.Name) then
                valid = locked:FindFirstChild("HumanoidRootPart") ~= nil
            else
                valid = locked.Character and locked.Character:FindFirstChild("HumanoidRootPart") ~= nil
            end
        end)
        if valid then return locked end
        Echo.QBAimbot.LockedTarget = nil
    end

    local MousePosition = Vector2.new(Mouse.X, Mouse.Y)
    local fov = Echo.QBAimbot.FOV
    local priority = Echo.QBAimbot.TargetPriority
    local receivers = GatherAllReceivers()

    if priority == "Most Open" then
        local bestReceiver = nil
        local bestOpenDist = -1

        for _, r in pairs(receivers) do
            local screenPos, onScreen = GetScreenPosition(r.HRP)
            local screenDist = (screenPos - MousePosition).Magnitude
            if fov > 0 and screenDist > fov then continue end

            local openDist = GetClosestDefenderToReceiver(r.Target)
            if openDist > bestOpenDist then
                bestOpenDist = openDist
                bestReceiver = r.Target
            end
        end

        if Echo.QBAimbot.TargetLock and bestReceiver then
            Echo.QBAimbot.LockedTarget = bestReceiver
        end
        return bestReceiver

    elseif priority == "Furthest Downfield" then
        local bestReceiver = nil
        local bestZ = -math.huge

        if not HumanoidRootPart then return nil end
        local qbZ = HumanoidRootPart.Position.Z

        for _, r in pairs(receivers) do
            local screenPos, onScreen = GetScreenPosition(r.HRP)
            local screenDist = (screenPos - MousePosition).Magnitude
            if fov > 0 and screenDist > fov then continue end

            local downfieldDist = math.abs(r.HRP.Position.Z - qbZ)
            if downfieldDist > bestZ then
                bestZ = downfieldDist
                bestReceiver = r.Target
            end
        end

        if Echo.QBAimbot.TargetLock and bestReceiver then
            Echo.QBAimbot.LockedTarget = bestReceiver
        end
        return bestReceiver

    else -- "Closest To Mouse" (default)
        local ClosestP = nil
        local ClosestDistance = math.huge

        for _, r in pairs(receivers) do
            local screenPos, onScreen = GetScreenPosition(r.HRP)
            local screenDist = (screenPos - MousePosition).Magnitude

            if fov > 0 and screenDist > fov then continue end

            if screenDist < ClosestDistance then
                ClosestP = r.Target
                ClosestDistance = screenDist
            end
        end

        if Echo.QBAimbot.TargetLock and ClosestP then
            Echo.QBAimbot.LockedTarget = ClosestP
        end
        return ClosestP
    end
end

local function CalculateRouteOfPlayer(Player)
    local RouteType = "Still"
    if not IsBot(Player.Name) then
        local ok, result = pcall(function()
            local LocalCharacter = LocalPlayer.Character
            if not LocalCharacter then return "Still" end
            local LocalHRP = LocalCharacter:FindFirstChild("HumanoidRootPart")
            if not LocalHRP then return "Still" end

            local Char = Player.Character
            if not Char then return "Still" end
            local Hum = Char:FindFirstChild("Humanoid")
            local HRP = Char:FindFirstChild("HumanoidRootPart")
            if not Hum or not HRP then return "Still" end

            local DirectionMoving = Hum.MoveDirection
            if DirectionMoving.Magnitude < 0.1 then return "Still" end

            local Distance = (HRP.Position - LocalHRP.Position)
            if Distance.Magnitude < 1 then return "Still" end
            local Direction = Distance.Unit

            local Z2
            if GetFieldOrientation(DirectionMoving) == -1 then
                Z2 = (Direction * Vector3.new(0, 0, -1))
            else
                Z2 = (Direction * Vector3.new(0, 0, 1))
            end

            local StreakingRoutesDotProduct = DirectionMoving:Dot(Z2)

            local rt = "Still"
            if StreakingRoutesDotProduct >= 0.8 or StreakingRoutesDotProduct <= -0.8 then
                rt = "Straight"
            elseif StreakingRoutesDotProduct >= 0.45 or StreakingRoutesDotProduct <= -0.45 then
                rt = "Post"
            elseif StreakingRoutesDotProduct >= 0.2 or StreakingRoutesDotProduct <= -0.2 then
                rt = "Slant"
            end

            -- Use normalized dot for Comeback so distance doesn't skew the check
            local DirectionDotNorm = DirectionMoving:Dot(Direction)
            if DirectionDotNorm < -0.35 then
                rt = "Comeback"
            end

            return rt
        end)
        if ok then
            RouteType = result
        end
    else
        RouteType = "Straight"
    end

    return RouteType
end

local function HorizontalRangeOfProjectile(Target)
    local TargetRootPart
    if IsBot(Target.Name) then
        TargetRootPart = Target:FindFirstChild("Head")
    else
        TargetRootPart = Target.Character and Target.Character:FindFirstChild("Head")
    end

    if not TargetRootPart or not LocalPlayer.Character then return 0 end

    local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not HRP then return 0 end

    local ProjectileRange = (HRP.Position - TargetRootPart.Position)
    local HorizontalRange = Vector2.new(ProjectileRange.X, ProjectileRange.Z).Magnitude
    return HorizontalRange
end

local function GetThrowType(Target)
    if not Target then return "Dime" end

    local RP = HorizontalRangeOfProjectile(Target)
    local r = CalculateRouteOfPlayer(Target)
    local calculatedThrowType = "Dime"

    if IsBot(Target.Name) then
        calculatedThrowType = "Dime"
    else
        if RP <= 100 and r == "Slant" then
            calculatedThrowType = "Bullet"
        elseif RP > 100 and r == "Slant" then
            calculatedThrowType = "Dive"
        elseif RP <= 150 and r == "Straight" then
            calculatedThrowType = "Dive"
        elseif RP > 150 and r == "Straight" then
            calculatedThrowType = "Dime"
        elseif RP <= 150 and r == "Post" then
            calculatedThrowType = "Dive"
        elseif RP > 150 and r == "Post" then
            calculatedThrowType = "Dime"
        elseif RP <= 100 and r == "Still" then
            calculatedThrowType = "Dot"
        elseif RP > 100 and r == "Still" then
            calculatedThrowType = "Dime"
        elseif RP <= 150 and r == "Comeback" then
            calculatedThrowType = "Bullet"
        elseif RP > 150 and r == "Comeback" then
            calculatedThrowType = "Dive"
        end
    end

    return calculatedThrowType
end

local ThrowTypeOffsets = {
    ["Dime"] = Vector3.new(0, 10, 0),
    ["Mag"] = Vector3.new(0, 7, 0),
    ["Dive"] = Vector3.new(0, 3, 0),
    ["Dot"] = Vector3.new(0, 2, 0),
    ["Fade"] = Vector3.new(0, 9, -2),
    ["Bullet"] = Vector3.new(0, 5, 0),
    ["Jump"] = Vector3.new(0, 5, 0),
}

local function CalculateHighSpeedLowAngle(Gravity, Speed)
    if not ClosestPlayer then return 0 end
    local ProjectileRange = HorizontalRangeOfProjectile(ClosestPlayer)
    local Route = CalculateRouteOfPlayer(ClosestPlayer)
    local sinVal = (ProjectileRange * Gravity) / (Speed ^ 2)
    if sinVal > 1 or sinVal < -1 then return math.rad(45) end
    local Equation

    if Route == "Comeback" then
        Equation = (ProjectileRange < 150) and 0.65 * math.asin(sinVal) or 0.6 * math.asin(sinVal)
    elseif Route == "Still" then
        Equation = 0.5 * math.asin(sinVal)
    elseif Route == "Post" then
        Equation = (ProjectileRange < 150) and 0.8 * math.asin(sinVal) or 0.84 * math.asin(sinVal)
    else
        Equation = (ProjectileRange < 150) and 0.82 * math.asin(sinVal) or 0.85 * math.asin(sinVal)
    end

    return Equation
end

local function CalculateLaunchAngleBullet(Gravity, InitialVelocity)
    if not ClosestPlayer then return 0 end
    local MaxAngle = 45
    local ProjectileRange = HorizontalRangeOfProjectile(ClosestPlayer)

    if InitialVelocity <= 0 then return 0 end

    local SinToTheta = (ProjectileRange * Gravity) / (InitialVelocity ^ 2)
    if SinToTheta > 1 or SinToTheta < -1 then return 0 end

    local AngleRadians = math.asin(SinToTheta) / 2
    local AngleDegrees = math.deg(AngleRadians)

    if AngleDegrees > MaxAngle then return math.rad(MaxAngle) end
    return AngleRadians
end

local function CalculateLaunchAngle(Gravity, InitialVelocity)
    if not ClosestPlayer then return 0 end
    local ProjectileRange = HorizontalRangeOfProjectile(ClosestPlayer)
    local sinVal = Gravity * ProjectileRange / (InitialVelocity ^ 2)
    if sinVal > 1 or sinVal < -1 then return math.rad(45) end
    local LaunchAngle = 0.65 * math.asin(sinVal)
    return LaunchAngle
end

local function GetTimeOfFlightProjectile(InitialVelocity, RequiredAngle, Gravity)
    local TimeOfFlight = (2 * InitialVelocity * math.sin(RequiredAngle)) / Gravity
    return TimeOfFlight
end

local function KeepPositionInBounds(TargetPosition, MinX, MinZ)
    local ClampedX = math.clamp(TargetPosition.X, -MinX, MinX)
    local ClampedZ = math.clamp(TargetPosition.Z, -MinZ, MinZ)
    return Vector3.new(ClampedX, TargetPosition.Y, ClampedZ)
end

local function IsMoving(OtherPlayer)
    local ok, result = pcall(function()
        local Char = OtherPlayer.Character
        local Hum = Char:FindFirstChild("Humanoid")
        return Hum and Hum.MoveDirection.Magnitude > 0
    end)
    return ok and result or false
end

local function IsBotMoving(BotSpeed)
    return BotSpeed.Magnitude > 0.5
end

local function BotEstimatedVel(Time, Bot)
    local ok, result = pcall(function()
        local HRP = Bot:FindFirstChild("HumanoidRootPart")
        if not HRP then return Bot:FindFirstChild("Head") and Bot:FindFirstChild("Head").Position or Vector3.zero end

        local Speed = HRP.Velocity
        local CurrentThrowType = GetThrowType(Bot)
        local Botequation
        local LeadBot3, LeadBot1

        if IsBotMoving(Speed) then
            LeadBot3 = {
                ["Dime"] = Vector3.new(-1, 1.25, -6),
                ["Mag"] = Vector3.new(-2, 2, -11),
                ["Dive"] = Vector3.new(-1.25, 1.5, -9),
                ["Dot"] = Vector3.new(-0.09, 0.09, -4),
                ["Fade"] = Vector3.new(0, 0, 0),
                ["Bullet"] = Vector3.new(-5, -1, -1.25),
                ["Jump"] = Vector3.new(-1, 2.25, -5)
            }
            LeadBot1 = {
                ["Dime"] = Vector3.new(1, 1.25, 6),
                ["Mag"] = Vector3.new(2, 2, 11),
                ["Dive"] = Vector3.new(1.25, 1.5, 9),
                ["Dot"] = Vector3.new(0.09, 0.09, 4),
                ["Fade"] = Vector3.new(0, 0, 0),
                ["Bullet"] = Vector3.new(5, 1, 1.25),
                ["Jump"] = Vector3.new(1, 2, 5)
            }
        else
            LeadBot3 = {
                ["Dime"] = Vector3.zero, ["Mag"] = Vector3.zero, ["Dive"] = Vector3.zero,
                ["Dot"] = Vector3.zero, ["Fade"] = Vector3.zero, ["Bullet"] = Vector3.zero,
                ["Jump"] = Vector3.new(0, 4, 0)
            }
            LeadBot1 = {
                ["Dime"] = Vector3.zero, ["Mag"] = Vector3.zero, ["Dive"] = Vector3.zero,
                ["Dot"] = Vector3.zero, ["Fade"] = Vector3.zero, ["Bullet"] = Vector3.zero,
                ["Jump"] = Vector3.new(0, 5, 0)
            }
        end

        local TimeAccount = Speed * Time
        if Bot.Name == "bot 3" and IsBotMoving(Speed) then
            Botequation = HRP.Position + TimeAccount + (LeadBot3[CurrentThrowType] or Vector3.zero)
        elseif Bot.Name == "bot 1" and IsBotMoving(Speed) then
            Botequation = HRP.Position + TimeAccount + (LeadBot1[CurrentThrowType] or Vector3.zero)
        elseif Bot.Name == "bot 3" and not IsBotMoving(Speed) then
            Botequation = HRP.Position + (LeadBot3[CurrentThrowType] or Vector3.zero)
        else
            Botequation = HRP.Position
        end

        return Botequation
    end)

    return ok and result or Vector3.zero
end

local function GetReceiverTargetPosition(TimeOfFlight, Receiver)
    local ok, result = pcall(function()
        local Char = Receiver.Character
        if not Char then return Vector3.zero end

        local Hum = Char:FindFirstChild("Humanoid")
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        local Head = Char:FindFirstChild("Head")
        if not Hum or not HRP or not Head then return Vector3.zero end

        local MoveDir = Hum.MoveDirection
        local Velocity2 = HRP.Velocity

        local CustomLead = Echo.QBAimbot.CustomLead or 0
        local CurrentThrowType = GetThrowType(Receiver)

        local FieldOrientation = GetFieldOrientation(MoveDir)
        local FieldOrientationX = GetFieldOrientationX(MoveDir)

        local LeadNumber

        if IsMoving(Receiver) then
            if FieldOrientation == 1 and FieldOrientationX == 1 then
                LeadNumber = {
                    Dime = Vector3.new(1, 1.25, 8), Mag = Vector3.new(2, 2, 15),
                    Dive = Vector3.new(1.25, 1.5, 12), Dot = Vector3.new(0.09, 0.09, 6),
                    Fade = Vector3.zero, Bullet = Vector3.new(5, 1, 2),
                    Jump = Vector3.new(1, 2.25, 7)
                }
            elseif FieldOrientation == -1 and FieldOrientationX == -1 then
                LeadNumber = {
                    Dime = Vector3.new(-1, 1.25, -8), Mag = Vector3.new(-2, 2, -15),
                    Dive = Vector3.new(-1.25, 1.5, -12), Dot = Vector3.new(-0.09, 0.09, -6),
                    Fade = Vector3.zero, Bullet = Vector3.new(-5, -1, -2),
                    Jump = Vector3.new(-1, 2.25, -7)
                }
            elseif FieldOrientation == 1 and FieldOrientationX == -1 then
                LeadNumber = {
                    Dime = Vector3.new(-1, 1.25, 8), Mag = Vector3.new(-2, 2, 15),
                    Dive = Vector3.new(-1.25, 1.5, 12), Dot = Vector3.new(-0.09, 0.09, 6),
                    Fade = Vector3.zero, Bullet = Vector3.new(-5, -1, 2),
                    Jump = Vector3.new(-1, 2.25, 7)
                }
            elseif FieldOrientation == -1 and FieldOrientationX == 1 then
                LeadNumber = {
                    Dime = Vector3.new(1, 1.25, -8), Mag = Vector3.new(2, 2, -15),
                    Dive = Vector3.new(1.25, 1.5, -12), Dot = Vector3.new(0.09, 0.09, -6),
                    Fade = Vector3.zero, Bullet = Vector3.new(5, -1, -2),
                    Jump = Vector3.new(1, 2.25, -7)
                }
            else
                LeadNumber = {
                    Dime = Vector3.zero, Mag = Vector3.zero, Dive = Vector3.zero,
                    Dot = Vector3.zero, Fade = Vector3.zero, Bullet = Vector3.zero,
                    Jump = Vector3.new(0, 5, 0)
                }
            end
        else
            LeadNumber = {
                Dime = Vector3.zero, Mag = Vector3.zero, Dive = Vector3.zero,
                Dot = Vector3.zero, Fade = Vector3.zero, Bullet = Vector3.zero,
                Jump = Vector3.new(0, 5, 0)
            }
        end

        -- When AutoAngle is on, extend the lead window by ~0.35s to compensate for
        -- the throw animation delay (ball leaves hand slightly after remote fires).
        local effectiveTOF = TimeOfFlight
        if Echo.QBAimbot.AutoAngle and not Echo.QBAimbot.HighestPowerMode then
            effectiveTOF = TimeOfFlight + 0.5
        end

        -- Physics prediction: actual velocity Ã— effective time of flight for all throw types.
        -- CustomLead (0-100) adds extra manual lead in the movement direction on top.
        local ThrowTypeAccountability
        if Echo.QBAimbot.HighestPowerMode then
            ThrowTypeAccountability = Velocity2 * TimeOfFlight
        elseif CustomLead ~= 0 then
            local flatDir = Vector3.new(MoveDir.X, 0, MoveDir.Z)
            local extraLead = (flatDir.Magnitude > 0) and (flatDir.Unit * (CustomLead * effectiveTOF)) or Vector3.zero
            ThrowTypeAccountability = Velocity2 * effectiveTOF + extraLead
        else
            ThrowTypeAccountability = Velocity2 * effectiveTOF
        end

        local Equation
        local BasePos = Echo.QBAimbot.HighestPowerMode and HRP.Position or Head.Position

        if IsMoving(Receiver) then
            Equation = BasePos + ThrowTypeAccountability + (LeadNumber[CurrentThrowType] or Vector3.zero)
        elseif CurrentThrowType == "Jump" then
            Equation = BasePos + Vector3.new(0, 6, 0)
        else
            Equation = BasePos
        end

        return Equation
    end)

    return ok and result or Vector3.zero
end

local function VelocityNeededToReachPosition(Angle, StartPosition, EndPosition, Gravity, Time)
    local Displacement = EndPosition - StartPosition
    local HorizDisp = Vector3.new(Displacement.X, 0, Displacement.Z)
    local HorizDist = HorizDisp.Magnitude

    local HorizVel = (HorizDist > 0) and (HorizDisp.Unit * (HorizDist / Time)) or Vector3.zero
    local VertVel = (Displacement.Y - 0.5 * Gravity.Y * Time * Time) / Time
    local EstimatedVelocity = HorizVel + Vector3.new(0, VertVel, 0)

    local Direction = EstimatedVelocity.Magnitude > 0 and EstimatedVelocity.Unit or Vector3.new(0, 1, 0)
    local Power = EstimatedVelocity.Magnitude + 0.05

    if Echo.QBAimbot.HighestPowerMode then
        return EstimatedVelocity, Direction, math.clamp(math.round(Power), 85, 95)
    else
        return EstimatedVelocity, Direction, math.clamp(math.round(Power), 0, 95)
    end
end

local function ThrowFootball(Football, StartPosition, Direction, Power)
    pcall(function()
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character
        if not character then return end

        local football = character:FindFirstChildOfClass("Tool")
        if not football then return end

        local handle = football:FindFirstChild("Handle")
        if not handle then return end

        local remote = handle:FindFirstChild("RemoteEvent")
        if not remote then return end

        local head = character:FindFirstChild("Head")
        if not head then return end

        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local finalDirection = Direction or Vector3.new(0, 0, 0)

        if (game.PlaceId == 81310542478972) then
            local arg1 = head.Position
            local arg2 = head.Position + finalDirection * 10000
            local arg3 = tonumber(Power) or 0
            remote:FireServer("Clicked", arg1, arg2, arg3)
        else
            local arg1 = (root.CFrame * CFrame.new(0, 1.5, 0)).Position + Vector3.new(70000000, 0, 0)
            local arg2 = head.Position + finalDirection * 10000
            local arg3 = tonumber(Power) or 0
            remote:FireServer("Clicked", arg1, arg2, arg3, 1)
        end
    end)
end

local function GetBallCarrier()
    for _, Player in next, Players:GetPlayers() do
        if Player and Player.Character and Player.Team ~= LocalPlayer.Team then
            local Tool = Player.Character:FindFirstChildWhichIsA("Tool")
            if Tool then
                return Player.Character
            end
        end
    end
end

local function CharacterHasFootball()
    return Character and Character:FindFirstChild("Football") ~= nil
end

-- // Mobile UI Buttons

local MobileButtons = {}

if IsMobile then
    local MobileGui = Instance.new("ScreenGui")
    MobileGui.Name = "EchoMobile"
    MobileGui.ResetOnSpawn = false
    MobileGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    MobileGui.Parent = LocalPlayer.PlayerGui

    local buttonDefs = {
        { Name = "Throw", Key = "Q", Color = Color3.fromRGB(50, 120, 255), Order = 1 },
        { Name = "Tackle", Key = "Click", Color = Color3.fromRGB(255, 60, 60), Order = 2 },
        { Name = "QuickTP", Key = "F", Color = Color3.fromRGB(60, 200, 60), Order = 3 },
        { Name = "Swat", Key = "R", Color = Color3.fromRGB(200, 150, 50), Order = 4 },
        { Name = "Catch", Key = "C", Color = Color3.fromRGB(150, 50, 200), Order = 5 },
        { Name = "FlyUp", Key = "Space", Color = Color3.fromRGB(100, 200, 255), Order = 6 },
        { Name = "FlyDown", Key = "Shift", Color = Color3.fromRGB(100, 150, 200), Order = 7 },
    }

    for _, def in pairs(buttonDefs) do
        local btn = Instance.new("TextButton")
        btn.Name = def.Name .. "Btn"
        btn.Size = UDim2.new(0, 60, 0, 60)
        btn.Position = UDim2.new(1, -80, 1, -80 * def.Order)
        btn.BackgroundColor3 = def.Color
        btn.BackgroundTransparency = 0.3
        btn.Text = def.Name
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamBold
        btn.Parent = MobileGui

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)
        corner.Parent = btn

        -- Make draggable
        local dragging = false
        local dragStart, startPos

        btn.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = btn.Position
            end
        end)

        btn.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                btn.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end)

        btn.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)

        MobileButtons[def.Name] = btn
    end
end

-- // Feature Loops / Threads

-- firetouchinterest can throw "new overlap in different world" if either part
-- leaves the physics world mid-call; an unhandled throw kills the whole loop,
-- so every touch is wrapped.
local function SafeTouch(part, ball)
    if not part.Parent or not ball.Parent then return end
    if not part:IsDescendantOf(workspace) or not ball:IsDescendantOf(workspace) then return end
    pcall(firetouchinterest, part, ball, 0)
    pcall(firetouchinterest, part, ball, 1)
end

local MagnetGrabbing = false
local LastMagnetGrabTick = 0

local function MagnetGrab(Football, CatchParts, duration, enabledCheck, grabCooldown)
    if MagnetGrabbing then return end

    local now = tick()
    if now - LastMagnetGrabTick < (grabCooldown or 0.35) then return end

    MagnetGrabbing = true
    LastMagnetGrabTick = now

    local deadline = tick() + duration
    while tick() < deadline and enabledCheck() and EchoAlive() do
        if not Football.Parent or Football:IsDescendantOf(Character) or CharacterHasFootball() then break end
        for _, part in ipairs(CatchParts) do
            SafeTouch(part, Football)
        end
        task.wait()
    end

    MagnetGrabbing = false
end

-- Shared with UI (Anti OOB) — must live outside deferred gameplay loops
local Boundaries = {}

-- Gameplay loops start AFTER menu (Luarmor freezes if 30+ loops spawn mid-boot)
local function EchoStartGameplayLoops()
Threads.FootballMagnets = task.spawn(function()
    while EchoAlive() and task.wait() do
        pcall(function()
            if not Echo.Catching.Magnets or not Character or not HumanoidRootPart then return end
            if CharacterHasFootball() then return end

            local Football = GetClosestFootball()
            if not Football or Football:IsDescendantOf(Character) then return end

            local CatchParts = GetCatchParts()
            if #CatchParts == 0 then return end

            local Distance = (Football.Position - HumanoidRootPart.Position).Magnitude
            if Distance > Echo.Catching.CustomizableRadius then return end

            MagnetGrab(
                Football,
                CatchParts,
                0.5,
                function() return Echo.Catching.Magnets end,
                math.max(Echo.Catching.CustomizableDelay, 0.35)
            )
        end)
    end
end)

-- Magnets V2: tighter radius, single strong grab attempt
Threads.FootballMagnetsV2 = task.spawn(function()
    while EchoAlive() and task.wait() do
        pcall(function()
            if not Echo.Catching.MagnetsV2 or not Character or not HumanoidRootPart then return end
            if CharacterHasFootball() then return end

            local Football = GetClosestFootball()
            if not Football or Football:IsDescendantOf(Character) then return end

            local CatchParts = GetCatchParts()
            if #CatchParts == 0 then return end

            local Distance = (Football.Position - HumanoidRootPart.Position).Magnitude
            if Distance > Echo.Catching.CustomizableRadiusV2 then return end

            MagnetGrab(
                Football,
                CatchParts,
                0.35,
                function() return Echo.Catching.MagnetsV2 end,
                math.max(Echo.Catching.CustomizableDelayV2, 0.35)
            )
        end)
    end
end)

-- Magnet hitbox visuals. Center the exact 3D activation radius on the ball:
-- distance(ball, player) <= radius is equivalent to the player entering this sphere.
local function DestroyHitbox(holder)
    if holder.part then
        pcall(function() holder.part:Destroy() end)
        holder.part = nil
    end
end

local function UpdateHitbox(holder, name, color, radius, football)
    if not holder.part or not holder.part.Parent then
        DestroyHitbox(holder)
        local part = Instance.new("Part")
        part.Name = name
        part.Anchored = true
        part.CanCollide = false
        part.CanTouch = false
        part.CanQuery = false
        part.CastShadow = false
        part.Shape = Enum.PartType.Ball
        part.Color = color
        part.Material = Enum.Material.ForceField
        part.Transparency = 0.72
        part.Parent = workspace

        holder.part = part
    end
    local diameter = radius * 2
    holder.part.Size = Vector3.new(diameter, diameter, diameter)
    holder.part.Position = football.Position
end

local MagHitboxV1 = {}
local MagHitboxV2 = {}

-- Old executions of this script keep recreating Part-based "MagnetHitbox"
-- visuals from their own loops; sweep them continuously so only the current
-- generation's adornment ("EchoMagHitbox*") is visible.
Threads.StaleHitboxSweeper = task.spawn(function()
    while EchoAlive() and task.wait(0.2) do
        pcall(function()
            for _, obj in ipairs(workspace:GetChildren()) do
                if obj.Name == "MagnetHitbox" or obj.Name == "MagnetHitboxV2" then
                    obj:Destroy()
                end
            end
        end)
    end
end)

Threads.ShowMagHitbox = task.spawn(function()
    while EchoAlive() and task.wait(0.05) do
        pcall(function()
            if Echo.Catching.ShowMagHitbox and Echo.Catching.Magnets and HumanoidRootPart then
                local football = GetClosestFootball()
                if football and football.Parent and not football:IsDescendantOf(Character) then
                    UpdateHitbox(MagHitboxV1, "EchoMagHitbox", Color3.fromRGB(0, 170, 255), Echo.Catching.CustomizableRadius, football)
                else
                    DestroyHitbox(MagHitboxV1)
                end
            else
                DestroyHitbox(MagHitboxV1)
            end
        end)
    end
    DestroyHitbox(MagHitboxV1)
end)

Threads.ShowMagHitboxV2 = task.spawn(function()
    while EchoAlive() and task.wait(0.05) do
        pcall(function()
            if Echo.Catching.ShowMagHitboxV2 and Echo.Catching.MagnetsV2 and HumanoidRootPart then
                local football = GetClosestFootball()
                if football and football.Parent and not football:IsDescendantOf(Character) then
                    UpdateHitbox(MagHitboxV2, "EchoMagHitboxV2", Color3.fromRGB(0, 170, 255), Echo.Catching.CustomizableRadiusV2, football)
                else
                    DestroyHitbox(MagHitboxV2)
                end
            else
                DestroyHitbox(MagHitboxV2)
            end
        end)
    end
    DestroyHitbox(MagHitboxV2)
end)

-- Fake Ball
Threads.FakeBall = task.spawn(function()
    while task.wait(0.1) do
        if Echo.Catching.FakeBall and HumanoidRootPart then
            if not FakeBallPart or not FakeBallPart.Parent then
                FakeBallPart = Instance.new("Part")
                FakeBallPart.Shape = Enum.PartType.Ball
                FakeBallPart.Size = Vector3.new(2, 2, 2)
                FakeBallPart.Anchored = false
                FakeBallPart.CanCollide = false
                FakeBallPart.Color = Color3.fromRGB(120, 70, 20)
                FakeBallPart.Material = Enum.Material.SmoothPlastic
                FakeBallPart.Name = "FakeBall"

                local weld = Instance.new("WeldConstraint")
                weld.Part0 = HumanoidRootPart
                weld.Part1 = FakeBallPart
                weld.Parent = FakeBallPart

                FakeBallPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(2, 0, 0)
                FakeBallPart.Parent = workspace
            end
        else
            if FakeBallPart and FakeBallPart.Parent then
                FakeBallPart:Destroy()
                FakeBallPart = nil
            end
        end
    end
end)

Threads.AutoRushQB = task.spawn(function()
    while task.wait() do
        if not Echo.Automatics.AutoRush then continue end
        if not Humanoid or not HumanoidRootPart then continue end

        local BallCarrierChar = GetBallCarrier()

        if BallCarrierChar and BallCarrierChar:FindFirstChild("HumanoidRootPart") then
            local Delay = tonumber(Echo.Automatics.AutoRushDelay) or 0.1
            task.wait(Delay)

            if Humanoid and BallCarrierChar:FindFirstChild("HumanoidRootPart") then
                if (game.PlaceId == 82866880824588) then
                    local Carrier = ReplicatedStorage:FindFirstChild("Flags") and ReplicatedStorage.Flags:FindFirstChild("Carrier") and ReplicatedStorage.Flags.Carrier.Value
                    if Carrier and Carrier.Team ~= LocalPlayer.Team and Carrier.Character and Carrier.Character:FindFirstChild("Torso") then
                        Humanoid:MoveTo(Carrier.Character.Torso.Position)
                    end
                else
                    Humanoid:MoveTo(BallCarrierChar.HumanoidRootPart.Position)
                end
            end
        end
    end
end)

Threads.WalkSpeed = task.spawn(function()
    while task.wait(0.1) do
        if Echo.Player.WalkSpeed and Humanoid then
            Humanoid.WalkSpeed = Echo.Player.WSSpeed
        end
    end
end)

Threads.JumpPower = task.spawn(function()
    while task.wait(0.1) do
        if Echo.Player.JumpPower and Humanoid then
            Humanoid.JumpPower = Echo.Player.JP
        end
    end
end)

Threads.CFrameSpeed = task.spawn(function()
    while task.wait(0.1) do
        if Echo.Player.CFrameSpeed and Humanoid and HumanoidRootPart then
            if Humanoid.MoveDirection.Magnitude > 0 then
                HumanoidRootPart.CFrame += Humanoid.MoveDirection * (Echo.Player.CFSpeed / 58.5)
            end
        end
    end
end)

Threads.PullVector = task.spawn(function()
    while task.wait(0.1) do
        if not Echo.Catching.PullVector or not HumanoidRootPart then continue end
        local Football = GetClosestFootball()

        if Football then
            local ok, _ = pcall(function()
                local Distance = (HumanoidRootPart.Position - Football.Position).Magnitude
                local Direction = (Football.Position - HumanoidRootPart.Position).Unit

                if Distance <= Echo.Catching.PullVectorRadius then
                    HumanoidRootPart.Velocity = Direction * math.min((Echo.Catching.PullVectorSpeed * 25), Distance)
                end
            end)
        end
    end
end)

-- Pull Vector V2 with Drag/Push/Pull modes
Threads.PullVectorV2 = task.spawn(function()
    while task.wait(0.1) do
        if not Echo.Catching.PullVectorV2 or not HumanoidRootPart then continue end
        local Football = GetClosestFootball()

        if Football then
            local ok, _ = pcall(function()
                local Distance = (HumanoidRootPart.Position - Football.Position).Magnitude

                if Distance <= Echo.Catching.PullVectorRadiusV2 then
                    local Direction
                    local PullType = Echo.Catching.PullVectorTypeV2

                    if PullType == "Pull" then
                        Direction = (Football.Position - HumanoidRootPart.Position).Unit
                    elseif PullType == "Push" then
                        Direction = (HumanoidRootPart.Position - Football.Position).Unit
                    elseif PullType == "Drag" then
                        Direction = (Football.Position - HumanoidRootPart.Position).Unit * 0.5 + Humanoid.MoveDirection * 0.5
                        if Direction.Magnitude > 0 then Direction = Direction.Unit end
                    end

                    if Direction and Direction.Magnitude > 0 then
                        HumanoidRootPart.Velocity = Direction * math.min(Echo.Catching.PullVectorSpeedV2 * 25, Distance)
                    end
                end
            end)
        end
    end
end)

-- Dive Vector: pull player toward ball when diving
Threads.DiveVector = task.spawn(function()
    while task.wait() do
        if not Echo.Catching.DiveVector or not Humanoid or not HumanoidRootPart then continue end

        local Football = GetClosestFootball()
        if not Football then continue end

        local ok, _ = pcall(function()
            local state = Humanoid:GetState()
            if state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Physics then
                local Distance = (Football.Position - HumanoidRootPart.Position).Magnitude
                if Distance <= Echo.Catching.DiveVectorRadius then
                    local Dir = (Football.Position - HumanoidRootPart.Position).Unit
                    HumanoidRootPart.Velocity = Dir * 60
                end
            end
        end)
    end
end)

Threads.NoJumpCooldown = task.spawn(function()
    while task.wait() do
        if Echo.Physics.NoJumpCooldown and Humanoid then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
        end
    end
end)

Threads.AntiJam = task.spawn(function()
    while task.wait() do
        if Echo.Physics.AntiJam and Character and Humanoid then
            local Head = Character:FindFirstChild("Head")
            local Torso = Character:FindFirstChild("Torso")
            local IsRunning = Humanoid:GetState() == Enum.HumanoidStateType.Running

            if Head and Torso then
                local CanCollide = not Echo.Physics.AntiJam
                if not IsRunning then CanCollide = true end
                Head.CanCollide = CanCollide
                Torso.CanCollide = CanCollide
            end
        end
    end
end)

-- Anti Tackle: keeps PlatformStand false to break tackle lock
Threads.AntiTackle = task.spawn(function()
    while task.wait() do
        if Echo.Physics.AntiTackle and Humanoid then
            if Humanoid.PlatformStand then
                Humanoid.PlatformStand = false
            end
        end
    end
end)

-- No Freeze: prevent player from being frozen
Threads.NoFreeze = task.spawn(function()
    while task.wait(0.1) do
        if Echo.Physics.NoFreeze and Humanoid and HumanoidRootPart then
            pcall(function()
                if HumanoidRootPart.Anchored then
                    HumanoidRootPart.Anchored = false
                end
                Humanoid.WalkSpeed = math.max(Humanoid.WalkSpeed, Echo.Player.WalkSpeed and Echo.Player.WSSpeed or 16)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
                Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
            end)
        end
    end
end)

-- Big Head: resize opponent heads
Threads.BigHead = task.spawn(function()
    while task.wait(0.5) do
        if Echo.Physics.BigHead then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team then
                    pcall(function()
                        local Char = player.Character
                        if Char then
                            local Head = Char:FindFirstChild("Head")
                            if Head then
                                Head.Size = Vector3.new(Echo.Physics.BigHeadSize, Echo.Physics.BigHeadSize, Echo.Physics.BigHeadSize)
                            end
                        end
                    end)
                end
            end
        end
    end
end)

-- Block Extender: create invisible enlarged hitbox
Threads.BlockExtender = task.spawn(function()
    while task.wait(0.1) do
        if Echo.Physics.BlockExtender and HumanoidRootPart then
            if not BlockExtenderPart or not BlockExtenderPart.Parent then
                BlockExtenderPart = Instance.new("Part")
                BlockExtenderPart.Shape = Enum.PartType.Ball
                BlockExtenderPart.Anchored = false
                BlockExtenderPart.CanCollide = false
                BlockExtenderPart.Massless = true
                BlockExtenderPart.Name = "BlockExtenderHitbox"
                BlockExtenderPart.Material = Enum.Material.ForceField

                local weld = Instance.new("WeldConstraint")
                weld.Part0 = HumanoidRootPart
                weld.Part1 = BlockExtenderPart
                weld.Parent = BlockExtenderPart

                BlockExtenderPart.CFrame = HumanoidRootPart.CFrame
                BlockExtenderPart.Parent = workspace
            end

            local reach = Echo.Physics.BlockExtenderReach
            BlockExtenderPart.Size = Vector3.new(reach, reach, reach)
            BlockExtenderPart.Transparency = Echo.Physics.BlockExtenderTransparency
        else
            if BlockExtenderPart and BlockExtenderPart.Parent then
                BlockExtenderPart:Destroy()
                BlockExtenderPart = nil
            end
        end
    end
end)

-- Auto Boost
Threads.AutoBoost = task.spawn(function()
    while task.wait(0.2) do
        if Echo.Automatics.AutoBoost and Character then
            pcall(function()
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftShift, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftShift, false, game)
            end)
        end
    end
end)

-- // Fly
local FlyKeysHeld = { W = false, A = false, S = false, D = false, Space = false, Shift = false }

if IsMobile then
    if MobileButtons.FlyUp then
        MobileButtons.FlyUp.MouseButton1Down:Connect(function() FlyKeysHeld.Space = true end)
        MobileButtons.FlyUp.MouseButton1Up:Connect(function() FlyKeysHeld.Space = false end)
    end
    if MobileButtons.FlyDown then
        MobileButtons.FlyDown.MouseButton1Down:Connect(function() FlyKeysHeld.Shift = true end)
        MobileButtons.FlyDown.MouseButton1Up:Connect(function() FlyKeysHeld.Shift = false end)
    end
end

UserInputService.InputBegan:Connect(function(Input, GP)
    if GP then return end
    if Input.KeyCode == Enum.KeyCode.W then FlyKeysHeld.W = true end
    if Input.KeyCode == Enum.KeyCode.A then FlyKeysHeld.A = true end
    if Input.KeyCode == Enum.KeyCode.S then FlyKeysHeld.S = true end
    if Input.KeyCode == Enum.KeyCode.D then FlyKeysHeld.D = true end
    if Input.KeyCode == Enum.KeyCode.Space then FlyKeysHeld.Space = true end
    if Input.KeyCode == Enum.KeyCode.LeftShift then FlyKeysHeld.Shift = true end
end)

UserInputService.InputEnded:Connect(function(Input, GP)
    if Input.KeyCode == Enum.KeyCode.W then FlyKeysHeld.W = false end
    if Input.KeyCode == Enum.KeyCode.A then FlyKeysHeld.A = false end
    if Input.KeyCode == Enum.KeyCode.S then FlyKeysHeld.S = false end
    if Input.KeyCode == Enum.KeyCode.D then FlyKeysHeld.D = false end
    if Input.KeyCode == Enum.KeyCode.Space then FlyKeysHeld.Space = false end
    if Input.KeyCode == Enum.KeyCode.LeftShift then FlyKeysHeld.Shift = false end
end)

Threads.Fly = task.spawn(function()
    while task.wait() do
        if Echo.Player.Fly and HumanoidRootPart and Humanoid then
            if not FlyBodyVelocity or not FlyBodyVelocity.Parent then
                FlyBodyVelocity = Instance.new("BodyVelocity")
                FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyVelocity.Velocity = Vector3.zero
                FlyBodyVelocity.Parent = HumanoidRootPart
            end
            if not FlyBodyGyro or not FlyBodyGyro.Parent then
                FlyBodyGyro = Instance.new("BodyGyro")
                FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
                FlyBodyGyro.D = 200
                FlyBodyGyro.P = 10000
                FlyBodyGyro.Parent = HumanoidRootPart
            end

            local speed = Echo.Player.FlySpeed
            local camCF = Camera.CFrame
            local moveDir = Vector3.zero

            if IsMobile then
                local md = Humanoid.MoveDirection
                if md.Magnitude > 0 then
                    moveDir = moveDir + Vector3.new(md.X, 0, md.Z).Unit * speed
                end
            else
                if FlyKeysHeld.W then moveDir = moveDir + camCF.LookVector end
                if FlyKeysHeld.S then moveDir = moveDir - camCF.LookVector end
                if FlyKeysHeld.D then moveDir = moveDir + camCF.RightVector end
                if FlyKeysHeld.A then moveDir = moveDir - camCF.RightVector end
            end

            if FlyKeysHeld.Space then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if FlyKeysHeld.Shift then moveDir = moveDir - Vector3.new(0, 1, 0) end

            if moveDir.Magnitude > 0 then
                FlyBodyVelocity.Velocity = moveDir.Unit * speed
            else
                FlyBodyVelocity.Velocity = Vector3.zero
            end

            FlyBodyGyro.CFrame = camCF
            Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
        else
            if FlyBodyVelocity and FlyBodyVelocity.Parent then
                FlyBodyVelocity:Destroy()
                FlyBodyVelocity = nil
            end
            if FlyBodyGyro and FlyBodyGyro.Parent then
                FlyBodyGyro:Destroy()
                FlyBodyGyro = nil
            end
        end
    end
end)

-- // Event Handlers

-- Click Tackle Aimbot (mouse + mobile)
local function DoClickTackle()
    if not Echo.Physics.ClickTackleAimbot or not HumanoidRootPart then return end

    local BallCarrierChar = GetBallCarrier()
    if BallCarrierChar then
        pcall(function()
            local Distance = (BallCarrierChar.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if Distance <= Echo.Physics.ClickTackleAimbotRadius then
                HumanoidRootPart.CFrame = BallCarrierChar.HumanoidRootPart.CFrame
            end
        end)
    end
end

Mouse.Button1Down:Connect(DoClickTackle)

if IsMobile and MobileButtons.Tackle then
    MobileButtons.Tackle.MouseButton1Click:Connect(DoClickTackle)
end

-- QuickTP (keyboard + mobile)
local QuickTPCooldown = tick()

local function DoQuickTP()
    if not Echo.Physics.QuickTP or not Humanoid or not HumanoidRootPart then return end
    if (tick() - QuickTPCooldown) >= 0.1 then
        local Acceleration = 2 + (Echo.Physics.QuickTPSpeed / 4)
        HumanoidRootPart.CFrame += Humanoid.MoveDirection * Acceleration
        QuickTPCooldown = tick()
    end
end

UserInputService.InputBegan:Connect(function(Input, GP)
    if GP then return end
    if Input.KeyCode == Enum.KeyCode.F then
        DoQuickTP()
    end
end)

if IsMobile and MobileButtons.QuickTP then
    MobileButtons.QuickTP.MouseButton1Click:Connect(DoQuickTP)
end

-- Manual Swat (mobile)
if IsMobile and MobileButtons.Swat then
    MobileButtons.Swat.MouseButton1Click:Connect(function()
        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
    end)
end

-- Manual Catch (mobile)
if IsMobile and MobileButtons.Catch then
    MobileButtons.Catch.MouseButton1Click:Connect(function()
        FireCatchRemote()
    end)
end

Threads.ResetOnCatch = task.spawn(function()
    while task.wait() do
        if Echo.Physics.ResetOnCatch and CharacterHasFootball() and Humanoid then
            task.wait(Echo.Physics.ResetOnCatchDuration)
            Humanoid.Health = 0
        end
    end
end)

Threads.AutoCatch = task.spawn(function()
    while task.wait() do
        if Echo.Automatics.AutoCatch and HumanoidRootPart then
            local Football = GetClosestFootball()
            if Football then
                pcall(function()
                    local Distance = (HumanoidRootPart.Position - Football.Position).Magnitude
                    if Distance <= Echo.Automatics.AutoCatchRadius then
                        FireCatchRemote()
                    end
                end)
            end
        end
    end
end)

Threads.AutoSwat = task.spawn(function()
    while task.wait() do
        if Echo.Automatics.AutoSwat and HumanoidRootPart then
            local Football = GetClosestFootball()
            if Football then
                pcall(function()
                    local Distance = (HumanoidRootPart.Position - Football.Position).Magnitude
                    if Distance <= Echo.Automatics.AutoSwatRadius then
                        VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.R, false, game)
                        VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.R, false, game)
                    end
                end)
            end
        end
    end
end)

Threads.CameraZoomIncreasement = task.spawn(function()
    while task.wait() do
        if Echo.Visuals.CameraZoom then
            LocalPlayer.CameraMaxZoomDistance = 1000
        end
    end
end)

-- Shared with UI (Anti OOB) — filled when gameplay loops start
if (PlaceIdStr == "82866880824588") then
    pcall(function()
        for _, Object in next, Workspace.Models.Boundaries:GetChildren() do
            Boundaries[#Boundaries + 1] = Object
        end
    end)
end

Threads.AngleEnhancer = task.spawn(function()
    local AngleTick = os.clock()
    local OldLookVector = Vector3.zero
    local ShiftLockEnabled = false
    local LastEnabled = false

    UserInputService:GetPropertyChangedSignal("MouseBehavior"):Connect(function()
        ShiftLockEnabled = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
    end)

    local function OnJump()
        if not Humanoid then return end
        if Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then return end
        if os.clock() - AngleTick > 0.2 then return end
        if not Echo.Player.AngleEnhancer then return end
        task.wait(0.05)
        if HumanoidRootPart then
            HumanoidRootPart.AssemblyLinearVelocity += Vector3.new(0, Echo.Player.AngleEnhancerValue - 50, 0)
        end
    end

    if Humanoid then
        Humanoid.Jumping:Connect(OnJump)
    end

    -- Reconnect on respawn
    LocalPlayer.CharacterAdded:Connect(function(newChar)
        task.wait(0.5)
        local hum = newChar:FindFirstChild("Humanoid")
        if hum then
            hum.Jumping:Connect(OnJump)
        end
    end)

    while true do
        task.wait()
        if not Character or not HumanoidRootPart or not Humanoid then continue end

        local LookVector = HumanoidRootPart.CFrame.LookVector

        if not ShiftLockEnabled and LastEnabled then
            AngleTick = os.clock()
        end

        if (os.clock() - AngleTick < 0.2) and Echo.Player.AngleEnhancer then
            Humanoid.JumpPower = (Echo.Player.JumpPower and Echo.Player.JP or 50) + (Echo.Player.AngleEnhancerValue - 50)
        elseif not Echo.Player.AngleEnhancer then
            Humanoid.JumpPower = (Echo.Player.JumpPower and Echo.Player.JP or 50)
        end

        OldLookVector = LookVector
        LastEnabled = ShiftLockEnabled
    end
end)

-- Anti Block
LocalPlayer.CharacterAdded:Connect(function(newChar)
    newChar.DescendantAdded:Connect(function(Child)
        if Echo.Physics.AntiBlock and string.find(Child.Name, "FFmover") then
            Child:Destroy()
        end
    end)
end)

if Character then
    Character.DescendantAdded:Connect(function(Child)
        if Echo.Physics.AntiBlock and string.find(Child.Name, "FFmover") then
            Child:Destroy()
        end
    end)
end

local Blacklisted = { "KICKOFF", "PUNT", "PAT" }

Threads.AutoQB = task.spawn(function()
    while task.wait() do
        if not Echo.Automatics.AutoQB or not HumanoidRootPart or not Humanoid then continue end

        pcall(function()
            local StatusValue = ReplicatedStorage:FindFirstChild("Flags") and ReplicatedStorage.Flags:FindFirstChild("Status")
            local PossessionTag = ReplicatedStorage:FindFirstChild("Flags") and ReplicatedStorage.Flags:FindFirstChild("PossessionTag")
            local StatusTag = ReplicatedStorage:FindFirstChild("Flags") and ReplicatedStorage.Flags:FindFirstChild("StatusTag")
            local Football = GetClosestFootball()

            if StatusValue and StatusValue.Value == "PrePlay"
                and Football
                and PossessionTag and PossessionTag.Value == LocalPlayer.Team.Name
                and StatusTag and not table.find(Blacklisted, StatusTag.Value) then

                local TargetPosition = Football.Position

                if Echo.Automatics.AutoQBType == "Legit" then
                    Humanoid:MoveTo(TargetPosition)
                elseif Echo.Automatics.AutoQBType == "Precise" then
                    HumanoidRootPart.CFrame = CFrame.new(TargetPosition + Vector3.new(0, 2, -0.5))
                elseif Echo.Automatics.AutoQBType == "Rage" then
                    HumanoidRootPart.CFrame = CFrame.new(TargetPosition + Vector3.new(0, 2, 0))
                end
            end
        end)
    end
end)

local FinishLine
pcall(function()
    if (game.PlaceId == 82866880824588) then
        FinishLine = Workspace.Models.LockerRoomA.FinishLine3
    end
end)

if FinishLine then
    FinishLine:GetPropertyChangedSignal("CFrame"):Connect(function()
        if Echo.Automatics.AutoCaptain and FinishLine.Position.Y > 0 and HumanoidRootPart then
            for _ = 1, 7, 1 do
                task.wait(0.20)
                HumanoidRootPart.CFrame = FinishLine.CFrame + Vector3.new(0, 2, 0)
            end
        end
    end)
end

LocalPlayer.PlayerGui.ChildAdded:Connect(function(Child)
    if Child.Name == "KickerGui" and Echo.Automatics.AutoKick then
        local Cursor = Child:FindFirstChild("Cursor", true)
        if not Cursor then return end

        repeat task.wait() until Cursor.Position.Y.Scale < 0.01 + ((100 - Echo.Automatics.AutoKickPower) * 0.012)
        mouse1click()
        repeat task.wait() until Cursor.Position.Y.Scale > 0.9 - ((100 - Echo.Automatics.AutoKickAccuracy) * 0.001)
        mouse1click()
    end
end)

-- // Receiver ESP Thread
Threads.ReceiverESP = task.spawn(function()
    while task.wait(0.25) do
        if not Echo.QBAimbot.ReceiverESP or not Echo.QBAimbot.Enabled or not HumanoidRootPart then
            CleanupReceiverESP()
            continue
        end

        -- Clean old guis
        CleanupReceiverESP()

        pcall(function()
            local receivers = GatherAllReceivers()
            for _, r in pairs(receivers) do
                pcall(function()
                    local hrp = r.HRP
                    if not hrp then return end

                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "ReceiverESP"
                    billboard.Size = UDim2.new(0, 150, 0, 60)
                    billboard.StudsOffset = Vector3.new(0, 4, 0)
                    billboard.AlwaysOnTop = true
                    billboard.Adornee = hrp

                    local isOpen = IsReceiverOpen(r.Target)
                    local textColor = isOpen and Color3.fromRGB(194, 155, 165) or Color3.fromRGB(110, 110, 110)

                    local nameText = r.IsBot and r.Target.Name or r.Target.DisplayName
                    local infoLines = nameText

                    if Echo.QBAimbot.ShowRoutes then
                        local route = "Still"
                        pcall(function()
                            route = CalculateRouteOfPlayer(r.Target)
                        end)
                        infoLines = infoLines .. "\n" .. route
                    end

                    if Echo.QBAimbot.ShowDistance then
                        local dist = math.floor((hrp.Position - HumanoidRootPart.Position).Magnitude)
                        infoLines = infoLines .. "\n" .. tostring(dist) .. " studs"
                    end

                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.BackgroundTransparency = 1
                    label.Text = infoLines
                    label.TextColor3 = textColor
                    label.TextScaled = true
                    label.Font = Enum.Font.GothamBold
                    label.TextStrokeTransparency = 0.5
                    label.TextStrokeColor3 = Color3.new(0, 0, 0)
                    label.Parent = billboard

                    local adornPart = Instance.new("Part")
                    adornPart.Transparency = 1
                    adornPart.Anchored = true
                    adornPart.CanCollide = false
                    adornPart.Size = Vector3.new(0.1, 0.1, 0.1)
                    adornPart.CFrame = hrp.CFrame
                    adornPart.Name = "ReceiverESPPart"
                    adornPart.Parent = workspace

                    billboard.Adornee = adornPart
                    billboard.Parent = adornPart

                    table.insert(ReceiverESPGuis, adornPart)
                end)
            end
        end)
    end
end)

-- // Auto Hike Thread
local LastHikeTick = 0
Threads.AutoHike = task.spawn(function()
    while task.wait(0.3) do
        if not Echo.QBAimbot.AutoHike or not Echo.QBAimbot.Enabled then continue end
        if not Character or not HumanoidRootPart then continue end

        pcall(function()
            local Football = Workspace:FindFirstChild("Football")
            if not Football then return end

            -- Don't hike if we already have the ball
            if Character:FindFirstChild("Football") then return end

            local StatusValue = (game.PlaceId == 82866880824588) and ReplicatedStorage:FindFirstChild("Flags") and ReplicatedStorage.Flags:FindFirstChild("Status")
            local PossessionTag = ReplicatedStorage:FindFirstChild("Flags") and ReplicatedStorage.Flags:FindFirstChild("PossessionTag")

            if StatusValue and StatusValue.Value == "PrePlay"
                and PossessionTag and PossessionTag.Value == LocalPlayer.Team.Name then

                local dist = (Football.Position - HumanoidRootPart.Position).Magnitude
                if dist < 10 then
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    task.wait(0.05)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                    LastHikeTick = tick()
                end
            end
        end)
    end
end)

-- // Auto Throw & Scramble state
local AutoThrowArmed = false
local IsScrambling = false

-- // QB Aimbot: Throw Handler

local function DoQBThrow()
    if not Echo.QBAimbot.Enabled then return end
    if not Character then return end

    local Football = Character:FindFirstChildOfClass("Tool")
    if not Football then return end

    if not ClosestPlayer then return end

    local isPlayer = pcall(function() return ClosestPlayer:IsA("Player") end)
    local isBot = IsBot(ClosestPlayer.Name)
    if not isPlayer and not isBot then return end

    pcall(function()
        local Head = Character:FindFirstChild("Head")
        local StartPosition = Head and Head.Position or (HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0)).Position
        local CurrentThrowType

        if Echo.QBAimbot.AutoChooseThrowType then
            CurrentThrowType = GetThrowType(ClosestPlayer)
        else
            CurrentThrowType = "Dime"
        end

        local ReceiverRoute = CalculateRouteOfPlayer(ClosestPlayer)
        local N = (ReceiverRoute == "Straight") and 4.3 or 5.5
        local Initial

        if Echo.QBAimbot.Use95PowerMode then
            Initial = 95
        elseif Echo.QBAimbot.HighestPowerMode then
            Initial = math.clamp(GetPower(HorizontalRangeOfProjectile(ClosestPlayer), 28), 85, 95)
        elseif Echo.QBAimbot.AutoPower then
            Initial = math.clamp(math.round(GetPower(HorizontalRangeOfProjectile(ClosestPlayer), 28) + N), 0, 95)
        else
            Initial = Echo.QBAimbot.NormalPower
        end

        if CurrentThrowType == "Bullet" then Initial = 95 end
        if CurrentThrowType == "Fade" then Initial = 65 end

        local Angle
        if CurrentThrowType == "Fade" then
            Angle = 85
        elseif CurrentThrowType == "Bullet" then
            Angle = Echo.QBAimbot.BulletAngle
        else
            Angle = Echo.QBAimbot.ThrowAngle
        end

        local ToLaunchAngle
        if Echo.QBAimbot.HighestPowerMode or Echo.QBAimbot.Use95PowerMode then
            if Echo.QBAimbot.AutoAngle then
                ToLaunchAngle = CalculateHighSpeedLowAngle(28, Initial)
            else
                ToLaunchAngle = math.rad(Angle)
            end
        else
            if Echo.QBAimbot.AutoAngle then
                if CurrentThrowType == "Fade" then
                    ToLaunchAngle = math.rad(85)
                elseif CurrentThrowType == "Bullet" then
                    ToLaunchAngle = math.clamp(CalculateLaunchAngleBullet(28, Initial), 0, 1)
                else
                    ToLaunchAngle = math.clamp(CalculateLaunchAngle(28, Initial), 0, 2.61799388)
                end
            else
                ToLaunchAngle = math.rad(Angle)
            end
        end

        local TimeOfFlight = GetTimeOfFlightProjectile(Initial, ToLaunchAngle, 28)
        local EndPosition

        if isBot then
            EndPosition = BotEstimatedVel(TimeOfFlight, ClosestPlayer)
        else
            EndPosition = GetReceiverTargetPosition(TimeOfFlight, ClosestPlayer)
        end

        local Velocity, DirectionToThrow, Power = VelocityNeededToReachPosition(ToLaunchAngle, StartPosition, EndPosition, Vector3.new(0, -28, 0), TimeOfFlight)

        if Echo.QBAimbot.AutoPower or Echo.QBAimbot.Use95PowerMode then
            if CurrentThrowType == "Fade" then
                Power = 65
            elseif CurrentThrowType == "Bullet" then
                Power = 95
            elseif Echo.QBAimbot.Use95PowerMode then
                Power = 95
            end
        else
            Power = Echo.QBAimbot.NormalPower
        end

        local throwDir = DirectionToThrow
        if IsVector3Valid(throwDir) then
            ThrowFootball(Football, StartPosition, StartPosition + throwDir * 10000, Power)
        end
    end)
end

-- // Mouse Throw
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        if (game.PlaceId == 82866880824588) then
            local Flags = ReplicatedStorage:FindFirstChild("Flags")
            if not Flags then return end
            local Status = Flags:FindFirstChild("Status")
            local Throwable = Flags:FindFirstChild("Throwable")
            local Message = LocalPlayer.PlayerGui:FindFirstChild("MainGui") and LocalPlayer.PlayerGui.MainGui:FindFirstChild("Message")
            if Status and Status.Value == "InPlay" and Throwable and Message and Message.Text == "HIKE" then
                DoQBThrow()
            end
        else
            DoQBThrow()
        end
    end
end)

-- Mobile throw button
if IsMobile and MobileButtons.Throw then
    MobileButtons.Throw.MouseButton1Click:Connect(DoQBThrow)
end

-- // Smoothed direction state
local SmoothedDirection = Vector3.zero

-- // QB Aimbot: Heartbeat (beam/prediction visuals + direction tracking + auto throw + scramble + FOV)
RunService.Heartbeat:Connect(function()
    pcall(UpdateFOVCircle)

    if not Echo.QBAimbot.Enabled then
        if FOVCircle then pcall(function() FOVCircle.Visible = false end) end
        if FOVCircleFrame then pcall(function() FOVCircleFrame.Visible = false end) end
        CleanupReceiverESP()
        IsScrambling = false
        if EchoHUDGui then EchoHUDGui.Enabled = false end
        DestroyTrajectoryBeam()
        return
    end

    ClosestPlayer = GetClosestPlayerToMouse()

    -- Clean up old visuals
    for _, Object in pairs(Workspace:GetChildren()) do
        if Object.Name == "BeamVisual" or Object.Name == "BillboardPart" or Object.Name == "PredictionBeam" then
            Object:Destroy()
        end
    end

    -- Scramble Mode: if no receivers are open, run forward
    if Echo.QBAimbot.ScrambleMode and Character and HumanoidRootPart and Humanoid then
        pcall(function()
            local FootballCheck = Character:FindFirstChild("Football")
            if FootballCheck then
                local receivers = GatherAllReceivers()
                local anyOpen = false
                for _, r in pairs(receivers) do
                    if IsReceiverOpen(r.Target) then
                        anyOpen = true
                        break
                    end
                end

                if not anyOpen then
                    IsScrambling = true
                    Humanoid.WalkSpeed = Echo.QBAimbot.ScrambleSpeed
                    local lookDir = HumanoidRootPart.CFrame.LookVector
                    Humanoid:MoveTo(HumanoidRootPart.Position + lookDir * 20)
                else
                    IsScrambling = false
                end
            else
                IsScrambling = false
            end
        end)
    else
        IsScrambling = false
    end

    local Head = Character and Character:FindFirstChild("Head")
    if not ClosestPlayer or not Character or not Head or not Character:FindFirstChild("Football") then
        if EchoHUDGui then EchoHUDGui.Enabled = false end

        -- Ball is out of our hands: keep the arc while the throw is in flight,
        -- remove it once the ball is caught (no loose ball left) or has landed
        -- (loose ball but barely moving), with a hard 8s failsafe.
        if currentBeam then
            local inFlight = false
            pcall(function()
                for _, obj in ipairs(Workspace:GetChildren()) do
                    if obj.Name == "Football" and obj:IsA("BasePart")
                        and obj.AssemblyLinearVelocity.Magnitude > 8 then
                        inFlight = true
                        break
                    end
                end
            end)
            if not inFlight or (tick() - BeamCreatedAt) > 8 then
                DestroyTrajectoryBeam()
            end
        end
        return
    end

    pcall(function()
        local CurrentThrowType
        if Echo.QBAimbot.AutoChooseThrowType then
            CurrentThrowType = GetThrowType(ClosestPlayer)
        else
            CurrentThrowType = "Dime"
        end

        local ReceiverRoute = CalculateRouteOfPlayer(ClosestPlayer)
        local N = (ReceiverRoute == "Straight") and 4.3 or 5.5

        local Initial

        if Echo.QBAimbot.Use95PowerMode then
            Initial = 95
        elseif Echo.QBAimbot.HighestPowerMode then
            Initial = math.clamp(GetPower(HorizontalRangeOfProjectile(ClosestPlayer), 28), 85, 95)
        elseif Echo.QBAimbot.AutoPower then
            Initial = math.clamp(math.round(GetPower(HorizontalRangeOfProjectile(ClosestPlayer), 28) + N), 0, 95)
        else
            Initial = Echo.QBAimbot.NormalPower
        end

        local Angle
        if CurrentThrowType == "Fade" then
            Angle = 85
        elseif CurrentThrowType == "Bullet" then
            Angle = Echo.QBAimbot.BulletAngle
        else
            Angle = Echo.QBAimbot.ThrowAngle
        end

        local LaunchAngle
        if Echo.QBAimbot.HighestPowerMode or Echo.QBAimbot.Use95PowerMode then
            if Echo.QBAimbot.AutoAngle then
                LaunchAngle = CalculateHighSpeedLowAngle(28, Initial)
            else
                LaunchAngle = math.rad(Angle)
            end
        else
            if Echo.QBAimbot.AutoAngle then
                if CurrentThrowType == "Fade" then
                    LaunchAngle = math.rad(85)
                elseif CurrentThrowType == "Bullet" then
                    LaunchAngle = math.clamp(CalculateLaunchAngleBullet(28, Initial), 0, 1)
                else
                    LaunchAngle = math.clamp(CalculateLaunchAngle(28, Initial), 0, 2.61799388)
                end
            else
                LaunchAngle = math.rad(Angle)
            end
        end

        local TimeOfFlight = GetTimeOfFlightProjectile(Initial, LaunchAngle, 28)
        local StartPosition
        if (game.PlaceId == 81310542478972) then
            StartPosition = Head.Position
        else
            StartPosition = (HumanoidRootPart.CFrame * CFrame.new(0, 1.5, 0)).Position
        end
        local TargetPosition

        local isBot = IsBot(ClosestPlayer.Name)
        if isBot then
            TargetPosition = BotEstimatedVel(TimeOfFlight, ClosestPlayer)
        else
            TargetPosition = GetReceiverTargetPosition(TimeOfFlight, ClosestPlayer)
        end

        local Velocity, Direction, Power = VelocityNeededToReachPosition(LaunchAngle, StartPosition, TargetPosition, Vector3.new(0, -28, 0), TimeOfFlight)

        -- // Smoothing
        if Echo.QBAimbot.SmoothEnabled and IsVector3Valid(Direction) then
            local factor = math.clamp(Echo.QBAimbot.SmoothFactor, 1, 20)
            local alpha = 1 / factor
            SmoothedDirection = SmoothedDirection:Lerp(Direction, alpha)
            Direction = SmoothedDirection
        end

        if IsVector3Valid(Direction) then
            ThrowingDirection = Direction
        end

        if IsVector3Valid(Direction) and IsVector3Valid(TargetPosition) then
            if Echo.QBAimbot.BeamMode then
                local curve0, curve1, cf1, cf2 = BeamProjectile(Vector3.new(0, -28, 0), Velocity, StartPosition, TimeOfFlight)
                CreateBeamFromCFrames(cf1, cf2, curve0, curve1, Echo.QBAimbot.PredictionColor)
            else
                DestroyTrajectoryBeam()
            end

            local targetName = ""
            pcall(function()
                if IsBot(ClosestPlayer.Name) then
                    targetName = ClosestPlayer.Name
                else
                    targetName = ClosestPlayer.DisplayName or ClosestPlayer.Name
                end
            end)

            local angleDeg = math.floor(math.deg(LaunchAngle) * 10) / 10
            local flightTimeFmt = math.floor(TimeOfFlight * 10) / 10
            local isOpen = IsReceiverOpen(ClosestPlayer)

            CreateAimbotCard(CurrentThrowType, Power, angleDeg, flightTimeFmt, StartPosition + Vector3.new(0, 6, 0), isOpen, targetName)
        else
            if EchoHUDGui then EchoHUDGui.Enabled = false end
        end

        if Echo.QBAimbot.AutoThrow and not IsScrambling then
            local timeSinceHike = tick() - LastHikeTick
            if timeSinceHike >= Echo.QBAimbot.AutoThrowDelay and timeSinceHike < 10 then
                if Echo.QBAimbot.InterceptionAvoidance then
                    if IsReceiverOpen(ClosestPlayer) then
                        DoQBThrow()
                    end
                else
                    DoQBThrow()
                end
            end
        end
    end)
end)

end

-- // Scoot UI
local Watermark = Library:Watermark("Echo | Football")
local KeybindList = Library:KeybindList()

local CatchingPage = Window:Page({ Name = "Catching", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
local PhysicsPage = Window:Page({ Name = "Physics", Columns = 2 })
local AutomaticsPage = Window:Page({ Name = "Automatics", Columns = 2 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
local QBAimbotPage = Window:Page({ Name = "QB Aimbot", Columns = 2 })
-- Hidden until LocalPlayer is holding the football
pcall(function()
	local btn = QBAimbotPage.Button or QBAimbotPage.TabButton
	if btn then
		btn.Visible = false
	end
end)
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local function AddToggle(Section, Name, Flag, Default, Callback)
    return Section:Toggle({
        Name = Name,
        Flag = Flag,
        Default = Default,
        Callback = Callback,
    })
end

local function AddSlider(Section, Name, Flag, Min, Max, Default, Decimals, Suffix, Callback)
    return Section:Slider({
        Name = Name,
        Flag = Flag,
        Min = Min,
        Max = Max,
        Default = Default,
        Decimals = Decimals or 1,
        Suffix = Suffix or "",
        Callback = Callback,
    })
end

local function AddDropdown(Section, Name, Flag, Items, Default, Callback)
    return Section:Dropdown({
        Name = Name,
        Flag = Flag,
        Items = Items,
        Default = Default,
        Multi = false,
        Callback = Callback,
    })
end

-- // Catching
local CatchingSection = CatchingPage:Section({ Name = "Catching", Side = 1 })
AddToggle(CatchingSection, "Magnets", "MagnetsToggle", Echo.Catching.Magnets, function(v) Echo.Catching.Magnets = v end)
AddToggle(CatchingSection, "Show Magnet Hitbox", "ShowMagHitboxToggle", Echo.Catching.ShowMagHitbox, function(v) Echo.Catching.ShowMagHitbox = v end)
AddToggle(CatchingSection, "Fake Ball", "FakeBallToggle", Echo.Catching.FakeBall, function(v) Echo.Catching.FakeBall = v end)
AddSlider(CatchingSection, "Magnet Radius", "MagRadiusSlider", 0, 100, Echo.Catching.CustomizableRadius, 1, " st", function(v) Echo.Catching.CustomizableRadius = v end)
AddSlider(CatchingSection, "Magnet Delay", "MagDelaySlider", 0, 5, Echo.Catching.CustomizableDelay, 0.1, "s", function(v) Echo.Catching.CustomizableDelay = v end)
AddSlider(CatchingSection, "Tween Speed", "TweenSpeedSlider", 0, 20, Echo.Catching.TweenSpeed, 0.1, "", function(v) Echo.Catching.TweenSpeed = v end)
AddToggle(CatchingSection, "Pull Vector", "PullVectorToggle", Echo.Catching.PullVector, function(v) Echo.Catching.PullVector = v end)
AddSlider(CatchingSection, "Pull Vector Speed", "PullVectorSpeedSlider", 0, 20, Echo.Catching.PullVectorSpeed, 0.1, "", function(v) Echo.Catching.PullVectorSpeed = v end)
AddSlider(CatchingSection, "Pull Vector Radius", "PullVectorRadiusSlider", 0, 100, Echo.Catching.PullVectorRadius, 1, " st", function(v) Echo.Catching.PullVectorRadius = v end)
AddToggle(CatchingSection, "Dive Vector", "DiveVectorToggle", Echo.Catching.DiveVector, function(v) Echo.Catching.DiveVector = v end)
AddSlider(CatchingSection, "Dive Vector Radius", "DiveVectorRadiusSlider", 0, 100, Echo.Catching.DiveVectorRadius, 1, " st", function(v) Echo.Catching.DiveVectorRadius = v end)

local CatchingV2Section = CatchingPage:Section({ Name = "Catching V2", Side = 2 })
AddToggle(CatchingV2Section, "Magnets V2", "MagnetsV2Toggle", Echo.Catching.MagnetsV2, function(v) Echo.Catching.MagnetsV2 = v end)
AddToggle(CatchingV2Section, "Show Magnet Hitbox V2", "ShowMagHitboxV2Toggle", Echo.Catching.ShowMagHitboxV2, function(v) Echo.Catching.ShowMagHitboxV2 = v end)
AddSlider(CatchingV2Section, "Magnet Radius V2", "MagRadiusV2Slider", 0, 100, Echo.Catching.CustomizableRadiusV2, 1, " st", function(v) Echo.Catching.CustomizableRadiusV2 = v end)
AddSlider(CatchingV2Section, "Magnet Delay V2", "MagDelayV2Slider", 0, 5, Echo.Catching.CustomizableDelayV2, 0.1, "s", function(v) Echo.Catching.CustomizableDelayV2 = v end)
AddToggle(CatchingV2Section, "Pull Vector V2", "PullVectorV2Toggle", Echo.Catching.PullVectorV2, function(v) Echo.Catching.PullVectorV2 = v end)
AddDropdown(CatchingV2Section, "Pull Vector Type V2", "PullVectorTypeV2Dropdown", { "Drag", "Push", "Pull" }, Echo.Catching.PullVectorTypeV2, function(v) Echo.Catching.PullVectorTypeV2 = v end)
AddSlider(CatchingV2Section, "Pull Vector Speed V2", "PullVectorSpeedV2Slider", 0, 20, Echo.Catching.PullVectorSpeedV2, 0.1, "", function(v) Echo.Catching.PullVectorSpeedV2 = v end)
AddSlider(CatchingV2Section, "Pull Vector Radius V2", "PullVectorRadiusV2Slider", 0, 100, Echo.Catching.PullVectorRadiusV2, 1, " st", function(v) Echo.Catching.PullVectorRadiusV2 = v end)

-- // Player
local MovementSection = PlayerPage:Section({ Name = "Movement", Side = 1 })
AddToggle(MovementSection, "Jump Power", "JumpPowerToggle", Echo.Player.JumpPower, function(v) Echo.Player.JumpPower = v end)
AddSlider(MovementSection, "Jump Power Value", "JumpPowerSlider", 0, 100, Echo.Player.JP, 1, "", function(v) Echo.Player.JP = v end)
AddToggle(MovementSection, "Angle Enhancer", "AngleEnhancerToggle", Echo.Player.AngleEnhancer, function(v) Echo.Player.AngleEnhancer = v end)
AddSlider(MovementSection, "Angle Enhancer Value", "AngleEnhancerValueSlider", 0, 100, Echo.Player.AngleEnhancerValue, 1, "", function(v) Echo.Player.AngleEnhancerValue = v end)
AddToggle(MovementSection, "CFrame Speed", "CFrameSpeedToggle", Echo.Player.CFrameSpeed, function(v) Echo.Player.CFrameSpeed = v end)
AddSlider(MovementSection, "CFrame Speed Value", "CFSpeedSlider", 0, 100, Echo.Player.CFSpeed, 1, "", function(v) Echo.Player.CFSpeed = v end)
AddToggle(MovementSection, "Fly", "FlyToggle", Echo.Player.Fly, function(v) Echo.Player.Fly = v end)
AddSlider(MovementSection, "Fly Speed", "FlySpeedSlider", 0, 200, Echo.Player.FlySpeed, 1, " st/s", function(v) Echo.Player.FlySpeed = v end)

local GamepassesSection = PlayerPage:Section({ Name = "Gamepasses", Side = 2 })
AddToggle(GamepassesSection, "Unlock All Gamepasses", "UnlockAllPasses", Echo.Gamepasses.UnlockAll, function(v) Echo.Gamepasses.UnlockAll = v end)

local CustomizationSection = PlayerPage:Section({ Name = "Customization", Side = 2 })
local JerseyNameInput = CustomizationSection:Textbox({
    Name = "Jersey Name",
    Flag = "JerseyNameInput",
    Placeholder = "Enter name...",
    Finished = true,
})
local NameButton = CustomizationSection:Button()
NameButton:Add("Apply Name", function()
    local value = JerseyNameInput:Get()
    if value ~= "" then
        Remote:fireServer("Game", "Customization", "Name", value)
    end
end)

local JerseyNumberInput = CustomizationSection:Textbox({
    Name = "Jersey Number",
    Flag = "JerseyNumberInput",
    Placeholder = "0-99 or blank to clear",
    Finished = true,
})
local NumberButton = CustomizationSection:Button()
NumberButton:Add("Apply Number", function()
    local number = tonumber(JerseyNumberInput:Get())
    if number then
        Remote:fireServer("Game", "Customization", "Number", tostring(math.clamp(math.floor(number), 0, 99)))
    else
        Remote:fireServer("Game", "Customization", "Number", "ClearNum")
    end
end)

local SelectedTitle = "QB"
AddDropdown(CustomizationSection, "Position Title", "TitleRoleDropdown", { "QB", "Cap", "Kicker" }, SelectedTitle, function(v) SelectedTitle = v end)
local TitleButtons = CustomizationSection:Button()
TitleButtons:Add("Set Title", function()
    Remote:fireServer("Game", SelectedTitle:lower(), LocalPlayer.DisplayName)
end)
TitleButtons:Add("Remove Title", function()
    Remote:fireServer("Game", SelectedTitle:lower(), "/remove")
end)

-- // Physics
local PhysicsSection = PhysicsPage:Section({ Name = "Physics", Side = 1 })
AddToggle(PhysicsSection, "Click Tackle Aimbot", "ClickTackleAimbotToggle", Echo.Physics.ClickTackleAimbot, function(v) Echo.Physics.ClickTackleAimbot = v end)
AddSlider(PhysicsSection, "Tackle Radius", "TackleAimbotRadiusSlider", 0, 50, Echo.Physics.ClickTackleAimbotRadius, 1, " st", function(v) Echo.Physics.ClickTackleAimbotRadius = v end)
AddToggle(PhysicsSection, "Quick TP", "QuickTPToggle", Echo.Physics.QuickTP, function(v) Echo.Physics.QuickTP = v end)
AddSlider(PhysicsSection, "Quick TP Speed", "QuickTPSpeedSlider", 0, 50, Echo.Physics.QuickTPSpeed, 1, "", function(v) Echo.Physics.QuickTPSpeed = v end)
AddToggle(PhysicsSection, "Throw Predictions", "ThrowPredictionsToggle", Echo.Physics.ThrowPredictions, function(v) Echo.Physics.ThrowPredictions = v end)
AddToggle(PhysicsSection, "Jump Predictions", "JumpPredictionsToggle", Echo.Physics.JumpPredictions, function(v) Echo.Physics.JumpPredictions = v end)
AddToggle(PhysicsSection, "Anti Block", "AntiBlockToggle", Echo.Physics.AntiBlock, function(v) Echo.Physics.AntiBlock = v end)
AddToggle(PhysicsSection, "Anti Jam", "AntiJamToggle", Echo.Physics.AntiJam, function(v) Echo.Physics.AntiJam = v end)
AddToggle(PhysicsSection, "No Jump Cooldown", "NoJumpCooldownToggle", Echo.Physics.NoJumpCooldown, function(v) Echo.Physics.NoJumpCooldown = v end)

local PhysicsV2Section = PhysicsPage:Section({ Name = "Physics V2", Side = 2 })
AddToggle(PhysicsV2Section, "Big Head", "BigHeadToggle", Echo.Physics.BigHead, function(v) Echo.Physics.BigHead = v end)
AddSlider(PhysicsV2Section, "Head Size", "BigHeadSizeSlider", 1, 10, Echo.Physics.BigHeadSize, 1, "", function(v) Echo.Physics.BigHeadSize = v end)
AddToggle(PhysicsV2Section, "Anti OOB", "AntiOOBToggle", Echo.Physics.AntiOOB, function(v)
    Echo.Physics.AntiOOB = v
    for _, Boundary in next, Boundaries do
        pcall(function()
            Boundary.Parent = not v and Workspace.Models.Boundaries or nil
        end)
    end
end)
AddToggle(PhysicsV2Section, "No Freeze", "NoFreezeToggle", Echo.Physics.NoFreeze, function(v) Echo.Physics.NoFreeze = v end)
AddToggle(PhysicsV2Section, "Block Extender", "BlockExtenderToggle", Echo.Physics.BlockExtender, function(v) Echo.Physics.BlockExtender = v end)
AddSlider(PhysicsV2Section, "Block Extender Reach", "BlockExtenderReachSlider", 0, 50, Echo.Physics.BlockExtenderReach, 1, " st", function(v) Echo.Physics.BlockExtenderReach = v end)
AddSlider(PhysicsV2Section, "Block Extender Transparency", "BlockExtenderTransparencySlider", 0, 1, Echo.Physics.BlockExtenderTransparency, 0.05, "", function(v) Echo.Physics.BlockExtenderTransparency = v end)
AddToggle(PhysicsV2Section, "Reset On Catch", "ResetOnCatchToggle", Echo.Physics.ResetOnCatch, function(v) Echo.Physics.ResetOnCatch = v end)
AddSlider(PhysicsV2Section, "Reset On Catch Duration", "ResetOnCatchDurationSlider", 0, 5, Echo.Physics.ResetOnCatchDuration, 0.1, "s", function(v) Echo.Physics.ResetOnCatchDuration = v end)

local ProtectionSection = PhysicsPage:Section({ Name = "Protection", Side = 2 })
AddToggle(ProtectionSection, "Anti Tackle", "AntiTackleToggle", Echo.Physics.AntiTackle, function(v) Echo.Physics.AntiTackle = v end)
AddToggle(ProtectionSection, "Anti Down", "AntiDownToggle", Echo.Physics.AntiDown, function(v) Echo.Physics.AntiDown = v end)

-- // Automatics
local MainAutomaticsSection = AutomaticsPage:Section({ Name = "Main Automatics", Side = 1 })
AddToggle(MainAutomaticsSection, "Auto QB", "AutoQB", Echo.Automatics.AutoQB, function(v) Echo.Automatics.AutoQB = v end)
AddDropdown(MainAutomaticsSection, "Auto QB Type", "AutoQBTypeDropdown", { "Legit", "Rage", "Precise" }, Echo.Automatics.AutoQBType, function(v) Echo.Automatics.AutoQBType = v end)
AddToggle(MainAutomaticsSection, "Auto Captain", "AutoCaptain", Echo.Automatics.AutoCaptain, function(v) Echo.Automatics.AutoCaptain = v end)
AddToggle(MainAutomaticsSection, "Auto Catch", "AutoCatch", Echo.Automatics.AutoCatch, function(v) Echo.Automatics.AutoCatch = v end)
AddSlider(MainAutomaticsSection, "Catch Radius", "AutoCatchRadius", 0, 100, Echo.Automatics.AutoCatchRadius, 1, " st", function(v) Echo.Automatics.AutoCatchRadius = v end)

local SwatKickSection = AutomaticsPage:Section({ Name = "Swat & Kick", Side = 2 })
AddToggle(SwatKickSection, "Auto Swat", "AutoSwat", Echo.Automatics.AutoSwat, function(v) Echo.Automatics.AutoSwat = v end)
AddSlider(SwatKickSection, "Swat Radius", "AutoSwatRadius", 0, 100, Echo.Automatics.AutoSwatRadius, 1, " st", function(v) Echo.Automatics.AutoSwatRadius = v end)
AddToggle(SwatKickSection, "Auto Kick", "AutoKick", Echo.Automatics.AutoKick, function(v) Echo.Automatics.AutoKick = v end)
AddSlider(SwatKickSection, "Kick Power", "AutoKickPower", 0, 100, Echo.Automatics.AutoKickPower, 1, "%", function(v) Echo.Automatics.AutoKickPower = v end)
AddSlider(SwatKickSection, "Kick Accuracy", "AutoKickAccuracy", 0, 100, Echo.Automatics.AutoKickAccuracy, 1, "%", function(v) Echo.Automatics.AutoKickAccuracy = v end)

local RushBoostSection = AutomaticsPage:Section({ Name = "Rush & Boost", Side = 1 })
AddToggle(RushBoostSection, "Auto Rush", "AutoRush", Echo.Automatics.AutoRush, function(v) Echo.Automatics.AutoRush = v end)
AddSlider(RushBoostSection, "Rush Delay", "AutoRushDelay", 0, 10, Echo.Automatics.AutoRushDelay, 0.1, "s", function(v) Echo.Automatics.AutoRushDelay = v end)
AddToggle(RushBoostSection, "Auto Boost", "AutoBoost", Echo.Automatics.AutoBoost, function(v) Echo.Automatics.AutoBoost = v end)
AddSlider(RushBoostSection, "Boost Power", "AutoBoostPower", 0, 100, Echo.Automatics.AutoBoostPower, 1, "", function(v) Echo.Automatics.AutoBoostPower = v end)

-- // Visuals
local VisualsSection = VisualsPage:Section({ Name = "Visuals", Side = 1 })
AddToggle(VisualsSection, "No Textures", "NoTexturesToggle", Echo.Visuals.NoTextures, function(v)
    Echo.Visuals.NoTextures = v
    if v then
        for _, Part in next, Workspace:GetDescendants() do
            if Part:IsA("BasePart") then
                Part:SetAttribute("OriginalMaterial", Part.Material.Name)
                Part.Material = Enum.Material.SmoothPlastic
            end
        end
        Workspace.DescendantAdded:Connect(function(Part)
            if Echo.Visuals.NoTextures and Part:IsA("BasePart") then
                Part:SetAttribute("OriginalMaterial", Part.Material.Name)
                Part.Material = Enum.Material.SmoothPlastic
            end
        end)
    else
        for _, Part in next, Workspace:GetDescendants() do
            local Original = Part:IsA("BasePart") and Part:GetAttribute("OriginalMaterial")
            if Original then
                pcall(function() Part.Material = Enum.Material[Original] end)
            end
        end
    end
end)
AddToggle(VisualsSection, "Camera Zoom", "CameraZoomToggle", Echo.Visuals.CameraZoom, function(v) Echo.Visuals.CameraZoom = v end)

-- // QB Aimbot
local ThrowConfigurationSection = QBAimbotPage:Section({ Name = "Throw Configuration", Side = 1 })
AddToggle(ThrowConfigurationSection, "QB Aimbot", "QBAimbot", Echo.QBAimbot.Enabled, function(v) Echo.QBAimbot.Enabled = v end)
AddToggle(ThrowConfigurationSection, "Auto Angle", "AutoAngle", Echo.QBAimbot.AutoAngle, function(v) Echo.QBAimbot.AutoAngle = v end)
AddToggle(ThrowConfigurationSection, "Auto Power", "AutoPower", Echo.QBAimbot.AutoPower, function(v) Echo.QBAimbot.AutoPower = v end)
AddToggle(ThrowConfigurationSection, "Auto Throw Type", "AutoChooseThrowType", Echo.QBAimbot.AutoChooseThrowType, function(v) Echo.QBAimbot.AutoChooseThrowType = v end)
local BeamToggle = AddToggle(ThrowConfigurationSection, "Beam Mode", "BeamMode", Echo.QBAimbot.BeamMode, function(v) Echo.QBAimbot.BeamMode = v end)
BeamToggle:Colorpicker({
    Name = "Prediction Color",
    Flag = "PredictionColorPicker",
    Default = Echo.QBAimbot.PredictionColor,
    Alpha = 0,
    Callback = function(v) Echo.QBAimbot.PredictionColor = v end,
})
AddDropdown(ThrowConfigurationSection, "Override Power Mode", "OverridePowerMode", { "Normal", "Highest Power", "95 Power" }, "Normal", function(v)
    Echo.QBAimbot.HighestPowerMode = v == "Highest Power"
    Echo.QBAimbot.Use95PowerMode = v == "95 Power"
end)
AddSlider(ThrowConfigurationSection, "Normal Power", "NormalPowerSlider", 0, 95, Echo.QBAimbot.NormalPower, 1, "", function(v) Echo.QBAimbot.NormalPower = v end)
AddSlider(ThrowConfigurationSection, "Custom Lead", "CustomLeadSlider", 0, 100, Echo.QBAimbot.CustomLead, 1, "", function(v) Echo.QBAimbot.CustomLead = v end)

local GeneralSection = QBAimbotPage:Section({ Name = "General", Side = 1 })
AddToggle(GeneralSection, "Smooth Throw", "SmoothThrow", Echo.QBAimbot.SmoothEnabled, function(v) Echo.QBAimbot.SmoothEnabled = v end)
AddSlider(GeneralSection, "Smooth Factor", "SmoothFactorSlider", 1, 20, Echo.QBAimbot.SmoothFactor, 1, "", function(v) Echo.QBAimbot.SmoothFactor = v end)
AddToggle(GeneralSection, "Target Lock", "TargetLock", Echo.QBAimbot.TargetLock, function(v)
    Echo.QBAimbot.TargetLock = v
    if not v then Echo.QBAimbot.LockedTarget = nil end
end)
AddToggle(GeneralSection, "Scramble Mode", "ScrambleMode", Echo.QBAimbot.ScrambleMode, function(v) Echo.QBAimbot.ScrambleMode = v end)
AddSlider(GeneralSection, "Scramble Speed", "ScrambleSpeedSlider", 16, 50, Echo.QBAimbot.ScrambleSpeed, 1, " st/s", function(v) Echo.QBAimbot.ScrambleSpeed = v end)

local TargetingSection = QBAimbotPage:Section({ Name = "Targeting", Side = 2 })
AddSlider(TargetingSection, "FOV", "FOVSlider", 0, 1000, Echo.QBAimbot.FOV, 1, "px", function(v) Echo.QBAimbot.FOV = v end)
AddToggle(TargetingSection, "Show FOV Circle", "ShowFOVToggle", Echo.QBAimbot.ShowFOV, function(v) Echo.QBAimbot.ShowFOV = v end)
AddDropdown(TargetingSection, "Target Priority", "TargetPriorityDropdown", { "Closest To Mouse", "Most Open", "Furthest Downfield" }, Echo.QBAimbot.TargetPriority, function(v)
    Echo.QBAimbot.TargetPriority = v
    Echo.QBAimbot.LockedTarget = nil
end)
AddToggle(TargetingSection, "Interception Avoidance", "InterceptionAvoidance", Echo.QBAimbot.InterceptionAvoidance, function(v) Echo.QBAimbot.InterceptionAvoidance = v end)
AddSlider(TargetingSection, "Min Open Distance", "MinOpenDistSlider", 5, 50, Echo.QBAimbot.MinOpenDistance, 1, " st", function(v) Echo.QBAimbot.MinOpenDistance = v end)
AddSlider(TargetingSection, "Throw Angle", "ThrowAngleSlider", 0, 85, Echo.QBAimbot.ThrowAngle, 1, "°", function(v) Echo.QBAimbot.ThrowAngle = v end)
AddSlider(TargetingSection, "Bullet Angle", "BulletAngleSlider", 0, 40, Echo.QBAimbot.BulletAngle, 1, "°", function(v) Echo.QBAimbot.BulletAngle = v end)

local AutomationVisualsSection = QBAimbotPage:Section({ Name = "Automation & Visuals", Side = 2 })
AddToggle(AutomationVisualsSection, "Auto Hike", "AutoHikeToggle", Echo.QBAimbot.AutoHike, function(v) Echo.QBAimbot.AutoHike = v end)
AddToggle(AutomationVisualsSection, "Auto Throw", "AutoThrowToggle", Echo.QBAimbot.AutoThrow, function(v) Echo.QBAimbot.AutoThrow = v end)
AddSlider(AutomationVisualsSection, "Auto Throw Delay", "AutoThrowDelaySlider", 0, 3, Echo.QBAimbot.AutoThrowDelay, 0.1, "s", function(v) Echo.QBAimbot.AutoThrowDelay = v end)
AddToggle(AutomationVisualsSection, "Receiver ESP", "ReceiverESPToggle", Echo.QBAimbot.ReceiverESP, function(v) Echo.QBAimbot.ReceiverESP = v end)
AddToggle(AutomationVisualsSection, "Show Routes", "ShowRoutesToggle", Echo.QBAimbot.ShowRoutes, function(v) Echo.QBAimbot.ShowRoutes = v end)
AddToggle(AutomationVisualsSection, "Show Distance", "ShowDistanceToggle", Echo.QBAimbot.ShowDistance, function(v) Echo.QBAimbot.ShowDistance = v end)


-- QB Aimbot menu tab + HUD only while holding the football
task.spawn(function()
    local last = nil
    while true do
        task.wait(0.2)
        local has = false
        pcall(function()
            has = CharacterHasFootball() == true
        end)
        if has == last then
            continue
        end
        last = has
        pcall(function()
            if EchoHUDGui then
                EchoHUDGui.Enabled = has
            end
        end)
        pcall(function()
            local btn = QBAimbotPage and (QBAimbotPage.Button or QBAimbotPage.TabButton or QBAimbotPage.LibraryButton)
            if btn and typeof(btn) == "Instance" then
                btn.Visible = has
            elseif QBAimbotPage and QBAimbotPage.Visible ~= nil then
                QBAimbotPage.Visible = has
            end
        end)
        -- If leaving possession, leave the QB page so leftover open tab isn't stuck
        if not has and Window and Window.SetPage and CatchingPage then
            pcall(function()
                Window:SetPage(CatchingPage)
            end)
        end
    end
end)

Library:Notification("Loaded!", "Menu took " .. string.format("%.4f", os.clock() - LoadTick) .. " seconds to load", 5)

-- Start loops next frame so the menu can paint first under Luarmor
task.defer(function()
    local ok, err = pcall(EchoStartGameplayLoops)
    if not ok then
        warn("[Echo] FF gameplay loops failed: " .. tostring(err))
    end
end)

-- // End of setup (AC bypass: ViseHub-FF3 core/ac_bypass via init_ac_bypass)

end -- Remote ok
end -- RemotesFolder ok
end -- Football Fusion PlaceId gate
]====], "Echo_Football_Fusion")
	if not EchoChunk then
		error("[Echo] Football Fusion compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsCFB() then
-- Echo Hub: College Football
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

-- // Place gate (Luarmor-safe)
-- Compare with strings only — numeric table keys get mangled by Luraph/Luarmor.
-- GameId 5113572498 = College Football universe (covers every sub-place).
local PlaceIdStr = tostring(game.PlaceId)
local GameIdStr = tostring(game.GameId)

local PlaceNames = {
	["14839650434"] = "College",
	["14783490031"] = "Training Facility",
	["15201655003"] = "Event Hall",
	["15358039559"] = "3s",
	["15720676770"] = "Tossup Warriors",
	["18768066477"] = "StadiumViewer",
	["71905624214428"] = "High School",
	["72118582190041"] = "Larger Servers",
}

local CurrentPlaceName = PlaceNames[PlaceIdStr]
if not CurrentPlaceName and GameIdStr == "5113572498" then
	CurrentPlaceName = "College"
end

print("[Echo] CFB PlaceId=" .. PlaceIdStr .. " GameId=" .. GameIdStr .. " match=" .. tostring(CurrentPlaceName))

if CurrentPlaceName then

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoCFBContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

-- Do NOT override getgenv().gethui — that breaks Football Fusion's Scoot UI
-- when both scripts share one Luarmor loader / same executor session.

print("[Echo] loading Scoot library...")
local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoSametScootLib then
		return getgenv().__EchoSametScootLib
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sametexe001/sametlibs/refs/heads/main/Scoot/Library.lua"))()
	getgenv().__EchoSametScootLib = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
else
print("[Echo] library ok, building UI...")

local Library = LibraryOrErr

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local Config = {
	MagsV1Enabled = false,
	MagsV1Range = 30,
	MagsV1ShowHitbox = false,
	MagsV2Enabled = false,
	MagsV2Scale = 20,
	MagsV3Enabled = false,
	MagsV3Range = 10,
	AutotuckEnabled = false,
	FreezeCatchEnabled = false,
	FreezeCatchDuration = 0.5,

	ThrowAssistEnabled = false,
	ThrowAutoPower = true,
	ThrowAutoAngle = true,
	ThrowManualPower = 50,
	ThrowPowerMode = "Normal",
	ThrowTypeMode = "Auto",
	ThrowAngle = 45,
	ThrowBulletAngle = 25,
	ThrowCustomLead = 0,
	ThrowLeadStrength = 1,
	ThrowExtraPower = 0,
	ThrowDistanceBoost = 5,
	ThrowTargetMode = "Closest To Mouse",
	ThrowOnlyInThrowMode = true,
	ThrowMobileCameraAim = true,
	ThrowMobileTapLock = true,
	ThrowMobileAutoPassMode = true,
	ThrowVelocityPrediction = true,
	ThrowIgnoreBlocked = false,
	ThrowTargetMarker = true,
	ThrowFov = 500,
	ThrowShowFov = false,
	ThrowReceiverEsp = false,
	ThrowShowDistance = true,
	ThrowShowRoutes = true,
	ThrowBeamMode = true,
	ThrowMinOpenDistance = 15,

	JumpPowerEnabled = false,
	JumpPower = 90,
	WalkSpeedEnabled = false,
	WalkSpeed = 30,

	AngleEnhancerEnabled = false,
	AngleEnhancerValue = 50,
	FlyEnabled = false,
	FlySpeed = 50,

	NoJumpCooldownEnabled = false,
	AntiJamEnabled = false,
	NoFreezeEnabled = false,
	AntiTackleEnabled = false,
	AntiDownEnabled = false,
	AntiBlockEnabled = false,

	ClickTackleEnabled = false,
	ClickTackleRadius = 15,
	BigHeadEnabled = false,
	BigHeadSize = 5,
	BlockExtenderEnabled = false,
	BlockExtenderReach = 10,
	BlockExtenderTransparency = 1,
	ResetOnCatchEnabled = false,
	ResetOnCatchDuration = 0.5,

	PhysicsGravity = -51,
	PhysicsPowerScale = 1,
	PhysicsMinPower = 20,
	PhysicsMaxPower = 95,
	PhysicsUseServerValues = true,
	PhysicsTimeStep = 0.05,
	PhysicsAirResistance = 1,
	PhysicsYardToStud = 4.365,
	PhysicsShowArc = false,
	PhysicsArcColor = Color3.fromRGB(120, 220, 255),
}

local Connections = {}
local CachedBalls = {}
local BallCacheClock = 0
local FootballObjectValue = nil
local BallCarrierValue = nil
local AutotuckLatched = false
local FreezeCatchToken = 0
local FrozenRoot = nil
local FrozenRootWasAnchored = false
local JumpBoostLatched = false
local LastJumpBoost = 0
local JumpBoostCooldown = 0.45
local AngleTick = 0
local AngleEnhancerLatched = false
local ShiftLockEnabled = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
local LastShiftLockEnabled = ShiftLockEnabled
local NoJumpCooldownLatched = false
local NoJumpCooldownHumanoid = nil
local NoJumpCooldownDisabledConnections = {}
local JumpOriginalSettings = setmetatable({}, { __mode = "k" })
local CollisionOriginalSettings = setmetatable({}, { __mode = "k" })
local BigHeadOriginalSizes = setmetatable({}, { __mode = "k" })
local MagnetHitboxPart = nil
local MagExpanderOriginalSizes = setmetatable({}, { __mode = "k" })
local MagExpanderClock = 0
local ThrowTargetPart = nil
local CurrentThrowTarget = nil
local CurrentThrowSolution = nil
local OldNamecall = nil
local HudGui = nil
local HudCards = nil
local FovFrame = nil
local ArcParts = {}
local EspBillboards = {}
local EspClock = 0
local ArcClock = 0
local TrajectoryBeam = nil
local BeamAttachment0 = nil
local BeamAttachment1 = nil
local LandingMarker = nil
local EchoUiRoots = {}
local FlyBodyVelocity = nil
local FlyBodyGyro = nil
local BlockExtenderPart = nil
local ResetOnCatchToken = 0
local BigHeadClock = 0
local PhysicsSynced = false
local FlyKeysHeld = {
	W = false,
	A = false,
	S = false,
	D = false,
	Space = false,
	LeftShift = false,
}

-- Mobile QB: treat game Mobile GUI / touch as mobile even if KeyboardEnabled is true
local function IsMobileClient()
	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		return true
	end

	local Ok, Preferred = pcall(function()
		return UserInputService.PreferredInput
	end)
	if Ok and Preferred == Enum.PreferredInput.Touch then
		return true
	end

	if UserInputService.TouchEnabled then
		local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
		if PlayerGui and PlayerGui:FindFirstChild("Mobile") then
			return true
		end
	end

	return false
end

local MobileThrowLock = nil -- Player
local LastTouchAimPoint = nil -- Vector2
local MobilePassModeLatched = false
local MobileMenuGui = nil
local LastMobileThrowClock = 0
local MobileTouchStarts = {}
local FireAssistedThrow -- forward declare for mobile tap handlers

local function InvalidateBallCache()
	CachedBalls = {}
	BallCacheClock = 0
end

pcall(function()
	local GameValues = ReplicatedStorage:FindFirstChild("GameValues")
	local Objects = GameValues and GameValues:FindFirstChild("Objects")
	if Objects then
		FootballObjectValue = Objects:FindFirstChild("Football")
		BallCarrierValue = Objects:FindFirstChild("BallCarrier")
	end
end)

pcall(function()
	if typeof(setsimulationradius) == "function" then
		setsimulationradius(10000, 10000)
	end
end)

local Window = Library:Window({
	Logo = "77218680285262",
	FadeTime = 0.3,
})

EchoUiRoots[#EchoUiRoots + 1] = EchoUiContainer

-- Scoot only toggles with RightControl — add a floating mobile menu button.
-- Tap-to-throw uses UserInputService (no Active overlay) so camera look stays free.
local function EnsureMobileMenuToggle()
	local WantMobile = UserInputService.TouchEnabled
		or IsMobileClient()
		or (LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("Mobile") ~= nil)
	if not WantMobile then
		return
	end
	if MobileMenuGui and MobileMenuGui.Parent then
		return
	end

	local Host = EchoUiContainer.Parent
	if not Host then
		Host = LocalPlayer:FindFirstChild("PlayerGui") or CoreGui
	end

	MobileMenuGui = Instance.new("ScreenGui")
	MobileMenuGui.Name = "EchoMobileMenu"
	MobileMenuGui.ResetOnSpawn = false
	MobileMenuGui.IgnoreGuiInset = true
	MobileMenuGui.DisplayOrder = 8
	MobileMenuGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	MobileMenuGui.Parent = Host

	local MenuButton = Instance.new("TextButton")
	MenuButton.Name = "MenuToggle"
	MenuButton.AnchorPoint = Vector2.new(0, 0.5)
	MenuButton.Size = UDim2.fromOffset(58, 58)
	MenuButton.Position = UDim2.new(0, 14, 0.42, 0)
	MenuButton.BackgroundColor3 = Color3.fromRGB(18, 22, 20)
	MenuButton.BackgroundTransparency = 0.12
	MenuButton.BorderSizePixel = 0
	MenuButton.AutoButtonColor = true
	MenuButton.Text = "Echo"
	MenuButton.TextColor3 = Color3.fromRGB(202, 243, 255)
	MenuButton.TextScaled = true
	MenuButton.Font = Enum.Font.GothamBold
	MenuButton.ZIndex = 10
	MenuButton.Parent = MobileMenuGui

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 12)
	Corner.Parent = MenuButton

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(120, 220, 255)
	Stroke.Thickness = 1.4
	Stroke.Transparency = 0.25
	Stroke.Parent = MenuButton

	local Padding = Instance.new("UIPadding")
	Padding.PaddingTop = UDim.new(0, 8)
	Padding.PaddingBottom = UDim.new(0, 8)
	Padding.PaddingLeft = UDim.new(0, 6)
	Padding.PaddingRight = UDim.new(0, 6)
	Padding.Parent = MenuButton

	MenuButton.MouseButton1Click:Connect(function()
		pcall(function()
			Window:SetOpen(not Window.IsOpen)
		end)
	end)

	pcall(function()
		Window:SetOpen(false)
	end)

	EchoUiRoots[#EchoUiRoots + 1] = MobileMenuGui
end

EnsureMobileMenuToggle()

local Watermark = Library:Watermark("Echo | " .. CurrentPlaceName)
local KeybindList = Library:KeybindList()

local ThrowingPage = Window:Page({ Name = "Throwing", Columns = 2 })
local CatchingPage = Window:Page({ Name = "Catching", Columns = 2 })
local PhysicsPage = Window:Page({ Name = "Physics", Columns = 2 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local QbAssistSection = ThrowingPage:Section({ Name = "QB Assist", Side = 1 })
local ThrowPredictionSection = ThrowingPage:Section({ Name = "Prediction", Side = 2 })
local MagSection = CatchingPage:Section({ Name = "Mags V1", Side = 1 })
local MagExpanderSection = CatchingPage:Section({ Name = "Mags V2", Side = 1 })
local MagPullSection = CatchingPage:Section({ Name = "Mags V3", Side = 2 })
local AutotuckSection = CatchingPage:Section({ Name = "Autotuck", Side = 2 })
local FreezeCatchSection = CatchingPage:Section({ Name = "Freeze Catch", Side = 2 })
local JumpPowerSection = PhysicsPage:Section({ Name = "Jump Power", Side = 1 })
local WalkSpeedSection = PhysicsPage:Section({ Name = "Walk Speed", Side = 1 })
local AngleEnhancerSection = PhysicsPage:Section({ Name = "Angle Enhancer", Side = 1 })
local FlySection = PhysicsPage:Section({ Name = "Fly", Side = 1 })
local ProtectionSection = PhysicsPage:Section({ Name = "Protection", Side = 2 })
local InteractionSection = PhysicsPage:Section({ Name = "Interaction", Side = 2 })

MagSection:Toggle({
	Name = "Enabled",
	Flag = "MagsV1Enabled",
	Default = Config.MagsV1Enabled,
	Callback = function(Value)
		Config.MagsV1Enabled = Value
		InvalidateBallCache()
	end,
})

MagSection:Slider({
	Name = "Mags Range",
	Flag = "MagsV1Range",
	Min = 1,
	Max = 30,
	Default = Config.MagsV1Range,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.MagsV1Range = Value
		InvalidateBallCache()
	end,
})

MagSection:Toggle({
	Name = "Visual Hitbox",
	Flag = "MagsV1ShowHitbox",
	Default = Config.MagsV1ShowHitbox,
	Callback = function(Value)
		Config.MagsV1ShowHitbox = Value
	end,
})

MagExpanderSection:Toggle({
	Name = "Ball Expander",
	Flag = "MagsV2Enabled",
	Default = Config.MagsV2Enabled,
	Callback = function(Value)
		Config.MagsV2Enabled = Value
		InvalidateBallCache()
	end,
})

MagExpanderSection:Slider({
	Name = "Expand Scale",
	Flag = "MagsV2Scale",
	Min = 5,
	Max = 20,
	Default = Config.MagsV2Scale,
	Decimals = 1,
	Suffix = "x",
	Callback = function(Value)
		Config.MagsV2Scale = Value
	end,
})

MagPullSection:Toggle({
	Name = "Pull Catch",
	Flag = "MagsV3Enabled",
	Default = Config.MagsV3Enabled,
	Callback = function(Value)
		Config.MagsV3Enabled = Value
		InvalidateBallCache()
	end,
})

MagPullSection:Slider({
	Name = "Pull Range",
	Flag = "MagsV3Range",
	Min = 1,
	Max = 20,
	Default = Config.MagsV3Range,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.MagsV3Range = Value
	end,
})

AutotuckSection:Toggle({
	Name = "Enabled",
	Flag = "AutotuckEnabled",
	Default = Config.AutotuckEnabled,
	Callback = function(Value)
		Config.AutotuckEnabled = Value
		if not Value then
			AutotuckLatched = false
		end
	end,
})

FreezeCatchSection:Toggle({
	Name = "Enabled",
	Flag = "FreezeCatchEnabled",
	Default = Config.FreezeCatchEnabled,
	Callback = function(Value)
		Config.FreezeCatchEnabled = Value
		if Value then
			Config.NoFreezeEnabled = false
			Config.ResetOnCatchEnabled = false
			if Library.Flags then
				Library.Flags.NoFreezeEnabled = false
				Library.Flags.ResetOnCatchEnabled = false
			end
		else
			FreezeCatchToken += 1
			if FrozenRoot and FrozenRoot.Parent then
				pcall(function()
					FrozenRoot.Anchored = FrozenRootWasAnchored
				end)
			end
			FrozenRoot = nil
		end
	end,
})

FreezeCatchSection:Slider({
	Name = "Freeze Time",
	Flag = "FreezeCatchDuration",
	Min = 0.1,
	Max = 10,
	Default = Config.FreezeCatchDuration,
	Decimals = 0.1,
	Suffix = "s",
	Callback = function(Value)
		Config.FreezeCatchDuration = Value
	end,
})

QbAssistSection:Toggle({
	Name = "Enabled",
	Flag = "ThrowAssistEnabled",
	Default = Config.ThrowAssistEnabled,
	Callback = function(Value)
		Config.ThrowAssistEnabled = Value
	end,
})

QbAssistSection:Toggle({
	Name = "Auto Power",
	Flag = "ThrowAutoPower",
	Default = Config.ThrowAutoPower,
	Callback = function(Value)
		Config.ThrowAutoPower = Value
	end,
})

QbAssistSection:Toggle({
	Name = "Auto Angle",
	Flag = "ThrowAutoAngle",
	Default = Config.ThrowAutoAngle,
	Callback = function(Value)
		Config.ThrowAutoAngle = Value
	end,
})

QbAssistSection:Dropdown({
	Name = "Power Mode",
	Flag = "ThrowPowerMode",
	Items = { "Normal", "Highest Power", "95 Power" },
	Default = Config.ThrowPowerMode,
	Multi = false,
	Callback = function(Value)
		Config.ThrowPowerMode = Value
	end,
})

QbAssistSection:Slider({
	Name = "Manual Power",
	Flag = "ThrowManualPower",
	Min = 0,
	Max = 95,
	Default = Config.ThrowManualPower,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.ThrowManualPower = Value
	end,
})

QbAssistSection:Dropdown({
	Name = "Throw Type",
	Flag = "ThrowTypeMode",
	Items = { "Auto", "Dime", "Bullet", "Dive", "Dot", "Fade" },
	Default = Config.ThrowTypeMode,
	Multi = false,
	Callback = function(Value)
		Config.ThrowTypeMode = Value
	end,
})

QbAssistSection:Dropdown({
	Name = "Target Priority",
	Flag = "ThrowTargetMode",
	Items = { "Closest To Mouse", "Most Open", "Furthest Downfield" },
	Default = Config.ThrowTargetMode,
	Multi = false,
	Callback = function(Value)
		Config.ThrowTargetMode = Value
	end,
})

QbAssistSection:Toggle({
	Name = "Only In Throw Mode",
	Flag = "ThrowOnlyInThrowMode",
	Default = Config.ThrowOnlyInThrowMode,
	Callback = function(Value)
		Config.ThrowOnlyInThrowMode = Value
	end,
})

QbAssistSection:Toggle({
	Name = "Mobile Camera Aim",
	Flag = "ThrowMobileCameraAim",
	Default = Config.ThrowMobileCameraAim,
	Callback = function(Value)
		Config.ThrowMobileCameraAim = Value
	end,
})

QbAssistSection:Toggle({
	Name = "Mobile Tap Lock",
	Flag = "ThrowMobileTapLock",
	Default = Config.ThrowMobileTapLock,
	Callback = function(Value)
		Config.ThrowMobileTapLock = Value
		if not Value then
			MobileThrowLock = nil
		end
	end,
})

QbAssistSection:Toggle({
	Name = "Mobile Auto Pass Mode",
	Flag = "ThrowMobileAutoPassMode",
	Default = Config.ThrowMobileAutoPassMode,
	Callback = function(Value)
		Config.ThrowMobileAutoPassMode = Value
		if not Value then
			MobilePassModeLatched = false
		end
	end,
})

QbAssistSection:Slider({
	Name = "Throw Angle",
	Flag = "ThrowAngle",
	Min = 0,
	Max = 85,
	Default = Config.ThrowAngle,
	Decimals = 1,
	Suffix = "°",
	Callback = function(Value)
		Config.ThrowAngle = Value
	end,
})

QbAssistSection:Slider({
	Name = "Bullet Angle",
	Flag = "ThrowBulletAngle",
	Min = 0,
	Max = 40,
	Default = Config.ThrowBulletAngle,
	Decimals = 1,
	Suffix = "°",
	Callback = function(Value)
		Config.ThrowBulletAngle = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Velocity Prediction",
	Flag = "ThrowVelocityPrediction",
	Default = Config.ThrowVelocityPrediction,
	Callback = function(Value)
		Config.ThrowVelocityPrediction = Value
	end,
})

ThrowPredictionSection:Slider({
	Name = "Custom Lead",
	Flag = "ThrowCustomLead",
	Min = 0,
	Max = 100,
	Default = Config.ThrowCustomLead,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.ThrowCustomLead = Value
	end,
})

ThrowPredictionSection:Slider({
	Name = "Lead Strength",
	Flag = "ThrowLeadStrength",
	Min = 0,
	Max = 2,
	Default = Config.ThrowLeadStrength,
	Decimals = 0.05,
	Suffix = "x",
	Callback = function(Value)
		Config.ThrowLeadStrength = Value
	end,
})

ThrowPredictionSection:Slider({
	Name = "Distance Boost",
	Flag = "ThrowDistanceBoost",
	Min = 0,
	Max = 20,
	Default = Config.ThrowDistanceBoost,
	Decimals = 1,
	Suffix = " st",
	Callback = function(Value)
		local Number = tonumber(Value)
		if Number ~= nil then
			Config.ThrowDistanceBoost = math.clamp(Number, 0, 20)
		end
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Target Marker",
	Flag = "ThrowTargetMarker",
	Default = Config.ThrowTargetMarker,
	Callback = function(Value)
		Config.ThrowTargetMarker = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Beam Mode",
	Flag = "ThrowBeamMode",
	Default = Config.ThrowBeamMode,
	Callback = function(Value)
		Config.ThrowBeamMode = Value
	end,
})

ThrowPredictionSection:Slider({
	Name = "FOV",
	Flag = "ThrowFov",
	Min = 50,
	Max = 1200,
	Default = Config.ThrowFov,
	Decimals = 10,
	Suffix = "px",
	Callback = function(Value)
		Config.ThrowFov = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Show FOV Circle",
	Flag = "ThrowShowFov",
	Default = Config.ThrowShowFov,
	Callback = function(Value)
		Config.ThrowShowFov = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Receiver ESP",
	Flag = "ThrowReceiverEsp",
	Default = Config.ThrowReceiverEsp,
	Callback = function(Value)
		Config.ThrowReceiverEsp = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Show Distance",
	Flag = "ThrowShowDistance",
	Default = Config.ThrowShowDistance,
	Callback = function(Value)
		Config.ThrowShowDistance = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Show Routes",
	Flag = "ThrowShowRoutes",
	Default = Config.ThrowShowRoutes,
	Callback = function(Value)
		Config.ThrowShowRoutes = Value
	end,
})

ThrowPredictionSection:Toggle({
	Name = "Ignore Blocked Lanes",
	Flag = "ThrowIgnoreBlocked",
	Default = Config.ThrowIgnoreBlocked,
	Callback = function(Value)
		Config.ThrowIgnoreBlocked = Value
	end,
})

ThrowPredictionSection:Slider({
	Name = "Min Open Distance",
	Flag = "ThrowMinOpenDistance",
	Min = 5,
	Max = 50,
	Default = Config.ThrowMinOpenDistance,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.ThrowMinOpenDistance = Value
	end,
})

JumpPowerSection:Toggle({
	Name = "Enabled",
	Flag = "JumpPowerEnabled",
	Default = Config.JumpPowerEnabled,
	Callback = function(Value)
		Config.JumpPowerEnabled = Value
		JumpBoostLatched = false
		LastJumpBoost = 0
	end,
})

JumpPowerSection:Slider({
	Name = "Jump Power",
	Flag = "JumpPower",
	Min = 50,
	Max = 150,
	Default = Config.JumpPower,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.JumpPower = Value
	end,
})

WalkSpeedSection:Toggle({
	Name = "Enabled",
	Flag = "WalkSpeedEnabled",
	Default = Config.WalkSpeedEnabled,
	Callback = function(Value)
		Config.WalkSpeedEnabled = Value
	end,
})

WalkSpeedSection:Slider({
	Name = "Speed",
	Flag = "WalkSpeed",
	Min = 16,
	Max = 100,
	Default = Config.WalkSpeed,
	Decimals = 1,
	Suffix = " st/s",
	Callback = function(Value)
		Config.WalkSpeed = Value
	end,
})

AngleEnhancerSection:Toggle({
	Name = "Enabled",
	Flag = "AngleEnhancerEnabled",
	Default = Config.AngleEnhancerEnabled,
	Callback = function(Value)
		Config.AngleEnhancerEnabled = Value
		AngleEnhancerLatched = false
		AngleTick = 0
	end,
})

AngleEnhancerSection:Slider({
	Name = "Boost",
	Flag = "AngleEnhancerValue",
	Min = 10,
	Max = 120,
	Default = Config.AngleEnhancerValue,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.AngleEnhancerValue = Value
	end,
})

FlySection:Toggle({
	Name = "Enabled",
	Flag = "FlyEnabled",
	Default = Config.FlyEnabled,
	Callback = function(Value)
		Config.FlyEnabled = Value
		if not Value and typeof(getgenv().EchoStopFly) == "function" then
			getgenv().EchoStopFly()
		end
	end,
})

FlySection:Slider({
	Name = "Speed",
	Flag = "FlySpeed",
	Min = 16,
	Max = 200,
	Default = Config.FlySpeed,
	Decimals = 1,
	Suffix = " st/s",
	Callback = function(Value)
		Config.FlySpeed = Value
	end,
})

ProtectionSection:Toggle({
	Name = "No Jump Cooldown",
	Flag = "NoJumpCooldownEnabled",
	Default = Config.NoJumpCooldownEnabled,
	Callback = function(Value)
		Config.NoJumpCooldownEnabled = Value
		if not Value and typeof(getgenv().EchoRestoreJumpCooldown) == "function" then
			getgenv().EchoRestoreJumpCooldown()
		end
	end,
})

ProtectionSection:Toggle({
	Name = "Anti Jam",
	Flag = "AntiJamEnabled",
	Default = Config.AntiJamEnabled,
	Callback = function(Value)
		Config.AntiJamEnabled = Value
		if not Value and typeof(getgenv().EchoRestoreCollision) == "function" then
			getgenv().EchoRestoreCollision()
		end
	end,
})

ProtectionSection:Toggle({
	Name = "No Freeze",
	Flag = "NoFreezeEnabled",
	Default = Config.NoFreezeEnabled,
	Callback = function(Value)
		Config.NoFreezeEnabled = Value
		if Value then
			Config.FreezeCatchEnabled = false
			if Library.Flags then
				Library.Flags.FreezeCatchEnabled = false
			end
			FreezeCatchToken += 1
			if FrozenRoot and FrozenRoot.Parent then
				pcall(function()
					FrozenRoot.Anchored = FrozenRootWasAnchored
				end)
			end
			FrozenRoot = nil
		end
	end,
})

ProtectionSection:Toggle({
	Name = "Anti Tackle",
	Flag = "AntiTackleEnabled",
	Default = Config.AntiTackleEnabled,
	Callback = function(Value)
		Config.AntiTackleEnabled = Value
	end,
})

ProtectionSection:Toggle({
	Name = "Anti Down",
	Flag = "AntiDownEnabled",
	Default = Config.AntiDownEnabled,
	Callback = function(Value)
		Config.AntiDownEnabled = Value
	end,
})

ProtectionSection:Toggle({
	Name = "Anti Block",
	Flag = "AntiBlockEnabled",
	Default = Config.AntiBlockEnabled,
	Callback = function(Value)
		Config.AntiBlockEnabled = Value
	end,
})

InteractionSection:Toggle({
	Name = "Click Tackle",
	Flag = "ClickTackleEnabled",
	Default = Config.ClickTackleEnabled,
	Callback = function(Value)
		Config.ClickTackleEnabled = Value
	end,
})

InteractionSection:Slider({
	Name = "Tackle Radius",
	Flag = "ClickTackleRadius",
	Min = 5,
	Max = 40,
	Default = Config.ClickTackleRadius,
	Decimals = 1,
	Suffix = " st",
	Callback = function(Value)
		Config.ClickTackleRadius = Value
	end,
})

InteractionSection:Toggle({
	Name = "Big Head",
	Flag = "BigHeadEnabled",
	Default = Config.BigHeadEnabled,
	Callback = function(Value)
		Config.BigHeadEnabled = Value
		if not Value and typeof(getgenv().EchoRestoreBigHeads) == "function" then
			getgenv().EchoRestoreBigHeads()
		end
	end,
})

InteractionSection:Slider({
	Name = "Head Size",
	Flag = "BigHeadSize",
	Min = 2,
	Max = 20,
	Default = Config.BigHeadSize,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.BigHeadSize = Value
	end,
})

InteractionSection:Toggle({
	Name = "Block Extender",
	Flag = "BlockExtenderEnabled",
	Default = Config.BlockExtenderEnabled,
	Callback = function(Value)
		Config.BlockExtenderEnabled = Value
		if not Value and typeof(getgenv().EchoClearBlockExtender) == "function" then
			getgenv().EchoClearBlockExtender()
		end
	end,
})

InteractionSection:Slider({
	Name = "Reach",
	Flag = "BlockExtenderReach",
	Min = 2,
	Max = 30,
	Default = Config.BlockExtenderReach,
	Decimals = 1,
	Suffix = " st",
	Callback = function(Value)
		Config.BlockExtenderReach = Value
	end,
})

InteractionSection:Slider({
	Name = "Transparency",
	Flag = "BlockExtenderTransparency",
	Min = 0,
	Max = 1,
	Default = Config.BlockExtenderTransparency,
	Decimals = 2,
	Suffix = "",
	Callback = function(Value)
		local Number = tonumber(Value)
		if Number ~= nil then
			Config.BlockExtenderTransparency = math.clamp(Number, 0, 1)
		end
	end,
})

InteractionSection:Toggle({
	Name = "Reset on Catch",
	Flag = "ResetOnCatchEnabled",
	Default = Config.ResetOnCatchEnabled,
	Callback = function(Value)
		Config.ResetOnCatchEnabled = Value
		if Value then
			Config.FreezeCatchEnabled = false
			if Library.Flags then
				Library.Flags.FreezeCatchEnabled = false
			end
			FreezeCatchToken += 1
			if FrozenRoot and FrozenRoot.Parent then
				pcall(function()
					FrozenRoot.Anchored = FrozenRootWasAnchored
				end)
			end
			FrozenRoot = nil
		else
			ResetOnCatchToken += 1
		end
	end,
})

InteractionSection:Slider({
	Name = "Reset Delay",
	Flag = "ResetOnCatchDuration",
	Min = 0.1,
	Max = 5,
	Default = Config.ResetOnCatchDuration,
	Decimals = 1,
	Suffix = "s",
	Callback = function(Value)
		Config.ResetOnCatchDuration = math.clamp(tonumber(Value) or 0.5, 0.1, 5)
	end,
})

Config.BlockExtenderTransparency = 1
Config.ResetOnCatchDuration = 0.5
Config.ThrowDistanceBoost = 5

-- // Utilities
local function TrackConnection(Signal, Callback)
	local Connection = Signal:Connect(Callback)
	Connections[#Connections + 1] = Connection
	return Connection
end

local function ResolvePart(Instance)
	if not Instance then
		return nil
	end
	if Instance:IsA("BasePart") then
		return Instance
	end
	if Instance:IsA("Tool") or Instance:IsA("Model") or Instance:IsA("Folder") then
		return Instance:FindFirstChild("Handle")
			or (Instance:IsA("Model") and Instance.PrimaryPart)
			or Instance:FindFirstChildWhichIsA("BasePart", true)
	end
	return nil
end

local function GetBallOwner(Part)
	if not Part or not Part.Parent then
		return true
	end

	if BallCarrierValue and typeof(BallCarrierValue.Value) == "Instance" then
		local Carrier = BallCarrierValue.Value
		if Carrier:IsA("Model") and Part:IsDescendantOf(Carrier) then
			return Players:GetPlayerFromCharacter(Carrier) or true
		end
		if Carrier:IsA("Player") and Carrier.Character and Part:IsDescendantOf(Carrier.Character) then
			return Carrier
		end
	end

	local Current = Part
	for _ = 1, 8 do
		if not Current then
			break
		end
		if Current:IsA("Accessory") or Current:IsA("Hat") then
			return true
		end

		local Owner = Players:GetPlayerFromCharacter(Current)
		if Owner then
			return Owner
		end

		if Current:IsA("Tool") then
			local Parent = Current.Parent
			if Parent then
				local FromCharacter = Players:GetPlayerFromCharacter(Parent)
				if FromCharacter then
					return FromCharacter
				end
				if Parent:IsA("Backpack") then
					return Parent.Parent
				end
			end
		end

		Current = Current.Parent
	end

	return nil
end

local function IsLooseFootball(Instance)
	local Part = ResolvePart(Instance)
	if not Part or not Part.Parent then
		return nil
	end
	if not Part:IsDescendantOf(Workspace) then
		return nil
	end
	if Part:IsDescendantOf(CoreGui) then
		return nil
	end

	local FullName = Part:GetFullName()
	if string.find(FullName, "ReplayObjects", 1, true) then
		return nil
	end
	if string.find(FullName, "ArcPoints", 1, true) then
		return nil
	end

	local Name = Part.Name
	local Parent = Part.Parent
	local IsBall = CollectionService:HasTag(Part, "Football")
		or CollectionService:HasTag(Part, "Ball")
		or Name == "Football"
		or (Name == "Handle" and Parent == Workspace)
		or (Name == "Handle" and Parent and Parent.Name == "Football")
		or (Parent and Parent:IsA("Tool") and Parent.Name == "Football")

	if not IsBall then
		return nil
	end
	if Parent and (Parent:IsA("Accessory") or Parent:IsA("Hat")) then
		return nil
	end
	if GetBallOwner(Part) ~= nil then
		return nil
	end

	return Part
end

local function GetLooseBalls()
	local Now = os.clock()
	if Now - BallCacheClock < 0.03 and #CachedBalls > 0 then
		local Alive = {}
		for Index = 1, #CachedBalls do
			local Part = CachedBalls[Index]
			if Part and Part.Parent and GetBallOwner(Part) == nil then
				Alive[#Alive + 1] = Part
			end
		end
		if #Alive > 0 then
			CachedBalls = Alive
			return CachedBalls
		end
	end

	BallCacheClock = Now
	local Results = {}
	local Seen = {}

	local function Add(Instance)
		local Part = IsLooseFootball(Instance)
		if Part and not Seen[Part] then
			Seen[Part] = true
			Results[#Results + 1] = Part
		end
	end

	if FootballObjectValue and typeof(FootballObjectValue.Value) == "Instance" then
		Add(FootballObjectValue.Value)
	end

	local WorkspaceHandle = Workspace:FindFirstChild("Handle")
	if WorkspaceHandle then
		Add(WorkspaceHandle)
	end

	local WorkspaceFootball = Workspace:FindFirstChild("Football")
	if WorkspaceFootball then
		Add(WorkspaceFootball)
	end

	for _, Instance in ipairs(CollectionService:GetTagged("Football")) do
		Add(Instance)
	end
	for _, Instance in ipairs(CollectionService:GetTagged("Ball")) do
		Add(Instance)
	end
	for _, Instance in ipairs(Workspace:GetChildren()) do
		if Instance.Name == "Football" or Instance.Name == "Handle" or (Instance:IsA("Tool") and Instance.Name == "Football") then
			Add(Instance)
		end
	end

	CachedBalls = Results
	return Results
end

local function RestoreExpandedBalls()
	for Ball, OriginalSize in pairs(MagExpanderOriginalSizes) do
		if Ball and Ball.Parent then
			pcall(function()
				Ball.Size = OriginalSize
			end)
		end
		MagExpanderOriginalSizes[Ball] = nil
	end
end

local function RunMagsV2()
	if not Config.MagsV2Enabled then
		if next(MagExpanderOriginalSizes) then
			RestoreExpandedBalls()
		end
		return
	end

	local Now = os.clock()
	if Now - MagExpanderClock < 0.05 then
		return
	end
	MagExpanderClock = Now

	local Scale = math.clamp(tonumber(Config.MagsV2Scale) or 20, 5, 20)
	local ActiveBalls = {}

	for _, Ball in ipairs(GetLooseBalls()) do
		if Ball and Ball.Parent then
			ActiveBalls[Ball] = true
			local OriginalSize = MagExpanderOriginalSizes[Ball]
			if not OriginalSize then
				OriginalSize = Ball.Size
				MagExpanderOriginalSizes[Ball] = OriginalSize
			end

			pcall(function()
				Ball.Size = OriginalSize * Scale
				Ball.CanCollide = false
				Ball.CanTouch = true
			end)
		end
	end

	for Ball, OriginalSize in pairs(MagExpanderOriginalSizes) do
		if not ActiveBalls[Ball] then
			if Ball and Ball.Parent then
				pcall(function()
					Ball.Size = OriginalSize
				end)
			end
			MagExpanderOriginalSizes[Ball] = nil
		end
	end
end

local function GetTouchParts(Character)
	local Parts = {}
	for _, Name in ipairs({ "Right Arm", "Left Arm", "Torso", "HumanoidRootPart", "Head" }) do
		local Part = Character:FindFirstChild(Name)
		if Part and Part:IsA("BasePart") then
			Part.CanTouch = true
			Parts[#Parts + 1] = Part
		end
	end
	return Parts
end

local function PulseTouch(PartA, PartB)
	pcall(firetouchinterest, PartA, PartB, 0)
	pcall(firetouchinterest, PartA, PartB, 1)
	pcall(firetouchinterest, PartB, PartA, 0)
	pcall(firetouchinterest, PartB, PartA, 1)
end

local function ForceCatchState(Character)
	local Jersey = Character and Character:FindFirstChild("Jersey")
	local Values = Jersey and Jersey:FindFirstChild("Values")
	local Catch = Values and Values:FindFirstChild("Catch")
	if Catch and Catch:IsA("BoolValue") then
		Catch.Value = true
	end
end

local function GetMagsV3CatchParts()
	local Character = LocalPlayer.Character
	if not Character then
		return {}
	end

	local Parts = {}
	local Seen = {}

	local function Add(Part)
		if Part and Part:IsA("BasePart") and not Seen[Part] then
			Seen[Part] = true
			Part.CanTouch = true
			Parts[#Parts + 1] = Part
		end
	end

	for _, Name in ipairs({ "CatchLeft", "CatchRight", "LeftHand", "RightHand", "Left Arm", "Right Arm" }) do
		Add(Character:FindFirstChild(Name, true))
	end

	local WorkspaceCharacter = Workspace:FindFirstChild(LocalPlayer.Name)
	if WorkspaceCharacter and WorkspaceCharacter ~= Character then
		for _, Name in ipairs({ "CatchLeft", "CatchRight", "LeftHand", "RightHand", "Left Arm", "Right Arm" }) do
			Add(WorkspaceCharacter:FindFirstChild(Name, true))
		end
	end

	for _, Root in ipairs({ Character, WorkspaceCharacter }) do
		if Root then
			for _, Descendant in ipairs(Root:GetDescendants()) do
				if Descendant:IsA("BasePart") then
					local Name = string.lower(Descendant.Name)
					if string.find(Name, "catch", 1, true)
						and (string.find(Name, "left", 1, true) or string.find(Name, "right", 1, true))
					then
						Add(Descendant)
					end
				end
			end
		end
	end

	return Parts
end

local function RunMagsV3()
	if not Config.MagsV3Enabled then
		return
	end

	local Character = LocalPlayer.Character
	local RootPart = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso"))
	if not Character or not RootPart then
		return
	end

	local HeldFootball = Character:FindFirstChild("Football")
	if HeldFootball and HeldFootball:IsA("Tool") then
		return
	end

	local CatchParts = GetMagsV3CatchParts()
	if #CatchParts == 0 then
		return
	end

	local Range = math.clamp(tonumber(Config.MagsV3Range) or 10, 1, 20)
	for _, Ball in ipairs(GetLooseBalls()) do
		if Ball and Ball.Parent and not Ball.Anchored and (RootPart.Position - Ball.Position).Magnitude <= Range then
			local Target = CatchParts[1]
			local BestDistance = math.huge
			for _, CatchPart in ipairs(CatchParts) do
				local Distance = (CatchPart.Position - Ball.Position).Magnitude
				if Distance < BestDistance then
					BestDistance = Distance
					Target = CatchPart
				end
			end

			if Target then
				pcall(function()
					Ball.CanCollide = false
					Ball.CanTouch = true
					Ball.CFrame = Target.CFrame
					Ball.AssemblyLinearVelocity = Vector3.zero
					Ball.AssemblyAngularVelocity = Vector3.zero
				end)
				ForceCatchState(Character)
				PulseTouch(Target, Ball)
			end
		end
	end
end

local function FireAutotuck()
	local Character = LocalPlayer.Character
	if not Character then
		return
	end

	local Jersey = Character:FindFirstChild("Jersey")
	local Values = Jersey and Jersey:FindFirstChild("Values")
	local Tuck = Values and Values:FindFirstChild("Tuck")
	if Tuck and Tuck:IsA("BoolValue") then
		Tuck.Value = true
	end

	local Event = Jersey and Jersey:FindFirstChild("Event")
	if Event and Event:IsA("RemoteEvent") then
		pcall(function()
			Event:FireServer({ "Tuck" })
		end)
	end
end

local function RunAutotuck()
	if not Config.AutotuckEnabled then
		AutotuckLatched = false
		return
	end

	local Character = LocalPlayer.Character
	if not Character then
		AutotuckLatched = false
		return
	end

	local Tool = Character:FindFirstChild("Football")
	if not (Tool and Tool:IsA("Tool")) then
		AutotuckLatched = false
		return
	end

	if AutotuckLatched then
		return
	end

	AutotuckLatched = true
	FireAutotuck()
end

local function RunMagsV1()
	if not Config.MagsV1Enabled then
		return
	end

	local Character = LocalPlayer.Character
	if not Character then
		return
	end

	if Character:FindFirstChild("Football") and Character:FindFirstChild("Football"):IsA("Tool") then
		return
	end

	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso")
	if not HumanoidRootPart then
		return
	end

	local TouchParts = GetTouchParts(Character)
	if #TouchParts == 0 then
		return
	end

	local Range = math.clamp(tonumber(Config.MagsV1Range) or 30, 1, 30)
	local Balls = GetLooseBalls()

	for Index = 1, #Balls do
		local Ball = Balls[Index]
		if Ball and Ball.Parent then
			local Distance = math.huge
			for PartIndex = 1, #TouchParts do
				local PartDistance = (TouchParts[PartIndex].Position - Ball.Position).Magnitude
				if PartDistance < Distance then
					Distance = PartDistance
				end
			end

			local Velocity = Ball.AssemblyLinearVelocity
			local Predicted = Ball.Position + Velocity * 0.1
			local PredictedDistance = (HumanoidRootPart.Position - Predicted).Magnitude

			if Distance <= Range or PredictedDistance <= Range then
				pcall(function()
					Ball.CanTouch = true
					Ball.CanCollide = false
				end)
				ForceCatchState(Character)
				for PartIndex = 1, #TouchParts do
					for _ = 1, 5 do
						PulseTouch(TouchParts[PartIndex], Ball)
					end
				end
			end
		end
	end
end

local function UpdateMagHitbox()
	local Character = LocalPlayer.Character
	local RootPart = Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso"))
	local HoldingFootball = Character and Character:FindFirstChild("Football")

	if not Config.MagsV1Enabled or not Config.MagsV1ShowHitbox or not RootPart or HoldingFootball then
		if MagnetHitboxPart then
			MagnetHitboxPart:Destroy()
			MagnetHitboxPart = nil
		end
		return
	end

	if not MagnetHitboxPart then
		MagnetHitboxPart = Instance.new("Part")
		MagnetHitboxPart.Name = "EchoMagHitbox"
		MagnetHitboxPart.Shape = Enum.PartType.Ball
		MagnetHitboxPart.Material = Enum.Material.ForceField
		MagnetHitboxPart.Color = Color3.fromRGB(180, 207, 229)
		MagnetHitboxPart.Transparency = 0.72
		MagnetHitboxPart.Anchored = true
		MagnetHitboxPart.CanCollide = false
		MagnetHitboxPart.CanTouch = false
		MagnetHitboxPart.CanQuery = false
		MagnetHitboxPart.CastShadow = false
		MagnetHitboxPart.Parent = Workspace
	end

	local Diameter = math.clamp(tonumber(Config.MagsV1Range) or 30, 1, 30) * 2
	MagnetHitboxPart.Size = Vector3.new(Diameter, Diameter, Diameter)
	MagnetHitboxPart.CFrame = RootPart.CFrame
end

local function GetReceiverRoot(Player)
	local Character = Player and Player.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or Humanoid.Health <= 0 or not RootPart then
		return nil
	end
	return RootPart
end

local function GetClosestDefenderDistance(Position)
	local ClosestDistance = math.huge
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Team ~= LocalPlayer.Team then
			local RootPart = GetReceiverRoot(Player)
			if RootPart then
				ClosestDistance = math.min(ClosestDistance, (RootPart.Position - Position).Magnitude)
			end
		end
	end
	return ClosestDistance
end

local function IsThrowLaneBlocked(StartPosition, TargetPlayer, TargetPosition)
	local Character = LocalPlayer.Character
	local TargetCharacter = TargetPlayer and TargetPlayer.Character
	local Filter = {}
	if Character then
		Filter[#Filter + 1] = Character
	end
	if TargetCharacter then
		Filter[#Filter + 1] = TargetCharacter
	end

	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = Filter
	Params.IgnoreWater = true

	local Result = Workspace:Raycast(StartPosition, TargetPosition - StartPosition, Params)
	if not Result then
		return false
	end

	local HitPlayer = Players:GetPlayerFromCharacter(Result.Instance:FindFirstAncestorOfClass("Model"))
	return HitPlayer ~= nil and HitPlayer.Team ~= LocalPlayer.Team
end

local ThrowTypeOffsets = {
	Dime = Vector3.new(0, 10, 0),
	Mag = Vector3.new(0, 7, 0),
	Dive = Vector3.new(0, 3, 0),
	Dot = Vector3.new(0, 2, 0),
	Fade = Vector3.new(0, 9, -2),
	Bullet = Vector3.new(0, 5, 0),
	Jump = Vector3.new(0, 5, 0),
}

local function GetFieldSign(Value)
	if Value > 0.05 then
		return 1
	elseif Value < -0.05 then
		return -1
	end
	return 0
end

local function CalculateRouteOfPlayer(Player)
	local Character = Player.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not RootPart or not LocalRoot then
		return "Still"
	end

	local MoveDirection = Humanoid.MoveDirection
	if MoveDirection.Magnitude < 0.1 then
		return "Still"
	end

	local Away = RootPart.Position - LocalRoot.Position
	if Away.Magnitude < 1 then
		return "Still"
	end

	local AwayUnit = Away.Unit
	local Forward = Vector3.new(0, 0, GetFieldSign(MoveDirection.Z) == -1 and -1 or 1)
	local StreakDot = MoveDirection:Dot(AwayUnit * Forward)
	local Route = "Still"

	if math.abs(StreakDot) >= 0.8 then
		Route = "Straight"
	elseif math.abs(StreakDot) >= 0.45 then
		Route = "Post"
	elseif math.abs(StreakDot) >= 0.2 then
		Route = "Slant"
	end

	if MoveDirection:Dot(AwayUnit) < -0.35 then
		Route = "Comeback"
	end

	return Route
end

local function HorizontalRangeToPlayer(Player, StartPosition)
	local Character = Player.Character
	local Head = Character and Character:FindFirstChild("Head")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	local Anchor = Head or RootPart
	if not Anchor then
		return 0
	end

	local Offset = Anchor.Position - StartPosition
	return Vector2.new(Offset.X, Offset.Z).Magnitude
end

local function ResolveThrowType(Player, StartPosition)
	if Config.ThrowTypeMode ~= "Auto" then
		return Config.ThrowTypeMode
	end

	local Range = HorizontalRangeToPlayer(Player, StartPosition)
	local Route = CalculateRouteOfPlayer(Player)

	if Range <= 100 and Route == "Slant" then
		return "Bullet"
	elseif Range > 100 and Route == "Slant" then
		return "Dive"
	elseif Range <= 150 and Route == "Straight" then
		return "Dive"
	elseif Range > 150 and Route == "Straight" then
		return "Dime"
	elseif Range <= 150 and Route == "Post" then
		return "Dive"
	elseif Range > 150 and Route == "Post" then
		return "Dime"
	elseif Range <= 100 and Route == "Still" then
		return "Dot"
	elseif Range > 100 and Route == "Still" then
		return "Dime"
	elseif Range <= 150 and Route == "Comeback" then
		return "Bullet"
	elseif Range > 150 and Route == "Comeback" then
		return "Dive"
	end

	return "Dime"
end

local function GetAimScreenPoint()
	local Camera = Workspace.CurrentCamera
	-- Camera aim must stay on viewport center. Never follow LastTouchAimPoint
	-- (joysticks / UI drag would steal the FOV target).
	if IsMobileClient() and Config.ThrowMobileCameraAim ~= false then
		if Camera then
			local Viewport = Camera.ViewportSize
			return Vector2.new(Viewport.X * 0.5, Viewport.Y * 0.5)
		end
	end

	if IsMobileClient() and LastTouchAimPoint then
		return LastTouchAimPoint
	end

	return UserInputService:GetMouseLocation()
end

local function IsMobileThrowLockValid(Player)
	if not Player then
		return false
	end
	if Player.Parent ~= Players then
		return false
	end
	if Player.Team ~= LocalPlayer.Team then
		return false
	end
	return GetReceiverRoot(Player) ~= nil
end

local function EnsureMobilePassMode(Character)
	if not IsMobileClient() or Config.ThrowMobileAutoPassMode == false then
		return
	end
	if not Config.ThrowAssistEnabled then
		return
	end

	local Holding = Character and Character:FindFirstChild("Football")
	if not (Holding and Holding:IsA("Tool")) then
		MobilePassModeLatched = false
		return
	end

	local Jersey = Character:FindFirstChild("Jersey")
	local Values = Jersey and Jersey:FindFirstChild("Values")
	local ThrowMode = Values and Values:FindFirstChild("ThrowMode")
	if not ThrowMode or not ThrowMode:IsA("BoolValue") then
		return
	end

	if ThrowMode.Value then
		return
	end

	-- Prefer the real Pass Mode button (sets ThrowMode + power UI). Never
	-- set-then-click — Pass Mode toggles and would flip throw mode back off.
	pcall(function()
		local MobileGui = LocalPlayer.PlayerGui:FindFirstChild("Mobile")
		local Carrier = MobileGui and MobileGui:FindFirstChild("Ball Carrier")
		local PassMode = Carrier and Carrier:FindFirstChild("Pass Mode")
		if PassMode and PassMode:IsA("GuiButton") and PassMode.Visible then
			if typeof(firesignal) == "function" then
				firesignal(PassMode.MouseButton1Click)
			elseif typeof(getconnections) == "function" then
				for _, Connection in ipairs(getconnections(PassMode.MouseButton1Click)) do
					if Connection.Fire then
						Connection:Fire()
						break
					end
				end
			end
		end
	end)

	if not ThrowMode.Value then
		ThrowMode.Value = true
	end
	MobilePassModeLatched = true
end

local function TouchHitsBlockingGui(ScreenPoint)
	local Ok, Objects = pcall(function()
		return LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(ScreenPoint.X, ScreenPoint.Y)
	end)
	if not Ok or type(Objects) ~= "table" then
		return false
	end

	for Index = 1, #Objects do
		local Object = Objects[Index]
		if Object and Object:IsA("GuiButton") and Object.Visible and Object.Active then
			if Object:FindFirstAncestor("EchoMobileMenu") or Object:FindFirstAncestor("EchoCFBContainer") then
				return true
			end

			-- Only block real mobile action buttons, not joysticks / empty frames.
			local Name = string.lower(Object.Name)
			if string.find(Name, "pass", 1, true)
				or string.find(Name, "tuck", 1, true)
				or string.find(Name, "sprint", 1, true)
				or string.find(Name, "emote", 1, true)
				or string.find(Name, "change", 1, true)
				or string.find(Name, "receiver", 1, true)
				or string.find(Name, "jump", 1, true)
				or string.find(Name, "catch", 1, true)
			then
				return true
			end
		end
	end

	return false
end

local function PickReceiverNearScreenPoint(ScreenPoint, MaxDistance)
	local Camera = Workspace.CurrentCamera
	if not Camera then
		return nil
	end

	local BestPlayer = nil
	local BestDistance = MaxDistance or 120

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Team == LocalPlayer.Team then
			local RootPart = GetReceiverRoot(Player)
			if RootPart then
				local ViewportPoint, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
				if OnScreen and ViewportPoint.Z > 0 then
					local Distance = (Vector2.new(ViewportPoint.X, ViewportPoint.Y) - ScreenPoint).Magnitude
					if Distance < BestDistance then
						BestDistance = Distance
						BestPlayer = Player
					end
				end
			end
		end
	end

	return BestPlayer
end

local function SelectThrowTarget(StartPosition)
	local Camera = Workspace.CurrentCamera
	if not Camera then
		return nil
	end

	if IsMobileClient() and Config.ThrowMobileTapLock ~= false and IsMobileThrowLockValid(MobileThrowLock) then
		local RootPart = GetReceiverRoot(MobileThrowLock)
		if RootPart then
			return MobileThrowLock
		end
		MobileThrowLock = nil
	end

	local AimPoint = GetAimScreenPoint()
	local BestPlayer = nil
	local BestScore = math.huge
	local Fov = tonumber(Config.ThrowFov) or 500
	if IsMobileClient() then
		Fov = math.max(Fov, 700)
	end
	local Mode = Config.ThrowTargetMode

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Team == LocalPlayer.Team then
			local RootPart = GetReceiverRoot(Player)
			if RootPart and (not Config.ThrowIgnoreBlocked or not IsThrowLaneBlocked(StartPosition, Player, RootPart.Position)) then
				local ViewportPoint, OnScreen = Camera:WorldToViewportPoint(RootPart.Position)
				local ScreenDistance = OnScreen and (Vector2.new(ViewportPoint.X, ViewportPoint.Y) - AimPoint).Magnitude or math.huge

				if ScreenDistance <= Fov then
					local Score
					if Mode == "Most Open" then
						Score = -GetClosestDefenderDistance(RootPart.Position)
					elseif Mode == "Furthest Downfield" or Mode == "Closest To Endzone" then
						Score = -math.abs(RootPart.Position.Z - StartPosition.Z)
					else
						Score = ScreenDistance
					end

					if Score < BestScore then
						BestScore = Score
						BestPlayer = Player
					end
				end
			end
		end
	end

	return BestPlayer
end

local function GetLeadTable(MoveDirection, ThrowType)
	local FieldZ = GetFieldSign(MoveDirection.Z)
	local FieldX = GetFieldSign(MoveDirection.X)
	local Leads

	if FieldZ == 1 and FieldX == 1 then
		Leads = {
			Dime = Vector3.new(1, 1.25, 8),
			Mag = Vector3.new(2, 2, 15),
			Dive = Vector3.new(1.25, 1.5, 12),
			Dot = Vector3.new(0.09, 0.09, 6),
			Fade = Vector3.zero,
			Bullet = Vector3.new(5, 1, 2),
			Jump = Vector3.new(1, 2.25, 7),
		}
	elseif FieldZ == -1 and FieldX == -1 then
		Leads = {
			Dime = Vector3.new(-1, 1.25, -8),
			Mag = Vector3.new(-2, 2, -15),
			Dive = Vector3.new(-1.25, 1.5, -12),
			Dot = Vector3.new(-0.09, 0.09, -6),
			Fade = Vector3.zero,
			Bullet = Vector3.new(-5, -1, -2),
			Jump = Vector3.new(-1, 2.25, -7),
		}
	elseif FieldZ == 1 and FieldX == -1 then
		Leads = {
			Dime = Vector3.new(-1, 1.25, 8),
			Mag = Vector3.new(-2, 2, 15),
			Dive = Vector3.new(-1.25, 1.5, 12),
			Dot = Vector3.new(-0.09, 0.09, 6),
			Fade = Vector3.zero,
			Bullet = Vector3.new(-5, -1, 2),
			Jump = Vector3.new(-1, 2.25, 7),
		}
	elseif FieldZ == -1 and FieldX == 1 then
		Leads = {
			Dime = Vector3.new(1, 1.25, -8),
			Mag = Vector3.new(2, 2, -15),
			Dive = Vector3.new(1.25, 1.5, -12),
			Dot = Vector3.new(0.09, 0.09, -6),
			Fade = Vector3.zero,
			Bullet = Vector3.new(5, -1, -2),
			Jump = Vector3.new(1, 2.25, -7),
		}
	else
		Leads = {
			Dime = Vector3.zero,
			Mag = Vector3.zero,
			Dive = Vector3.zero,
			Dot = Vector3.zero,
			Fade = Vector3.zero,
			Bullet = Vector3.zero,
			Jump = Vector3.new(0, 5, 0),
		}
	end

	return Leads[ThrowType] or Vector3.zero
end

local function PredictReceiverPosition(Player, ThrowType, FlightTime, HighPower)
	local Character = Player.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	local Head = Character and Character:FindFirstChild("Head")
	if not Humanoid or not RootPart or not Head then
		return nil
	end

	local MoveDirection = Humanoid.MoveDirection
	local Velocity = RootPart.AssemblyLinearVelocity
	local Moving = MoveDirection.Magnitude > 0.05
	local CustomLead = tonumber(Config.ThrowCustomLead) or 0
	local LeadStrength = tonumber(Config.ThrowLeadStrength) or 1
	local EffectiveTime = FlightTime

	if Config.ThrowAutoAngle and not HighPower then
		EffectiveTime = FlightTime + 0.5
	end

	local Accountability
	if HighPower then
		Accountability = Velocity * FlightTime
	elseif CustomLead ~= 0 then
		local Flat = Vector3.new(MoveDirection.X, 0, MoveDirection.Z)
		local Extra = Flat.Magnitude > 0 and Flat.Unit * (CustomLead * EffectiveTime) or Vector3.zero
		Accountability = Velocity * EffectiveTime + Extra
	else
		Accountability = Velocity * EffectiveTime
	end

	Accountability = Accountability * LeadStrength

	local CatchOffset = Vector3.new(0, 1.5, 0)
	local BasePosition = (HighPower and RootPart.Position or Head.Position) + CatchOffset

	if not Config.ThrowVelocityPrediction then
		return BasePosition
	end

	if Moving then
		return BasePosition + Accountability + GetLeadTable(MoveDirection, ThrowType) * 0.5
	end

	if ThrowType == "Jump" then
		return BasePosition + Vector3.new(0, 6, 0)
	end

	return BasePosition
end

local function ChooseLaunchAngle(Gravity, Speed, Range, Route, ThrowType, HighPower)
	if not Config.ThrowAutoAngle then
		if ThrowType == "Fade" then
			return math.rad(85)
		elseif ThrowType == "Bullet" then
			return math.rad(tonumber(Config.ThrowBulletAngle) or 25)
		end
		return math.rad(tonumber(Config.ThrowAngle) or 45)
	end

	if ThrowType == "Fade" then
		return math.rad(85)
	end

	local SinValue = (Range * Gravity) / (Speed * Speed)
	if SinValue > 1 or SinValue < -1 then
		return math.rad(45)
	end

	local Angle
	if HighPower then
		if Route == "Comeback" then
			Angle = (Range < 150 and 0.65 or 0.6) * math.asin(SinValue)
		elseif Route == "Still" then
			Angle = 0.5 * math.asin(SinValue)
		elseif Route == "Post" then
			Angle = (Range < 150 and 0.8 or 0.84) * math.asin(SinValue)
		else
			Angle = (Range < 150 and 0.82 or 0.85) * math.asin(SinValue)
		end
	elseif ThrowType == "Bullet" then
		Angle = math.asin(SinValue) / 2
		if Angle > math.rad(45) then
			Angle = math.rad(45)
		end
	else
		Angle = 0.65 * math.asin(SinValue)
	end

	return math.clamp(Angle, 0, math.rad(150))
end

local function SimulateAtHeight(StartPosition, Velocity, TargetY)
	local Gravity = tonumber(Config.PhysicsGravity) or -51
	local Friction = tonumber(Config.PhysicsAirResistance) or 1
	local TimeStep = tonumber(Config.PhysicsTimeStep) or 0.05
	local Position = StartPosition
	local Elapsed = 0

	while Elapsed < 8 do
		local UnitY = Velocity.Magnitude > 0 and math.abs(Velocity.Unit.Y) or 0
		local DynamicGravity = Gravity + Friction * (1 - UnitY)
		local NextPosition = Position + Velocity * TimeStep
		Velocity = Velocity + Vector3.new(0, DynamicGravity * TimeStep, 0)

		if Velocity.Y < 0 and NextPosition.Y <= TargetY then
			local DeltaY = NextPosition.Y - Position.Y
			local Alpha = math.abs(DeltaY) > 0.001 and math.clamp((TargetY - Position.Y) / DeltaY, 0, 1) or 1
			return Position:Lerp(NextPosition, Alpha), Elapsed + TimeStep * Alpha
		end

		Position = NextPosition
		Elapsed = Elapsed + TimeStep
	end

	return nil
end

local function CalculateThrowSolution(StartPosition, TargetPlayer)
	local RootPart = GetReceiverRoot(TargetPlayer)
	if not RootPart then
		return nil
	end

	local Gravity = math.abs(tonumber(Config.PhysicsGravity) or -51)
	local MinimumPower = tonumber(Config.PhysicsMinPower) or 0
	local MaximumPower = tonumber(Config.PhysicsMaxPower) or 95
	local Range = math.max(HorizontalRangeToPlayer(TargetPlayer, StartPosition), 1)
	local Route = CalculateRouteOfPlayer(TargetPlayer)
	local ThrowType = ResolveThrowType(TargetPlayer, StartPosition)
	local PowerMode = Config.ThrowPowerMode
	local HighPower = PowerMode == "Highest Power" or PowerMode == "95 Power"
	local RemotePower

	if PowerMode == "95 Power" then
		RemotePower = 95
	elseif PowerMode == "Highest Power" then
		RemotePower = math.clamp(math.sqrt(Range * Gravity) - 10, 85, MaximumPower)
	elseif Config.ThrowAutoPower then
		local Bonus = Route == "Straight" and 4.3 or 5.5
		RemotePower = math.clamp(math.floor(math.sqrt(Range * Gravity) - 10 + Bonus + 0.5), MinimumPower, MaximumPower)
	else
		RemotePower = math.clamp(tonumber(Config.ThrowManualPower) or 50, MinimumPower, MaximumPower)
	end

	local Extra = 1 + (tonumber(Config.ThrowExtraPower) or 0) / 100
	local PowerScale = math.max(tonumber(Config.PhysicsPowerScale) or 1, 0.1)
	RemotePower = math.clamp(RemotePower * Extra, MinimumPower, MaximumPower)

	local Speed = math.max((RemotePower + 10) * PowerScale, 1)
	local Angle = ChooseLaunchAngle(Gravity, Speed, Range, Route, ThrowType, HighPower)
	local FlightTime = math.max((2 * Speed * math.sin(Angle)) / Gravity, 0.05)
	local TargetPosition = PredictReceiverPosition(TargetPlayer, ThrowType, FlightTime, HighPower)
	if not TargetPosition then
		return nil
	end

	Range = math.max(Vector2.new(TargetPosition.X - StartPosition.X, TargetPosition.Z - StartPosition.Z).Magnitude, 1)
	if Config.ThrowAutoPower and PowerMode == "Normal" then
		local Bonus = Route == "Straight" and 4.3 or 5.5
		RemotePower = math.clamp(math.floor(math.sqrt(Range * Gravity) - 10 + Bonus + 0.5) * Extra, MinimumPower, MaximumPower)
		Speed = math.max((RemotePower + 10) * PowerScale, 1)
		Angle = ChooseLaunchAngle(Gravity, Speed, Range, Route, ThrowType, HighPower)
		FlightTime = math.max((2 * Speed * math.sin(Angle)) / Gravity, 0.05)
		TargetPosition = PredictReceiverPosition(TargetPlayer, ThrowType, FlightTime, HighPower) or TargetPosition
	end

	local function SolveVelocity(AimTarget)
		local Displacement = AimTarget - StartPosition
		local Horiz = Vector3.new(Displacement.X, 0, Displacement.Z)
		if Horiz.Magnitude < 0.01 then
			return nil
		end

		local HorizVelocity = Horiz.Unit * (Horiz.Magnitude / FlightTime)
		local VertVelocity = (Displacement.Y - 0.5 * (-Gravity) * FlightTime * FlightTime) / FlightTime
		local Velocity = HorizVelocity + Vector3.new(0, VertVelocity, 0)
		if Velocity.Magnitude < 0.01 then
			return nil
		end
		return Velocity
	end

	local function ResolvePower(SolvedMagnitude)
		local SolvedPower = SolvedMagnitude - 10 + 0.05
		if PowerMode == "Highest Power" then
			return math.clamp(math.floor(SolvedPower + 0.5), 85, MaximumPower)
		elseif PowerMode == "95 Power" or ThrowType == "Bullet" then
			return 95
		elseif ThrowType == "Fade" then
			return 65
		elseif Config.ThrowAutoPower then
			return math.clamp(math.floor(SolvedPower + 0.5), MinimumPower, MaximumPower)
		end
		return math.clamp(tonumber(Config.ThrowManualPower) or 50, MinimumPower, MaximumPower)
	end

	local DistanceBoost = math.clamp(tonumber(Config.ThrowDistanceBoost) or 0, 0, 20)
	if DistanceBoost > 0 then
		local FlatLine = Vector3.new(TargetPosition.X - StartPosition.X, 0, TargetPosition.Z - StartPosition.Z)
		if FlatLine.Magnitude > 0.01 then
			TargetPosition = TargetPosition + FlatLine.Unit * DistanceBoost
		end
	end

	local EstimatedVelocity = SolveVelocity(TargetPosition)
	if not EstimatedVelocity then
		return nil
	end

	local Direction = EstimatedVelocity.Unit
	RemotePower = ResolvePower(EstimatedVelocity.Magnitude)

	local LaunchSpeed = math.max((RemotePower + 10) * PowerScale, 1)
	local SimPosition = SimulateAtHeight(StartPosition, Direction * LaunchSpeed, TargetPosition.Y)
	if SimPosition then
		local Miss = Vector3.new(SimPosition.X - TargetPosition.X, 0, SimPosition.Z - TargetPosition.Z)
		if Miss.Magnitude > 0.25 and Miss.Magnitude < 60 then
			local Corrected = SolveVelocity(TargetPosition - Miss)
			if Corrected then
				EstimatedVelocity = Corrected
				Direction = Corrected.Unit
				RemotePower = ResolvePower(Corrected.Magnitude)
				LaunchSpeed = math.max((RemotePower + 10) * PowerScale, 1)
			end
		end
	end

	return {
		Player = TargetPlayer,
		Position = TargetPosition,
		AimPosition = StartPosition + Direction * 10000,
		Direction = Direction,
		Power = math.floor(RemotePower + 0.5),
		FlightTime = FlightTime,
		Angle = Angle,
		ThrowType = ThrowType,
		Route = Route,
		Speed = math.max((RemotePower + 10) * PowerScale, 1),
	}
end

local function GetThrowSolution(StartPosition)
	if not Config.ThrowAssistEnabled then
		return nil
	end

	local Character = LocalPlayer.Character
	EnsureMobilePassMode(Character)

	local Jersey = Character and Character:FindFirstChild("Jersey")
	local Values = Jersey and Jersey:FindFirstChild("Values")
	local ThrowMode = Values and Values:FindFirstChild("ThrowMode")
	if Config.ThrowOnlyInThrowMode and (not ThrowMode or not ThrowMode.Value) then
		return nil
	end

	local Target = SelectThrowTarget(StartPosition)
	if not Target then
		return nil
	end

	return CalculateThrowSolution(StartPosition, Target)
end

FireAssistedThrow = function()
	if not Config.ThrowAssistEnabled then
		return false
	end

	local Now = os.clock()
	if Now - LastMobileThrowClock < 0.25 then
		return false
	end
	LastMobileThrowClock = Now

	local Character = LocalPlayer.Character
	if not Character then
		return false
	end

	local Football = Character:FindFirstChild("Football")
	if not Football or not Football:IsA("Tool") then
		return false
	end

	EnsureMobilePassMode(Character)

	local Jersey = Character:FindFirstChild("Jersey")
	local Values = Jersey and Jersey:FindFirstChild("Values")
	local ThrowMode = Values and Values:FindFirstChild("ThrowMode")
	if ThrowMode and ThrowMode:IsA("BoolValue") and not ThrowMode.Value then
		ThrowMode.Value = true
	end

	local Handle = ResolvePart(Football)
	if not Handle then
		return false
	end

	local Solution = CurrentThrowSolution
	if not Solution then
		local Target = SelectThrowTarget(Handle.Position)
		if Target then
			Solution = CalculateThrowSolution(Handle.Position, Target)
		end
	end
	if not Solution then
		return false
	end

	CurrentThrowSolution = Solution
	CurrentThrowTarget = Solution.Player
	getgenv().EchoCurrentThrowSolution = Solution

	local StartPosition = Handle.Position
	local Event = Jersey and Jersey:FindFirstChild("Event")

	-- Send the same Throw payload the PC hook rewrites. Do not Activate afterward
	-- (that races and the block flag was swallowing the real throw).
	if Event and Event:IsA("RemoteEvent") then
		local Ok = pcall(function()
			Event:FireServer({ "Throw", StartPosition, Solution.AimPosition, Solution.Power })
		end)
		if Ok then
			return true
		end
	end

	local Remote = Football:FindFirstChild("RemoteEvent", true) or Handle:FindFirstChild("RemoteEvent")
	local Head = Character:FindFirstChild("Head")
	if Remote and Head then
		local Ok = pcall(function()
			Remote:FireServer("Clicked", Head.Position, Solution.AimPosition, Solution.Power, 1)
		end)
		if Ok then
			return true
		end
	end

	-- Last resort: fire the game's Tool.Activated handlers (hook rewrites aim).
	local Fired = false
	pcall(function()
		if typeof(getconnections) == "function" then
			for _, Connection in ipairs(getconnections(Football.Activated)) do
				if Connection and Connection.Fire then
					pcall(function()
						Connection:Fire()
					end)
					Fired = true
				end
			end
		end
		if not Fired then
			Football:Activate()
			Fired = true
		end
	end)

	return Fired
end

local function TryMobileTapThrow(ScreenPoint)
	if not Config.ThrowAssistEnabled then
		return
	end
	if Window and Window.IsOpen then
		return
	end
	if ScreenPoint and TouchHitsBlockingGui(ScreenPoint) then
		return
	end

	local Character = LocalPlayer.Character
	local Football = Character and Character:FindFirstChild("Football")
	if not Football or not Football:IsA("Tool") then
		return
	end

	FireAssistedThrow()
end

local function UpdateThrowTarget()
	if not Config.ThrowAssistEnabled then
		CurrentThrowTarget = nil
		CurrentThrowSolution = nil
		MobileThrowLock = nil
		LastTouchAimPoint = nil
	elseif LocalPlayer.Character then
		local Football = LocalPlayer.Backpack:FindFirstChild("Football") or LocalPlayer.Character:FindFirstChild("Football")
		local Handle = ResolvePart(Football)
		if Handle then
			CurrentThrowSolution = GetThrowSolution(Handle.Position)
			CurrentThrowTarget = CurrentThrowSolution and CurrentThrowSolution.Player or nil
			getgenv().EchoCurrentThrowSolution = CurrentThrowSolution
		else
			CurrentThrowTarget = nil
			CurrentThrowSolution = nil
			getgenv().EchoCurrentThrowSolution = nil
			MobileThrowLock = nil
			LastTouchAimPoint = nil
			MobilePassModeLatched = false
		end
	end

	if not Config.ThrowTargetMarker or not CurrentThrowSolution then
		if ThrowTargetPart then
			ThrowTargetPart:Destroy()
			ThrowTargetPart = nil
		end
		return
	end

	if not ThrowTargetPart then
		ThrowTargetPart = Instance.new("Part")
		ThrowTargetPart.Name = "EchoThrowTarget"
		ThrowTargetPart.Shape = Enum.PartType.Ball
		ThrowTargetPart.Size = Vector3.new(2, 2, 2)
		ThrowTargetPart.Material = Enum.Material.Neon
		ThrowTargetPart.Color = Config.PhysicsArcColor
		ThrowTargetPart.Transparency = 0.15
		ThrowTargetPart.Anchored = true
		ThrowTargetPart.CanCollide = false
		ThrowTargetPart.CanTouch = false
		ThrowTargetPart.CanQuery = false
		ThrowTargetPart.Parent = Workspace
	end

	ThrowTargetPart.Color = Config.PhysicsArcColor
	ThrowTargetPart.Position = CurrentThrowSolution.Position
end

local function GetThemeColor(Name, Fallback)
	local Ok, Value = pcall(function()
		return Library.Theme and Library.Theme[Name]
	end)
	if Ok and typeof(Value) == "Color3" then
		return Value
	end
	return Fallback
end

local function BuildHudCard(Parent, Title, Width, Order)
	local Element = GetThemeColor("Element", Color3.fromRGB(20, 24, 21))
	local Border = GetThemeColor("Border", Color3.fromRGB(12, 12, 12))
	local Accent = GetThemeColor("Accent", Config.PhysicsArcColor)

	local Card = Instance.new("Frame")
	Card.Name = "Echo" .. Title
	Card.Size = UDim2.new(0, Width, 0, 42)
	Card.BackgroundColor3 = Element
	Card.BackgroundTransparency = 0.08
	Card.BorderSizePixel = 0
	Card.Active = false
	Card.Selectable = false
	pcall(function()
		Card.Interactable = false
	end)
	Card.LayoutOrder = Order
	Card.Parent = Parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 4)
	Corner.Parent = Card

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Border
	Stroke.Transparency = 0.1
	Stroke.Thickness = 1.5
	Stroke.Parent = Card

	local AccentBar = Instance.new("Frame")
	AccentBar.Name = "Accent"
	AccentBar.AnchorPoint = Vector2.new(0, 1)
	AccentBar.Position = UDim2.new(0, 6, 1, -4)
	AccentBar.Size = UDim2.new(1, -12, 0, 2)
	AccentBar.BackgroundColor3 = Accent
	AccentBar.BorderSizePixel = 0
	AccentBar.Parent = Card

	local BarCorner = Instance.new("UICorner")
	BarCorner.CornerRadius = UDim.new(1, 0)
	BarCorner.Parent = AccentBar

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, -12, 0, 12)
	TitleLabel.Position = UDim2.new(0, 6, 0, 4)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = string.upper(Title)
	TitleLabel.TextColor3 = Accent
	TitleLabel.TextTransparency = 0.25
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 8
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Active = false
	pcall(function()
		TitleLabel.Interactable = false
	end)
	TitleLabel.Parent = Card

	local ValueLabel = Instance.new("TextLabel")
	ValueLabel.Name = "Value"
	ValueLabel.Size = UDim2.new(1, -12, 0, 16)
	ValueLabel.Position = UDim2.new(0, 6, 0, 17)
	ValueLabel.BackgroundTransparency = 1
	ValueLabel.Text = "-"
	ValueLabel.TextColor3 = Color3.fromRGB(235, 240, 238)
	ValueLabel.Font = Enum.Font.GothamBold
	ValueLabel.TextSize = 13
	ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
	ValueLabel.TextTruncate = Enum.TextTruncate.AtEnd
	ValueLabel.Active = false
	pcall(function()
		ValueLabel.Interactable = false
	end)
	ValueLabel.Parent = Card

	return ValueLabel
end

local function EnsureHud()
	if HudGui and HudGui.Parent then
		return
	end

	HudGui = Instance.new("ScreenGui")
	HudGui.Name = "EchoQbHud"
	HudGui.ResetOnSpawn = false
	HudGui.IgnoreGuiInset = true
	HudGui.Enabled = false
	HudGui.DisplayOrder = 5
	HudGui.Parent = EchoUiContainer.Parent

	local Container = Instance.new("Frame")
	Container.Name = "EchoHudBar"
	Container.AnchorPoint = Vector2.new(0.5, 0)
	Container.Position = UDim2.new(0.5, 0, 0, 14)
	Container.BackgroundTransparency = 1
	Container.AutomaticSize = Enum.AutomaticSize.XY
	Container.Size = UDim2.new(0, 0, 0, 42)
	Container.Active = false
	Container.Selectable = false
	pcall(function()
		Container.Interactable = false
	end)
	Container.Parent = HudGui

	local Layout = Instance.new("UIListLayout")
	Layout.FillDirection = Enum.FillDirection.Horizontal
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Padding = UDim.new(0, 6)
	Layout.Parent = Container

	HudCards = {
		Angle = BuildHudCard(Container, "Angle", 64, 1),
		Mode = BuildHudCard(Container, "Throw", 82, 2),
		Power = BuildHudCard(Container, "Power", 60, 3),
		Target = BuildHudCard(Container, "Target", 132, 4),
	}
end

local function UpdateHud()
	EnsureHud()

	local Solution = CurrentThrowSolution
	local Character = LocalPlayer.Character
	local HoldingFootball = Character and (Character:FindFirstChild("Football") or LocalPlayer.Backpack:FindFirstChild("Football"))

	if not Config.ThrowAssistEnabled or not Solution or not HoldingFootball then
		HudGui.Enabled = false
		return
	end

	HudGui.Enabled = true

	local AngleDegrees = Solution.Angle and math.floor(math.deg(Solution.Angle) * 10) / 10
		or math.floor(math.deg(math.asin(math.clamp(Solution.Direction.Y, -1, 1))) * 10) / 10
	HudCards.Angle.Text = tostring(AngleDegrees) .. "\194\176"
	HudCards.Mode.Text = tostring(Solution.ThrowType or Config.ThrowTypeMode)
	HudCards.Power.Text = tostring(Solution.Power)

	local OpenDistance = tonumber(Config.ThrowMinOpenDistance) or 15
	local IsOpen = GetClosestDefenderDistance(Solution.Position) > OpenDistance
	HudCards.Target.Text = Solution.Player and (Solution.Player.DisplayName or Solution.Player.Name) or "None"
	HudCards.Target.TextColor3 = IsOpen and Color3.fromRGB(140, 235, 160) or Color3.fromRGB(230, 120, 120)
end

local function UpdateFovCircle()
	local Show = Config.ThrowShowFov and Config.ThrowAssistEnabled

	if not Show then
		if FovFrame then
			FovFrame.Visible = false
		end
		return
	end

	EnsureHud()

	if not FovFrame or not FovFrame.Parent then
		FovFrame = Instance.new("Frame")
		FovFrame.Name = "EchoFov"
		FovFrame.BackgroundTransparency = 1
		FovFrame.BorderSizePixel = 0
		FovFrame.Active = false
		FovFrame.Selectable = false
		FovFrame.Parent = HudGui

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0.5, 0)
		Corner.Parent = FovFrame

		local Stroke = Instance.new("UIStroke")
		Stroke.Thickness = 1.5
		Stroke.Transparency = 0.25
		Stroke.Parent = FovFrame
	end

	local Fov = tonumber(Config.ThrowFov) or 500
	if IsMobileClient() then
		Fov = math.max(Fov, 700)
	end
	local AimPoint = GetAimScreenPoint()
	FovFrame.Size = UDim2.fromOffset(Fov * 2, Fov * 2)
	FovFrame.Position = UDim2.fromOffset(AimPoint.X - Fov, AimPoint.Y - Fov)
	FovFrame:FindFirstChildOfClass("UIStroke").Color = Config.PhysicsArcColor
	FovFrame.Visible = true
	HudGui.Enabled = true
end

local function ClearReceiverEsp()
	for _, Billboard in ipairs(EspBillboards) do
		pcall(function()
			Billboard:Destroy()
		end)
	end
	table.clear(EspBillboards)
end

local function UpdateReceiverEsp()
	if not Config.ThrowReceiverEsp or not Config.ThrowAssistEnabled then
		if #EspBillboards > 0 then
			ClearReceiverEsp()
		end
		return
	end

	local Now = os.clock()
	if Now - EspClock < 0.25 then
		return
	end
	EspClock = Now

	ClearReceiverEsp()

	local Character = LocalPlayer.Character
	local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Team == LocalPlayer.Team then
			local RootPart = GetReceiverRoot(Player)
			if RootPart then
				local DefenderDistance = GetClosestDefenderDistance(RootPart.Position)
				local IsOpen = DefenderDistance > (tonumber(Config.ThrowMinOpenDistance) or 15)
				local Text = Player.DisplayName or Player.Name
				local Details = {}

				if Config.ThrowShowRoutes then
					Details[#Details + 1] = CalculateRouteOfPlayer(Player)
				end
				if Config.ThrowShowDistance and MyRoot then
					Details[#Details + 1] = tostring(math.floor((RootPart.Position - MyRoot.Position).Magnitude)) .. " st"
				end
				if #Details > 0 then
					Text = Text .. "\n" .. table.concat(Details, " | ")
				end

				local Billboard = Instance.new("BillboardGui")
				Billboard.Name = "EchoReceiverEsp"
				Billboard.Size = UDim2.new(0, 130, 0, 44)
				Billboard.StudsOffset = Vector3.new(0, 4, 0)
				Billboard.AlwaysOnTop = true
				Billboard.Adornee = RootPart
				Billboard.Parent = RootPart

				local Label = Instance.new("TextLabel")
				Label.Size = UDim2.fromScale(1, 1)
				Label.BackgroundTransparency = 1
				Label.Text = Text
				Label.TextColor3 = IsOpen and Color3.fromRGB(140, 235, 160) or Color3.fromRGB(230, 120, 120)
				Label.Font = Enum.Font.GothamBold
				Label.TextSize = 12
				Label.TextStrokeTransparency = 0.4
				Label.Parent = Billboard

				EspBillboards[#EspBillboards + 1] = Billboard
			end
		end
	end
end

local function ClearArcParts()
	for _, Part in ipairs(ArcParts) do
		pcall(function()
			Part:Destroy()
		end)
	end
	table.clear(ArcParts)
end

local function ClearBeam()
	if TrajectoryBeam then
		TrajectoryBeam:Destroy()
		TrajectoryBeam = nil
	end
	if BeamAttachment0 then
		BeamAttachment0:Destroy()
		BeamAttachment0 = nil
	end
	if BeamAttachment1 then
		BeamAttachment1:Destroy()
		BeamAttachment1 = nil
	end
	if LandingMarker then
		LandingMarker:Destroy()
		LandingMarker = nil
	end
end

local function GetBeamCurve(Gravity, Velocity, StartPosition, FlightTime, EndOverride)
	local C = 0.5 * 0.5 * 0.5
	local EndPosition = EndOverride or (0.5 * Gravity * FlightTime * FlightTime + Velocity * FlightTime + StartPosition)
	local Control2 = EndPosition - (Gravity * FlightTime * FlightTime + Velocity * FlightTime) / 3
	local Control1 = (C * Gravity * FlightTime * FlightTime + 0.5 * Velocity * FlightTime + StartPosition - C * (StartPosition + EndPosition)) / (3 * C) - Control2

	local Curve0 = (Control1 - StartPosition).Magnitude
	local Curve1 = (Control2 - EndPosition).Magnitude
	local Right0 = (Control1 - StartPosition).Unit
	local Right1 = (Control2 - EndPosition).Unit
	local WorldUp = Vector3.new(0, 1, 0)
	local Back0 = math.abs(Right0:Dot(WorldUp)) < 0.999 and Right0:Cross(WorldUp).Unit or Right0:Cross(Vector3.new(1, 0, 0)).Unit
	local Back1 = math.abs(Right1:Dot(WorldUp)) < 0.999 and Right1:Cross(WorldUp).Unit or Right1:Cross(Vector3.new(1, 0, 0)).Unit
	local Up0 = Back0:Cross(Right0).Unit
	local Up1 = Back1:Cross(Right1).Unit
	local CFrame0 = CFrame.fromMatrix(StartPosition, Right0, Up0, Back0)
	local CFrame1 = CFrame.fromMatrix(EndPosition, Right1, Up1, Back1)

	return Curve0, -Curve1, CFrame0, CFrame1, EndPosition
end

local function EnsureBeam()
	if TrajectoryBeam and TrajectoryBeam.Parent then
		return
	end

	BeamAttachment0 = Instance.new("Attachment")
	BeamAttachment0.Name = "EchoBeamStart"
	BeamAttachment0.Parent = Workspace.Terrain

	BeamAttachment1 = Instance.new("Attachment")
	BeamAttachment1.Name = "EchoBeamEnd"
	BeamAttachment1.Parent = Workspace.Terrain

	TrajectoryBeam = Instance.new("Beam")
	TrajectoryBeam.Name = "EchoTrajectoryBeam"
	TrajectoryBeam.Attachment0 = BeamAttachment0
	TrajectoryBeam.Attachment1 = BeamAttachment1
	TrajectoryBeam.FaceCamera = true
	TrajectoryBeam.Width0 = 0.9
	TrajectoryBeam.Width1 = 0.3
	TrajectoryBeam.Segments = 160
	TrajectoryBeam.LightEmission = 1
	TrajectoryBeam.Brightness = 8
	TrajectoryBeam.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.05),
		NumberSequenceKeypoint.new(0.8, 0.12),
		NumberSequenceKeypoint.new(1, 0.35),
	})
	TrajectoryBeam.Parent = Workspace.Terrain

	LandingMarker = Instance.new("Part")
	LandingMarker.Name = "EchoLandingMarker"
	LandingMarker.Shape = Enum.PartType.Cylinder
	LandingMarker.Size = Vector3.new(0.15, 5, 5)
	LandingMarker.Material = Enum.Material.Neon
	LandingMarker.Transparency = 0.15
	LandingMarker.Anchored = true
	LandingMarker.CanCollide = false
	LandingMarker.CanTouch = false
	LandingMarker.CanQuery = false
	LandingMarker.CastShadow = false
	LandingMarker.Parent = Workspace
end

local function UpdateArcPreview()
	local Solution = CurrentThrowSolution
	local Character = LocalPlayer.Character
	local Football = Character and (LocalPlayer.Backpack:FindFirstChild("Football") or Character:FindFirstChild("Football"))
	local Handle = ResolvePart(Football)
	local ShowDots = Config.PhysicsShowArc
	local ShowBeam = Config.ThrowBeamMode

	if (not ShowDots and not ShowBeam) or not Config.ThrowAssistEnabled or not Solution or not Handle then
		if #ArcParts > 0 then
			ClearArcParts()
		end
		ClearBeam()
		return
	end

	local Now = os.clock()
	if Now - ArcClock < 0.05 then
		return
	end
	ArcClock = Now

	ClearArcParts()

	local Gravity = tonumber(Config.PhysicsGravity) or -51
	local Friction = tonumber(Config.PhysicsAirResistance) or 1
	local TimeStep = tonumber(Config.PhysicsTimeStep) or 0.05
	local Position = Handle.Position
	local StartPosition = Position
	local Speed = Solution.Speed or (Solution.Power + 10)
	local Velocity = Solution.Direction * Speed
	local InitialVelocity = Velocity
	local FieldPart = Workspace:FindFirstChild("Field") and Workspace.Field.PrimaryPart
	local SurfaceY = FieldPart and FieldPart.Position.Y + FieldPart.Size.Y / 2 or -math.huge
	local Elapsed = 0
	local Step = 0
	local LandingPosition = Solution.Position
	local LandingTime = Solution.FlightTime or 1

	local GroundParams = RaycastParams.new()
	GroundParams.FilterType = Enum.RaycastFilterType.Exclude
	local GroundFilter = {}
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player.Character then
			GroundFilter[#GroundFilter + 1] = Player.Character
		end
	end
	if LandingMarker then
		GroundFilter[#GroundFilter + 1] = LandingMarker
	end
	if ThrowTargetPart then
		GroundFilter[#GroundFilter + 1] = ThrowTargetPart
	end
	GroundParams.FilterDescendantsInstances = GroundFilter
	GroundParams.IgnoreWater = true

	while Elapsed < 10 do
		local UnitY = Velocity.Magnitude > 0 and math.abs(Velocity.Unit.Y) or 0
		local DynamicGravity = Gravity + Friction * (1 - UnitY)
		local NextPosition = Position + Velocity * TimeStep
		Velocity = Velocity + Vector3.new(0, DynamicGravity * TimeStep, 0)

		if Velocity.Y < 0 then
			local SegmentResult = Workspace:Raycast(Position, NextPosition - Position, GroundParams)
			if SegmentResult then
				LandingPosition = SegmentResult.Position
				LandingTime = Elapsed + TimeStep * math.clamp((SegmentResult.Position - Position).Magnitude / math.max((NextPosition - Position).Magnitude, 0.001), 0, 1)
				break
			end
		end

		Step = Step + 1
		if ShowDots and Step % 3 == 0 then
			local Part = Instance.new("Part")
			Part.Name = "EchoArcPoint"
			Part.Shape = Enum.PartType.Ball
			Part.Size = Vector3.new(0.4, 0.4, 0.4)
			Part.Material = Enum.Material.Neon
			Part.Color = Config.PhysicsArcColor
			Part.Anchored = true
			Part.CanCollide = false
			Part.CanTouch = false
			Part.CanQuery = false
			Part.CastShadow = false
			Part.Position = NextPosition
			Part.Parent = Workspace
			ArcParts[#ArcParts + 1] = Part
		end

		if NextPosition.Y <= SurfaceY then
			local DeltaY = NextPosition.Y - Position.Y
			local Alpha = math.abs(DeltaY) > 0.001 and math.clamp((SurfaceY - Position.Y) / DeltaY, 0, 1) or 1
			LandingPosition = Position:Lerp(NextPosition, Alpha)
			LandingTime = Elapsed + TimeStep * Alpha
			break
		end

		Position = NextPosition
		Elapsed = Elapsed + TimeStep
	end

	if ShowBeam and LandingPosition and LandingTime then
		EnsureBeam()

		local GravityVector = Vector3.new(0, Gravity, 0)
		local Curve0, Curve1, CFrame0, CFrame1, BeamEnd = GetBeamCurve(GravityVector, InitialVelocity, StartPosition, LandingTime, LandingPosition)
		BeamAttachment0.WorldCFrame = CFrame0
		BeamAttachment1.WorldCFrame = CFrame1
		TrajectoryBeam.CurveSize0 = Curve0
		TrajectoryBeam.CurveSize1 = Curve1

		local BaseColor = Config.PhysicsArcColor
		local Hue, Saturation, Value = BaseColor:ToHSV()
		local MidColor = Color3.fromHSV(Hue, math.max(Saturation - 0.2, 0), math.min(Value + 0.15, 1))
		local TipColor = Color3.fromHSV(Hue, math.max(Saturation - 0.5, 0), 1)
		TrajectoryBeam.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, BaseColor),
			ColorSequenceKeypoint.new(0.45, MidColor),
			ColorSequenceKeypoint.new(1, TipColor),
		})
		TrajectoryBeam.Enabled = true

		local MarkerPosition = LandingPosition or BeamEnd or Solution.Position
		LandingMarker.Color = Config.PhysicsArcColor
		LandingMarker.CFrame = CFrame.new(MarkerPosition + Vector3.new(0, 0.08, 0)) * CFrame.Angles(0, 0, math.rad(90))
	else
		ClearBeam()
	end
end

getgenv().EchoConfig = Config

local function InstallThrowHook()
	getgenv().EchoGetThrowSolution = nil
	getgenv().EchoThrowResolverV2 = GetThrowSolution

	if getgenv().EchoThrowHookInstalledV5 then
		return
	end
	if typeof(hookmetamethod) ~= "function" or typeof(getnamecallmethod) ~= "function" or typeof(newcclosure) ~= "function" then
		return
	end

	getgenv().EchoThrowHookInstalledV5 = true
	getgenv().EchoThrowHookInstalledV4 = true
	getgenv().EchoThrowHookInstalledV3 = true

	local RemoteEventFireServer = Instance.new("RemoteEvent").FireServer

	OldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
		local Method = getnamecallmethod()
		local Arg1, Arg2, Arg3 = ...
		local EchoConfig = getgenv().EchoConfig
		local Resolver = getgenv().EchoThrowResolverV2

		if EchoConfig and EchoConfig.AntiDownEnabled and Method == "FireServer" and typeof(Self) == "Instance" and Self.ClassName == "RemoteEvent" then
			if Arg1 == "Game" and Arg2 == "AutoDown" then
				return
			end
			if type(Arg1) == "table" and (Arg1[1] == "AutoDown" or Arg1[1] == "Down" or (Arg1[1] == "Game" and Arg1[2] == "AutoDown")) then
				return
			end
		end

		if Resolver and Method == "FireServer" and typeof(Self) == "Instance" and Self.ClassName == "RemoteEvent" then
			local IsCaller = typeof(checkcaller) == "function" and checkcaller() or false

			if not IsCaller then
				local BlockUntil = getgenv().EchoMobileThrowBlockUntil
				if typeof(BlockUntil) == "number" and os.clock() < BlockUntil then
					if type(Arg1) == "table" and Arg1[1] == "Throw" then
						return
					end
					if Arg1 == "Clicked" then
						return
					end
				end
			end

			if not IsCaller then
				local Solution = nil
				if type(Arg1) == "table" and Arg1[1] == "Throw" and typeof(Arg1[2]) == "Vector3" then
					local Ok, Resolved = pcall(Resolver, Arg1[2])
					if Ok then
						Solution = Resolved
					end
					if not Solution then
						Solution = getgenv().EchoCurrentThrowSolution
					end
					if Solution then
						local NewPayload = table.clone(Arg1)
						NewPayload[3] = Solution.AimPosition
						NewPayload[4] = Solution.Power
						return RemoteEventFireServer(Self, NewPayload, select(2, ...))
					end
				elseif Arg1 == "Clicked" and typeof(Arg2) == "Vector3" and typeof(Arg3) == "Vector3" then
					local Ok, Resolved = pcall(Resolver, Arg2)
					if Ok then
						Solution = Resolved
					end
					if not Solution then
						Solution = getgenv().EchoCurrentThrowSolution
					end
					if Solution then
						return RemoteEventFireServer(Self, "Clicked", Arg2, Solution.AimPosition, Solution.Power, select(4, ...))
					end
				end
			end
		end

		return OldNamecall(Self, ...)
	end))
end

local BaseJumpPower = 62

local function GetJerseyValues(Character)
	local Jersey = Character and Character:FindFirstChild("Jersey")
	return Jersey and Jersey:FindFirstChild("Values")
end

local function SetBoolValue(Values, Name, Wanted)
	local ValueObject = Values and Values:FindFirstChild(Name)
	if ValueObject and ValueObject:IsA("BoolValue") and ValueObject.Value ~= Wanted then
		ValueObject.Value = Wanted
	end
end

local function ReadNumberValue(Parent, Names)
	if not Parent then
		return nil
	end
	for _, Name in ipairs(Names) do
		local Object = Parent:FindFirstChild(Name)
		if Object and (Object:IsA("NumberValue") or Object:IsA("IntValue")) then
			return tonumber(Object.Value)
		end
		local Attribute = Parent:GetAttribute(Name)
		if typeof(Attribute) == "number" then
			return Attribute
		end
	end
	return nil
end

local function SyncPhysicsFromGame()
	if not Config.PhysicsUseServerValues or PhysicsSynced then
		return
	end

	local Candidates = {
		ReplicatedStorage:FindFirstChild("BallUtil"),
		ReplicatedStorage:FindFirstChild("ballUtil"),
		ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("BallUtil"),
		ReplicatedStorage:FindFirstChild("Shared") and ReplicatedStorage.Shared:FindFirstChild("BallUtil"),
		ReplicatedStorage:FindFirstChild("GameValues"),
		ReplicatedStorage:FindFirstChild("GameValues") and ReplicatedStorage.GameValues:FindFirstChild("Physics"),
		ReplicatedStorage:FindFirstChild("GameValues") and ReplicatedStorage.GameValues:FindFirstChild("Ball"),
	}

	local Found = false
	for _, Source in ipairs(Candidates) do
		if Source then
			local ModuleTable = nil
			if Source:IsA("ModuleScript") then
				local Ok, Result = pcall(require, Source)
				if Ok and typeof(Result) == "table" then
					ModuleTable = Result
				end
			end

			local Gravity = ReadNumberValue(Source, { "Gravity", "BallGravity", "PHYSICS_GRAVITY" })
				or (ModuleTable and (tonumber(ModuleTable.Gravity) or tonumber(ModuleTable.BallGravity)))
			local Friction = ReadNumberValue(Source, { "AirResistance", "Friction", "Drag", "PHYSICS_FRICTION" })
				or (ModuleTable and (tonumber(ModuleTable.AirResistance) or tonumber(ModuleTable.Friction)))
			local PowerScale = ReadNumberValue(Source, { "PowerScale", "PhysicsPowerScale" })
				or (ModuleTable and tonumber(ModuleTable.PowerScale))
			local YardToStud = ReadNumberValue(Source, { "YardToStud", "YardsToStuds", "StudsPerYard" })
				or (ModuleTable and (tonumber(ModuleTable.YardToStud) or tonumber(ModuleTable.YardsToStuds)))
			local MinPower = ReadNumberValue(Source, { "MinPower", "MinimumPower" })
				or (ModuleTable and tonumber(ModuleTable.MinPower))
			local MaxPower = ReadNumberValue(Source, { "MaxPower", "MaximumPower" })
				or (ModuleTable and tonumber(ModuleTable.MaxPower))

			if Gravity then
				Config.PhysicsGravity = Gravity > 0 and -Gravity or Gravity
				Found = true
			end
			if Friction then
				Config.PhysicsAirResistance = Friction
				Found = true
			end
			if PowerScale then
				Config.PhysicsPowerScale = PowerScale
				Found = true
			end
			if YardToStud then
				Config.PhysicsYardToStud = YardToStud
				Found = true
			end
			if MinPower then
				Config.PhysicsMinPower = MinPower
				Found = true
			end
			if MaxPower then
				Config.PhysicsMaxPower = MaxPower
				Found = true
			end

			if Found then
				break
			end
		end
	end

	if Found or os.clock() - LoadTick > 5 then
		PhysicsSynced = true
	end
end

local function GetDesiredJumpPower()
	if Config.JumpPowerEnabled then
		return math.clamp(tonumber(Config.JumpPower) or 90, 50, 150)
	end
	return BaseJumpPower
end

local function MaintainJumpPower(Character)
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end

	local AngleWindow = Config.AngleEnhancerEnabled and (os.clock() - AngleTick < 0.2)
	local WantedPower = GetDesiredJumpPower()
	if AngleWindow then
		WantedPower = WantedPower + ((tonumber(Config.AngleEnhancerValue) or 50) - 50)
	end

	if Config.JumpPowerEnabled or AngleWindow then
		if not JumpOriginalSettings[Humanoid] then
			JumpOriginalSettings[Humanoid] = {
				UseJumpPower = Humanoid.UseJumpPower,
				JumpPower = Humanoid.JumpPower,
				JumpHeight = Humanoid.JumpHeight,
			}
		end
		Humanoid.UseJumpPower = true
		if Humanoid.JumpPower ~= WantedPower then
			Humanoid.JumpPower = WantedPower
		end
	elseif JumpOriginalSettings[Humanoid] then
		local Original = JumpOriginalSettings[Humanoid]
		pcall(function()
			Humanoid.UseJumpPower = Original.UseJumpPower
			Humanoid.JumpPower = Original.JumpPower
			if Original.JumpHeight then
				Humanoid.JumpHeight = Original.JumpHeight
			end
		end)
		JumpOriginalSettings[Humanoid] = nil
	end
end

local function RestoreJumpPower()
	for Humanoid, Original in pairs(JumpOriginalSettings) do
		if Humanoid and Humanoid.Parent then
			pcall(function()
				Humanoid.UseJumpPower = Original.UseJumpPower
				Humanoid.JumpPower = Original.JumpPower
				if Original.JumpHeight then
					Humanoid.JumpHeight = Original.JumpHeight
				end
			end)
		end
		JumpOriginalSettings[Humanoid] = nil
	end
end

local function ResetJumpLatch(NewState)
	if NewState == Enum.HumanoidStateType.Landed
		or NewState == Enum.HumanoidStateType.Running
		or NewState == Enum.HumanoidStateType.RunningNoPhysics
		or NewState == Enum.HumanoidStateType.GettingUp
		or NewState == Enum.HumanoidStateType.Climbing
	then
		JumpBoostLatched = false
		AngleEnhancerLatched = false
	end
end

local function ApplyAngleEnhancerImpulse(Character)
	if not Config.AngleEnhancerEnabled or AngleEnhancerLatched then
		return
	end
	if os.clock() - AngleTick > 0.2 then
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not RootPart or Humanoid.Health <= 0 then
		return
	end
	if Humanoid:GetState() ~= Enum.HumanoidStateType.Jumping
		and Humanoid:GetState() ~= Enum.HumanoidStateType.Freefall
	then
		return
	end

	local AngleBoost = (tonumber(Config.AngleEnhancerValue) or 50) - 50
	if AngleBoost == 0 then
		return
	end

	AngleEnhancerLatched = true
	task.delay(0.05, function()
		if not Config.AngleEnhancerEnabled or not RootPart.Parent then
			return
		end
		RootPart.AssemblyLinearVelocity += Vector3.new(0, AngleBoost, 0)
	end)
end

local function RunAngleEnhancer(Character)
	ShiftLockEnabled = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
	if not ShiftLockEnabled and LastShiftLockEnabled then
		AngleTick = os.clock()
		AngleEnhancerLatched = false
	end
	LastShiftLockEnabled = ShiftLockEnabled

	if not Config.AngleEnhancerEnabled then
		return
	end

	MaintainJumpPower(Character)
end

local function TryJumpBoost(Character, OldState, NewState)
	ResetJumpLatch(NewState)

	if NewState == Enum.HumanoidStateType.Jumping then
		ApplyAngleEnhancerImpulse(Character)
	end

	if NewState ~= Enum.HumanoidStateType.Jumping then
		return
	end
	if not Config.JumpPowerEnabled then
		return
	end

	local FromGround = OldState == Enum.HumanoidStateType.Running
		or OldState == Enum.HumanoidStateType.RunningNoPhysics
		or OldState == Enum.HumanoidStateType.Landed
		or OldState == Enum.HumanoidStateType.Climbing
		or OldState == Enum.HumanoidStateType.Swimming
		or OldState == Enum.HumanoidStateType.GettingUp
		or OldState == Enum.HumanoidStateType.Freefall
		or OldState == Enum.HumanoidStateType.Jumping

	if not FromGround or JumpBoostLatched or os.clock() - LastJumpBoost < JumpBoostCooldown then
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not RootPart then
		return
	end

	MaintainJumpPower(Character)
	local WantedPower = GetDesiredJumpPower()
	local Velocity = RootPart.AssemblyLinearVelocity
	if WantedPower <= BaseJumpPower and Velocity.Y >= WantedPower - 1 then
		return
	end

	JumpBoostLatched = true
	LastJumpBoost = os.clock()
	task.defer(function()
		if not RootPart.Parent or not Config.JumpPowerEnabled then
			return
		end
		local Current = RootPart.AssemblyLinearVelocity
		if Current.Y < WantedPower then
			RootPart.AssemblyLinearVelocity = Vector3.new(Current.X, WantedPower, Current.Z)
		end
	end)
end

local function RunWalkSpeed(DeltaTime)
	if not Config.WalkSpeedEnabled then
		return
	end

	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not RootPart or Humanoid.Health <= 0 then
		return
	end

	local Direction = Humanoid.MoveDirection
	if Direction.Magnitude < 0.01 then
		return
	end

	local TargetSpeed = math.clamp(tonumber(Config.WalkSpeed) or 30, 16, 100)
	local NativeSpeed = math.max(tonumber(Humanoid.WalkSpeed) or 16, 0)
	local ExtraSpeed = math.max(TargetSpeed - NativeSpeed, 0)
	if ExtraSpeed <= 0 then
		return
	end

	local Step = math.clamp(tonumber(DeltaTime) or 0, 0, 1 / 15)
	RootPart.CFrame = RootPart.CFrame + Direction.Unit * ExtraSpeed * Step
end

local function StopFly()
	if FlyBodyVelocity then
		pcall(function()
			FlyBodyVelocity:Destroy()
		end)
		FlyBodyVelocity = nil
	end
	if FlyBodyGyro then
		pcall(function()
			FlyBodyGyro:Destroy()
		end)
		FlyBodyGyro = nil
	end
end

getgenv().EchoStopFly = StopFly

local function RunFly()
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Config.FlyEnabled or not Humanoid or not RootPart or Humanoid.Health <= 0 or FrozenRoot then
		StopFly()
		return
	end

	if not FlyBodyVelocity or not FlyBodyVelocity.Parent then
		FlyBodyVelocity = Instance.new("BodyVelocity")
		FlyBodyVelocity.Name = "EchoFlyVelocity"
		FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		FlyBodyVelocity.Velocity = Vector3.zero
		FlyBodyVelocity.Parent = RootPart
	end
	if not FlyBodyGyro or not FlyBodyGyro.Parent then
		FlyBodyGyro = Instance.new("BodyGyro")
		FlyBodyGyro.Name = "EchoFlyGyro"
		FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		FlyBodyGyro.D = 200
		FlyBodyGyro.P = 10000
		FlyBodyGyro.Parent = RootPart
	end

	local Camera = Workspace.CurrentCamera
	local CamCF = Camera and Camera.CFrame or RootPart.CFrame
	local MoveDir = Vector3.zero
	local Speed = math.clamp(tonumber(Config.FlySpeed) or 50, 16, 200)

	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		local Md = Humanoid.MoveDirection
		if Md.Magnitude > 0 then
			MoveDir += Vector3.new(Md.X, 0, Md.Z)
		end
	else
		if FlyKeysHeld.W then
			MoveDir += CamCF.LookVector
		end
		if FlyKeysHeld.S then
			MoveDir -= CamCF.LookVector
		end
		if FlyKeysHeld.D then
			MoveDir += CamCF.RightVector
		end
		if FlyKeysHeld.A then
			MoveDir -= CamCF.RightVector
		end
	end

	if FlyKeysHeld.Space then
		MoveDir += Vector3.new(0, 1, 0)
	end
	if FlyKeysHeld.LeftShift then
		MoveDir -= Vector3.new(0, 1, 0)
	end

	if MoveDir.Magnitude > 0 then
		FlyBodyVelocity.Velocity = MoveDir.Unit * Speed
	else
		FlyBodyVelocity.Velocity = Vector3.zero
	end
	FlyBodyGyro.CFrame = CamCF
	pcall(function()
		Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
	end)
end

local function RestoreCollision()
	for Part, CanCollide in pairs(CollisionOriginalSettings) do
		if Part and Part.Parent then
			pcall(function()
				Part.CanCollide = CanCollide
			end)
		end
		CollisionOriginalSettings[Part] = nil
	end
end

getgenv().EchoRestoreCollision = RestoreCollision

local function RestoreCollegeJumpCooldown()
	for _, Connection in ipairs(NoJumpCooldownDisabledConnections) do
		pcall(function()
			if Connection and Connection.Enable then
				Connection:Enable()
			end
		end)
	end
	table.clear(NoJumpCooldownDisabledConnections)
	NoJumpCooldownHumanoid = nil
	NoJumpCooldownLatched = false
end

local function DisableCollegeJumpCooldown(Humanoid)
	if typeof(getconnections) ~= "function" or not Humanoid then
		return
	end

	pcall(function()
		for _, Connection in ipairs(getconnections(Humanoid.Changed)) do
			local Fn = Connection.Function
			local ShouldDisable = false
			if typeof(Fn) == "function" and typeof(debug) == "table" and typeof(debug.info) == "function" then
				local Ok, Source = pcall(debug.info, Fn, "s")
				if Ok and typeof(Source) == "string" and string.find(Source, "PlayerControls", 1, true) then
					ShouldDisable = true
				end
			end
			if ShouldDisable and Connection.Disable then
				Connection:Disable()
				NoJumpCooldownDisabledConnections[#NoJumpCooldownDisabledConnections + 1] = Connection
			end
		end
	end)
end

local function RunNoJumpCooldown(Character)
	if not Config.NoJumpCooldownEnabled then
		if NoJumpCooldownHumanoid or #NoJumpCooldownDisabledConnections > 0 then
			RestoreCollegeJumpCooldown()
		end
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid or Humanoid.Health <= 0 then
		return
	end

	if NoJumpCooldownHumanoid ~= Humanoid then
		RestoreCollegeJumpCooldown()
		NoJumpCooldownHumanoid = Humanoid
		DisableCollegeJumpCooldown(Humanoid)
	end

	pcall(function()
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
	end)

	local SpaceDown = UserInputService:IsKeyDown(Enum.KeyCode.Space)
	local State = Humanoid:GetState()
	local Grounded = Humanoid.FloorMaterial ~= Enum.Material.Air
		and (
			State == Enum.HumanoidStateType.Running
			or State == Enum.HumanoidStateType.RunningNoPhysics
			or State == Enum.HumanoidStateType.Landed
			or State == Enum.HumanoidStateType.Climbing
			or State == Enum.HumanoidStateType.GettingUp
		)

	if not SpaceDown then
		NoJumpCooldownLatched = false
		return
	end

	if not Grounded then
		NoJumpCooldownLatched = false
		return
	end

	if NoJumpCooldownLatched then
		return
	end

	NoJumpCooldownLatched = true
	Humanoid.Jump = true
	pcall(function()
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end)
end

getgenv().EchoRestoreJumpCooldown = RestoreCollegeJumpCooldown

local function IsEchoMover(Instance)
	local Name = Instance.Name
	return Name == "EchoFlyVelocity" or Name == "EchoFlyGyro" or Name == "EchoBlockExtender"
end

local function DestroyForeignGrips(Character)
	for _, Descendant in ipairs(Character:GetDescendants()) do
		local ShouldDestroy = false
		if Descendant:IsA("Weld") or Descendant:IsA("WeldConstraint") then
			local Part0 = Descendant.Part0
			local Part1 = Descendant.Part1
			local Other = nil
			if Part0 and not Part0:IsDescendantOf(Character) then
				Other = Part0
			elseif Part1 and not Part1:IsDescendantOf(Character) then
				Other = Part1
			end
			if Other then
				local OtherModel = Other:FindFirstAncestorOfClass("Model")
				if OtherModel and OtherModel:FindFirstChildOfClass("Humanoid") then
					ShouldDestroy = true
				end
			end
		elseif Descendant:IsA("BodyPosition")
			or Descendant:IsA("BodyVelocity")
			or Descendant:IsA("BodyGyro")
			or Descendant:IsA("BodyAngularVelocity")
			or Descendant:IsA("AlignPosition")
			or Descendant:IsA("AlignOrientation")
			or Descendant:IsA("LinearVelocity")
			or Descendant:IsA("AngularVelocity")
			or Descendant:IsA("VectorForce")
			or Descendant:IsA("Torque")
		then
			if not IsEchoMover(Descendant) then
				ShouldDestroy = true
			end
		end
		if ShouldDestroy then
			pcall(function()
				Descendant:Destroy()
			end)
		end
	end
end

local function RunAntiJam(Character)
	if not Config.AntiJamEnabled then
		RestoreCollision()
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end

	local Values = GetJerseyValues(Character)
	if Values then
		SetBoolValue(Values, "GripBlock", false)
		SetBoolValue(Values, "BeingBlocked", false)
		SetBoolValue(Values, "BeingBullRushed", false)
		SetBoolValue(Values, "Jammed", false)
		SetBoolValue(Values, "BeingJammed", false)
	end

	if Humanoid.PlatformStand then
		Humanoid.PlatformStand = false
		pcall(function()
			Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end)
	end
	if Humanoid.Sit then
		Humanoid.Sit = false
	end

	local RootPart = Character:FindFirstChild("HumanoidRootPart")
	if RootPart and RootPart.Anchored and not FrozenRoot then
		RootPart.Anchored = false
	end

	DestroyForeignGrips(Character)

	local State = Humanoid:GetState()
	local IsRunning = State == Enum.HumanoidStateType.Running
		or State == Enum.HumanoidStateType.RunningNoPhysics
	local Parts = {
		Character:FindFirstChild("Head"),
		Character:FindFirstChild("Torso"),
		Character:FindFirstChild("UpperTorso"),
		Character:FindFirstChild("LowerTorso"),
		Character:FindFirstChild("HumanoidRootPart"),
	}

	for _, Part in ipairs(Parts) do
		if Part and Part:IsA("BasePart") then
			if CollisionOriginalSettings[Part] == nil then
				CollisionOriginalSettings[Part] = Part.CanCollide
			end
			Part.CanCollide = not IsRunning
		end
	end
end

local function RunNoFreeze(Character)
	if not Config.NoFreezeEnabled or Config.FreezeCatchEnabled or FrozenRoot then
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not RootPart then
		return
	end

	pcall(function()
		if RootPart.Anchored then
			RootPart.Anchored = false
		end
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running, true)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics, true)
		if Humanoid.WalkSpeed < 1 then
			Humanoid.WalkSpeed = 16
		end
	end)
end

local function RunAntiTackle(Character)
	if not Config.AntiTackleEnabled then
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Values = GetJerseyValues(Character)
	if Values then
		SetBoolValue(Values, "BeingTackled", false)
		SetBoolValue(Values, "Tackled", false)
		SetBoolValue(Values, "WrapTackle", false)
	end
	if Humanoid and Humanoid.PlatformStand then
		Humanoid.PlatformStand = false
	end
	if Humanoid then
		local State = Humanoid:GetState()
		if State == Enum.HumanoidStateType.PlatformStanding
			or State == Enum.HumanoidStateType.FallingDown
			or State == Enum.HumanoidStateType.Ragdoll
		then
			pcall(function()
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end)
		end
	end
end

local function RunAntiDown(Character)
	if not Config.AntiDownEnabled then
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Values = GetJerseyValues(Character)
	if Values then
		SetBoolValue(Values, "Downed", false)
	end
	if Humanoid then
		local State = Humanoid:GetState()
		if State == Enum.HumanoidStateType.Physics
			or State == Enum.HumanoidStateType.FallingDown
			or State == Enum.HumanoidStateType.Ragdoll
		then
			pcall(function()
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end)
		end
	end
end

local function RunAntiBlock(Character)
	if not Config.AntiBlockEnabled then
		return
	end

	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Values = GetJerseyValues(Character)
	if Values then
		SetBoolValue(Values, "BeingBlocked", false)
		SetBoolValue(Values, "GripBlock", false)
	end
	if Humanoid and Humanoid.PlatformStand then
		Humanoid.PlatformStand = false
	end
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if RootPart and RootPart.Anchored and not FrozenRoot then
		RootPart.Anchored = false
	end
end

local function RestoreBigHeads()
	for Head, Size in pairs(BigHeadOriginalSizes) do
		if Head and Head.Parent then
			pcall(function()
				Head.Size = Size
			end)
		end
		BigHeadOriginalSizes[Head] = nil
	end
end

getgenv().EchoRestoreBigHeads = RestoreBigHeads

local function RunBigHead()
	if not Config.BigHeadEnabled then
		RestoreBigHeads()
		return
	end

	if os.clock() - BigHeadClock < 0.35 then
		return
	end
	BigHeadClock = os.clock()

	local Size = math.clamp(tonumber(Config.BigHeadSize) or 5, 2, 20)
	local TargetSize = Vector3.new(Size, Size, Size)
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Team ~= LocalPlayer.Team then
			local Character = Player.Character
			local Head = Character and Character:FindFirstChild("Head")
			if Head and Head:IsA("BasePart") then
				if BigHeadOriginalSizes[Head] == nil then
					BigHeadOriginalSizes[Head] = Head.Size
				end
				if Head.Size ~= TargetSize then
					Head.Size = TargetSize
				end
			end
		end
	end
end

local function ClearBlockExtender()
	if BlockExtenderPart then
		pcall(function()
			BlockExtenderPart:Destroy()
		end)
		BlockExtenderPart = nil
	end
end

getgenv().EchoClearBlockExtender = ClearBlockExtender

local BlockExtenderTouchClock = 0

local function GetTouchablePart(Character)
	local Jersey = Character and Character:FindFirstChild("Jersey")
	if Jersey and Jersey:IsA("BasePart") then
		return Jersey
	end
	return Character and (Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart"))
end

local function RunBlockExtender(Character)
	if not Config.BlockExtenderEnabled then
		ClearBlockExtender()
		return
	end

	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not RootPart then
		ClearBlockExtender()
		return
	end

	if not BlockExtenderPart or not BlockExtenderPart.Parent then
		BlockExtenderPart = Instance.new("Part")
		BlockExtenderPart.Name = "EchoBlockExtender"
		BlockExtenderPart.Shape = Enum.PartType.Ball
		BlockExtenderPart.Anchored = false
		BlockExtenderPart.CanCollide = false
		BlockExtenderPart.CanTouch = false
		BlockExtenderPart.CanQuery = false
		BlockExtenderPart.Massless = true
		BlockExtenderPart.Material = Enum.Material.ForceField
		BlockExtenderPart.CFrame = RootPart.CFrame
		BlockExtenderPart.Parent = Character

		local Weld = Instance.new("WeldConstraint")
		Weld.Part0 = RootPart
		Weld.Part1 = BlockExtenderPart
		Weld.Parent = BlockExtenderPart
	end

	local Reach = math.clamp(tonumber(Config.BlockExtenderReach) or 10, 2, 30)
	BlockExtenderPart.Size = Vector3.new(Reach, Reach, Reach)
	BlockExtenderPart.Transparency = math.clamp(tonumber(Config.BlockExtenderTransparency) or 1, 0, 1)

	if typeof(firetouchinterest) ~= "function" then
		return
	end
	if IsHoldingFootball(Character) then
		return
	end
	if os.clock() - BlockExtenderTouchClock < 0.2 then
		return
	end

	local MyPart = GetTouchablePart(Character)
	if not MyPart then
		return
	end

	local HalfReach = Reach * 0.5
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Team ~= LocalPlayer.Team then
			local OtherCharacter = Player.Character
			local OtherRoot = OtherCharacter and OtherCharacter:FindFirstChild("HumanoidRootPart")
			local OtherPart = GetTouchablePart(OtherCharacter)
			if OtherRoot and OtherPart and (OtherRoot.Position - RootPart.Position).Magnitude <= HalfReach then
				BlockExtenderTouchClock = os.clock()
				pcall(function()
					firetouchinterest(MyPart, OtherPart, 0)
					task.delay(0.1, function()
						pcall(firetouchinterest, MyPart, OtherPart, 1)
					end)
				end)
			end
		end
	end
end

local function GetBallCarrierCharacter()
	local Carrier = BallCarrierValue and BallCarrierValue.Value
	if typeof(Carrier) == "Instance" then
		if Carrier:IsA("Player") then
			return Carrier.Character
		end
		if Carrier:IsA("Model") then
			return Carrier
		end
	end
	return nil
end

local function IsHoldingFootball(Character)
	local Tool = Character and Character:FindFirstChild("Football")
	return Tool and Tool:IsA("Tool")
end

local function IsInThrowMode(Character)
	local Values = GetJerseyValues(Character)
	local ThrowMode = Values and Values:FindFirstChild("ThrowMode")
	return ThrowMode and ThrowMode:IsA("BoolValue") and ThrowMode.Value
end

local function DoClickTackle()
	if not Config.ClickTackleEnabled then
		return
	end

	local Character = LocalPlayer.Character
	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not RootPart then
		return
	end

	if IsHoldingFootball(Character) then
		return
	end
	if Config.ThrowAssistEnabled and IsInThrowMode(Character) then
		return
	end

	local CarrierCharacter = GetBallCarrierCharacter()
	if not CarrierCharacter or CarrierCharacter == Character then
		return
	end

	local CarrierRoot = CarrierCharacter:FindFirstChild("HumanoidRootPart")
	if not CarrierRoot then
		return
	end

	local Radius = math.clamp(tonumber(Config.ClickTackleRadius) or 15, 5, 40)
	if (CarrierRoot.Position - RootPart.Position).Magnitude > Radius then
		return
	end

	RootPart.CFrame = CarrierRoot.CFrame
end

local function ScheduleResetOnCatch(Character)
	if not Config.ResetOnCatchEnabled or Config.FreezeCatchEnabled then
		return
	end

	ResetOnCatchToken += 1
	local Token = ResetOnCatchToken
	local Duration = math.clamp(tonumber(Config.ResetOnCatchDuration) or 0.5, 0.1, 5)
	task.delay(Duration, function()
		if Token ~= ResetOnCatchToken or not Config.ResetOnCatchEnabled then
			return
		end
		local Current = LocalPlayer.Character
		if Current ~= Character or not IsHoldingFootball(Current) then
			return
		end
		local Humanoid = Current:FindFirstChildOfClass("Humanoid")
		if Humanoid and Humanoid.Health > 0 then
			Humanoid.Health = 0
		end
	end)
end

local function ReleaseFreezeCatch()
	FreezeCatchToken += 1
	if FrozenRoot and FrozenRoot.Parent then
		pcall(function()
			FrozenRoot.Anchored = FrozenRootWasAnchored
		end)
	end
	FrozenRoot = nil
end

local function RunFreezeCatch(Character)
	if not Config.FreezeCatchEnabled or Config.NoFreezeEnabled or Config.ResetOnCatchEnabled then
		return
	end

	local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
	if not RootPart then
		return
	end

	StopFly()
	FreezeCatchToken += 1
	local Token = FreezeCatchToken

	if FrozenRoot ~= RootPart then
		if FrozenRoot and FrozenRoot.Parent then
			pcall(function()
				FrozenRoot.Anchored = FrozenRootWasAnchored
			end)
		end
		FrozenRoot = RootPart
		FrozenRootWasAnchored = RootPart.Anchored
	end

	pcall(function()
		RootPart.AssemblyLinearVelocity = Vector3.zero
		RootPart.AssemblyAngularVelocity = Vector3.zero
		RootPart.Anchored = true
	end)

	local Duration = math.clamp(tonumber(Config.FreezeCatchDuration) or 0.5, 0.1, 10)
	task.delay(Duration, function()
		if Token ~= FreezeCatchToken or FrozenRoot ~= RootPart then
			return
		end
		if RootPart.Parent then
			pcall(function()
				RootPart.Anchored = FrozenRootWasAnchored
			end)
		end
		FrozenRoot = nil
	end)
end

local function RunPhysicsProtections(Character)
	RunNoJumpCooldown(Character)
	RunAntiJam(Character)
	RunNoFreeze(Character)
	RunAntiTackle(Character)
	RunAntiDown(Character)
	RunAntiBlock(Character)
end

TrackConnection(Workspace.ChildAdded, function(Child)
	if Child.Name == "Handle" or Child.Name == "Football" then
		InvalidateBallCache()
	end
end)

TrackConnection(Workspace.DescendantAdded, function(Descendant)
	if Descendant.Name == "Handle" or Descendant.Name == "Football" then
		InvalidateBallCache()
	end
end)

TrackConnection(Workspace.ChildRemoved, function(Child)
	if Child.Name == "Handle" or Child.Name == "Football" then
		InvalidateBallCache()
	end
end)

if FootballObjectValue then
	TrackConnection(FootballObjectValue.Changed, InvalidateBallCache)
end
if BallCarrierValue then
	TrackConnection(BallCarrierValue.Changed, InvalidateBallCache)
end

local function HookCharacter(Character)
	AutotuckLatched = false
	JumpBoostLatched = false
	LastJumpBoost = 0
	AngleEnhancerLatched = false
	AngleTick = 0
	NoJumpCooldownLatched = false
	NoJumpCooldownHumanoid = nil
	RestoreCollegeJumpCooldown()
	StopFly()
	ClearBlockExtender()
	RestoreCollision()
	ResetOnCatchToken += 1

	TrackConnection(Character.ChildAdded, function(Child)
		if Child.Name == "Football" and Child:IsA("Tool") then
			if Config.FreezeCatchEnabled then
				task.defer(RunFreezeCatch, Character)
			end
			if Config.ResetOnCatchEnabled then
				task.defer(ScheduleResetOnCatch, Character)
			end
			if Config.AutotuckEnabled and not AutotuckLatched then
				AutotuckLatched = true
				task.defer(FireAutotuck)
			end
		end
	end)

	TrackConnection(Character.ChildRemoved, function(Child)
		if Child.Name == "Football" then
			AutotuckLatched = false
			ResetOnCatchToken += 1
			if FrozenRoot and FrozenRoot:IsDescendantOf(Character) then
				ReleaseFreezeCatch()
			end
		end
	end)

	local Humanoid = Character:FindFirstChildOfClass("Humanoid") or Character:WaitForChild("Humanoid", 5)
	if Humanoid then
		TrackConnection(Humanoid.StateChanged, function(OldState, NewState)
			TryJumpBoost(Character, OldState, NewState)
		end)
		TrackConnection(Humanoid.Jumping, function(Active)
			if Active then
				ApplyAngleEnhancerImpulse(Character)
			end
		end)
		TrackConnection(Humanoid:GetPropertyChangedSignal("JumpPower"), function()
			if Config.JumpPowerEnabled or (Config.AngleEnhancerEnabled and os.clock() - AngleTick < 0.2) then
				MaintainJumpPower(Character)
			end
		end)
		MaintainJumpPower(Character)
	end
end

if LocalPlayer.Character then
	task.defer(HookCharacter, LocalPlayer.Character)
end

TrackConnection(LocalPlayer.CharacterAdded, function(Character)
	task.defer(HookCharacter, Character)
end)

TrackConnection(UserInputService.InputBegan, function(Input, GameProcessed)
	if Input.UserInputType == Enum.UserInputType.Touch then
		local Position = Input.Position
		local ScreenPoint = Vector2.new(Position.X, Position.Y)
		MobileTouchStarts[Input] = {
			Point = ScreenPoint,
			Clock = os.clock(),
			Dragged = false,
			MaxDrag = 0,
		}

		if not TouchHitsBlockingGui(ScreenPoint) then
			if Config.ThrowMobileCameraAim == false then
				LastTouchAimPoint = ScreenPoint
			end

			if Config.ThrowAssistEnabled and Config.ThrowMobileTapLock ~= false and UserInputService.TouchEnabled then
				local Holding = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Football")
				if Holding and Holding:IsA("Tool") then
					local Locked = PickReceiverNearScreenPoint(ScreenPoint, 140)
					if Locked then
						MobileThrowLock = Locked
					end
				end
			end
		end
	end

	if GameProcessed then
		return
	end
	if Input.KeyCode == Enum.KeyCode.W then
		FlyKeysHeld.W = true
	elseif Input.KeyCode == Enum.KeyCode.A then
		FlyKeysHeld.A = true
	elseif Input.KeyCode == Enum.KeyCode.S then
		FlyKeysHeld.S = true
	elseif Input.KeyCode == Enum.KeyCode.D then
		FlyKeysHeld.D = true
	elseif Input.KeyCode == Enum.KeyCode.Space then
		FlyKeysHeld.Space = true
	elseif Input.KeyCode == Enum.KeyCode.LeftShift then
		FlyKeysHeld.LeftShift = true
	elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
		DoClickTackle()
	end
end)

TrackConnection(UserInputService.TouchMoved, function(Touch, _GameProcessed)
	local Start = MobileTouchStarts[Touch]
	if Start then
		local Position = Touch.Position
		local ScreenPoint = Vector2.new(Position.X, Position.Y)
		local Drag = (ScreenPoint - Start.Point).Magnitude
		if Drag > Start.MaxDrag then
			Start.MaxDrag = Drag
		end
		-- Camera look / joystick slide — do not treat as a throw tap.
		if Drag > 22 then
			Start.Dragged = true
		end
	end

	if Config.ThrowMobileCameraAim ~= false then
		return
	end
	local Position = Touch.Position
	local ScreenPoint = Vector2.new(Position.X, Position.Y)
	if TouchHitsBlockingGui(ScreenPoint) then
		return
	end
	LastTouchAimPoint = ScreenPoint
end)

TrackConnection(UserInputService.InputEnded, function(Input)
	if Input.UserInputType == Enum.UserInputType.Touch then
		local Start = MobileTouchStarts[Input]
		MobileTouchStarts[Input] = nil

		if Start and not Start.Dragged then
			local Position = Input.Position
			local EndPoint = Vector2.new(Position.X, Position.Y)
			local Drag = math.max(Start.MaxDrag, (EndPoint - Start.Point).Magnitude)
			local HeldFor = os.clock() - Start.Clock

			-- True tap anywhere = throw. Drags (camera) are ignored.
			if Drag <= 28 and HeldFor <= 0.5 then
				TryMobileTapThrow(EndPoint)
			end
		end
	end

	if Input.KeyCode == Enum.KeyCode.W then
		FlyKeysHeld.W = false
	elseif Input.KeyCode == Enum.KeyCode.A then
		FlyKeysHeld.A = false
	elseif Input.KeyCode == Enum.KeyCode.S then
		FlyKeysHeld.S = false
	elseif Input.KeyCode == Enum.KeyCode.D then
		FlyKeysHeld.D = false
	elseif Input.KeyCode == Enum.KeyCode.Space then
		FlyKeysHeld.Space = false
	elseif Input.KeyCode == Enum.KeyCode.LeftShift then
		FlyKeysHeld.LeftShift = false
	end
end)

-- Roblox tap signals — never block camera because no Active overlay is used.
pcall(function()
	TrackConnection(UserInputService.TouchTap, function(TouchPositions, _GameProcessed)
		local Position = TouchPositions and TouchPositions[1]
		if not Position then
			return
		end
		TryMobileTapThrow(Vector2.new(Position.X, Position.Y))
	end)
end)

pcall(function()
	TrackConnection(UserInputService.TouchTapInWorld, function(Position, ProcessedByUI)
		if ProcessedByUI then
			return
		end
		TryMobileTapThrow(Vector2.new(Position.X, Position.Y))
	end)
end)

task.defer(function()
	task.wait(2.5)
	local Ok, Err = pcall(InstallThrowHook)
	if not Ok then
		warn("[Echo] throw hook skipped:", Err)
	end
end)

TrackConnection(UserInputService:GetPropertyChangedSignal("MouseBehavior"), function()
	ShiftLockEnabled = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
	if not ShiftLockEnabled and LastShiftLockEnabled then
		AngleTick = os.clock()
		AngleEnhancerLatched = false
	end
	LastShiftLockEnabled = ShiftLockEnabled
end)

local function KeepInputFree()
	local FocusedBox = UserInputService:GetFocusedTextBox()
	if FocusedBox and not FocusedBox:IsDescendantOf(CoreGui) then
		return
	end
	if UserInputService.ModalEnabled then
		pcall(function()
			UserInputService.ModalEnabled = false
		end)
	end
end

local EchoVisualClock = 0
TrackConnection(RunService.Heartbeat, function(DeltaTime)
	local Character = LocalPlayer.Character
	if Config.PhysicsUseServerValues and not PhysicsSynced then
		pcall(SyncPhysicsFromGame)
	end
	-- Movement / combat every frame
	pcall(MaintainJumpPower, Character)
	pcall(RunAngleEnhancer, Character)
	pcall(RunWalkSpeed, DeltaTime)
	pcall(RunFly)
	pcall(RunPhysicsProtections, Character)
	pcall(RunAutotuck)
	pcall(RunMagsV1)
	pcall(RunMagsV2)
	pcall(RunMagsV3)
	pcall(UpdateMagHitbox)
	pcall(UpdateThrowTarget)
	pcall(KeepInputFree)

	-- Visuals / ESP throttled ~8Hz to cut Heartbeat cost
	local Now = os.clock()
	if Now - EchoVisualClock >= 0.12 then
		EchoVisualClock = Now
		pcall(RunBigHead)
		pcall(RunBlockExtender, Character)
		pcall(UpdateHud)
		pcall(UpdateFovCircle)
		pcall(UpdateReceiverEsp)
		pcall(UpdateArcPreview)
	end
end)

getgenv().EchoCleanup = function()
	Config.MagsV1Enabled = false
	Config.MagsV1ShowHitbox = false
	Config.MagsV2Enabled = false
	Config.MagsV3Enabled = false
	Config.AutotuckEnabled = false
	Config.FreezeCatchEnabled = false
	ReleaseFreezeCatch()
	Config.JumpPowerEnabled = false
	Config.WalkSpeedEnabled = false
	Config.AngleEnhancerEnabled = false
	Config.FlyEnabled = false
	Config.NoJumpCooldownEnabled = false
	Config.AntiJamEnabled = false
	Config.NoFreezeEnabled = false
	Config.AntiTackleEnabled = false
	Config.AntiDownEnabled = false
	Config.AntiBlockEnabled = false
	Config.ClickTackleEnabled = false
	Config.BigHeadEnabled = false
	Config.BlockExtenderEnabled = false
	Config.ResetOnCatchEnabled = false
	ResetOnCatchToken += 1
	JumpBoostLatched = false
	AngleEnhancerLatched = false
	AngleTick = 0
	PhysicsSynced = false
	RestoreCollegeJumpCooldown()
	RestoreJumpPower()
	RestoreCollision()
	RestoreBigHeads()
	StopFly()
	ClearBlockExtender()
	Config.ThrowAssistEnabled = false
	MobileThrowLock = nil
	LastTouchAimPoint = nil
	MobilePassModeLatched = false
	MobileMenuGui = nil
	getgenv().EchoCurrentThrowSolution = nil
	AutotuckLatched = false
	for Key in pairs(FlyKeysHeld) do
		FlyKeysHeld[Key] = false
	end
	if MagnetHitboxPart then
		MagnetHitboxPart:Destroy()
		MagnetHitboxPart = nil
	end
	RestoreExpandedBalls()
	if ThrowTargetPart then
		ThrowTargetPart:Destroy()
		ThrowTargetPart = nil
	end
	if HudGui then
		HudGui:Destroy()
		HudGui = nil
		HudCards = nil
		FovFrame = nil
	end
	ClearReceiverEsp()
	ClearArcParts()
	ClearBeam()
	for _, Root in ipairs(EchoUiRoots) do
		pcall(function()
			Root:Destroy()
		end)
	end
	table.clear(EchoUiRoots)
	pcall(function()
		for _, Child in ipairs(CoreGui:GetChildren()) do
			if Child.Name == "EchoCFBContainer" or Child.Name == "EchoQbHud" then
				Child:Destroy()
			end
		end
	end)
	getgenv().EchoGetThrowSolution = nil
	getgenv().EchoThrowResolverV2 = nil
	getgenv().EchoStopFly = nil
	getgenv().EchoRestoreCollision = nil
	getgenv().EchoRestoreBigHeads = nil
	getgenv().EchoClearBlockExtender = nil
	getgenv().EchoRestoreJumpCooldown = nil
	getgenv().EchoConfig = nil
	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)
	InvalidateBallCache()
end

Library:Notification("Echo Loaded", CurrentPlaceName .. " · " .. string.format("%.3f", os.clock() - LoadTick) .. "s", 5)
print("[Echo] UI ready (" .. CurrentPlaceName .. ")")

end -- LibraryOk
end -- PlaceId gate

]====], "Echo_College_Football")
	if not EchoChunk then
		error("[Echo] College Football compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsClutch() then
-- Echo Hub: Clutch Basketball
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local CollectionService = game:GetService("CollectionService")

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

getgenv().gethui = function()
	return EchoUiContainer
end

local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoScootUI then
		return getgenv().__EchoScootUI
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/saintsrevival1/eee/refs/heads/main/UI-Source.lua"))()
	getgenv().__EchoScootUI = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
	return
end

local Library = LibraryOrErr
getgenv().Library = Library

pcall(function()
	Library.Round = function(_, Number, Float)
		if typeof(Number) ~= "number" or Number ~= Number then
			return 0
		end
		if typeof(Float) ~= "number" or Float ~= Float or Float == 0 then
			Float = 1
		end
		local Multiplier = 1 / Float
		return math.floor(Number * Multiplier + 1e-9) / Multiplier
	end
end)

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local Config = {
	AutoGreen = false,
	AutoDunkGreen = false,
	GreenMode = "Perfect",
	DunkMode = "Perfect",
	GreenPercent = 94,
	DunkPercent = 93,
	RandomizeGreen = false,
	PerfectChance = 55,
	GreatChance = 30,
	GoodChance = 15,
	GreenDelayOffset = 0,

	AutoGuard = false,
	GuardHoldActive = false,
	GuardUiToggle = false,
	GuardDistance = 10,
	GuardPrediction = 0.25,
	GuardKey = Enum.KeyCode.G,

	AutoReach = false,
	AutoBlock = false,
	BlockDistance = 14,

	BallMagnet = false,
	MagnetDistance = 30,

	ReboundTp = false,
	ReboundOffset = 0,
	FollowCarrier = false,
	FollowOffset = -8,

	StealReach = false,
	ReachMultiplier = 2.5,

	SpeedBoost = false,
	SpeedAmount = 18,

	InfiniteStamina = false,
	AntiOob = false,

	CarrierEsp = false,
	OpponentEsp = false,
	EspFillTransparency = 0.65,
	EspOutlineTransparency = 0,
	CarrierEspColor = Color3.fromRGB(80, 220, 120),
	OpponentEspColor = Color3.fromRGB(255, 90, 90),
}

local Connections = {}
local EchoUiRoots = {}
local ActionRemote = nil
local CourtLibrary = nil
local InputFunctions = nil
local MeterTime = 0.5
local DunkTime = 0.75
local FadeTime = 0.485
local ShotGreenWindow = 88
local FadeGreenWindow = 95
local LayupGreenWindow = 85
local DefaultSpeed = 14
local SprintSpeed = 17
local MaxGuardDistance = 13
local MaxReachDistance = 6
local MaxBlockDistance = 14

local ShotToken = 0
local DunkToken = 0
local AutoReleasingShot = false
local AutoReleasingDunk = false
local ShotActive = false
local DunkActive = false
local OldShoot = nil
local OldDunk = nil
local OldGuard = nil
local GuardForced = false
local ApplyingGuard = false
local MeterFunctions = nil
local LastShotWasMoving = false
local ShotLockUntil = 0

local EspFolder = nil
local CarrierHighlights = {}
local OpponentHighlights = {}
local OriginalArmSizes = setmetatable({}, { __mode = "k" })
local OriginalHitboxSize = nil
local StealHitboxes = {}
local ReachClock = 0
local BlockClock = 0
local BlockedShotSessions = {}
local MobileGui = nil
local StatusLabel = nil
local CachedCourtBounds = nil
local CachedCourtRef = nil

local QualityBands = {
	Perfect = { 0.92, 0.96 },
	Great = { 0.9, 0.925 },
	Good = { 0.86, 0.9 },
	Okay = { 0.8, 0.86 },
}

local MovingQualityBands = {
	Perfect = { 0.95, 0.985 },
	Great = { 0.93, 0.96 },
	Good = { 0.9, 0.94 },
	Okay = { 0.88, 0.92 },
}

local Window = Library:Window({
	Logo = "72316209028225",
	FadeTime = 0.3,
})

EchoUiRoots[#EchoUiRoots + 1] = EchoUiContainer

local Watermark = Library:Watermark("Echo | Clutch Basketball")
local KeybindList = Library:KeybindList()

local OffensePage = Window:Page({ Name = "Offense", Columns = 2 })
local DefensePage = Window:Page({ Name = "Defense", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
local MiscPage = Window:Page({ Name = "Misc", Columns = 2 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local GreenSection = OffensePage:Section({ Name = "Auto Green", Side = 1 })
local GreenTuneSection = OffensePage:Section({ Name = "Green Tuning", Side = 1 })
local DunkSection = OffensePage:Section({ Name = "Auto Dunk Green", Side = 2 })
local BallSection = OffensePage:Section({ Name = "Ball Control", Side = 2 })

local GuardSection = DefensePage:Section({ Name = "Auto Guard", Side = 1 })
local DefenseToolsSection = DefensePage:Section({ Name = "Defense Tools", Side = 2 })

local MovementSection = PlayerPage:Section({ Name = "Movement", Side = 1 })
local StaminaSection = PlayerPage:Section({ Name = "Stamina", Side = 2 })

local EspSection = VisualsPage:Section({ Name = "ESP", Side = 1 })
local EspStyleSection = VisualsPage:Section({ Name = "ESP Style", Side = 2 })

local TeleSection = MiscPage:Section({ Name = "Teleport", Side = 1 })
local ServerSection = MiscPage:Section({ Name = "Server", Side = 2 })

-- // Utilities
local function TrackConnection(Signal, Callback)
	local Connection = Signal:Connect(Callback)
	Connections[#Connections + 1] = Connection
	return Connection
end

local function ResolveDeps()
	local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
	ActionRemote = Remotes and Remotes:FindFirstChild("Action")

	local Shared = ReplicatedStorage:FindFirstChild("Shared")
	local CourtModule = Shared and Shared:FindFirstChild("CourtLibrary")
	if CourtModule then
		local Ok, Result = pcall(require, CourtModule)
		if Ok and typeof(Result) == "table" then
			CourtLibrary = Result
			MeterTime = tonumber(Result.MeterTime) or MeterTime
			DunkTime = tonumber(Result.DunkTime) or DunkTime
			FadeTime = tonumber(Result.FadeTime) or FadeTime
			ShotGreenWindow = tonumber(Result.ShotGreenWindow) or ShotGreenWindow
			FadeGreenWindow = tonumber(Result.FadeGreenWindow) or FadeGreenWindow
			LayupGreenWindow = tonumber(Result.LayupGreenWindow) or LayupGreenWindow
			DefaultSpeed = tonumber(Result.DefaultSpeed) or DefaultSpeed
			SprintSpeed = tonumber(Result.SprintSpeed) or SprintSpeed
			MaxGuardDistance = tonumber(Result.MaxGuardDistance) or MaxGuardDistance
			MaxReachDistance = tonumber(Result.MaxReachDistance) or MaxReachDistance
			MaxBlockDistance = tonumber(Result.MaxBlockDistance) or MaxBlockDistance
		end
	end

	local PlayerScripts = LocalPlayer:FindFirstChild("PlayerScripts")
	local ClientFolder = PlayerScripts and PlayerScripts:FindFirstChild("Client")
	local Gameplay = ClientFolder and ClientFolder:FindFirstChild("Gameplay")
	local InputScript = Gameplay and Gameplay:FindFirstChild("Client.Input")
	local FunctionsModule = InputScript and InputScript:FindFirstChild("Functions")
	if FunctionsModule then
		local Ok, Result = pcall(require, FunctionsModule)
		if Ok and typeof(Result) == "table" then
			InputFunctions = Result
		end
	end

	local InterfaceRoot = ClientFolder and ClientFolder:FindFirstChild("Interface")
	local InterfaceScript = InterfaceRoot and InterfaceRoot:FindFirstChild("Client.Interface")
	local MeterModule = InterfaceScript and InterfaceScript:FindFirstChild("Functions2")
	if MeterModule then
		local Ok, Result = pcall(require, MeterModule)
		if Ok and typeof(Result) == "table" then
			MeterFunctions = Result
		end
	end
end

local function HideMeters()
	if MeterFunctions and typeof(MeterFunctions.StopMeter) == "function" then
		pcall(function()
			MeterFunctions:StopMeter(false, true)
		end)
	end

	local Character = LocalPlayer.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Root then
		return
	end

	for _, Name in ipairs({ "Meter", "Meter2", "Meter3", "Meter4" }) do
		local Meter = Root:FindFirstChild(Name)
		if Meter then
			if Meter:IsA("BillboardGui") or Meter:IsA("LayerCollector") then
				Meter.Enabled = false
			end
			for _, Desc in ipairs(Meter:GetDescendants()) do
				if Desc:IsA("ImageLabel") or Desc:IsA("ImageButton") then
					Desc.ImageTransparency = 1
				end
			end
		end
	end
end

local function ForceResetMeter()
	HideMeters()
end

local function IsMovingShot()
	local Character = LocalPlayer.Character
	if not Character then
		return false
	end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Root = Character:FindFirstChild("HumanoidRootPart")
	if Humanoid and Humanoid.MoveDirection.Magnitude > 0.12 then
		return true
	end
	if Root then
		local Flat = Vector3.new(Root.AssemblyLinearVelocity.X, 0, Root.AssemblyLinearVelocity.Z)
		if Flat.Magnitude > 3.5 then
			return true
		end
	end
	if LocalPlayer:GetAttribute("Sprinting") then
		return true
	end
	return false
end

local function HasBall(Character)
	Character = Character or LocalPlayer.Character
	if not Character then
		return false
	end
	local Flag = Character:FindFirstChild("HasBall")
	if Flag and Flag:IsA("BoolValue") and Flag.Value == true then
		return true
	end
	if Character:GetAttribute("HasBall") == true then
		return true
	end
	-- Park often keeps HasBall=false while the live ball is welded as Character.Ball
	local Ball = Character:FindFirstChild("Ball")
	if Ball and Ball:IsA("BasePart") then
		return true
	end
	local Basketball = Character:FindFirstChild("Basketball")
	if Basketball and Basketball:IsA("BasePart") then
		return true
	end
	return false
end

local function GetRoot(Character)
	return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function GetPlayerCourt(Player)
	local CourtData = Player and Player:FindFirstChild("CourtData")
	local CourtValue = CourtData and CourtData:FindFirstChild("Court")
	if not CourtValue then
		return nil
	end
	local Value = CourtValue.Value
	if typeof(Value) == "Instance" then
		return Value
	end
	if typeof(Value) == "string" and Value ~= "" and Value ~= "nil" then
		local Courts = Workspace:FindFirstChild("Courts")
		return Courts and Courts:FindFirstChild(Value)
	end
	return nil
end

local function GetPlayerTeamName(Player)
	local CourtData = Player and Player:FindFirstChild("CourtData")
	local TeamValue = CourtData and CourtData:FindFirstChild("Team")
	if not TeamValue then
		return ""
	end
	return tostring(TeamValue.Value or "")
end

local function IsCourtLive(Court)
	if not Court then
		return false
	end
	local Values = Court:FindFirstChild("Values")
	local Progress = Values and Values:FindFirstChild("Progress")
	if Progress and typeof(Progress.Value) == "boolean" then
		return Progress.Value == true
	end
	return false
end

local function GetNearestCourt(Root, MaxDist)
	if not Root then
		return nil
	end
	MaxDist = MaxDist or 140
	local Courts = Workspace:FindFirstChild("Courts")
	if not Courts then
		return nil
	end
	local Best, BestDist = nil, math.huge
	local BestLive, BestLiveDist = nil, math.huge
	for _, Court in ipairs(Courts:GetChildren()) do
		local Part = Court:FindFirstChildWhichIsA("BasePart", true)
		if Part then
			local Dist = (Part.Position - Root.Position).Magnitude
			if Dist < BestDist then
				BestDist = Dist
				Best = Court
			end
			if IsCourtLive(Court) and Dist < BestLiveDist then
				BestLiveDist = Dist
				BestLive = Court
			end
		end
	end
	if BestLive and BestLiveDist <= MaxDist then
		return BestLive
	end
	if Best and BestDist <= MaxDist then
		return Best
	end
	return nil
end

-- Assigned CourtData first; Park often leaves Court=nil so fall back to nearest court
local function GetEffectiveCourt()
	local Assigned = GetPlayerCourt(LocalPlayer)
	if Assigned then
		return Assigned
	end
	return GetNearestCourt(GetRoot(LocalPlayer.Character), 140)
end

-- Guard movement is driven through a RenderStep bind that runs AFTER the game's
-- default control module. A Heartbeat Humanoid:Move loses to the control script
-- every frame (character rotates but never walks); a render bind at
-- Character priority + 1 wins, so auto-guard actually paths to the ball.
local GuardMoveDir = nil

local function StopGuardMovement(Humanoid, Root)
	GuardMoveDir = nil
	if not Humanoid then
		return
	end
	pcall(function()
		Humanoid:Move(Vector3.new(), false)
	end)
end

local function GetStamina()
	local GameData = LocalPlayer:FindFirstChild("GameData")
	return GameData and GameData:FindFirstChild("Stamina")
end

local function IsOnDifferentTeam(OtherPlayer)
	if not OtherPlayer or OtherPlayer == LocalPlayer then
		return false
	end
	local MyTeam = GetPlayerTeamName(LocalPlayer)
	local TheirTeam = GetPlayerTeamName(OtherPlayer)
	-- Only trust CourtData teams. Roblox Team service is wrong in Park and was
	-- marking everyone as teammates so FindBallCarrier always returned nil.
	if MyTeam ~= "" and TheirTeam ~= "" then
		return MyTeam ~= TheirTeam
	end
	return true
end

local function FindBallCarrier()
	local MyRoot = GetRoot(LocalPlayer.Character)
	if not MyRoot then
		return nil, nil
	end

	local MyCourt = GetPlayerCourt(LocalPlayer) or GetEffectiveCourt()
	local Best, BestRoot, BestScore = nil, nil, math.huge

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Character and HasBall(Player.Character) then
			local Root = GetRoot(Player.Character)
			if Root and IsOnDifferentTeam(Player) then
				local Dist = (Root.Position - MyRoot.Position).Magnitude
				if Dist <= 45 then
					-- Proximity-first. Same court is a soft bonus (Park CourtData is flaky).
					local Score = Dist
					local TheirCourt = GetPlayerCourt(Player)
					if MyCourt and TheirCourt == MyCourt then
						Score -= 8
					end
					if Score < BestScore then
						BestScore = Score
						Best = Player
						BestRoot = Root
					end
				end
			end
		end
	end
	return Best, BestRoot
end

local function FindLooseBall()
	local MyRoot = GetRoot(LocalPlayer.Character)
	if not MyRoot then
		return nil
	end
	local Best, BestDist = nil, math.huge
	local Balls = Workspace:FindFirstChild("Balls")
	local function Consider(Part)
		if not Part or not Part:IsA("BasePart") then
			return
		end
		local Dist = (Part.Position - MyRoot.Position).Magnitude
		if Dist < BestDist then
			BestDist = Dist
			Best = Part
		end
	end
	if Balls then
		for _, Child in ipairs(Balls:GetChildren()) do
			Consider(Child:IsA("BasePart") and Child or Child:FindFirstChildWhichIsA("BasePart"))
		end
	end
	for _, Child in ipairs(Workspace:GetChildren()) do
		if Child.Name == "Basketball" or Child.Name == "Ball" then
			Consider(Child:IsA("BasePart") and Child or Child:FindFirstChildWhichIsA("BasePart"))
		end
	end
	return Best
end

local function PickQuality(Mode, Randomize)
	if not Randomize and Mode ~= "Random" then
		return Mode
	end
	local Roll = math.random(1, 100)
	local Perfect = math.clamp(tonumber(Config.PerfectChance) or 55, 0, 100)
	local Great = math.clamp(tonumber(Config.GreatChance) or 30, 0, 100)
	if Roll <= Perfect then
		return "Perfect"
	elseif Roll <= Perfect + Great then
		return "Great"
	else
		return "Good"
	end
end

local function GetReleasePlan(ModeName, IsDunk, Moving)
	local Mode = IsDunk and (Config.DunkMode or "Perfect") or (Config.GreenMode or "Perfect")
	if ModeName then
		Mode = ModeName
	end
	if not IsDunk and (Config.RandomizeGreen or Mode == "Random") then
		Mode = PickQuality(Mode, true)
	elseif IsDunk and Mode == "Random" then
		Mode = PickQuality(Mode, true)
	end

	local Duration = IsDunk and DunkTime or MeterTime
	if not IsDunk and Moving then
		Duration = math.max(MeterTime, FadeTime)
	end

	local MinP, MaxP
	if Mode == "Custom" then
		local Custom = IsDunk and Config.DunkPercent or Config.GreenPercent
		Custom = math.clamp(tonumber(Custom) or 94, 70, 100) / 100
		MinP, MaxP = Custom, Custom
	else
		local Band
		if Moving and not IsDunk then
			Band = MovingQualityBands[Mode] or MovingQualityBands.Perfect
		else
			Band = QualityBands[Mode] or QualityBands.Perfect
		end
		MinP, MaxP = Band[1], Band[2]
	end

	local Target = MinP
	if MaxP > MinP then
		Target = MinP + math.random() * (MaxP - MinP)
	end
	Target = math.clamp(Target, 0.7, 0.995)

	local Offset = tonumber(Config.GreenDelayOffset) or 0
	local Delay = math.max(Duration * Target + Offset, 0.05)
	return Delay, true, Mode, Target * 100, Moving, Duration, Target
end

local function FireShootRelease(RisingFlag)
	AutoReleasingShot = true
	if OldShoot then
		pcall(OldShoot, InputFunctions, false, RisingFlag and true or false)
	elseif ActionRemote then
		ActionRemote:FireServer("Shoot", false, RisingFlag and true or false)
	end
	HideMeters()
	task.defer(HideMeters)
	AutoReleasingShot = false
end

local function FireDunkRelease()
	AutoReleasingDunk = true
	if OldDunk then
		pcall(OldDunk, InputFunctions, false)
	elseif ActionRemote then
		ActionRemote:FireServer("Dunk", false)
	end
	HideMeters()
	task.defer(HideMeters)
	AutoReleasingDunk = false
end

local function ScheduleAutoGreen()
	if not Config.AutoGreen then
		return
	end

	ShotToken += 1
	local Token = ShotToken
	ShotActive = true
	LastShotWasMoving = IsMovingShot()
	local MeterStart = os.clock()
	local Delay, RisingFlag, _, _, _, Duration, Target = GetReleasePlan(nil, false, LastShotWasMoving)

	task.spawn(function()
		while Token == ShotToken and Config.AutoGreen do
			LastShotWasMoving = IsMovingShot() or LastShotWasMoving
			local Elapsed = os.clock() - MeterStart
			local ActiveDuration = LastShotWasMoving and math.max(MeterTime, FadeTime) or Duration
			local MeterPercent = Elapsed / ActiveDuration

			if MeterPercent >= Target or Elapsed >= Delay then
				break
			end
			if Elapsed > ActiveDuration * 1.15 then
				break
			end
			RunService.Heartbeat:Wait()
		end

		if Token ~= ShotToken or not Config.AutoGreen then
			return
		end

		AutoReleasingShot = true
		pcall(FireShootRelease, true)
		AutoReleasingShot = false
		ShotActive = false
		ShotLockUntil = os.clock() + 0.05
	end)
end

local function ScheduleAutoDunk()
	if not Config.AutoDunkGreen then
		return
	end
	if DunkActive then
		return
	end

	DunkToken += 1
	local Token = DunkToken
	DunkActive = true
	local MeterStart = os.clock()
	local Delay, _, _, _, _, Duration, Target = GetReleasePlan(nil, true, false)

	task.spawn(function()
		while Token == DunkToken and Config.AutoDunkGreen do
			local Elapsed = os.clock() - MeterStart
			local MeterPercent = Elapsed / Duration
			if MeterPercent >= Target or Elapsed >= Delay then
				break
			end
			if Elapsed > Duration * 1.15 then
				break
			end
			RunService.Heartbeat:Wait()
		end

		if Token ~= DunkToken or not Config.AutoDunkGreen then
			return
		end

		AutoReleasingDunk = true
		pcall(FireDunkRelease)
		AutoReleasingDunk = false
		DunkActive = false
	end)
end

local function SetGuardState(Enabled)
	if GuardForced == Enabled then
		return
	end
	GuardForced = Enabled
	ApplyingGuard = true
	local Ok, Err = pcall(function()
		if OldGuard then
			OldGuard(InputFunctions, Enabled)
		elseif InputFunctions and typeof(InputFunctions.Guard) == "function" then
			InputFunctions:Guard(Enabled)
		elseif ActionRemote then
			ActionRemote:FireServer("Guard", Enabled)
		end
	end)
	ApplyingGuard = false
	if not Ok then
		warn("[Echo] Guard state failed: " .. tostring(Err))
	end
end

local function IsGuardKeyHeld()
	local Key = Config.GuardKey
	if not Key then
		return false
	end
	if UserInputService:IsKeyDown(Key) then
		return true
	end
	if Key == Enum.KeyCode.ButtonL2 then
		return UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonL2)
	end
	if UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Key) then
		return true
	end
	return false
end

local function UpdateGuardHoldFromInput()
	if not Config.AutoGuard then
		Config.GuardHoldActive = false
		Config.GuardUiToggle = false
		return
	end
	-- UI toggle (mobile button / latched) OR physical hold key / gamepad
	Config.GuardHoldActive = Config.GuardUiToggle or IsGuardKeyHeld()
end

local function InstallHooks()
	ResolveDeps()
	if not InputFunctions then
		return false
	end

	if typeof(InputFunctions.Shoot) == "function" and not OldShoot then
		OldShoot = InputFunctions.Shoot
		InputFunctions.Shoot = function(Self, Holding, Flag)
			if Holding then
				ShotToken += 1
				ShotActive = false
				ForceResetMeter()
				local Result = OldShoot(Self, true, Flag)
				ScheduleAutoGreen()
				return Result
			end

			if Config.AutoGreen and not AutoReleasingShot then
				if ShotActive or LocalPlayer:GetAttribute("Shooting") or os.clock() < ShotLockUntil then
					return
				end
			end

			ShotActive = false
			return OldShoot(Self, false, Flag)
		end
	end

	if typeof(InputFunctions.Dunk) == "function" and not OldDunk then
		OldDunk = InputFunctions.Dunk
		InputFunctions.Dunk = function(Self, Holding)
			if Holding then
				ForceResetMeter()
				local Result = OldDunk(Self, true)
				if not DunkActive then
					ScheduleAutoDunk()
				end
				return Result
			end
			if Config.AutoDunkGreen and DunkActive and not AutoReleasingDunk then
				return
			end
			DunkActive = false
			return OldDunk(Self, false)
		end
	end

	if typeof(InputFunctions.Guard) == "function" then
		if not OldGuard then
			OldGuard = InputFunctions.Guard
		end
		InputFunctions.Guard = function(Self, Enabled)
			-- Native G roots you. Auto-guard owns stance while held.
			if Config.AutoGuard and Config.GuardHoldActive and not ApplyingGuard then
				if Enabled then
					return
				end
			end
			return OldGuard(Self, Enabled)
		end
	end

	return OldShoot ~= nil
end

local function UninstallHooks()
	if InputFunctions and OldShoot then
		InputFunctions.Shoot = OldShoot
	end
	if InputFunctions and OldDunk then
		InputFunctions.Dunk = OldDunk
	end
	if InputFunctions and OldGuard then
		InputFunctions.Guard = OldGuard
	end
	OldShoot = nil
	OldDunk = nil
	OldGuard = nil
	ShotActive = false
	DunkActive = false
	ShotToken += 1
	DunkToken += 1
	SetGuardState(false)
end

local function EnsureEspFolder()
	if EspFolder and EspFolder.Parent then
		return EspFolder
	end
	EspFolder = Instance.new("Folder")
	EspFolder.Name = "EchoClutchEsp"
	EspFolder.Parent = CoreGui
	return EspFolder
end

local function ClearHighlightTable(Table)
	for Character, Highlight in pairs(Table) do
		pcall(function()
			Highlight:Destroy()
		end)
		Table[Character] = nil
	end
end

local function UpsertHighlight(Store, Character, Color, Enabled)
	if not Enabled or not Character or not Character.Parent then
		local Existing = Store[Character]
		if Existing then
			pcall(function()
				Existing:Destroy()
			end)
			Store[Character] = nil
		end
		return
	end

	local Highlight = Store[Character]
	if not Highlight or not Highlight.Parent then
		Highlight = Instance.new("Highlight")
		Highlight.Name = "EchoEsp"
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.Parent = EnsureEspFolder()
		Store[Character] = Highlight
	end

	Highlight.Adornee = Character
	Highlight.FillColor = Color
	Highlight.OutlineColor = Color
	Highlight.FillTransparency = Config.EspFillTransparency
	Highlight.OutlineTransparency = Config.EspOutlineTransparency
	Highlight.Enabled = true
end

local function UpdateEsp()
	local SeenCarrier = {}
	local SeenOpponent = {}

	if Config.CarrierEsp then
		for _, Player in ipairs(Players:GetPlayers()) do
			if Player ~= LocalPlayer and Player.Character and HasBall(Player.Character) then
				SeenCarrier[Player.Character] = true
				UpsertHighlight(CarrierHighlights, Player.Character, Config.CarrierEspColor, true)
			end
		end
	end

	if Config.OpponentEsp then
		for _, Player in ipairs(Players:GetPlayers()) do
			if IsOnDifferentTeam(Player) and Player.Character then
				SeenOpponent[Player.Character] = true
				UpsertHighlight(OpponentHighlights, Player.Character, Config.OpponentEspColor, true)
			end
		end
	end

	for Character, Highlight in pairs(CarrierHighlights) do
		if not Config.CarrierEsp or not SeenCarrier[Character] or not Character.Parent then
			pcall(function()
				Highlight:Destroy()
			end)
			CarrierHighlights[Character] = nil
		end
	end

	for Character, Highlight in pairs(OpponentHighlights) do
		if not Config.OpponentEsp or not SeenOpponent[Character] or not Character.Parent then
			pcall(function()
				Highlight:Destroy()
			end)
			OpponentHighlights[Character] = nil
		end
	end
end

local function GetActiveCourt()
	-- Anti-OOB must use assigned court only â€” inferred park courts would yank you
	return GetPlayerCourt(LocalPlayer)
end

local function GetCourtSafeBounds(Court)
	if not Court then
		return nil
	end
	if CachedCourtRef == Court and CachedCourtBounds then
		return CachedCourtBounds.Min, CachedCourtBounds.Max, CachedCourtBounds.Center
	end

	local Source = Court:FindFirstChild("Objects") or Court:FindFirstChild("Walls")
	if not Source then
		return nil
	end

	local MinV, MaxV
	for _, Desc in ipairs(Source:GetDescendants()) do
		if Desc:IsA("BasePart") then
			local Pos = Desc.Position
			local Half = Desc.Size * 0.5
			local Mn = Pos - Half
			local Mx = Pos + Half
			if not MinV then
				MinV, MaxV = Mn, Mx
			else
				MinV = Vector3.new(math.min(MinV.X, Mn.X), math.min(MinV.Y, Mn.Y), math.min(MinV.Z, Mn.Z))
				MaxV = Vector3.new(math.max(MaxV.X, Mx.X), math.max(MaxV.Y, Mx.Y), math.max(MaxV.Z, Mx.Z))
			end
		end
	end
	if not MinV then
		return nil
	end

	local Inset = 2.75
	local SafeMin = Vector3.new(MinV.X + Inset, MinV.Y, MinV.Z + Inset)
	local SafeMax = Vector3.new(MaxV.X - Inset, MaxV.Y, MaxV.Z - Inset)
	local Center = (SafeMin + SafeMax) * 0.5
	CachedCourtRef = Court
	CachedCourtBounds = { Min = SafeMin, Max = SafeMax, Center = Center }
	return SafeMin, SafeMax, Center
end

local function GetOffenseHoop(CarrierRoot)
	local Court = GetActiveCourt()
	if CourtLibrary and typeof(CourtLibrary.NearestHoop) == "function" then
		local Ok, Hoop = pcall(function()
			return CourtLibrary:NearestHoop(LocalPlayer, Court)
		end)
		if Ok and Hoop then
			return Hoop
		end
	end
	if Court then
		local Hoops = Court:FindFirstChild("Hoops")
		if Hoops then
			local Best, BestDist = nil, math.huge
			for _, Desc in ipairs(Hoops:GetDescendants()) do
				if Desc:IsA("BasePart") and (Desc.Name:lower():find("rim") or Desc:GetAttribute("Goal") or Desc.Name == "GoalRoot") then
					local Dist = (Desc.Position - CarrierRoot.Position).Magnitude
					if Dist < BestDist then
						BestDist = Dist
						Best = Desc
					end
				end
			end
			if Best then
				return Best
			end
			return Hoops:FindFirstChildWhichIsA("BasePart", true)
		end
	end
	return nil
end

local function ClearStealHitboxes()
	for _, Part in pairs(StealHitboxes) do
		pcall(function()
			Part:Destroy()
		end)
	end
	table.clear(StealHitboxes)
	local Character = LocalPlayer.Character
	if Character then
		for _, Child in ipairs(Character:GetChildren()) do
			if Child.Name:find("EchoSteal_") == 1 then
				pcall(function()
					Child:Destroy()
				end)
			end
		end
		local Hitbox = Character:FindFirstChild("CharacterHitbox")
		if Hitbox and OriginalHitboxSize then
			Hitbox.Size = OriginalHitboxSize
			OriginalHitboxSize = nil
		end
	end
end

local function UpdateStealReach()
	local Character = LocalPlayer.Character
	if not Character then
		return
	end

	if not Config.StealReach then
		ClearStealHitboxes()
		return
	end

	-- Soft hand touch expand only. Never CFrame welded parts (flings into void).
	-- Do not resize CharacterHitbox â€” that despawns / pauses gameplay.
	local Scale = math.clamp(tonumber(Config.ReachMultiplier) or 2.5, 1, 6)
	local Hands = {
		Left = Character:FindFirstChild("LeftHand") or Character:FindFirstChild("LeftLowerArm"),
		Right = Character:FindFirstChild("RightHand") or Character:FindFirstChild("RightLowerArm"),
	}

	for Side, Hand in pairs(Hands) do
		if Hand and Hand:IsA("BasePart") then
			local Name = "EchoSteal_" .. Side
			local Box = StealHitboxes[Side]
			if not Box or not Box.Parent then
				Box = Instance.new("Part")
				Box.Name = Name
				Box.Transparency = 1
				Box.Anchored = false
				Box.CanCollide = false
				Box.CanTouch = true
				Box.CanQuery = true
				Box.Massless = true
				Box.CastShadow = false
				Box.Material = Enum.Material.SmoothPlastic
				Box.Color = Color3.new(1, 1, 1)
				Box.Size = Vector3.new(1.2, 1.2, 1.2) * Scale
				Box.CFrame = Hand.CFrame
				Box.Parent = Character
				local Weld = Instance.new("WeldConstraint")
				Weld.Part0 = Hand
				Weld.Part1 = Box
				Weld.Parent = Box
				StealHitboxes[Side] = Box
			else
				Box.Size = Vector3.new(1.2, 1.2, 1.2) * Scale
				Box.CanCollide = false
				Box.Anchored = false
				Box.Massless = true
			end
		end
	end
end

local function RunAntiOob()
	if not Config.AntiOob then
		return
	end

	local Court = GetActiveCourt()
	local Root = GetRoot(LocalPlayer.Character)
	if not Court or not Root then
		return
	end

	local OobFolder = Court:FindFirstChild("OOB")
	if OobFolder then
		for _, Part in ipairs(OobFolder:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.CanCollide = false
				Part.CanTouch = false
			end
		end
	end

	local MinV, MaxV, Center = GetCourtSafeBounds(Court)
	if not MinV or not MaxV then
		return
	end

	local Pos = Root.Position
	local ClampedX = math.clamp(Pos.X, MinV.X, MaxV.X)
	local ClampedZ = math.clamp(Pos.Z, MinV.Z, MaxV.Z)
	if ClampedX ~= Pos.X or ClampedZ ~= Pos.Z then
		local Look = Root.CFrame - Root.Position
		Root.CFrame = CFrame.new(ClampedX, Pos.Y, ClampedZ) * Look
		local Vel = Root.AssemblyLinearVelocity
		local Push = Vector3.new(Center.X - ClampedX, 0, Center.Z - ClampedZ)
		if Push.Magnitude > 0.05 then
			Push = Push.Unit * math.min(Vel.Magnitude, 18)
		else
			Push = Vector3.new()
		end
		Root.AssemblyLinearVelocity = Vector3.new(Push.X, Vel.Y, Push.Z)
	end
end

local function RunAutoGuard()
	UpdateGuardHoldFromInput()
	GuardMoveDir = nil

	local Debug = {
		hold = Config.GuardHoldActive,
		auto = Config.AutoGuard,
		why = "ok",
		carrier = nil,
		dist = nil,
		flat = nil,
		inFront = false,
	}

	if not (Config.AutoGuard and Config.GuardHoldActive) then
		SetGuardState(false)
		Debug.why = "not-held"
		getgenv().EchoGuardDebug = Debug
		return
	end

	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Root = GetRoot(Character)
	if not Humanoid or not Root then
		Debug.why = "no-char"
		getgenv().EchoGuardDebug = Debug
		return
	end

	if HasBall() then
		SetGuardState(false)
		Debug.why = "has-ball"
		getgenv().EchoGuardDebug = Debug
		return
	end

	local MyCourt = GetEffectiveCourt()
	Debug.court = MyCourt and MyCourt.Name or "nil"
	local Carrier, CarrierRoot = FindBallCarrier()
	if not CarrierRoot then
		SetGuardState(false)
		Debug.why = "no-carrier"
		getgenv().EchoGuardDebug = Debug
		return
	end
	Debug.carrier = Carrier and Carrier.Name

	local Dist = (CarrierRoot.Position - Root.Position).Magnitude
	local Limit = math.min(Config.GuardDistance, MaxGuardDistance)
	local EngageRange = math.max(Limit + 22, 32)
	Debug.dist = math.floor(Dist * 10) / 10
	if Dist > EngageRange then
		SetGuardState(false)
		Debug.why = "too-far"
		getgenv().EchoGuardDebug = Debug
		return
	end

	local Velocity = CarrierRoot.AssemblyLinearVelocity
	local Predicted = CarrierRoot.Position + Velocity * Config.GuardPrediction
	Predicted = Vector3.new(Predicted.X, CarrierRoot.Position.Y, Predicted.Z)

	local Hoop = GetOffenseHoop(CarrierRoot)
	-- Prefer hoop on the carrier's court / effective court when park CourtData is nil
	if not Hoop and MyCourt then
		local Hoops = MyCourt:FindFirstChild("Hoops")
		if Hoops then
			local Best, BestDist = nil, math.huge
			for _, Desc in ipairs(Hoops:GetDescendants()) do
				if Desc:IsA("BasePart") and (Desc.Name:lower():find("rim") or Desc.Name == "GoalRoot") then
					local D = (Desc.Position - Predicted).Magnitude
					if D < BestDist then
						BestDist = D
						Best = Desc
					end
				end
			end
			Hoop = Best
		end
	end
	local FlatLook = Vector3.new(CarrierRoot.CFrame.LookVector.X, 0, CarrierRoot.CFrame.LookVector.Z)
	local ToHoop
	if Hoop then
		ToHoop = Vector3.new(Hoop.Position.X - Predicted.X, 0, Hoop.Position.Z - Predicted.Z)
	end
	if not ToHoop or ToHoop.Magnitude < 0.15 then
		ToHoop = FlatLook.Magnitude > 0.15 and FlatLook
			or Vector3.new(Root.Position.X - Predicted.X, 0, Root.Position.Z - Predicted.Z)
	end
	if ToHoop.Magnitude < 0.05 then
		SetGuardState(false)
		return
	end

	local FrontDist = math.clamp(Config.GuardDistance * 0.35, 2.6, 4.4)
	local GuardPos = Predicted + ToHoop.Unit * FrontDist
	GuardPos = Vector3.new(GuardPos.X, Root.Position.Y, GuardPos.Z)

	-- Only clamp to court bounds when officially assigned to that court
	local AssignedCourt = GetPlayerCourt(LocalPlayer)
	if AssignedCourt then
		local MinV, MaxV = GetCourtSafeBounds(AssignedCourt)
		if MinV and MaxV then
			GuardPos = Vector3.new(
				math.clamp(GuardPos.X, MinV.X, MaxV.X),
				GuardPos.Y,
				math.clamp(GuardPos.Z, MinV.Z, MaxV.Z)
			)
		end
	end

	local Flat = Vector3.new(GuardPos.X - Root.Position.X, 0, GuardPos.Z - Root.Position.Z)
	local FlatDist = Flat.Magnitude
	local ToCarrier = Vector3.new(Predicted.X - Root.Position.X, 0, Predicted.Z - Root.Position.Z)
	local FromCarrier = -ToCarrier
	-- True "in front" = on the hoop side of the ball handler, close enough to contest
	local Align = 0
	if ToHoop.Magnitude > 0.1 and FromCarrier.Magnitude > 0.1 then
		Align = FromCarrier.Unit:Dot(ToHoop.Unit)
	end
	Debug.align = math.floor(Align * 100) / 100
	local InFront = Dist <= Limit + 1.5 and Align >= 0.25 and FlatDist <= 2.8
	Debug.flat = math.floor(FlatDist * 10) / 10
	Debug.inFront = InFront

	if not InFront then
		-- Path first â€” guard stance roots you, so keep it off until in front
		SetGuardState(false)
		Humanoid.AutoRotate = true
		if FlatDist > 0.35 then
			-- Close to carrier but wrong angle: strafe around instead of walking through them
			if Dist <= Limit + 2.5 and ToCarrier.Magnitude > 0.2 then
				local Side = Vector3.new(-ToCarrier.Z, 0, ToCarrier.X)
				if Side.Magnitude > 0.1 then
					if Side:Dot(Flat) < 0 then
						Side = -Side
					end
					-- Blend orbit + close-the-gap so we slide into the front spot
					local Orbit = Side.Unit
					local Close = Flat.Unit
					GuardMoveDir = (Orbit * 0.8 + Close * 0.45).Unit
					Debug.why = "strafe"
				else
					GuardMoveDir = Flat.Unit
					Debug.why = "pathing"
				end
			else
				GuardMoveDir = Flat.Unit
				Debug.why = "pathing"
			end
		else
			Debug.why = "flat-small"
		end
	else
		GuardMoveDir = nil
		local FaceFlat = Vector3.new(Predicted.X - Root.Position.X, 0, Predicted.Z - Root.Position.Z)
		if FaceFlat.Magnitude > 0.1 then
			local Face = CFrame.lookAt(Root.Position, Root.Position + FaceFlat.Unit)
			Root.CFrame = CFrame.new(Root.Position) * (Face - Face.Position)
		end
		SetGuardState(true)
		Debug.why = "stance"
	end
	getgenv().EchoGuardDebug = Debug
end

local function RunAutoReach()
	if not Config.AutoReach or HasBall() then
		return
	end

	local Now = os.clock()
	if Now - ReachClock < 0.22 then
		return
	end

	local Character = LocalPlayer.Character
	local Root = GetRoot(Character)
	if not Root then
		return
	end

	-- Only reach real ball carriers — glitchy Workspace balls in error lobbies spam Reach.
	local Carrier, CarrierRoot = FindBallCarrier()
	if not CarrierRoot then
		return
	end

	local Velocity = CarrierRoot.AssemblyLinearVelocity
	local Predicted = CarrierRoot.Position + Velocity * 0.12
	local TargetPos = Predicted
	local TargetDist = (Predicted - Root.Position).Magnitude

	local Closing = false
	local ToMe = Root.Position - CarrierRoot.Position
	local RelVel = CarrierRoot.AssemblyLinearVelocity - Root.AssemblyLinearVelocity
	if ToMe.Magnitude > 0.05 and RelVel:Dot(ToMe.Unit) < -1 then
		Closing = true
	end

	local SmartRange = MaxReachDistance + (Closing and 1.25 or 0.35)
	if Config.StealReach then
		SmartRange += math.clamp((tonumber(Config.ReachMultiplier) or 2.5) * 0.35, 0, 2)
	end

	if TargetDist > SmartRange then
		return
	end

	local Flat = Vector3.new(TargetPos.X - Root.Position.X, 0, TargetPos.Z - Root.Position.Z)
	if Flat.Magnitude > 0.05 then
		Root.CFrame = CFrame.lookAt(Root.Position, Root.Position + Flat.Unit)
	end

	ReachClock = Now
	if InputFunctions and InputFunctions.Reach then
		InputFunctions:Reach()
	elseif ActionRemote then
		ActionRemote:FireServer("Reach")
	end
end

local function RunAutoBlock()
	if not Config.AutoBlock or HasBall() then
		return
	end

	local Now = os.clock()
	-- Hard cooldown — sticky Shooting/Dunking attrs in error lobbies spam Block every frame.
	if Now - BlockClock < 0.55 then
		return
	end

	local Root = GetRoot(LocalPlayer.Character)
	if not Root then
		return
	end

	local Range = math.min(Config.BlockDistance, MaxBlockDistance)

	for _, Player in ipairs(Players:GetPlayers()) do
		if not IsOnDifferentTeam(Player) or not Player.Character then
			continue
		end

		local Shooting = Player:GetAttribute("Shooting") == true
		local Dunking = Player:GetAttribute("Dunking") == true
		local SessionKey = tostring(Player.UserId)

		if not Shooting and not Dunking then
			BlockedShotSessions[SessionKey] = nil
			continue
		end

		-- Already contested this shot / dunk attempt
		if BlockedShotSessions[SessionKey] then
			continue
		end

		local TheirRoot = GetRoot(Player.Character)
		if not TheirRoot then
			continue
		end

		if (TheirRoot.Position - Root.Position).Magnitude > Range then
			continue
		end

		BlockedShotSessions[SessionKey] = true
		BlockClock = Now

		if InputFunctions and InputFunctions.Block then
			InputFunctions:Block()
		elseif ActionRemote then
			ActionRemote:FireServer("Block")
		end
		return
	end
end

local function RunBallMagnet()
	if not Config.BallMagnet or HasBall() then
		return
	end
	if typeof(firetouchinterest) ~= "function" then
		return
	end
	local Root = GetRoot(LocalPlayer.Character)
	local Ball = FindLooseBall()
	if not Root or not Ball then
		return
	end
	if (Ball.Position - Root.Position).Magnitude <= Config.MagnetDistance then
		pcall(firetouchinterest, Root, Ball, 0)
		pcall(firetouchinterest, Root, Ball, 1)
	end
end

local function RunReboundTp()
	if not Config.ReboundTp or HasBall() then
		return
	end
	local Root = GetRoot(LocalPlayer.Character)
	local Ball = FindLooseBall()
	if not Root or not Ball then
		return
	end
	Root.CFrame = CFrame.new(Ball.Position + Ball.CFrame.LookVector * Config.ReboundOffset)
end

local function RunFollowCarrier()
	if not Config.FollowCarrier or HasBall() then
		return
	end
	local Root = GetRoot(LocalPlayer.Character)
	local _, CarrierRoot = FindBallCarrier()
	if not Root or not CarrierRoot then
		return
	end
	Root.CFrame = CarrierRoot.CFrame * CFrame.new(0, 0, Config.FollowOffset)
end

local function RunSpeedBoost(Dt)
	if not Config.SpeedBoost then
		return
	end
	local Character = LocalPlayer.Character
	local Root = GetRoot(Character)
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Root or not Humanoid then
		return
	end
	local Move = Humanoid.MoveDirection
	if Move.Magnitude <= 0 then
		return
	end
	local Extra = math.max((tonumber(Config.SpeedAmount) or SprintSpeed) - Humanoid.WalkSpeed, 0)
	if Extra > 0 then
		Root.CFrame = Root.CFrame + Move.Unit * Extra * Dt
	end
end

local function RunInfiniteStamina()
	if not Config.InfiniteStamina then
		return
	end
	local Stamina = GetStamina()
	if Stamina then
		Stamina.Value = 100
	end
end

local function GetNearestCourt()
	local Courts = Workspace:FindFirstChild("Courts")
	local Root = GetRoot(LocalPlayer.Character)
	if not Courts or not Root then
		return nil
	end
	local Best, BestDist = nil, math.huge
	for _, Court in ipairs(Courts:GetChildren()) do
		local Pivot = Court:FindFirstChild("Pads") or Court:FindFirstChild("Spots") or Court
		local Part = Pivot:IsA("BasePart") and Pivot or Pivot:FindFirstChildWhichIsA("BasePart", true)
		if Part then
			local Dist = (Part.Position - Root.Position).Magnitude
			if Dist < BestDist then
				BestDist = Dist
				Best = Part
			end
		end
	end
	return Best
end

local function GetNearestHoop()
	local Courts = Workspace:FindFirstChild("Courts")
	local Root = GetRoot(LocalPlayer.Character)
	if not Courts or not Root then
		return nil
	end
	local Best, BestDist = nil, math.huge
	for _, Court in ipairs(Courts:GetChildren()) do
		local Hoops = Court:FindFirstChild("Hoops")
		if Hoops then
			for _, Desc in ipairs(Hoops:GetDescendants()) do
				if Desc:IsA("BasePart") and (Desc.Name:lower():find("rim") or Desc.Name:lower():find("hoop") or Desc.Name:lower():find("basket")) then
					local Dist = (Desc.Position - Root.Position).Magnitude
					if Dist < BestDist then
						BestDist = Dist
						Best = Desc
					end
				end
			end
			if not Best then
				local Part = Hoops:FindFirstChildWhichIsA("BasePart", true)
				if Part then
					local Dist = (Part.Position - Root.Position).Magnitude
					if Dist < BestDist then
						BestDist = Dist
						Best = Part
					end
				end
			end
		end
	end
	return Best
end

local function SoftTeleport(Part)
	local Root = GetRoot(LocalPlayer.Character)
	if not Root or not Part then
		return
	end
	Root.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
end

GreenSection:Toggle({
	Name = "Enabled",
	Flag = "AutoGreen",
	Default = Config.AutoGreen,
	Callback = function(Value)
		Config.AutoGreen = Value
		if Value then
			InstallHooks()
		end
	end,
})

GreenSection:Dropdown({
	Name = "Quality",
	Flag = "GreenMode",
	Items = { "Perfect", "Great", "Good", "Okay", "Custom", "Random" },
	Default = Config.GreenMode,
	Callback = function(Value)
		Config.GreenMode = Value
	end,
})

GreenSection:Toggle({
	Name = "Randomize Quality",
	Flag = "RandomizeGreen",
	Default = Config.RandomizeGreen,
	Callback = function(Value)
		Config.RandomizeGreen = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Custom Release %",
	Flag = "GreenPercent",
	Min = 70,
	Max = 100,
	Default = Config.GreenPercent,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.GreenPercent = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Perfect Chance",
	Flag = "PerfectChance",
	Min = 0,
	Max = 100,
	Default = Config.PerfectChance,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.PerfectChance = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Great Chance",
	Flag = "GreatChance",
	Min = 0,
	Max = 100,
	Default = Config.GreatChance,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.GreatChance = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Good Chance",
	Flag = "GoodChance",
	Min = 0,
	Max = 100,
	Default = Config.GoodChance,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.GoodChance = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Timing Offset",
	Flag = "GreenDelayOffset",
	Min = -0.08,
	Max = 0.08,
	Default = Config.GreenDelayOffset,
	Decimals = 0.001,
	Suffix = "s",
	Callback = function(Value)
		Config.GreenDelayOffset = Value
	end,
})

DunkSection:Toggle({
	Name = "Enabled",
	Flag = "AutoDunkGreen",
	Default = Config.AutoDunkGreen,
	Callback = function(Value)
		Config.AutoDunkGreen = Value
		if Value then
			InstallHooks()
		end
	end,
})

DunkSection:Dropdown({
	Name = "Quality",
	Flag = "DunkMode",
	Items = { "Perfect", "Great", "Good", "Custom", "Random" },
	Default = Config.DunkMode,
	Callback = function(Value)
		Config.DunkMode = Value
	end,
})

DunkSection:Slider({
	Name = "Custom Release %",
	Flag = "DunkPercent",
	Min = 70,
	Max = 100,
	Default = Config.DunkPercent,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.DunkPercent = Value
	end,
})

BallSection:Toggle({
	Name = "Ball Magnet",
	Flag = "BallMagnet",
	Default = Config.BallMagnet,
	Callback = function(Value)
		Config.BallMagnet = Value
	end,
})

BallSection:Slider({
	Name = "Magnet Distance",
	Flag = "MagnetDistance",
	Min = 5,
	Max = 85,
	Default = Config.MagnetDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.MagnetDistance = Value
	end,
})

BallSection:Toggle({
	Name = "Rebound TP",
	Flag = "ReboundTp",
	Default = Config.ReboundTp,
	Callback = function(Value)
		Config.ReboundTp = Value
	end,
})

BallSection:Slider({
	Name = "Rebound Offset",
	Flag = "ReboundOffset",
	Min = 0,
	Max = 6,
	Default = Config.ReboundOffset,
	Decimals = 1,
	Callback = function(Value)
		Config.ReboundOffset = Value
	end,
})

BallSection:Toggle({
	Name = "Follow Carrier",
	Flag = "FollowCarrier",
	Default = Config.FollowCarrier,
	Callback = function(Value)
		Config.FollowCarrier = Value
	end,
})

BallSection:Slider({
	Name = "Follow Offset",
	Flag = "FollowOffset",
	Min = -12,
	Max = 12,
	Default = Config.FollowOffset,
	Decimals = 1,
	Callback = function(Value)
		Config.FollowOffset = Value
	end,
})

GuardSection:Toggle({
	Name = "Enabled",
	Flag = "AutoGuard",
	Default = Config.AutoGuard,
	Callback = function(Value)
		Config.AutoGuard = Value
		if not Value then
			Config.GuardHoldActive = false
			Config.GuardUiToggle = false
			SetGuardState(false)
		else
			InstallHooks()
		end
	end,
})

GuardSection:Dropdown({
	Name = "Hold Key",
	Flag = "GuardKeyName",
	Items = { "G", "Q", "F", "V", "C", "LeftControl", "LeftAlt", "ButtonL2" },
	Default = "G",
	Callback = function(Value)
		local Map = {
			G = Enum.KeyCode.G,
			Q = Enum.KeyCode.Q,
			F = Enum.KeyCode.F,
			V = Enum.KeyCode.V,
			C = Enum.KeyCode.C,
			LeftControl = Enum.KeyCode.LeftControl,
			LeftAlt = Enum.KeyCode.LeftAlt,
			ButtonL2 = Enum.KeyCode.ButtonL2,
		}
		Config.GuardKey = Map[Value] or Enum.KeyCode.G
	end,
})

GuardSection:Slider({
	Name = "Distance",
	Flag = "GuardDistance",
	Min = 4,
	Max = 20,
	Default = Config.GuardDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.GuardDistance = Value
	end,
})

GuardSection:Slider({
	Name = "Prediction",
	Flag = "GuardPrediction",
	Min = 0,
	Max = 0.8,
	Default = Config.GuardPrediction,
	Decimals = 0.01,
	Suffix = "s",
	Callback = function(Value)
		Config.GuardPrediction = Value
	end,
})

DefenseToolsSection:Toggle({
	Name = "Auto Reach",
	Flag = "AutoReach",
	Default = Config.AutoReach,
	Callback = function(Value)
		Config.AutoReach = Value
	end,
})

DefenseToolsSection:Toggle({
	Name = "Auto Block",
	Flag = "AutoBlock",
	Default = Config.AutoBlock,
	Callback = function(Value)
		Config.AutoBlock = Value
	end,
})

DefenseToolsSection:Slider({
	Name = "Block Distance",
	Flag = "BlockDistance",
	Min = 5,
	Max = 20,
	Default = Config.BlockDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.BlockDistance = Value
	end,
})

DefenseToolsSection:Toggle({
	Name = "Steal Reach",
	Flag = "StealReach",
	Default = Config.StealReach,
	Callback = function(Value)
		Config.StealReach = Value
		UpdateStealReach()
	end,
})

DefenseToolsSection:Slider({
	Name = "Steal Size",
	Flag = "ReachMultiplier",
	Min = 1,
	Max = 12,
	Default = Config.ReachMultiplier,
	Decimals = 0.1,
	Suffix = "x",
	Callback = function(Value)
		Config.ReachMultiplier = Value
		if Config.StealReach then
			UpdateStealReach()
		end
	end,
})

MovementSection:Toggle({
	Name = "Speed Boost",
	Flag = "SpeedBoost",
	Default = Config.SpeedBoost,
	Callback = function(Value)
		Config.SpeedBoost = Value
	end,
})

MovementSection:Slider({
	Name = "Speed",
	Flag = "SpeedAmount",
	Min = 14,
	Max = 30,
	Default = Config.SpeedAmount,
	Decimals = 0.1,
	Callback = function(Value)
		Config.SpeedAmount = Value
	end,
})

MovementSection:Toggle({
	Name = "Anti Out Of Bounds",
	Flag = "AntiOob",
	Default = Config.AntiOob,
	Callback = function(Value)
		Config.AntiOob = Value
		CachedCourtBounds = nil
		CachedCourtRef = nil
	end,
})

StaminaSection:Toggle({
	Name = "Infinite Stamina",
	Flag = "InfiniteStamina",
	Default = Config.InfiniteStamina,
	Callback = function(Value)
		Config.InfiniteStamina = Value
	end,
})

EspSection:Toggle({
	Name = "Ball Carrier ESP",
	Flag = "CarrierEsp",
	Default = Config.CarrierEsp,
	Callback = function(Value)
		Config.CarrierEsp = Value
		if not Value then
			ClearHighlightTable(CarrierHighlights)
		end
	end,
})

EspSection:Toggle({
	Name = "Opponent ESP",
	Flag = "OpponentEsp",
	Default = Config.OpponentEsp,
	Callback = function(Value)
		Config.OpponentEsp = Value
		if not Value then
			ClearHighlightTable(OpponentHighlights)
		end
	end,
})

EspStyleSection:Slider({
	Name = "Fill Transparency",
	Flag = "EspFillTransparency",
	Min = 0,
	Max = 1,
	Default = Config.EspFillTransparency,
	Decimals = 0.01,
	Callback = function(Value)
		Config.EspFillTransparency = Value
	end,
})

EspStyleSection:Slider({
	Name = "Outline Transparency",
	Flag = "EspOutlineTransparency",
	Min = 0,
	Max = 1,
	Default = Config.EspOutlineTransparency,
	Decimals = 0.01,
	Callback = function(Value)
		Config.EspOutlineTransparency = Value
	end,
})

do
	local TeleButtons = TeleSection:Button()
	TeleButtons:Add("TP Nearest Court", function()
		local Court = GetNearestCourt()
		if Court then
			SoftTeleport(Court)
			Library:Notification("Teleport", "Moved to nearest court", 3)
		else
			Library:Notification("Teleport", "No court found", 3)
		end
	end)
	TeleButtons:Add("TP Nearest Hoop", function()
		local Hoop = GetNearestHoop()
		if Hoop then
			SoftTeleport(Hoop)
			Library:Notification("Teleport", "Moved to nearest hoop", 3)
		else
			Library:Notification("Teleport", "No hoop found", 3)
		end
	end)
end

do
	local ServerButtons = ServerSection:Button()
	ServerButtons:Add("Rejoin", function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	end)
	ServerButtons:Add("Server Hop", function()
		local Servers = {}
		local Cursor = ""
		repeat
			local Ok, Result = pcall(function()
				return game:HttpGet(
					"https://games.roblox.com/v1/games/"
						.. game.PlaceId
						.. "/servers/Public?sortOrder=Asc&limit=100&cursor="
						.. Cursor
				)
			end)
			if not Ok then
				break
			end
			local Decoded = HttpService:JSONDecode(Result)
			Cursor = Decoded.nextPageCursor or ""
			for _, Server in ipairs(Decoded.data or {}) do
				if Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
					Servers[#Servers + 1] = Server
				end
			end
		until Cursor == ""
		if #Servers == 0 then
			Library:Notification("Server", "No servers found", 3)
			return
		end
		table.sort(Servers, function(A, B)
			return A.playing < B.playing
		end)
		TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[1].id, LocalPlayer)
	end)
end

if UserInputService.TouchEnabled then
	MobileGui = Instance.new("ScreenGui")
	MobileGui.Name = "EchoClutchMobile"
	MobileGui.ResetOnSpawn = false
	MobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)

	StatusLabel = Instance.new("TextLabel")
	StatusLabel.Size = UDim2.new(0, 170, 0, 28)
	StatusLabel.Position = UDim2.new(0.5, -85, 0.11, 0)
	StatusLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	StatusLabel.BackgroundTransparency = 0.25
	StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.TextSize = 12
	StatusLabel.Text = "Auto Green: OFF"
	StatusLabel.Parent = MobileGui
	Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 6)

	local GuardBtn = Instance.new("TextButton")
	GuardBtn.Size = UDim2.new(0, 120, 0, 36)
	GuardBtn.Position = UDim2.new(0.5, -60, 0.86, 0)
	GuardBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	GuardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	GuardBtn.Text = "Guard: OFF"
	GuardBtn.Font = Enum.Font.GothamBold
	GuardBtn.TextSize = 12
	GuardBtn.Parent = MobileGui
	Instance.new("UICorner", GuardBtn).CornerRadius = UDim.new(0, 6)

	GuardBtn.Activated:Connect(function()
		if not Config.AutoGuard then
			GuardBtn.Text = "Enable first"
			task.delay(1, function()
				if GuardBtn.Parent then
					GuardBtn.Text = "Guard: OFF"
				end
			end)
			return
		end
		Config.GuardUiToggle = not Config.GuardUiToggle
		Config.GuardHoldActive = Config.GuardUiToggle or IsGuardKeyHeld()
		GuardBtn.Text = Config.GuardUiToggle and "Guard: ON" or "Guard: OFF"
		GuardBtn.BackgroundColor3 = Config.GuardUiToggle and Color3.fromRGB(0, 150, 50) or Color3.fromRGB(40, 40, 40)
		if not Config.GuardHoldActive then
			SetGuardState(false)
		end
	end)
end

task.spawn(function()
	for _ = 1, 30 do
		if InstallHooks() then
			break
		end
		task.wait(0.4)
	end
end)

TrackConnection(LocalPlayer:GetAttributeChangedSignal("Shooting"), function()
	if not LocalPlayer:GetAttribute("Shooting") then
		ShotActive = false
		if Config.AutoGreen or Config.AutoDunkGreen then
			task.defer(HideMeters)
			task.delay(0.15, HideMeters)
		end
	end
end)

TrackConnection(LocalPlayer:GetAttributeChangedSignal("Dunking"), function()
	if not LocalPlayer:GetAttribute("Dunking") then
		DunkActive = false
		if Config.AutoDunkGreen then
			task.defer(HideMeters)
			task.delay(0.15, HideMeters)
		end
	end
end)

TrackConnection(LocalPlayer:GetAttributeChangedSignal("Green"), function()
	if LocalPlayer:GetAttribute("Green") and (Config.AutoGreen or Config.AutoDunkGreen) then
		task.delay(0.35, HideMeters)
	end
end)

local function IsGuardKey(KeyCode)
	return KeyCode == Config.GuardKey
end

TrackConnection(UserInputService.InputBegan, function(Input, GameProcessed)
	-- Guard key is also used by the game (GameProcessed); still latch hold
	if Config.AutoGuard and IsGuardKey(Input.KeyCode) then
		Config.GuardHoldActive = true
		return
	end
	if GameProcessed then
		return
	end
end)

TrackConnection(UserInputService.InputEnded, function(Input)
	if IsGuardKey(Input.KeyCode) then
		-- Keep hold if the UI/mobile latch is still on
		Config.GuardHoldActive = Config.GuardUiToggle
		if not Config.GuardHoldActive then
			SetGuardState(false)
			local Character = LocalPlayer.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local Root = GetRoot(Character)
			StopGuardMovement(Humanoid, Root)
		end
	end
end)

TrackConnection(RunService.RenderStepped, function(Dt)
	pcall(RunSpeedBoost, Dt)
	pcall(UpdateStealReach)
end)

-- Apply guard pathing AFTER the default control module so our walk direction
-- wins (a Heartbeat/RenderStepped Move gets overwritten by the control script).
local GuardBindName = "EchoGuardMove"
pcall(function()
	pcall(function()
		RunService:UnbindFromRenderStep(GuardBindName)
	end)
	-- Character+1 beats PlayerModule (verified live). Only call Move when we
	-- actually have a path direction â€” a stuck zero vector would root you.
	RunService:BindToRenderStep(GuardBindName, Enum.RenderPriority.Character.Value + 1, function()
		local Dir = GuardMoveDir
		if typeof(Dir) ~= "Vector3" or Dir.Magnitude < 0.05 then
			return
		end
		if not (Config.AutoGuard and Config.GuardHoldActive) then
			return
		end
		local Character = LocalPlayer.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid:Move(Dir.Unit, false)
		end
	end)
end)

TrackConnection(RunService.Heartbeat, function()
	pcall(RunInfiniteStamina)
	pcall(RunAntiOob)
	pcall(RunAutoGuard)
	pcall(RunAutoReach)
	pcall(RunAutoBlock)
	pcall(RunBallMagnet)
	pcall(RunReboundTp)
	pcall(RunFollowCarrier)
	pcall(UpdateEsp)

	if StatusLabel and StatusLabel.Parent then
		if Config.AutoGreen or Config.AutoDunkGreen then
			StatusLabel.Text = "Auto Green: ON"
			StatusLabel.TextColor3 = Color3.fromRGB(90, 255, 130)
		else
			StatusLabel.Text = "Auto Green: OFF"
			StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		end
	end
end)

getgenv().EchoCleanup = function()
	Config.AutoGreen = false
	Config.AutoDunkGreen = false
	Config.AutoGuard = false
	Config.GuardHoldActive = false
	Config.GuardUiToggle = false
	Config.SpeedBoost = false
	Config.BallMagnet = false
	Config.ReboundTp = false
	Config.FollowCarrier = false
	Config.StealReach = false
	Config.AntiOob = false
	Config.CarrierEsp = false
	Config.OpponentEsp = false
	Config.InfiniteStamina = false

	table.clear(BlockedShotSessions)
	BlockClock = 0
	ReachClock = 0

	GuardMoveDir = nil
	pcall(function()
		RunService:UnbindFromRenderStep(GuardBindName)
	end)

	UninstallHooks()
	ClearStealHitboxes()
	UpdateStealReach()
	ClearHighlightTable(CarrierHighlights)
	ClearHighlightTable(OpponentHighlights)
	if EspFolder then
		pcall(function()
			EspFolder:Destroy()
		end)
		EspFolder = nil
	end
	if MobileGui then
		pcall(function()
			MobileGui:Destroy()
		end)
		MobileGui = nil
	end

	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)

	pcall(function()
		if Library and Library.Unload then
			Library:Unload()
		end
	end)
	pcall(function()
		EchoUiContainer:Destroy()
	end)

	if getgenv().Library == Library then
		getgenv().Library = nil
	end
	getgenv().EchoConfig = nil
end

getgenv().EchoConfig = Config

Library:Notification(
	"Echo",
	string.format("Clutch loaded in %.2fs Â· meter %.2fs Â· dunk %.2fs", os.clock() - LoadTick, MeterTime, DunkTime),
	5
)
]====], "Echo_Clutch_Basketball")
	if not EchoChunk then
		error("[Echo] Clutch Basketball compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsBasketballLegends() then
-- Echo Hub: Basketball Legends
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

getgenv().gethui = function()
	return EchoUiContainer
end

local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoScootUI then
		return getgenv().__EchoScootUI
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/saintsrevival1/eee/refs/heads/main/UI-Source.lua"))()
	getgenv().__EchoScootUI = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
	return
end

local Library = LibraryOrErr
getgenv().Library = Library

pcall(function()
	Library.Round = function(_, Number, Float)
		if typeof(Number) ~= "number" or Number ~= Number then
			return 0
		end
		if typeof(Float) ~= "number" or Float ~= Float or Float == 0 then
			Float = 1
		end
		local Multiplier = 1 / Float
		return math.floor(Number * Multiplier + 1e-9) / Multiplier
	end
end)

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local Config = {
	AutoGreen = false,
	ShootPower = 0.8,

	AutoGuard = false,
	GuardHoldActive = false,
	GuardDistance = 10,
	GuardPrediction = 0.3,

	ReboundSteal = false,
	ReboundOffset = 0,

	PostAimbot = false,
	PostHoldActive = false,
	PostDistance = 10,

	StealReach = false,
	ReachMultiplier = 1.5,

	BallMagnet = false,
	MagnetDistance = 30,

	FollowCarrier = false,
	FollowOffset = -10,

	SpeedBoost = false,
	SpeedAmount = 16,

	ShowBodyGyro = false,

	AnimSpoof = false,
	DunkAnim = "Default",
	EmoteAnim = "Dance_Casual",

	TelePlace = "Loading...",
}

local Connections = {}
local EchoUiRoots = {}
local ShootRemote = nil
local ShootingElement = nil
local VisibleConn = nil
local AutoGuardConn = nil
local PostAimbotConn = nil
local SpeedBoostCleanup = nil
local FollowConn = nil
local DunkSpoofConn = nil
local EmoteSpoofConn = nil
local CharAddedDunk = nil
local CharAddedEmote = nil
local MobileGui = nil
local LastPositions = {}
local LastPostUpdate = 0
local OriginalRightArmSize = nil
local OriginalLeftArmSize = nil
local AnimationsFolder = nil
local PlacesList = {}
local PlaceNames = {}
local TeleDropdown = nil

local EmoteAnimations = {
	Default = "Dance_Casual",
	Dance_Sturdy = "Dance_Sturdy",
	Dance_Taunt = "Dance_Taunt",
	Dance_TakeFlight = "Dance_TakeFlight",
	Dance_Flex = "Dance_Flex",
	Dance_Bat = "Dance_Bat",
	Dance_Twist = "Dance_Twist",
	Dance_Griddy = "Dance_Griddy",
	Dance_Dab = "Dance_Dab",
	Dance_Drake = "Dance_Drake",
	Dance_Fresh = "Dance_Fresh",
	Dance_Hype = "Dance_Hype",
	Dance_Spongebob = "Dance_Spongebob",
	Dance_Backflip = "Dance_Backflip",
	Dance_L = "Dance_L",
	Dance_Facepalm = "Dance_Facepalm",
	Dance_Bow = "Dance_Bow",
}

local EmoteKeys = {}
for Key in pairs(EmoteAnimations) do
	EmoteKeys[#EmoteKeys + 1] = Key
end
table.sort(EmoteKeys)

local DunkItems = {
	"Default",
	"Testing",
	"Testing2",
	"Reverse",
	"360",
	"Testing3",
	"Tomahawk",
	"Windmill",
}

pcall(function()
	ShootRemote = ReplicatedStorage.Packages.Knit.Services.ControlService.RE.Shoot
end)

pcall(function()
	local VisualGui = LocalPlayer.PlayerGui:WaitForChild("Visual", 5)
	if VisualGui then
		ShootingElement = VisualGui:WaitForChild("Shooting", 5)
	end
end)

pcall(function()
	AnimationsFolder = ReplicatedStorage:WaitForChild("Assets", 5):WaitForChild("Animations_R15", 5)
end)

local function IsPark()
	local GameFolder = Workspace:FindFirstChild("Game")
	return GameFolder and GameFolder:FindFirstChild("Courts") ~= nil
end

local IsParkGame = IsPark()

local Window = Library:Window({
	Logo = "72316209028225",
	FadeTime = 0.3,
})

EchoUiRoots[#EchoUiRoots + 1] = EchoUiContainer

local Watermark = Library:Watermark("Echo | Basketball Legends")
local KeybindList = Library:KeybindList()

local MainPage = Window:Page({ Name = "Main", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
local MiscPage = Window:Page({ Name = "Misc", Columns = 2 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local ShootSection = MainPage:Section({ Name = "Auto Green", Side = 1 })
local ShootSettingsSection = MainPage:Section({ Name = "Shoot Settings", Side = 2 })
local GuardSection = MainPage:Section({ Name = "Auto Guard", Side = 1 })
local GuardSettingsSection = MainPage:Section({ Name = "Guard Settings", Side = 2 })
local ReboundSection = MainPage:Section({ Name = "Rebound / Steal", Side = 1 })
local PostSection = MainPage:Section({ Name = "Post Aimbot", Side = 1 })
local ReachSection = MainPage:Section({ Name = "Steal Reach", Side = 2 })
local MagnetSection = MainPage:Section({ Name = "Ball Magnet", Side = 2 })
local FollowSection = MainPage:Section({ Name = "Follow Carrier", Side = 2 })

local SpeedSection = PlayerPage:Section({ Name = "Speed Boost", Side = 1 })

local VisualSection = MiscPage:Section({ Name = "Visuals", Side = 1 })
local AnimSection = MiscPage:Section({ Name = "Animations", Side = 1 })
local TeleSection = MiscPage:Section({ Name = "Teleport", Side = 2 })

-- // Utilities
local function TrackConnection(Signal, Callback)
	local Connection = Signal:Connect(Callback)
	Connections[#Connections + 1] = Connection
	return Connection
end

local function GetPlayerFromModel(Model)
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player.Character == Model then
			return Player
		end
	end
	return nil
end

local function IsOnDifferentTeam(OtherModel)
	local OtherPlayer = GetPlayerFromModel(OtherModel)
	if not OtherPlayer then
		return false
	end
	if not LocalPlayer.Team or not OtherPlayer.Team then
		return OtherPlayer ~= LocalPlayer
	end
	return LocalPlayer.Team ~= OtherPlayer.Team
end

local function FindPlayerWithBall()
	local Character = LocalPlayer.Character
	local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then
		return nil, nil
	end

	if IsParkGame then
		local ClosestPlayer, ClosestDistance = nil, math.huge
		for _, Model in ipairs(Workspace:GetChildren()) do
			if Model:IsA("Model") and Model ~= Character and Model:FindFirstChild("HumanoidRootPart") then
				local Tool = Model:FindFirstChild("Basketball")
				if Tool and Tool:IsA("Tool") then
					local Dist = (Model.HumanoidRootPart.Position - MyRoot.Position).Magnitude
					if Dist < ClosestDistance then
						ClosestDistance = Dist
						ClosestPlayer = Model
					end
				end
			end
		end
		if ClosestPlayer then
			return ClosestPlayer, ClosestPlayer.HumanoidRootPart
		end
		return nil, nil
	end

	local LooseBall = Workspace:FindFirstChild("Basketball")
	if LooseBall and LooseBall:IsA("BasePart") then
		local ClosestPlayer, ClosestDistance = nil, math.huge
		for _, Model in ipairs(Workspace:GetChildren()) do
			if Model:IsA("Model") and Model ~= Character and Model:FindFirstChild("HumanoidRootPart") then
				if IsOnDifferentTeam(Model) then
					local Dist = (LooseBall.Position - Model.HumanoidRootPart.Position).Magnitude
					if Dist < ClosestDistance and Dist < 15 then
						ClosestDistance = Dist
						ClosestPlayer = Model
					end
				end
			end
		end
		if ClosestPlayer then
			return ClosestPlayer, ClosestPlayer.HumanoidRootPart
		end
	end

	for _, Model in ipairs(Workspace:GetChildren()) do
		if Model:IsA("Model") and Model ~= Character and Model:FindFirstChild("HumanoidRootPart") then
			if IsOnDifferentTeam(Model) and Model:FindFirstChild("Basketball") then
				return Model, Model.HumanoidRootPart
			end
		end
	end

	return nil, nil
end

local function GetClosestOpponent()
	local Character = LocalPlayer.Character
	local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then
		return nil
	end

	local Closest, MinDist = nil, Config.PostDistance
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
			if IsOnDifferentTeam(Player.Character) then
				local Dist = (Player.Character.HumanoidRootPart.Position - MyRoot.Position).Magnitude
				if Dist < MinDist then
					Closest = Player.Character.HumanoidRootPart
					MinDist = Dist
				end
			end
		end
	end
	return Closest
end

local function PlayerHasBall()
	local Character = LocalPlayer.Character
	if not Character then
		return false
	end
	local Tool = Character:FindFirstChild("Basketball")
	return Tool and Tool:IsA("Tool")
end

local function DetectBallHand()
	local Character = LocalPlayer.Character
	if not Character then
		return "right"
	end
	local Tool = Character:FindFirstChild("Basketball")
	if Tool and Tool:IsA("Tool") then
		local Handle = Tool:FindFirstChild("Handle")
		local Root = Character:FindFirstChild("HumanoidRootPart")
		if Handle and Root then
			local Rel = Root.CFrame:ToObjectSpace(Handle.CFrame)
			return Rel.X > 0 and "right" or "left"
		end
	end
	return "right"
end

local function ReleaseGuardKey()
	pcall(function()
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
	end)
end

local function BindAutoGreen()
	if VisibleConn then
		VisibleConn:Disconnect()
		VisibleConn = nil
	end
	if not Config.AutoGreen or not ShootingElement then
		return
	end
	VisibleConn = ShootingElement:GetPropertyChangedSignal("Visible"):Connect(function()
		if Config.AutoGreen and ShootingElement.Visible == true then
			task.wait(0.25)
			if ShootRemote then
				pcall(function()
					ShootRemote:FireServer(Config.ShootPower)
				end)
			end
		end
	end)
	Connections[#Connections + 1] = VisibleConn
end

local function ExecutePostAimbot()
	local Now = tick()
	if Now - LastPostUpdate < 0.033 then
		return
	end
	LastPostUpdate = Now
	if not Config.PostHoldActive then
		return
	end

	local Character = LocalPlayer.Character
	local MyRoot = Character and Character:FindFirstChild("HumanoidRootPart")
	if not MyRoot then
		return
	end

	local Target = GetClosestOpponent()
	if not Target then
		return
	end

	local Dir = (Target.Position - MyRoot.Position)
	if Dir.Magnitude < 0.05 then
		return
	end
	local Face = CFrame.new(MyRoot.Position, MyRoot.Position + Dir.Unit)
	if PlayerHasBall() then
		local Hand = DetectBallHand()
		MyRoot.CFrame = Face * CFrame.Angles(0, math.rad(Hand == "left" and 90 or -90), 0)
	else
		MyRoot.CFrame = Face
	end
end

local function RunAutoGuard()
	if not Config.GuardHoldActive then
		return
	end
	if LocalPlayer:FindFirstChild("Basketball") then
		return
	end

	local Character = LocalPlayer.Character
	if not Character then
		return
	end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Root = Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not Root then
		return
	end

	local BallCarrier, BallCarrierRoot = FindPlayerWithBall()
	if BallCarrier and BallCarrierRoot then
		local Distance = (Root.Position - BallCarrierRoot.Position).Magnitude
		local CurrentPos = BallCarrierRoot.Position
		local Velocity = Vector3.new()
		if LastPositions[BallCarrier] then
			Velocity = (CurrentPos - LastPositions[BallCarrier]) / 0.016
		end
		LastPositions[BallCarrier] = CurrentPos

		local PredictedPos = CurrentPos + (Velocity * Config.GuardPrediction * 60)
		local Dir = (PredictedPos - Root.Position)
		if Dir.Magnitude < 0.05 then
			return
		end
		local Unit = Dir.Unit
		local DefPos = Vector3.new((PredictedPos - Unit * 5).X, Root.Position.Y, (PredictedPos - Unit * 5).Z)

		if Distance <= Config.GuardDistance then
			Humanoid:MoveTo(DefPos)
			if Distance <= 10 then
				VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
			else
				ReleaseGuardKey()
			end
		else
			ReleaseGuardKey()
		end
	else
		ReleaseGuardKey()
	end
end

local function StartCFrameSpeed(Speed)
	local Conn
	Conn = RunService.RenderStepped:Connect(function(Dt)
		if not Config.SpeedBoost then
			return
		end
		local Character = LocalPlayer.Character
		if not Character then
			return
		end
		local Root = Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Root or not Humanoid then
			return
		end
		local Move = Humanoid.MoveDirection
		if Move.Magnitude > 0 then
			Root.CFrame = Root.CFrame + (Move.Unit * math.max(Speed - Humanoid.WalkSpeed, 0) * Dt)
		end
	end)
	Connections[#Connections + 1] = Conn
	return function()
		if Conn then
			Conn:Disconnect()
		end
	end
end

local function UpdateHitboxSizes()
	local Character = LocalPlayer.Character
	if not Character then
		return
	end

	local RightArm = Character:FindFirstChild("Right Arm")
		or Character:FindFirstChild("RightHand")
		or Character:FindFirstChild("RightLowerArm")
	local LeftArm = Character:FindFirstChild("Left Arm")
		or Character:FindFirstChild("LeftHand")
		or Character:FindFirstChild("LeftLowerArm")

	if Config.StealReach then
		if RightArm then
			if not OriginalRightArmSize then
				OriginalRightArmSize = RightArm.Size
			end
			RightArm.Size = OriginalRightArmSize * Config.ReachMultiplier
			RightArm.Transparency = 1
			RightArm.CanCollide = false
			RightArm.Massless = true
		end
		if LeftArm then
			if not OriginalLeftArmSize then
				OriginalLeftArmSize = LeftArm.Size
			end
			LeftArm.Size = OriginalLeftArmSize * Config.ReachMultiplier
			LeftArm.Transparency = 1
			LeftArm.CanCollide = false
			LeftArm.Massless = true
		end
	else
		if RightArm and OriginalRightArmSize then
			RightArm.Size = OriginalRightArmSize
			RightArm.Transparency = 0
			RightArm.Massless = false
			OriginalRightArmSize = nil
		end
		if LeftArm and OriginalLeftArmSize then
			LeftArm.Size = OriginalLeftArmSize
			LeftArm.Transparency = 0
			LeftArm.Massless = false
			OriginalLeftArmSize = nil
		end
	end
end

local function SetupDunkSpoof(Humanoid)
	local Animator = Humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", Humanoid)
	return Animator.AnimationPlayed:Connect(function(Track)
		if Config.AnimSpoof and Track.Animation.Name == "Dunk_Default" and Config.DunkAnim ~= "Default" and AnimationsFolder then
			Track:Stop()
			local Anim = AnimationsFolder:FindFirstChild("Dunk_" .. Config.DunkAnim)
			if Anim then
				Humanoid:LoadAnimation(Anim):Play()
			end
		end
	end)
end

local function SetupEmoteSpoof(Humanoid)
	local Animator = Humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", Humanoid)
	return Animator.AnimationPlayed:Connect(function(Track)
		if Config.AnimSpoof and Track.Animation.Name == "Dance_Casual" and Config.EmoteAnim ~= "Dance_Casual" and AnimationsFolder then
			Track:Stop()
			local Anim = AnimationsFolder:FindFirstChild(Config.EmoteAnim)
			if Anim then
				Humanoid:LoadAnimation(Anim):Play()
			end
		end
	end)
end

local function EnableAnimationSpoof()
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			if DunkSpoofConn then
				DunkSpoofConn:Disconnect()
			end
			if EmoteSpoofConn then
				EmoteSpoofConn:Disconnect()
			end
			DunkSpoofConn = SetupDunkSpoof(Humanoid)
			EmoteSpoofConn = SetupEmoteSpoof(Humanoid)
		end
	end

	if CharAddedDunk then
		CharAddedDunk:Disconnect()
	end
	if CharAddedEmote then
		CharAddedEmote:Disconnect()
	end

	CharAddedDunk = LocalPlayer.CharacterAdded:Connect(function(Character)
		local Humanoid = Character:WaitForChild("Humanoid", 8)
		if DunkSpoofConn then
			DunkSpoofConn:Disconnect()
		end
		DunkSpoofConn = SetupDunkSpoof(Humanoid)
	end)
	CharAddedEmote = LocalPlayer.CharacterAdded:Connect(function(Character)
		local Humanoid = Character:WaitForChild("Humanoid", 8)
		if EmoteSpoofConn then
			EmoteSpoofConn:Disconnect()
		end
		EmoteSpoofConn = SetupEmoteSpoof(Humanoid)
	end)

	Connections[#Connections + 1] = CharAddedDunk
	Connections[#Connections + 1] = CharAddedEmote
end

local function DisableAnimationSpoof()
	if DunkSpoofConn then
		DunkSpoofConn:Disconnect()
		DunkSpoofConn = nil
	end
	if EmoteSpoofConn then
		EmoteSpoofConn:Disconnect()
		EmoteSpoofConn = nil
	end
	if CharAddedDunk then
		CharAddedDunk:Disconnect()
		CharAddedDunk = nil
	end
	if CharAddedEmote then
		CharAddedEmote:Disconnect()
		CharAddedEmote = nil
	end
end

local function ApplyBodyGyro(Enabled)
	for _, Model in ipairs(Workspace:GetChildren()) do
		if Model:IsA("Model") and Model:FindFirstChild("HumanoidRootPart") then
			for _, Obj in ipairs(Model.HumanoidRootPart:GetDescendants()) do
				if Obj.Name == "BG" and Obj:IsA("BodyGyro") then
					if Enabled then
						Obj.Parent = Model.HumanoidRootPart
						Obj.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
						Obj.P = 9e4
						Obj.D = 500
						Obj.CFrame = Model.HumanoidRootPart.CFrame
					else
						Obj.Parent = nil
					end
				end
			end
		end
	end
end

ShootSection:Toggle({
	Name = "Enabled",
	Flag = "AutoGreen",
	Default = Config.AutoGreen,
	Callback = function(Value)
		Config.AutoGreen = Value
		BindAutoGreen()
	end,
})

ShootSettingsSection:Slider({
	Name = "Green %",
	Flag = "ShootPower",
	Min = 50,
	Max = 100,
	Default = Config.ShootPower * 100,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.ShootPower = Value / 100
	end,
})

GuardSection:Toggle({
	Name = "Enabled",
	Flag = "AutoGuard",
	Default = Config.AutoGuard,
	Callback = function(Value)
		Config.AutoGuard = Value
		if not Value then
			Config.GuardHoldActive = false
			if AutoGuardConn then
				AutoGuardConn:Disconnect()
				AutoGuardConn = nil
			end
			LastPositions = {}
			ReleaseGuardKey()
		end
	end,
})

GuardSettingsSection:Slider({
	Name = "Guard Distance",
	Flag = "GuardDistance",
	Min = 5,
	Max = 20,
	Default = Config.GuardDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.GuardDistance = Value
	end,
})

GuardSettingsSection:Slider({
	Name = "Prediction",
	Flag = "GuardPrediction",
	Min = 0.1,
	Max = 0.8,
	Default = Config.GuardPrediction,
	Decimals = 0.01,
	Suffix = "s",
	Callback = function(Value)
		Config.GuardPrediction = Value
	end,
})

ReboundSection:Toggle({
	Name = "Enabled",
	Flag = "ReboundSteal",
	Default = Config.ReboundSteal,
	Callback = function(Value)
		Config.ReboundSteal = Value
	end,
})

ReboundSection:Slider({
	Name = "Offset",
	Flag = "ReboundOffset",
	Min = 0,
	Max = 6,
	Default = Config.ReboundOffset,
	Decimals = 1,
	Callback = function(Value)
		Config.ReboundOffset = Value
	end,
})

PostSection:Toggle({
	Name = "Enabled",
	Flag = "PostAimbot",
	Default = Config.PostAimbot,
	Callback = function(Value)
		Config.PostAimbot = Value
		if not Value then
			Config.PostHoldActive = false
			if PostAimbotConn then
				PostAimbotConn:Disconnect()
				PostAimbotConn = nil
			end
		end
	end,
})

PostSection:Slider({
	Name = "Activation Distance",
	Flag = "PostDistance",
	Min = 5,
	Max = 20,
	Default = Config.PostDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.PostDistance = Value
	end,
})

ReachSection:Toggle({
	Name = "Enabled",
	Flag = "StealReach",
	Default = Config.StealReach,
	Callback = function(Value)
		Config.StealReach = Value
		UpdateHitboxSizes()
	end,
})

ReachSection:Slider({
	Name = "Reach Multiplier",
	Flag = "ReachMultiplier",
	Min = 1,
	Max = 20,
	Default = Config.ReachMultiplier,
	Decimals = 0.1,
	Suffix = "x",
	Callback = function(Value)
		Config.ReachMultiplier = Value
		if Config.StealReach then
			UpdateHitboxSizes()
		end
	end,
})

MagnetSection:Toggle({
	Name = "Enabled",
	Flag = "BallMagnet",
	Default = Config.BallMagnet,
	Callback = function(Value)
		Config.BallMagnet = Value
	end,
})

MagnetSection:Slider({
	Name = "Distance",
	Flag = "MagnetDistance",
	Min = 10,
	Max = 85,
	Default = Config.MagnetDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.MagnetDistance = Value
	end,
})

FollowSection:Toggle({
	Name = "Enabled",
	Flag = "FollowCarrier",
	Default = Config.FollowCarrier,
	Callback = function(Value)
		Config.FollowCarrier = Value
		if Value then
			if not FollowConn then
				FollowConn = RunService.Heartbeat:Connect(function()
					if not Config.FollowCarrier then
						return
					end
					local Character = LocalPlayer.Character
					local Root = Character and Character:FindFirstChild("HumanoidRootPart")
					if not Root then
						return
					end
					local BallCarrier, BallCarrierRoot = FindPlayerWithBall()
					if BallCarrier and BallCarrierRoot then
						local MaxDist = IsParkGame and 100 or math.huge
						if (Root.Position - BallCarrierRoot.Position).Magnitude <= MaxDist then
							Root.CFrame = BallCarrierRoot.CFrame * CFrame.new(0, 0, Config.FollowOffset)
						end
					end
				end)
				Connections[#Connections + 1] = FollowConn
			end
		else
			if FollowConn then
				FollowConn:Disconnect()
				FollowConn = nil
			end
		end
	end,
})

FollowSection:Slider({
	Name = "Offset",
	Flag = "FollowOffset",
	Min = -10,
	Max = 10,
	Default = Config.FollowOffset,
	Decimals = 1,
	Callback = function(Value)
		Config.FollowOffset = Value
	end,
})

SpeedSection:Toggle({
	Name = "Enabled",
	Flag = "SpeedBoost",
	Default = Config.SpeedBoost,
	Callback = function(Value)
		Config.SpeedBoost = Value
		if Value then
			if SpeedBoostCleanup then
				SpeedBoostCleanup()
			end
			SpeedBoostCleanup = StartCFrameSpeed(Config.SpeedAmount)
		else
			if SpeedBoostCleanup then
				SpeedBoostCleanup()
			end
			SpeedBoostCleanup = nil
		end
	end,
})

SpeedSection:Slider({
	Name = "Speed",
	Flag = "SpeedAmount",
	Min = 16,
	Max = 23,
	Default = Config.SpeedAmount,
	Decimals = 0.1,
	Callback = function(Value)
		Config.SpeedAmount = Value
		if Config.SpeedBoost then
			if SpeedBoostCleanup then
				SpeedBoostCleanup()
			end
			SpeedBoostCleanup = StartCFrameSpeed(Config.SpeedAmount)
		end
	end,
})

VisualSection:Toggle({
	Name = "Show BodyGyro",
	Flag = "ShowBodyGyro",
	Default = Config.ShowBodyGyro,
	Callback = function(Value)
		Config.ShowBodyGyro = Value
		ApplyBodyGyro(Value)
	end,
})

AnimSection:Toggle({
	Name = "Enable Anim Spoof",
	Flag = "AnimSpoof",
	Default = Config.AnimSpoof,
	Callback = function(Value)
		Config.AnimSpoof = Value
		if Value then
			EnableAnimationSpoof()
		else
			DisableAnimationSpoof()
		end
	end,
})

AnimSection:Dropdown({
	Name = "Dunk Animation",
	Flag = "DunkAnim",
	Items = DunkItems,
	Default = Config.DunkAnim,
	Callback = function(Value)
		Config.DunkAnim = Value
	end,
})

AnimSection:Dropdown({
	Name = "Emote Animation",
	Flag = "EmoteAnim",
	Items = EmoteKeys,
	Default = "Default",
	Callback = function(Value)
		Config.EmoteAnim = EmoteAnimations[Value] or "Dance_Casual"
	end,
})

TeleDropdown = TeleSection:Dropdown({
	Name = "Select Place",
	Flag = "TelePlace",
	Items = { "Loading..." },
	Default = "Loading...",
	Callback = function(Value)
		Config.TelePlace = Value
	end,
})

do
	local TeleButtons = TeleSection:Button()
	TeleButtons:Add("Teleport", function()
		local PlaceId = PlacesList[Config.TelePlace]
		if PlaceId then
			Library:Notification("Teleport", "Going to " .. tostring(Config.TelePlace), 3)
			TeleportService:Teleport(PlaceId)
		end
	end)
	TeleButtons:Add("Rejoin", function()
		Library:Notification("Teleport", "Rejoining...", 3)
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
	end)
	TeleButtons:Add("Server Hop", function()
		local Servers = {}
		local Cursor = ""
		repeat
			local Ok, Result = pcall(function()
				return game:HttpGet(
					"https://games.roblox.com/v1/games/"
						.. game.PlaceId
						.. "/servers/Public?sortOrder=Asc&limit=100&cursor="
						.. Cursor
				)
			end)
			if Ok then
				local Decoded = HttpService:JSONDecode(Result)
				Cursor = Decoded.nextPageCursor or ""
				for _, Server in ipairs(Decoded.data or {}) do
					if Server.playing < Server.maxPlayers and Server.id ~= game.JobId then
						Servers[#Servers + 1] = Server
					end
				end
			else
				break
			end
		until Cursor == ""

		if #Servers > 0 then
			table.sort(Servers, function(A, B)
				return A.playing < B.playing
			end)
			TeleportService:TeleportToPlaceInstance(game.PlaceId, Servers[1].id, LocalPlayer)
		else
			Library:Notification("Teleport", "No available servers found", 3)
		end
	end)
end

task.spawn(function()
	local Http = (syn and syn.request)
		or (http and http.request)
		or (fluxus and fluxus.request)
		or request
		or http_request

	if not Http then
		PlacesList["Current Place"] = game.PlaceId
		Config.TelePlace = "Current Place"
		if TeleDropdown and TeleDropdown.Refresh then
			TeleDropdown:Refresh({ "Current Place" })
			TeleDropdown:Set("Current Place")
		end
		return
	end

	local Url = "https://develop.roblox.com/v1/universes/" .. game.GameId .. "/places?limit=100"
	local Ok, Response = pcall(function()
		return Http({ Url = Url, Method = "GET" })
	end)
	if Ok and Response and Response.Body then
		local DecodeOk, Data = pcall(function()
			return HttpService:JSONDecode(Response.Body)
		end)
		if DecodeOk and Data and Data.data then
			for _, Place in ipairs(Data.data) do
				if Place.name and Place.id then
					local Name = Place.name .. (Place.isRootPlace and " (Root)" or "")
					PlacesList[Name] = Place.id
					PlaceNames[#PlaceNames + 1] = Name
				end
			end
		end
	end

	if #PlaceNames == 0 then
		PlacesList["Current Place"] = game.PlaceId
		PlaceNames[1] = "Current Place"
	end
	table.sort(PlaceNames)
	Config.TelePlace = PlaceNames[1]
	if TeleDropdown and TeleDropdown.Refresh then
		TeleDropdown:Refresh(PlaceNames)
		TeleDropdown:Set(PlaceNames[1])
	end
end)

TrackConnection(UserInputService.InputBegan, function(Input, GameProcessed)
	if GameProcessed then
		return
	end

	if Input.KeyCode == Enum.KeyCode.P and Config.PostAimbot then
		Config.PostHoldActive = true
		if not PostAimbotConn then
			PostAimbotConn = RunService.Heartbeat:Connect(ExecutePostAimbot)
			Connections[#Connections + 1] = PostAimbotConn
		end
	end

	if Input.KeyCode == Enum.KeyCode.G and Config.AutoGuard then
		Config.GuardHoldActive = true
		LastPositions = {}
		if not AutoGuardConn then
			AutoGuardConn = RunService.Heartbeat:Connect(RunAutoGuard)
			Connections[#Connections + 1] = AutoGuardConn
		end
	end
end)

TrackConnection(UserInputService.InputEnded, function(Input)
	if Input.KeyCode == Enum.KeyCode.P then
		Config.PostHoldActive = false
		if PostAimbotConn then
			PostAimbotConn:Disconnect()
			PostAimbotConn = nil
		end
	end

	if Input.KeyCode == Enum.KeyCode.G then
		Config.GuardHoldActive = false
		if AutoGuardConn then
			AutoGuardConn:Disconnect()
			AutoGuardConn = nil
		end
		LastPositions = {}
		ReleaseGuardKey()
	end
end)

TrackConnection(RunService.RenderStepped, function()
	if Config.StealReach then
		UpdateHitboxSizes()
	end

	if not Config.ReboundSteal then
		return
	end

	local Character = LocalPlayer.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Root then
		return
	end

	local ClosestBall, ClosestDist = nil, math.huge
	local MaxDistance = IsParkGame and 100 or math.huge
	for _, Child in ipairs(Workspace:GetChildren()) do
		if Child.Name == "Basketball" then
			local Part = Child:IsA("BasePart") and Child or Child:FindFirstChildWhichIsA("BasePart")
			if Part then
				local Dist = (Part.Position - Root.Position).Magnitude
				if Dist < ClosestDist and Dist <= MaxDistance then
					ClosestDist = Dist
					ClosestBall = Part
				end
			end
		end
	end

	if ClosestBall then
		Root.CFrame = CFrame.new(ClosestBall.Position + ClosestBall.CFrame.LookVector * Config.ReboundOffset)
	end
end)

TrackConnection(RunService.Heartbeat, function()
	if not Config.BallMagnet then
		return
	end
	if typeof(firetouchinterest) ~= "function" then
		return
	end

	local Character = LocalPlayer.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Root then
		return
	end

	local Ball = Workspace:FindFirstChild("Basketball", true)
	if Ball and Ball:IsA("BasePart") then
		if (Root.Position - Ball.Position).Magnitude <= Config.MagnetDistance then
			pcall(firetouchinterest, Root, Ball, 0)
			pcall(firetouchinterest, Root, Ball, 1)
		end
	end
end)

if UserInputService.TouchEnabled then
	MobileGui = Instance.new("ScreenGui")
	MobileGui.Name = "EchoMobileGuard"
	MobileGui.ResetOnSpawn = false
	MobileGui.Parent = LocalPlayer.PlayerGui

	local GuardBtn = Instance.new("TextButton")
	GuardBtn.Size = UDim2.new(0, 120, 0, 40)
	GuardBtn.Position = UDim2.new(0.5, -60, 0.85, 0)
	GuardBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	GuardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	GuardBtn.Text = "Auto Guard: OFF"
	GuardBtn.Font = Enum.Font.GothamBold
	GuardBtn.TextSize = 13
	GuardBtn.BorderSizePixel = 0
	GuardBtn.Parent = MobileGui
	Instance.new("UICorner", GuardBtn).CornerRadius = UDim.new(0, 6)

	local Dragging = false
	local DragStart, StartPos
	GuardBtn.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch then
			Dragging = true
			DragStart = Input.Position
			StartPos = GuardBtn.Position
			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Dragging and Input.UserInputType == Enum.UserInputType.Touch then
			local Delta = Input.Position - DragStart
			GuardBtn.Position = UDim2.new(
				StartPos.X.Scale,
				StartPos.X.Offset + Delta.X,
				StartPos.Y.Scale,
				StartPos.Y.Offset + Delta.Y
			)
		end
	end)

	GuardBtn.Activated:Connect(function()
		if not Config.AutoGuard then
			GuardBtn.Text = "Enable toggle first"
			task.delay(1.5, function()
				if GuardBtn and GuardBtn.Parent then
					GuardBtn.Text = "Auto Guard: OFF"
				end
			end)
			return
		end

		Config.GuardHoldActive = not Config.GuardHoldActive
		if Config.GuardHoldActive then
			LastPositions = {}
			if not AutoGuardConn then
				AutoGuardConn = RunService.Heartbeat:Connect(RunAutoGuard)
				Connections[#Connections + 1] = AutoGuardConn
			end
			GuardBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 40)
			GuardBtn.Text = "Auto Guard: ON"
		else
			if AutoGuardConn then
				AutoGuardConn:Disconnect()
				AutoGuardConn = nil
			end
			LastPositions = {}
			ReleaseGuardKey()
			GuardBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			GuardBtn.Text = "Auto Guard: OFF"
		end
	end)
end

getgenv().EchoCleanup = function()
	Config.AutoGreen = false
	Config.AutoGuard = false
	Config.GuardHoldActive = false
	Config.ReboundSteal = false
	Config.PostAimbot = false
	Config.PostHoldActive = false
	Config.StealReach = false
	Config.BallMagnet = false
	Config.FollowCarrier = false
	Config.SpeedBoost = false
	Config.AnimSpoof = false
	Config.ShowBodyGyro = false

	ReleaseGuardKey()
	DisableAnimationSpoof()
	UpdateHitboxSizes()
	ApplyBodyGyro(false)

	if VisibleConn then
		VisibleConn:Disconnect()
		VisibleConn = nil
	end
	if AutoGuardConn then
		AutoGuardConn:Disconnect()
		AutoGuardConn = nil
	end
	if PostAimbotConn then
		PostAimbotConn:Disconnect()
		PostAimbotConn = nil
	end
	if FollowConn then
		FollowConn:Disconnect()
		FollowConn = nil
	end
	if SpeedBoostCleanup then
		SpeedBoostCleanup()
		SpeedBoostCleanup = nil
	end
	if MobileGui then
		pcall(function()
			MobileGui:Destroy()
		end)
		MobileGui = nil
	end

	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)

	pcall(function()
		if Library and Library.Unload then
			Library:Unload()
		end
	end)

	pcall(function()
		EchoUiContainer:Destroy()
	end)

	if getgenv().Library == Library then
		getgenv().Library = nil
	end
	getgenv().EchoConfig = nil
end

getgenv().EchoConfig = Config

Library:Notification(
	"Echo",
	string.format("Basketball Legends loaded in %.2fs", os.clock() - LoadTick),
	4
)
]====], "Echo_Basketball_Legends")
	if not EchoChunk then
		error("[Echo] Basketball Legends compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsPlayground() then
-- Echo Hub: Playground Basketball
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

getgenv().gethui = function()
	return EchoUiContainer
end

local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoScootUI then
		return getgenv().__EchoScootUI
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/saintsrevival1/eee/refs/heads/main/UI-Source.lua"))()
	getgenv().__EchoScootUI = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
	return
end

local Library = LibraryOrErr
getgenv().Library = Library

pcall(function()
	Library.Round = function(_, Number, Float)
		if typeof(Number) ~= "number" or Number ~= Number then
			return 0
		end
		if typeof(Float) ~= "number" or Float ~= Float or Float == 0 then
			Float = 1
		end
		local Multiplier = 1 / Float
		return math.floor(Number * Multiplier + 1e-9) / Multiplier
	end
end)

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local Config = {
	AutoGreen = false,
	AutoDunkGreen = false,
	GreenMode = "Perfect",
	DunkMode = "Perfect",
	GreenPercent = 94,
	DunkPercent = 93,
	RandomizeGreen = false,
	PerfectChance = 55,
	GreatChance = 30,
	GoodChance = 15,
	GreenDelayOffset = 0,

	AutoGuard = false,
	GuardHoldActive = false,
	GuardUiToggle = false,
	GuardDistance = 10,
	GuardPrediction = 0.25,
	GuardKey = Enum.KeyCode.G,

	AutoReach = false,
	AutoBlock = false,
	BlockDistance = 14,

	ReboundTp = false,
	ReboundOffset = 0,
	FollowCarrier = false,
	FollowOffset = -8,

	StealReach = false,
	ReachMultiplier = 2.5,

	SpeedBoost = false,
	SpeedAmount = 20,
	AlwaysSprint = false,
	InfiniteStamina = false,

	CarrierEsp = false,
	OpponentEsp = false,
	EspFillTransparency = 0.65,
	EspOutlineTransparency = 0,
	CarrierEspColor = Color3.fromRGB(80, 220, 120),
	OpponentEspColor = Color3.fromRGB(255, 90, 90),
}
getgenv().EchoConfig = Config

local Connections = {}
local EchoUiRoots = {}
local ActionRemote = nil
local OldNamecall = nil
local HookInstalled = false

local ShotToken = 0
local DunkToken = 0
local AutoReleasingShot = false
local AutoReleasingDunk = false
local ShotActive = false
local DunkActive = false
local ShotArmed = false
local DunkArmed = false
local ShotLockUntil = 0
local DunkLockUntil = 0
local DunkSuppressHold = false
local ShotStartedAt = 0
local GuardForced = false
local ApplyingGuard = false
local ReachClock = 0
local BlockClock = 0
local DefaultWalkSpeed = 16
local MaxGuardDistance = 13

local EspFolder = nil
local CarrierHighlights = {}
local OpponentHighlights = {}
local OriginalHitboxSize = nil
local OriginalScreenHitboxSize = nil
local StealHitboxes = {}
local MobileGui = nil
local StatusLabel = nil

local QualityBands = {
	Perfect = { 0.955, 0.985 },
	Great = { 0.93, 0.955 },
	Good = { 0.9, 0.93 },
	Okay = { 0.86, 0.9 },
}

local DistanceBands = {
	Close = { Perfect = { 0.94, 0.975 }, Great = { 0.91, 0.95 }, Good = { 0.88, 0.92 }, Okay = { 0.84, 0.89 } },
	Mid = { Perfect = { 0.94, 0.975 }, Great = { 0.91, 0.95 }, Good = { 0.88, 0.92 }, Okay = { 0.84, 0.89 } },
	Three = { Perfect = { 0.955, 0.985 }, Great = { 0.93, 0.96 }, Good = { 0.9, 0.94 }, Okay = { 0.86, 0.91 } },
	Layup = { Perfect = { 0.93, 0.97 }, Great = { 0.9, 0.94 }, Good = { 0.87, 0.91 }, Okay = { 0.83, 0.88 } },
}

local PerfectTimings = {
	Good = true,
	Perfect = true,
	Green = true,
	Excellent = true,
}

local GreatTimings = {
	["Slightly Early"] = true,
	Good = true,
	Perfect = true,
	Green = true,
}

local Window = Library:Window({
	Logo = "72316209028225",
	FadeTime = 0.3,
})

EchoUiRoots[#EchoUiRoots + 1] = EchoUiContainer

local Watermark = Library:Watermark("Echo | Playground Basketball")
local KeybindList = Library:KeybindList()

local OffensePage = Window:Page({ Name = "Offense", Columns = 2 })
local DefensePage = Window:Page({ Name = "Defense", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
local MiscPage = Window:Page({ Name = "Misc", Columns = 2 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local GreenSection = OffensePage:Section({ Name = "Auto Green", Side = 1 })
local GreenTuneSection = OffensePage:Section({ Name = "Green Tuning", Side = 1 })
local DunkSection = OffensePage:Section({ Name = "Auto Dunk Green", Side = 2 })
local BallSection = OffensePage:Section({ Name = "Ball Control", Side = 2 })

local GuardSection = DefensePage:Section({ Name = "Auto Guard", Side = 1 })
local DefenseToolsSection = DefensePage:Section({ Name = "Defense Tools", Side = 2 })

local MovementSection = PlayerPage:Section({ Name = "Movement", Side = 1 })
local StaminaSection = PlayerPage:Section({ Name = "Stamina", Side = 2 })

local EspSection = VisualsPage:Section({ Name = "ESP", Side = 1 })
local EspStyleSection = VisualsPage:Section({ Name = "ESP Style", Side = 2 })

local TeleSection = MiscPage:Section({ Name = "Teleport", Side = 1 })
local ServerSection = MiscPage:Section({ Name = "Server", Side = 2 })

-- // Utilities
local function TrackConnection(Signal, Callback)
	local Connection = Signal:Connect(Callback)
	Connections[#Connections + 1] = Connection
	return Connection
end

local function ResolveDeps()
	local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
	local Server = Remotes and Remotes:FindFirstChild("Server")
	ActionRemote = Server and Server:FindFirstChild("Action")
	return ActionRemote ~= nil
end

local function GetCharacter()
	return LocalPlayer.Character
end

local function GetRoot(Character)
	Character = Character or GetCharacter()
	return Character and Character:FindFirstChild("HumanoidRootPart")
end

local function CharacterHasPossession(Character, Player)
	if Player and Player:GetAttribute("HasBall") == true then
		return true
	end
	if not Character then
		return false
	end
	if Character:GetAttribute("HasBall") == true then
		return true
	end
	local Flag = Character:FindFirstChild("HasBall")
	-- MeshPart named "Ball" is a visual, not possession
	return Flag ~= nil and Flag:IsA("BoolValue") and Flag.Value == true
end

local function PlayerHasBall(Player)
	if not Player then
		return false
	end
	return CharacterHasPossession(Player.Character, Player)
end

local function HasBall(Character)
	Character = Character or GetCharacter()
	return CharacterHasPossession(Character, LocalPlayer)
end

local function GetPlayerTeam(Player)
	local Team = Player and Player:GetAttribute("PlrTeam")
	if typeof(Team) == "string" and Team ~= "" and Team ~= "None" then
		return Team
	end
	return nil
end

local function IsEnemy(Player)
	if not Player or Player == LocalPlayer then
		return false
	end
	local Mine = GetPlayerTeam(LocalPlayer)
	local Theirs = GetPlayerTeam(Player)
	-- Only trust PlrTeam. Missing team data = allow (Park-style).
	if Mine and Theirs then
		return Mine ~= Theirs
	end
	return true
end

local function GetMeterBar(Character)
	Character = Character or GetCharacter()
	local Meter = Character and Character:FindFirstChild("ShotMeterUI")
	if not Meter then
		return nil
	end
	local NewMeter = Meter:FindFirstChild("NewMeter")
	local Bar = NewMeter and NewMeter:FindFirstChild("Bar")
	if Bar and Meter.Enabled then
		return Bar, Meter
	end
	local OldMeter = Meter:FindFirstChild("Meter")
	local OldBar = OldMeter and OldMeter:FindFirstChild("Bar")
	if OldBar and Meter.Enabled then
		return OldBar, Meter
	end
	return nil, Meter
end

local function GetBarProgress(Character)
	local Bar = GetMeterBar(Character)
	if not Bar then
		return nil
	end
	return Bar.Size.Y.Scale
end

local function GetRimPosition(Character)
	Character = Character or GetCharacter()
	local Data = Character and Character:FindFirstChild("Data")
	local HoopValue = Data and Data:FindFirstChild("Hoop")
	local Hoop = HoopValue and HoopValue.Value
	if not Hoop then
		local Courts = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Courts")
		local Court = Courts and Courts:FindFirstChild("Court1")
		Hoop = Court and (Court:FindFirstChild("Hoop2") or Court:FindFirstChildWhichIsA("Model", true))
	end
	if not Hoop then
		return nil
	end
	local Rim = Hoop:FindFirstChild("RimMesh", true) or Hoop:FindFirstChild("Rim", true)
	if Rim and Rim:IsA("BasePart") then
		return Rim.Position, Hoop
	end
	if Rim then
		local Part = Rim:FindFirstChildWhichIsA("BasePart", true)
		if Part then
			return Part.Position, Hoop
		end
	end
	local Part = Hoop:FindFirstChildWhichIsA("BasePart", true)
	return Part and Part.Position, Hoop
end

local function GetShotDistance(Character)
	Character = Character or GetCharacter()
	local Root = GetRoot(Character)
	local RimPos = GetRimPosition(Character)
	if not Root or not RimPos then
		return nil
	end
	return (Root.Position - RimPos).Magnitude
end

local function GetRangeKey(Character, IsDunk)
	if IsDunk then
		return "Layup"
	end
	Character = Character or GetCharacter()
	local ShotType = tostring(Character and Character:GetAttribute("ShotType") or "")
	if ShotType == "Layup"
		or ShotType == "Floater"
		or ShotType == "Driving Dunk"
		or ShotType == "Contact Layup"
		or ShotType:find("Layup")
		or ShotType:find("Floater")
	then
		return "Layup"
	end
	local Distance = GetShotDistance(Character)
	if not Distance then
		return "Mid"
	end
	if Distance <= 10 then
		return "Close"
	end
	if Distance <= 22 then
		return "Mid"
	end
	return "Three"
end

local function PickQuality(Mode, Randomize)
	if not Randomize and Mode ~= "Random" then
		return Mode
	end
	local Roll = math.random(1, 100)
	local Perfect = math.clamp(tonumber(Config.PerfectChance) or 55, 0, 100)
	local Great = math.clamp(tonumber(Config.GreatChance) or 30, 0, 100)
	if Roll <= Perfect then
		return "Perfect"
	elseif Roll <= Perfect + Great then
		return "Great"
	else
		return "Good"
	end
end

local function GetTargetProgress(IsDunk)
	local Mode = IsDunk and (Config.DunkMode or "Perfect") or (Config.GreenMode or "Perfect")
	if not IsDunk and (Config.RandomizeGreen or Mode == "Random") then
		Mode = PickQuality(Mode, true)
	elseif IsDunk and Mode == "Random" then
		Mode = PickQuality(Mode, true)
	end

	local Character = GetCharacter()
	local RangeKey = GetRangeKey(Character, IsDunk)
	local RangeTable = DistanceBands[RangeKey] or DistanceBands.Mid

	local MinP, MaxP
	if Mode == "Custom" then
		local Custom = IsDunk and Config.DunkPercent or Config.GreenPercent
		Custom = math.clamp(tonumber(Custom) or 94, 70, 100) / 100
		if RangeKey == "Three" then
			Custom = math.clamp(Custom + 0.01, 0.7, 0.995)
		elseif RangeKey == "Layup" or RangeKey == "Close" then
			Custom = math.clamp(Custom - 0.01, 0.7, 0.995)
		end
		MinP, MaxP = Custom, Custom
	else
		local Band = RangeTable[Mode] or RangeTable.Perfect or QualityBands[Mode] or QualityBands.Perfect
		MinP, MaxP = Band[1], Band[2]
	end

	local GreenWindow = Character and tonumber(Character:GetAttribute("GreenWindow"))
	if Mode == "Perfect" and GreenWindow and GreenWindow >= 0.85 and GreenWindow <= 0.995 then
		MinP = math.max(GreenWindow - 0.01, 0.88)
		MaxP = math.min(GreenWindow + 0.025, 0.995)
	end

	local Target = MinP
	if MaxP > MinP then
		Target = MinP + math.random() * (MaxP - MinP)
	end
	return math.clamp(Target, 0.7, 0.995), Mode, RangeKey
end

local function ShouldReleaseByTiming(IsDunk, Mode)
	local Character = GetCharacter()
	if not Character then
		return false
	end
	local Timing = tostring(Character:GetAttribute("Timing") or "")
	Mode = Mode or (IsDunk and Config.DunkMode or Config.GreenMode) or "Perfect"
	if Mode == "Perfect" or Mode == "Custom" then
		return PerfectTimings[Timing] == true
	end
	if Mode == "Great" then
		return GreatTimings[Timing] == true or PerfectTimings[Timing] == true
	end
	if Mode == "Good" or Mode == "Okay" then
		return Timing == "Slightly Early" or GreatTimings[Timing] == true or PerfectTimings[Timing] == true
	end
	return PerfectTimings[Timing] == true
end

local function FireAction(Payload)
	if not ActionRemote then
		ResolveDeps()
	end
	if not ActionRemote then
		return
	end
	pcall(function()
		ActionRemote:FireServer(Payload)
	end)
end

local function FireShootRelease()
	AutoReleasingShot = true
	ShotArmed = false
	FireAction({ Type = "Shoot", Shoot = false })
	task.delay(0.03, function()
		FireAction({ Type = "Shoot", Shoot = false })
	end)
	ShotLockUntil = os.clock() + 0.12
	task.delay(0.1, function()
		AutoReleasingShot = false
	end)
end

local function FireDunkRelease()
	AutoReleasingDunk = true
	DunkSuppressHold = true
	FireAction({ Action = "Jump", Jump = false })
	FireAction({ Type = "Shoot", Shoot = false })
	DunkLockUntil = os.clock() + 0.55
	task.defer(function()
		AutoReleasingDunk = false
	end)
end

local function ScheduleMeterRelease(IsDunk)
	if IsDunk then
		if not Config.AutoDunkGreen or DunkActive then
			return
		end
		DunkActive = true
		DunkArmed = false
		DunkToken += 1
	else
		if not Config.AutoGreen or ShotActive then
			return
		end
		ShotActive = true
		ShotArmed = false
		ShotStartedAt = os.clock()
		ShotToken += 1
	end

	local Token = IsDunk and DunkToken or ShotToken

	local Target, Mode, RangeKey = GetTargetProgress(IsDunk)
	local Offset = tonumber(Config.GreenDelayOffset) or 0
	local Started = os.clock()
	local Armed = false
	local Baseline = nil
	local SawVeryEarly = false
	local LastTiming = ""
	local NeedAction = IsDunk and "Dunking" or "Shooting"

	task.spawn(function()
		while Token == (IsDunk and DunkToken or ShotToken) and (IsDunk and Config.AutoDunkGreen or Config.AutoGreen) do
			local Character = GetCharacter()
			local Action = Character and Character:GetAttribute("Action")
			local Meter = Character and Character:FindFirstChild("ShotMeterUI")
			local Progress = GetBarProgress(Character)
			local Timing = Character and tostring(Character:GetAttribute("Timing") or "")
			local Elapsed = os.clock() - Started

			local NewTarget, _, NewRange = GetTargetProgress(IsDunk)
			if NewRange ~= RangeKey then
				RangeKey = NewRange
				Target = NewTarget
			end

			if Timing == "Very Early" then
				SawVeryEarly = true
			end

			if not Armed then
				local MeterOn = Meter and Meter.Enabled
				local RightAction = Action == NeedAction
				if MeterOn and RightAction and Progress then
					if Baseline == nil then
						Baseline = Progress
					end
					if Progress <= 0.35 or Progress >= (Baseline + 0.1) then
						Armed = true
						if IsDunk then
							DunkArmed = true
						else
							ShotArmed = true
						end
						Target = NewTarget
						RangeKey = NewRange
					end
				elseif Elapsed > (IsDunk and 0.55 or 0.5) and not MeterOn then
					if IsDunk then
						DunkActive = false
						DunkArmed = false
					else
						ShotActive = false
						ShotArmed = false
						ShotStartedAt = 0
					end
					return
				end
			else
				if Progress and Progress > 0.2 then
					local Floor = (RangeKey == "Layup" or RangeKey == "Close") and 0.9 or 0.88
					local TimingFlip = SawVeryEarly
						and Timing ~= LastTiming
						and ShouldReleaseByTiming(IsDunk, Mode)
						and Progress >= Floor
					local BarReady = Progress >= (Target + Offset)
					if RangeKey == "Layup" or RangeKey == "Close" then
						if TimingFlip then
							break
						end
						if BarReady and Progress >= 0.93 and (Timing == "Slightly Early" or PerfectTimings[Timing]) then
							break
						end
						if Progress >= math.max(Target + Offset, 0.96) then
							break
						end
					elseif TimingFlip or BarReady then
						break
					end
				end
				if Action ~= NeedAction and not (Meter and Meter.Enabled) then
					break
				end
			end

			LastTiming = Timing
			if Elapsed > (IsDunk and 1.6 or 1.35) then
				break
			end
			RunService.RenderStepped:Wait()
		end

		local TokenAlive = Token == (IsDunk and DunkToken or ShotToken)
		local Character = GetCharacter()
		local ActionNow = Character and Character:GetAttribute("Action")
		local StillInShot = ActionNow == NeedAction
			or (Character and Character:FindFirstChild("ShotMeterUI") and Character.ShotMeterUI.Enabled)

		if not TokenAlive then
			-- Armed release was blocked from the user; if nothing took over, force release
			local TakenOver = IsDunk and DunkActive or ShotActive
			if Armed and not TakenOver then
				if IsDunk then
					FireDunkRelease()
				else
					FireShootRelease()
				end
			end
			if IsDunk then
				if not TakenOver then
					DunkActive = false
					DunkArmed = false
				end
			else
				if not TakenOver then
					ShotActive = false
					ShotArmed = false
				end
			end
			return
		end

		-- Always release if we armed, or if the shot is still live after the wait window
		if Armed or StillInShot then
			if IsDunk then
				FireDunkRelease()
				DunkActive = false
				DunkArmed = false
			else
				FireShootRelease()
				ShotActive = false
				ShotArmed = false
				ShotStartedAt = 0
			end
			return
		end

		if IsDunk then
			DunkActive = false
			DunkArmed = false
		else
			ShotActive = false
			ShotArmed = false
			ShotStartedAt = 0
		end
	end)
end

local function ScheduleAutoGreen()
	ScheduleMeterRelease(false)
end

local function ScheduleAutoDunk()
	ScheduleMeterRelease(true)
end

local function SetGuardState(Enabled)
	if GuardForced == Enabled then
		return
	end
	GuardForced = Enabled
	ApplyingGuard = true
	FireAction({ Action = "Guard", Guard = Enabled })
	ApplyingGuard = false
end

-- Guard movement is driven through a RenderStep bind that runs AFTER the game's
-- default control module. A Heartbeat Humanoid:Move loses to the control script
-- every frame (character rotates but never walks); a render bind at
-- Character priority + 1 wins, so auto-guard actually paths to the ball.
local GuardMoveDir = nil

local function StopGuardMovement(Humanoid, Root)
	GuardMoveDir = nil
	if not Humanoid then
		return
	end
	pcall(function()
		Humanoid:Move(Vector3.new(), false)
	end)
end

local function GetCourtFromRoot(Root)
	if not Root then
		return nil
	end
	local Map = Workspace:FindFirstChild("Map")
	local Courts = Map and Map:FindFirstChild("Courts")
	if not Courts then
		return nil
	end
	local Best, BestDist = nil, math.huge
	for _, Court in ipairs(Courts:GetChildren()) do
		local Part = Court:IsA("BasePart") and Court or Court:FindFirstChildWhichIsA("BasePart", true)
		if Part then
			local Dist = (Part.Position - Root.Position).Magnitude
			if Dist < BestDist then
				BestDist = Dist
				Best = Court
			end
		end
	end
	if not Best or BestDist > 140 then
		return nil
	end
	return Best
end

local function GetOffenseHoop(CarrierRoot, CarrierCharacter)
	local _, Hoop = GetRimPosition(CarrierCharacter)
	if Hoop then
		local Rim = Hoop:FindFirstChild("RimMesh", true) or Hoop:FindFirstChild("Rim", true)
		if Rim and Rim:IsA("BasePart") then
			return Rim
		end
		if Rim then
			local Part = Rim:FindFirstChildWhichIsA("BasePart", true)
			if Part then
				return Part
			end
		end
		return Hoop:FindFirstChildWhichIsA("BasePart", true)
	end
	if not CarrierRoot then
		return nil
	end
	local Court = GetCourtFromRoot(CarrierRoot)
	if not Court then
		return nil
	end
	local Best, BestDist = nil, math.huge
	for _, Desc in ipairs(Court:GetDescendants()) do
		if Desc:IsA("BasePart") then
			local Name = Desc.Name:lower()
			if Name:find("rim") or Name:find("hoop") or Name:find("goal") then
				local Dist = (Desc.Position - CarrierRoot.Position).Magnitude
				if Dist < BestDist then
					BestDist = Dist
					Best = Desc
				end
			end
		end
	end
	return Best
end

local function FindBallCarrier()
	local MyRoot = GetRoot()
	if not MyRoot then
		return nil, nil
	end
	local MyCourt = GetCourtFromRoot(MyRoot)
	local BestPlayer, BestRoot, BestScore = nil, nil, math.huge
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and PlayerHasBall(Player) and IsEnemy(Player) then
			local Root = GetRoot(Player.Character)
			if Root then
				local Dist = (Root.Position - MyRoot.Position).Magnitude
				if Dist <= 45 then
					local Score = Dist
					if MyCourt and GetCourtFromRoot(Root) == MyCourt then
						Score -= 8
					end
					if Score < BestScore then
						BestScore = Score
						BestPlayer = Player
						BestRoot = Root
					end
				end
			end
		end
	end
	return BestPlayer, BestRoot
end

local function IsGuardKeyHeld()
	local Key = Config.GuardKey
	if not Key then
		return false
	end
	if UserInputService:IsKeyDown(Key) then
		return true
	end
	if Key == Enum.KeyCode.ButtonL2 then
		return UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonL2)
	end
	if UserInputService:IsGamepadButtonDown(Enum.UserInputType.Gamepad1, Key) then
		return true
	end
	return false
end

local function UpdateGuardHoldFromInput()
	if not Config.AutoGuard then
		Config.GuardHoldActive = false
		Config.GuardUiToggle = false
		return
	end
	-- UI toggle (mobile button / latched) OR physical hold key / gamepad
	Config.GuardHoldActive = Config.GuardUiToggle or IsGuardKeyHeld()
end

local function RunAutoGuard()
	UpdateGuardHoldFromInput()

	-- Default to no forced movement each frame; only the pathing branch sets it.
	GuardMoveDir = nil

	if not (Config.AutoGuard and Config.GuardHoldActive) then
		SetGuardState(false)
		return
	end

	local Character = GetCharacter()
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Root = GetRoot(Character)
	if not Humanoid or not Root then
		return
	end

	if HasBall() then
		SetGuardState(false)
		return
	end

	local Carrier, CarrierRoot = FindBallCarrier()
	if not CarrierRoot then
		SetGuardState(false)
		return
	end

	local Dist = (CarrierRoot.Position - Root.Position).Magnitude
	local Limit = math.min(Config.GuardDistance, MaxGuardDistance)
	local EngageRange = math.max(Limit + 22, 32)
	if Dist > EngageRange then
		SetGuardState(false)
		return
	end

	local Velocity = CarrierRoot.AssemblyLinearVelocity
	local Predicted = CarrierRoot.Position + Velocity * Config.GuardPrediction
	Predicted = Vector3.new(Predicted.X, CarrierRoot.Position.Y, Predicted.Z)

	local Hoop = GetOffenseHoop(CarrierRoot, Carrier and Carrier.Character)
	local FlatLook = Vector3.new(CarrierRoot.CFrame.LookVector.X, 0, CarrierRoot.CFrame.LookVector.Z)
	local ToHoop
	if Hoop and Hoop.Position then
		ToHoop = Vector3.new(Hoop.Position.X - Predicted.X, 0, Hoop.Position.Z - Predicted.Z)
	end
	if not ToHoop or ToHoop.Magnitude < 0.15 then
		ToHoop = FlatLook.Magnitude > 0.15 and FlatLook
			or Vector3.new(Root.Position.X - Predicted.X, 0, Root.Position.Z - Predicted.Z)
	end
	if ToHoop.Magnitude < 0.05 then
		SetGuardState(false)
		return
	end

	local FrontDist = math.clamp(Config.GuardDistance * 0.35, 2.6, 4.4)
	local GuardPos = Predicted + ToHoop.Unit * FrontDist
	GuardPos = Vector3.new(GuardPos.X, Root.Position.Y, GuardPos.Z)

	local Flat = Vector3.new(GuardPos.X - Root.Position.X, 0, GuardPos.Z - Root.Position.Z)
	local FlatDist = Flat.Magnitude
	local ToCarrier = Vector3.new(Predicted.X - Root.Position.X, 0, Predicted.Z - Root.Position.Z)
	local FromCarrier = -ToCarrier
	local Align = 0
	if ToHoop.Magnitude > 0.1 and FromCarrier.Magnitude > 0.1 then
		Align = FromCarrier.Unit:Dot(ToHoop.Unit)
	end
	local InFront = Dist <= Limit + 1.5 and Align >= 0.25 and FlatDist <= 2.8

	if not InFront then
		-- Path to front spot; do NOT enter guard stance yet (stance roots movement).
		SetGuardState(false)
		Humanoid.AutoRotate = true
		if FlatDist > 0.35 then
			if Dist <= Limit + 2.5 and ToCarrier.Magnitude > 0.2 then
				local Side = Vector3.new(-ToCarrier.Z, 0, ToCarrier.X)
				if Side.Magnitude > 0.1 then
					if Side:Dot(Flat) < 0 then
						Side = -Side
					end
					GuardMoveDir = (Side.Unit * 0.8 + Flat.Unit * 0.45).Unit
				else
					GuardMoveDir = Flat.Unit
				end
			else
				GuardMoveDir = Flat.Unit
			end
		else
			GuardMoveDir = nil
		end
	else
		GuardMoveDir = nil
		Humanoid:Move(Vector3.zero, false)
		local FaceFlat = Vector3.new(Predicted.X - Root.Position.X, 0, Predicted.Z - Root.Position.Z)
		if FaceFlat.Magnitude > 0.1 then
			local Face = CFrame.lookAt(Root.Position, Root.Position + FaceFlat.Unit)
			Root.CFrame = CFrame.new(Root.Position) * (Face - Face.Position)
		end
		SetGuardState(true)
	end
end

local function FindLooseBall()
	local Root = GetRoot()
	if not Root then
		return nil
	end
	local Character = GetCharacter()
	local Best, BestDist = nil, math.huge
	local function Consider(Part)
		if not Part or not Part:IsA("BasePart") then
			return
		end
		if Character and Part:IsDescendantOf(Character) then
			return
		end
		local Dist = (Part.Position - Root.Position).Magnitude
		if Dist < BestDist then
			BestDist = Dist
			Best = Part
		end
	end

	local Map = Workspace:FindFirstChild("Map")
	local MapBalls = Map and Map:FindFirstChild("Balls")
	if MapBalls then
		for _, Child in ipairs(MapBalls:GetChildren()) do
			Consider(Child:IsA("BasePart") and Child or Child:FindFirstChildWhichIsA("BasePart"))
		end
	end

	local Balls = Workspace:FindFirstChild("Balls")
	if Balls then
		for _, Child in ipairs(Balls:GetChildren()) do
			Consider(Child:IsA("BasePart") and Child or Child:FindFirstChildWhichIsA("BasePart"))
		end
	end

	for _, Child in ipairs(Workspace:GetChildren()) do
		if Child.Name == "Ball" or Child.Name == "Basketball" then
			Consider(Child:IsA("BasePart") and Child or Child:FindFirstChildWhichIsA("BasePart"))
		end
	end

	return Best
end

local function GetNearestCourt()
	local Root = GetRoot()
	if not Root then
		return nil
	end
	local Best, BestDist = nil, math.huge
	local Map = Workspace:FindFirstChild("Map")
	local Courts = Map and Map:FindFirstChild("Courts")
	if not Courts then
		return nil
	end
	for _, Court in ipairs(Courts:GetChildren()) do
		local Part = Court:IsA("BasePart") and Court or Court:FindFirstChildWhichIsA("BasePart", true)
		if Part then
			local Dist = (Part.Position - Root.Position).Magnitude
			if Dist < BestDist then
				BestDist = Dist
				Best = Part
			end
		end
	end
	return Best
end

local function GetNearestHoop()
	local Root = GetRoot()
	if not Root then
		return nil
	end
	local Best, BestDist = nil, math.huge
	local Map = Workspace:FindFirstChild("Map")
	local Courts = Map and Map:FindFirstChild("Courts")
	if not Courts then
		return nil
	end
	for _, Court in ipairs(Courts:GetDescendants()) do
		if Court.Name:lower():find("hoop") or Court.Name:lower():find("rim") then
			local Part = Court:IsA("BasePart") and Court or Court:FindFirstChildWhichIsA("BasePart")
			if Part then
				local Dist = (Part.Position - Root.Position).Magnitude
				if Dist < BestDist then
					BestDist = Dist
					Best = Part
				end
			end
		end
	end
	return Best
end

local function SoftTeleport(Part)
	local Root = GetRoot()
	if not Root or not Part then
		return
	end
	Root.CFrame = Part.CFrame + Vector3.new(0, 3, 0)
end

local function ClearStealHitboxes()
	for _, Part in pairs(StealHitboxes) do
		pcall(function()
			Part:Destroy()
		end)
	end
	table.clear(StealHitboxes)
	local Character = GetCharacter()
	if Character then
		if OriginalHitboxSize then
			local Hitbox = Character:FindFirstChild("Hitbox")
			if Hitbox and Hitbox:IsA("BasePart") then
				Hitbox.Size = OriginalHitboxSize
			end
			OriginalHitboxSize = nil
		end
		if OriginalScreenHitboxSize then
			local ScreenHitbox = Character:FindFirstChild("ScreenHitbox")
			if ScreenHitbox and ScreenHitbox:IsA("BasePart") then
				ScreenHitbox.Size = OriginalScreenHitboxSize
			end
			OriginalScreenHitboxSize = nil
		end
	end
end

local function UpdateStealReach()
	local Character = GetCharacter()
	if not Character then
		return
	end

	if not Config.StealReach then
		ClearStealHitboxes()
		return
	end

	-- Soft hand expand only â€” never resize body hitboxes / never CFrame welded parts
	local Scale = math.clamp(tonumber(Config.ReachMultiplier) or 2.5, 1, 6)
	for _, HandName in ipairs({ "LeftHand", "RightHand" }) do
		local Hand = Character:FindFirstChild(HandName)
		if Hand and Hand:IsA("BasePart") then
			local Box = StealHitboxes[HandName]
			if not Box or not Box.Parent then
				Box = Instance.new("Part")
				Box.Name = "EchoStealReach"
				Box.Size = Vector3.new(1.2, 1.2, 1.2) * Scale
				Box.Transparency = 1
				Box.CanCollide = false
				Box.Massless = true
				Box.Anchored = false
				Box.CanTouch = true
				Box.CanQuery = true
				Box.CastShadow = false
				Box.CFrame = Hand.CFrame
				Box.Parent = Character
				local Weld = Instance.new("WeldConstraint")
				Weld.Part0 = Hand
				Weld.Part1 = Box
				Weld.Parent = Box
				StealHitboxes[HandName] = Box
			else
				Box.Size = Vector3.new(1.2, 1.2, 1.2) * Scale
				Box.CanCollide = false
				Box.Anchored = false
				Box.Massless = true
			end
		end
	end
end

local function EnsureEspFolder()
	if EspFolder and EspFolder.Parent then
		return EspFolder
	end
	EspFolder = Instance.new("Folder")
	EspFolder.Name = "EchoPlaygroundEsp"
	pcall(function()
		EspFolder.Parent = CoreGui
	end)
	if not EspFolder.Parent then
		EspFolder.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
	end
	return EspFolder
end

local function ClearHighlightTable(Table)
	for Character, Highlight in pairs(Table) do
		pcall(function()
			Highlight:Destroy()
		end)
		Table[Character] = nil
	end
end

local function UpsertHighlight(Store, Character, Color)
	if not Character or not Character.Parent then
		local Existing = Store[Character]
		if Existing then
			pcall(function()
				Existing:Destroy()
			end)
			Store[Character] = nil
		end
		return
	end

	local Highlight = Store[Character]
	if not Highlight or not Highlight.Parent then
		Highlight = Instance.new("Highlight")
		Highlight.Name = "EchoEsp"
		Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		Highlight.Parent = Character
		Store[Character] = Highlight
	end

	Highlight.Adornee = Character
	Highlight.FillColor = Color
	Highlight.OutlineColor = Color
	Highlight.FillTransparency = Config.EspFillTransparency
	Highlight.OutlineTransparency = Config.EspOutlineTransparency
	Highlight.Enabled = true
end

local function CharacterHasBall(Character)
	if not Character then
		return false
	end
	return CharacterHasPossession(Character, Players:GetPlayerFromCharacter(Character))
end

local function UpdateEsp()
	local SeenCarrier = {}
	local SeenOpponent = {}

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer then
			local Character = Player.Character
			if Character and Character.Parent then
				local Holding = CharacterHasBall(Character) or PlayerHasBall(Player)
				if Config.CarrierEsp and Holding then
					SeenCarrier[Character] = true
					UpsertHighlight(CarrierHighlights, Character, Config.CarrierEspColor)
				elseif Config.OpponentEsp and IsEnemy(Player) then
					SeenOpponent[Character] = true
					UpsertHighlight(OpponentHighlights, Character, Config.OpponentEspColor)
				end
			end
		end
	end

	for Character, Highlight in pairs(CarrierHighlights) do
		if not Config.CarrierEsp or not SeenCarrier[Character] or not Character.Parent then
			pcall(function()
				Highlight:Destroy()
			end)
			CarrierHighlights[Character] = nil
		end
	end
	for Character, Highlight in pairs(OpponentHighlights) do
		if not Config.OpponentEsp or not SeenOpponent[Character] or not Character.Parent or SeenCarrier[Character] then
			pcall(function()
				Highlight:Destroy()
			end)
			OpponentHighlights[Character] = nil
		end
	end
end

local function RunAutoReach()
	if not Config.AutoReach or HasBall() then
		return
	end
	local Now = os.clock()
	if Now - ReachClock < 0.14 then
		return
	end

	local Root = GetRoot()
	if not Root then
		return
	end

	local Carrier, CarrierRoot = FindBallCarrier()
	local TargetPos = nil
	local TargetDist = math.huge
	if CarrierRoot then
		TargetPos = CarrierRoot.Position + CarrierRoot.AssemblyLinearVelocity * 0.1
		TargetDist = (TargetPos - Root.Position).Magnitude
	else
		local Ball = FindLooseBall()
		if Ball then
			TargetPos = Ball.Position
			TargetDist = (Ball.Position - Root.Position).Magnitude
		end
	end
	if not TargetPos then
		return
	end

	local Range = 6.5
	if Config.StealReach then
		Range += math.clamp((tonumber(Config.ReachMultiplier) or 2.5) * 0.35, 0, 2)
	end
	if TargetDist > Range then
		return
	end

	local Flat = Vector3.new(TargetPos.X - Root.Position.X, 0, TargetPos.Z - Root.Position.Z)
	if Flat.Magnitude > 0.05 then
		Root.CFrame = CFrame.lookAt(Root.Position, Root.Position + Flat.Unit)
	end

	ReachClock = Now
	FireAction({ Action = "Reach", Reach = true })
end

local function RunAutoBlock()
	if not Config.AutoBlock or HasBall() then
		return
	end
	local LocalCharacter = GetCharacter()
	local LocalAction = LocalCharacter and LocalCharacter:GetAttribute("Action")
	if LocalAction == "Dunking" or LocalAction == "Shooting" or DunkActive or DunkArmed then
		return
	end
	local Now = os.clock()
	if Now - BlockClock < 0.18 then
		return
	end
	local Root = GetRoot()
	if not Root then
		return
	end
	for _, Player in ipairs(Players:GetPlayers()) do
		if IsEnemy(Player) and Player.Character then
			local Action = Player.Character:GetAttribute("Action")
			if Action == "Shooting" or Action == "Dunking" then
				local TheirRoot = GetRoot(Player.Character)
				if TheirRoot and (TheirRoot.Position - Root.Position).Magnitude <= Config.BlockDistance then
					BlockClock = Now
					FireAction({ Action = "Jump", Jump = true })
					task.delay(0.12, function()
						FireAction({ Action = "Jump", Jump = false })
					end)
					return
				end
			end
		end
	end
end

local function RunReboundTp()
	if not Config.ReboundTp or HasBall() then
		return
	end
	local Root = GetRoot()
	local Ball = FindLooseBall()
	if not Root or not Ball then
		return
	end
	if (Ball.Position - Root.Position).Magnitude > 55 then
		return
	end
	Root.CFrame = CFrame.new(Ball.Position + Ball.CFrame.LookVector * Config.ReboundOffset + Vector3.new(0, 2.5, 0))
end

local function RunFollowCarrier()
	if not Config.FollowCarrier or HasBall() then
		return
	end
	local Root = GetRoot()
	local _, CarrierRoot = FindBallCarrier()
	if not Root or not CarrierRoot then
		return
	end
	Root.CFrame = CarrierRoot.CFrame * CFrame.new(0, 0, Config.FollowOffset)
end

local function RunSpeedBoost()
	local Character = GetCharacter()
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end
	if not Config.SpeedBoost then
		return
	end
	local Amount = math.clamp(tonumber(Config.SpeedAmount) or DefaultWalkSpeed, 14, 25)
	Humanoid.WalkSpeed = math.max(Humanoid.WalkSpeed, Amount)
end

local function RunAlwaysSprint()
	if not Config.AlwaysSprint or not ActionRemote then
		return
	end
	local Character = GetCharacter()
	if not Character then
		return
	end
	if Character:GetAttribute("Sprinting") ~= true and (tonumber(Character:GetAttribute("Stamina")) or 0) > 1 then
		FireAction({ Type = "Sprint", Sprinting = true })
	end
end

local function RunInfiniteStamina()
	if not Config.InfiniteStamina then
		return
	end
	local Character = GetCharacter()
	if Character then
		pcall(function()
			Character:SetAttribute("Stamina", 100)
		end)
	end
end

local function OnActionPayload(Payload)
	if typeof(Payload) ~= "table" then
		return
	end

	local Type = Payload.Type
	local Action = Payload.Action

	if Action == "Guard" then
		if Config.AutoGuard and Config.GuardHoldActive and not ApplyingGuard then
			if Payload.Guard == true then
				return true
			end
		end
	end

	if Type == "Shoot" then
		if Payload.Shoot == true then
			if Config.AutoGreen then
				task.defer(ScheduleAutoGreen)
			end
		elseif Payload.Shoot == false then
			if AutoReleasingShot then
				return
			end
			if Config.AutoGreen and ShotArmed then
				return true
			end
			if Config.AutoGreen and os.clock() < ShotLockUntil then
				return true
			end
			if Config.AutoGreen and ShotActive and not ShotArmed then
				ShotToken += 1
				ShotActive = false
				ShotStartedAt = 0
			end
		end
	elseif Action == "Jump" then
		if Payload.Jump == true then
			if Config.AutoDunkGreen and HasBall() then
				if DunkSuppressHold or os.clock() < DunkLockUntil then
					return true
				end
				task.defer(ScheduleAutoDunk)
			end
		elseif Payload.Jump == false then
			if AutoReleasingDunk then
				return
			end
			if Config.AutoDunkGreen and DunkArmed then
				return true
			end
			if Config.AutoDunkGreen and os.clock() < DunkLockUntil then
				return true
			end
			DunkSuppressHold = false
			DunkActive = false
			DunkArmed = false
		end
	end
end

local function IsActionRemote(Self)
	if Self == ActionRemote then
		return true
	end
	return typeof(Self) == "Instance"
		and Self.ClassName == "RemoteEvent"
		and Self.Name == "Action"
		and Self.Parent
		and Self.Parent.Name == "Server"
end

local function InstallHooks()
	if HookInstalled then
		return true
	end
	if not ResolveDeps() then
		return false
	end
	if typeof(hookmetamethod) ~= "function" or typeof(getnamecallmethod) ~= "function" then
		return false
	end

	local Handler = function(Self, ...)
		local Method = getnamecallmethod()
		if Method == "FireServer" and IsActionRemote(Self) then
			local Caller = typeof(checkcaller) == "function" and checkcaller()
			if not Caller then
				local Args = { ... }
				local Block = OnActionPayload(Args[1])
				if Block then
					return
				end
			end
		end
		return OldNamecall(Self, ...)
	end

	local Ok, Result = pcall(function()
		if typeof(newcclosure) == "function" then
			return hookmetamethod(game, "__namecall", newcclosure(Handler))
		end
		return hookmetamethod(game, "__namecall", Handler)
	end)
	if not Ok then
		warn("[Echo] Action hook failed: " .. tostring(Result))
		return false
	end

	OldNamecall = Result
	HookInstalled = true
	return true
end

local function UninstallHooks()
	ShotToken += 1
	DunkToken += 1
	ShotActive = false
	DunkActive = false
	ShotArmed = false
	DunkArmed = false
	DunkSuppressHold = false
	SetGuardState(false)
	HookInstalled = false
end

local function WatchShotAttributes()
	local Character = GetCharacter()
	if not Character then
		return
	end
	TrackConnection(Character:GetAttributeChangedSignal("Action"), function()
		local Action = Character:GetAttribute("Action")
		if Action == "Shooting" and Config.AutoGreen and not ShotActive then
			ScheduleAutoGreen()
		elseif Action == "Dunking" and Config.AutoDunkGreen and not DunkActive then
			ScheduleAutoDunk()
		elseif Action ~= "Dunking" then
			DunkSuppressHold = false
		end
	end)

	TrackConnection(Character:GetAttributeChangedSignal("Released"), function()
		if Character:GetAttribute("Released") == true then
			DunkSuppressHold = false
		end
	end)
end

local function IsGuardKey(KeyCode)
	return KeyCode == Config.GuardKey
end

local function BuildMobileGui()
	if MobileGui then
		pcall(function()
			MobileGui:Destroy()
		end)
		MobileGui = nil
	end
	if not UserInputService.TouchEnabled then
		return
	end

	MobileGui = Instance.new("ScreenGui")
	MobileGui.Name = "EchoPlaygroundMobile"
	MobileGui.ResetOnSpawn = false
	MobileGui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)

	StatusLabel = Instance.new("TextLabel")
	StatusLabel.Size = UDim2.fromOffset(180, 24)
	StatusLabel.Position = UDim2.new(0.5, -90, 0, 12)
	StatusLabel.BackgroundTransparency = 1
	StatusLabel.Text = "Auto Green: OFF"
	StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
	StatusLabel.Font = Enum.Font.GothamBold
	StatusLabel.TextSize = 14
	StatusLabel.Parent = MobileGui

	local GuardBtn = Instance.new("TextButton")
	GuardBtn.Size = UDim2.fromOffset(110, 42)
	GuardBtn.Position = UDim2.new(1, -130, 1, -90)
	GuardBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	GuardBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	GuardBtn.Font = Enum.Font.GothamBold
	GuardBtn.TextSize = 14
	GuardBtn.Text = "Guard: OFF"
	GuardBtn.Parent = MobileGui
	Instance.new("UICorner", GuardBtn).CornerRadius = UDim.new(0, 8)

	GuardBtn.MouseButton1Click:Connect(function()
		if not Config.AutoGuard then
			Library:Notification("Guard", "Enable Auto Guard first", 3)
			return
		end
		Config.GuardUiToggle = not Config.GuardUiToggle
		Config.GuardHoldActive = Config.GuardUiToggle or IsGuardKeyHeld()
		GuardBtn.Text = Config.GuardUiToggle and "Guard: ON" or "Guard: OFF"
		GuardBtn.BackgroundColor3 = Config.GuardUiToggle and Color3.fromRGB(0, 150, 50) or Color3.fromRGB(40, 40, 40)
		if not Config.GuardHoldActive then
			SetGuardState(false)
			local Character = GetCharacter()
			StopGuardMovement(Character and Character:FindFirstChildOfClass("Humanoid"), GetRoot(Character))
		end
	end)
end

GreenSection:Toggle({
	Name = "Enabled",
	Flag = "AutoGreen",
	Default = Config.AutoGreen,
	Callback = function(Value)
		Config.AutoGreen = Value
		if Value then
			InstallHooks()
		end
	end,
})

GreenSection:Dropdown({
	Name = "Quality",
	Flag = "GreenMode",
	Items = { "Perfect", "Great", "Good", "Okay", "Custom", "Random" },
	Default = Config.GreenMode,
	Callback = function(Value)
		Config.GreenMode = Value
	end,
})

GreenSection:Toggle({
	Name = "Randomize Quality",
	Flag = "RandomizeGreen",
	Default = Config.RandomizeGreen,
	Callback = function(Value)
		Config.RandomizeGreen = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Custom Release %",
	Flag = "GreenPercent",
	Min = 70,
	Max = 100,
	Default = Config.GreenPercent,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.GreenPercent = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Perfect Chance",
	Flag = "PerfectChance",
	Min = 0,
	Max = 100,
	Default = Config.PerfectChance,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.PerfectChance = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Great Chance",
	Flag = "GreatChance",
	Min = 0,
	Max = 100,
	Default = Config.GreatChance,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.GreatChance = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Good Chance",
	Flag = "GoodChance",
	Min = 0,
	Max = 100,
	Default = Config.GoodChance,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.GoodChance = Value
	end,
})

GreenTuneSection:Slider({
	Name = "Timing Offset",
	Flag = "GreenDelayOffset",
	Min = -0.08,
	Max = 0.08,
	Default = Config.GreenDelayOffset,
	Decimals = 0.001,
	Suffix = "",
	Callback = function(Value)
		Config.GreenDelayOffset = Value
	end,
})

DunkSection:Toggle({
	Name = "Enabled",
	Flag = "AutoDunkGreen",
	Default = Config.AutoDunkGreen,
	Callback = function(Value)
		Config.AutoDunkGreen = Value
		if Value then
			InstallHooks()
		end
	end,
})

DunkSection:Dropdown({
	Name = "Quality",
	Flag = "DunkMode",
	Items = { "Perfect", "Great", "Good", "Custom", "Random" },
	Default = Config.DunkMode,
	Callback = function(Value)
		Config.DunkMode = Value
	end,
})

DunkSection:Slider({
	Name = "Custom Release %",
	Flag = "DunkPercent",
	Min = 70,
	Max = 100,
	Default = Config.DunkPercent,
	Decimals = 1,
	Suffix = "%",
	Callback = function(Value)
		Config.DunkPercent = Value
	end,
})

BallSection:Toggle({
	Name = "Rebound TP",
	Flag = "ReboundTp",
	Default = Config.ReboundTp,
	Callback = function(Value)
		Config.ReboundTp = Value
	end,
})

BallSection:Slider({
	Name = "Rebound Offset",
	Flag = "ReboundOffset",
	Min = 0,
	Max = 6,
	Default = Config.ReboundOffset,
	Decimals = 1,
	Callback = function(Value)
		Config.ReboundOffset = Value
	end,
})

BallSection:Toggle({
	Name = "Follow Carrier",
	Flag = "FollowCarrier",
	Default = Config.FollowCarrier,
	Callback = function(Value)
		Config.FollowCarrier = Value
	end,
})

BallSection:Slider({
	Name = "Follow Offset",
	Flag = "FollowOffset",
	Min = -12,
	Max = 12,
	Default = Config.FollowOffset,
	Decimals = 1,
	Callback = function(Value)
		Config.FollowOffset = Value
	end,
})

GuardSection:Toggle({
	Name = "Enabled",
	Flag = "AutoGuard",
	Default = Config.AutoGuard,
	Callback = function(Value)
		Config.AutoGuard = Value
		if not Value then
			Config.GuardHoldActive = false
			Config.GuardUiToggle = false
			SetGuardState(false)
		else
			InstallHooks()
		end
	end,
})

GuardSection:Dropdown({
	Name = "Hold Key",
	Flag = "GuardKeyName",
	Items = { "G", "Q", "F", "V", "C", "LeftControl", "LeftAlt", "ButtonL2" },
	Default = "G",
	Callback = function(Value)
		local Map = {
			G = Enum.KeyCode.G,
			Q = Enum.KeyCode.Q,
			F = Enum.KeyCode.F,
			V = Enum.KeyCode.V,
			C = Enum.KeyCode.C,
			LeftControl = Enum.KeyCode.LeftControl,
			LeftAlt = Enum.KeyCode.LeftAlt,
			ButtonL2 = Enum.KeyCode.ButtonL2,
		}
		Config.GuardKey = Map[Value] or Enum.KeyCode.G
	end,
})

GuardSection:Slider({
	Name = "Distance",
	Flag = "GuardDistance",
	Min = 4,
	Max = 20,
	Default = Config.GuardDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.GuardDistance = Value
	end,
})

GuardSection:Slider({
	Name = "Prediction",
	Flag = "GuardPrediction",
	Min = 0,
	Max = 0.8,
	Default = Config.GuardPrediction,
	Decimals = 0.01,
	Suffix = "s",
	Callback = function(Value)
		Config.GuardPrediction = Value
	end,
})

DefenseToolsSection:Toggle({
	Name = "Auto Reach",
	Flag = "AutoReach",
	Default = Config.AutoReach,
	Callback = function(Value)
		Config.AutoReach = Value
	end,
})

DefenseToolsSection:Toggle({
	Name = "Auto Block",
	Flag = "AutoBlock",
	Default = Config.AutoBlock,
	Callback = function(Value)
		Config.AutoBlock = Value
	end,
})

DefenseToolsSection:Slider({
	Name = "Block Distance",
	Flag = "BlockDistance",
	Min = 5,
	Max = 20,
	Default = Config.BlockDistance,
	Decimals = 1,
	Callback = function(Value)
		Config.BlockDistance = Value
	end,
})

DefenseToolsSection:Toggle({
	Name = "Steal Reach",
	Flag = "StealReach",
	Default = Config.StealReach,
	Callback = function(Value)
		Config.StealReach = Value
		UpdateStealReach()
	end,
})

DefenseToolsSection:Slider({
	Name = "Steal Size",
	Flag = "ReachMultiplier",
	Min = 1,
	Max = 12,
	Default = Config.ReachMultiplier,
	Decimals = 0.1,
	Suffix = "x",
	Callback = function(Value)
		Config.ReachMultiplier = Value
		if Config.StealReach then
			UpdateStealReach()
		end
	end,
})

MovementSection:Toggle({
	Name = "Speed Boost",
	Flag = "SpeedBoost",
	Default = Config.SpeedBoost,
	Callback = function(Value)
		Config.SpeedBoost = Value
	end,
})

MovementSection:Slider({
	Name = "Speed",
	Flag = "SpeedAmount",
	Min = 14,
	Max = 25,
	Default = Config.SpeedAmount,
	Decimals = 0.1,
	Callback = function(Value)
		Config.SpeedAmount = math.clamp(Value, 14, 25)
	end,
})

MovementSection:Toggle({
	Name = "Always Sprint",
	Flag = "AlwaysSprint",
	Default = Config.AlwaysSprint,
	Callback = function(Value)
		Config.AlwaysSprint = Value
		if not Value then
			FireAction({ Type = "Sprint", Sprinting = false })
		end
	end,
})

StaminaSection:Toggle({
	Name = "Infinite Stamina",
	Flag = "InfiniteStamina",
	Default = Config.InfiniteStamina,
	Callback = function(Value)
		Config.InfiniteStamina = Value
	end,
})

EspSection:Toggle({
	Name = "Ball Carrier ESP",
	Flag = "CarrierEsp",
	Default = Config.CarrierEsp,
	Callback = function(Value)
		Config.CarrierEsp = Value
		if not Value then
			ClearHighlightTable(CarrierHighlights)
		end
	end,
})

EspSection:Toggle({
	Name = "Opponent ESP",
	Flag = "OpponentEsp",
	Default = Config.OpponentEsp,
	Callback = function(Value)
		Config.OpponentEsp = Value
		if not Value then
			ClearHighlightTable(OpponentHighlights)
		end
	end,
})

EspStyleSection:Slider({
	Name = "Fill Transparency",
	Flag = "EspFillTransparency",
	Min = 0,
	Max = 1,
	Default = Config.EspFillTransparency,
	Decimals = 0.01,
	Callback = function(Value)
		Config.EspFillTransparency = Value
	end,
})

EspStyleSection:Slider({
	Name = "Outline Transparency",
	Flag = "EspOutlineTransparency",
	Min = 0,
	Max = 1,
	Default = Config.EspOutlineTransparency,
	Decimals = 0.01,
	Callback = function(Value)
		Config.EspOutlineTransparency = Value
	end,
})

do
	local TeleButtons = TeleSection:Button()
	TeleButtons:Add("TP Nearest Court", function()
		local Court = GetNearestCourt()
		if Court then
			SoftTeleport(Court)
			Library:Notification("Teleport", "Moved to nearest court", 3)
		else
			Library:Notification("Teleport", "No court found", 3)
		end
	end)
	TeleButtons:Add("TP Nearest Hoop", function()
		local Hoop = GetNearestHoop()
		if Hoop then
			SoftTeleport(Hoop)
			Library:Notification("Teleport", "Moved to nearest hoop", 3)
		else
			Library:Notification("Teleport", "No hoop found", 3)
		end
	end)
end

do
	local ServerButtons = ServerSection:Button()
	ServerButtons:Add("Rejoin", function()
		TeleportService:Teleport(game.PlaceId, LocalPlayer)
	end)
	ServerButtons:Add("Server Hop", function()
		local Ok, Servers = pcall(function()
			return HttpService:JSONDecode(game:HttpGet(
				"https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
			))
		end)
		if not Ok or not Servers or not Servers.data then
			Library:Notification("Server", "Failed to fetch servers", 3)
			return
		end
		for _, Server in ipairs(Servers.data) do
			if Server.id ~= game.JobId and Server.playing < Server.maxPlayers then
				TeleportService:TeleportToPlaceInstance(game.PlaceId, Server.id, LocalPlayer)
				return
			end
		end
		Library:Notification("Server", "No open servers found", 3)
	end)
end

ResolveDeps()
InstallHooks()
BuildMobileGui()

if LocalPlayer.Character then
	WatchShotAttributes()
end

TrackConnection(LocalPlayer.CharacterAdded, function()
	task.wait(0.5)
	ResolveDeps()
	OriginalHitboxSize = nil
	OriginalScreenHitboxSize = nil
	ClearStealHitboxes()
	WatchShotAttributes()
	if Config.StealReach then
		UpdateStealReach()
	end
end)

TrackConnection(UserInputService.InputBegan, function(Input, GameProcessed)
	if Config.AutoGuard and IsGuardKey(Input.KeyCode) then
		Config.GuardHoldActive = true
		return
	end
	if GameProcessed then
		return
	end
end)

TrackConnection(UserInputService.InputEnded, function(Input)
	if IsGuardKey(Input.KeyCode) then
		Config.GuardHoldActive = Config.GuardUiToggle
		if not Config.GuardHoldActive then
			SetGuardState(false)
			local Character = GetCharacter()
			StopGuardMovement(Character and Character:FindFirstChildOfClass("Humanoid"), GetRoot(Character))
		end
	end
end)

TrackConnection(RunService.RenderStepped, function()
	pcall(RunSpeedBoost)
	pcall(UpdateStealReach)
end)

-- Apply guard pathing AFTER the default control module so our walk direction
-- wins (a Heartbeat/RenderStepped Move gets overwritten by the control script).
local GuardBindName = "EchoGuardMove"
pcall(function()
	pcall(function()
		RunService:UnbindFromRenderStep(GuardBindName)
	end)
	RunService:BindToRenderStep(GuardBindName, Enum.RenderPriority.Character.Value + 1, function()
		local Dir = GuardMoveDir
		if typeof(Dir) ~= "Vector3" or Dir.Magnitude < 0.05 then
			return
		end
		if not (Config.AutoGuard and Config.GuardHoldActive) then
			return
		end
		local Character = GetCharacter()
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid:Move(Dir.Unit, false)
		end
	end)
end)

TrackConnection(RunService.Heartbeat, function()
	pcall(RunInfiniteStamina)
	pcall(RunAlwaysSprint)
	pcall(RunAutoGuard)
	pcall(RunAutoReach)
	pcall(RunAutoBlock)
	pcall(RunReboundTp)
	pcall(RunFollowCarrier)
	pcall(UpdateEsp)

	if Config.AutoGreen or Config.AutoDunkGreen then
		local Character = GetCharacter()
		local Meter = Character and Character:FindFirstChild("ShotMeterUI")
		local Action = Character and Character:GetAttribute("Action")
		if Meter and Meter.Enabled then
			if Config.AutoGreen and Action == "Shooting" and not ShotActive then
				ScheduleAutoGreen()
			elseif Config.AutoDunkGreen and Action == "Dunking" and not DunkActive then
				ScheduleAutoDunk()
			end
		end

		-- stuck-shot failsafe: only while we own an active/armed shot
		if Config.AutoGreen and not AutoReleasingShot and (ShotActive or ShotArmed) then
			local HangTime = ShotStartedAt > 0 and (os.clock() - ShotStartedAt) or 0
			local MeterOn = Meter and Meter.Enabled
			if (Action == "Shooting" or MeterOn) and HangTime > 1.25 then
				FireShootRelease()
				ShotActive = false
				ShotArmed = false
				ShotToken += 1
				ShotStartedAt = 0
			elseif Action ~= "Shooting" and not MeterOn and HangTime > 0.15 then
				FireShootRelease()
				ShotActive = false
				ShotArmed = false
				ShotToken += 1
				ShotStartedAt = 0
			end
		end
	end

	if StatusLabel and StatusLabel.Parent then
		if Config.AutoGreen or Config.AutoDunkGreen then
			StatusLabel.Text = "Auto Green: ON"
			StatusLabel.TextColor3 = Color3.fromRGB(90, 255, 130)
		else
			StatusLabel.Text = "Auto Green: OFF"
			StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
		end
	end
end)

getgenv().EchoCleanup = function()
	Config.AutoGreen = false
	Config.AutoDunkGreen = false
	Config.AutoGuard = false
	Config.GuardHoldActive = false
	Config.GuardUiToggle = false
	Config.SpeedBoost = false
	Config.AlwaysSprint = false
	Config.ReboundTp = false
	Config.FollowCarrier = false
	Config.StealReach = false
	Config.CarrierEsp = false
	Config.OpponentEsp = false
	Config.InfiniteStamina = false

	GuardMoveDir = nil
	pcall(function()
		RunService:UnbindFromRenderStep(GuardBindName)
	end)

	UninstallHooks()
	ClearStealHitboxes()
	ClearHighlightTable(CarrierHighlights)
	ClearHighlightTable(OpponentHighlights)
	if EspFolder then
		pcall(function()
			EspFolder:Destroy()
		end)
		EspFolder = nil
	end
	if MobileGui then
		pcall(function()
			MobileGui:Destroy()
		end)
		MobileGui = nil
	end

	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)

	pcall(function()
		if Library and Library.Unload then
			Library:Unload()
		end
	end)
	pcall(function()
		EchoUiContainer:Destroy()
	end)
end

Library:Notification(
	"Echo",
	string.format("Playground loaded in %.2fs Â· full kit ready", os.clock() - LoadTick),
	5
)
]====], "Echo_Playground_Basketball")
	if not EchoChunk then
		error("[Echo] Playground Basketball compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsStreetLife() then
-- Echo Hub: Street Life
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local GuiService = game:GetService("GuiService")

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

-- Restore stock namecall only if a prior Echo hook exists (deferred — sync hookmetamethod crashes Potassium)
task.defer(function()
	task.wait(0.5)
	pcall(function()
		if typeof(getgenv().EchoBaseNamecall) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__namecall", getgenv().EchoBaseNamecall)
		end
		getgenv().EchoBaseNamecall = nil
		getgenv().EchoSilentHooked = nil
	end)
end)

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

getgenv().gethui = function()
	return EchoUiContainer
end

local EspOk, EspOrErr = pcall(function()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/BufferExploiters/EspLibrary5/refs/heads/main/esp/esp.lua"))()
end)

local Esp = EspOk and EspOrErr or nil
if not EspOk then
	warn("[Echo] ESP library failed: " .. tostring(EspOrErr))
end
-- Library defaults ESP on — force off immediately so it doesn't flash then vanish
pcall(function()
	if Esp and Esp.Table then
		Esp.Table.Enabled = false
	end
end)

local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoScootUI then
		return getgenv().__EchoScootUI
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/saintsrevival1/eee/refs/heads/main/UI-Source.lua"))()
	getgenv().__EchoScootUI = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
	return
end

local Library = LibraryOrErr
getgenv().Library = Library

pcall(function()
	Library.Round = function(_, Number, Float)
		if typeof(Number) ~= "number" or Number ~= Number then
			return 0
		end
		if typeof(Float) ~= "number" or Float ~= Float or Float == 0 then
			Float = 1
		end
		local Multiplier = 1 / Float
		return math.floor(Number * Multiplier + 1e-9) / Multiplier
	end
end)

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local Config = {
	SilentEnabled = false,
	SilentFov = 180,
	SilentShowFov = false,
	SilentHitPart = "Head",
	SilentGangCheck = false,
	SilentSticky = true,
	SilentMaxDistance = 800,
	SilentAirshot = false,
	SilentWallBang = false,

	CamlockEnabled = false,
	CamlockFov = 220,
	CamlockShowFov = false,
	CamlockHitPart = "Head",
	CamlockSmoothness = 0.18,
	CamlockSticky = true,
	CamlockKey = "Q",
	CamlockMode = "Toggle",
	CamlockActive = false,
	CamlockGangCheck = false,
	CamlockMaxDistance = 800,

	TriggerbotEnabled = false,
	TriggerbotDelay = 0.04,
	TriggerbotFov = 40,

	EspEnabled = false,
	EspDistance = 500,
	EspBoxes = true,
	EspBoxGlow = true,
	EspFilled = true,
	EspHealthBar = true,
	EspName = true,
	EspDistanceText = true,
	EspWeapon = true,
	EspColor = Color3.fromRGB(0, 255, 255),

	WalkSpeedEnabled = false,
	WalkSpeed = 22,
	JumpPowerEnabled = false,
	JumpPower = 55,
	FlyEnabled = false,
	FlySpeed = 40,
	InfiniteStamina = false,
	AntiAfk = false,
	FovEnabled = false,
	FovValue = 90,

	HitboxEnabled = false,
	HitboxSize = 3.5,
	HitboxTransparency = 0.7,

	NoRecoil = false,
	NoSpread = false,
	InfiniteAmmo = false,
	ForceAutomatic = false,
	NeverJam = false,
	KillAuraEnabled = false,
	AutoReload = false,
	RapidFire = false,
	RapidFireDelay = 0.05,
	InfiniteJump = false,
	ClickTp = false,
	ClickTpKey = "LeftControl",

	Fullbright = false,
	NoFog = false,
	NoShadows = false,
	Xray = false,
	PlayerHighlights = false,
	DropEsp = false,
	TracerEsp = false,

	VehicleSpeedEnabled = false,
	VehicleSpeed = 120,
	InstantInteract = false,
	AntiSit = false,
	MaxZoom = 128,
	Freecam = false,
	FreecamSpeed = 60,
	SpectateEnabled = false,
	SpectateTarget = "",

	AutoDaily = false,
}

local Connections = {}
local EchoUiRoots = {}
local SilentTarget = nil
local CamlockTarget = nil
local StickySilent = nil
local StickyCamlock = nil
local FovCircle = nil
local CamFovCircle = nil
local FireRemote = nil
local ReloadRemote = nil
local OldNamecall = nil
local HookInstalled = false
local ApplyAllGunMods
local SyncCombatHook
local KillAuraServerId = nil
local KillAuraTokenFn = nil
local OriginalGunSettings = {}
local RunBankRob = nil
local BankStatus = "Idle"
local FlyBodyVelocity = nil
local FlyBodyGyro = nil
local HitboxOriginal = setmetatable({}, { __mode = "k" })
local NoclipParts = setmetatable({}, { __mode = "k" })
local FlyKeysHeld = {
	W = false,
	A = false,
	S = false,
	D = false,
	Space = false,
	LeftShift = false,
}
local TriggerClock = 0
local RapidClock = 0
local ReloadClock = 0
local SpinAngle = 0
local OrbitAngle = 0
local FreecamConn = nil
local FreecamPart = nil
local OriginalLighting = nil
local XrayParts = setmetatable({}, { __mode = "k" })
local HighlightFolder = nil
local DropBillboards = {}
local TracerBeams = {}
local HitParts = { "Head", "HumanoidRootPart", "UpperTorso", "Torso", "LowerTorso" }
local PoiNames = {
	"GunStore", "GunStore2", "Bank", "BlackMarket", "Police", "CarDealer", "Warehouse",
	"Jewelry", "Museum", "Mansion", "Penthouse", "Arcade", "Gym", "Farm", "Supplies",
	"DripStore", "Clothing", "Tattoo", "Chop", "Garage", "Pier", "Merchant", "LootBuyer",
	"GunBuyer", "APT1", "APT2", "APT3", "APT4", "Houses", "ChickenJob", "IceCreamJob",
	"CleanJob", "CrateJob", "Studio", "GasStation",
}
local SelectedPoi = "GunStore"

local TeleportToPoi
local SafeTweenTeleport
local RestoreLighting
local StartFreecam
local StopFreecam
local ClearHighlights
local ClearTracers
local ClearDropEsp
local RestoreXray
local GetClosestPlayer
local IsFriendly
local MeetsRequirement
local RestorePlayerCamera

pcall(function()
	Library.MenuKeybind = tostring(Enum.KeyCode.RightShift)
end)

local Window = Library:Window({
	Logo = "72316209028225",
	FadeTime = 0.25,
})

local Watermark = Library:Watermark("Echo | Street Life")
local KeybindList = Library:KeybindList()

local CombatPage = Window:Page({ Name = "Combat", Columns = 2 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
local WorldPage = Window:Page({ Name = "World", Columns = 2 })
local TeleportPage = Window:Page({ Name = "Teleports", Columns = 2 })
local MiscPage = Window:Page({ Name = "Misc", Columns = 2 })
-- Settings last so it isn't the first tab
pcall(function()
	Library.MenuKeybind = tostring(Enum.KeyCode.RightShift)
	Library:CreateSettingsPage(Window, Watermark, KeybindList)
	Library.MenuKeybind = tostring(Enum.KeyCode.RightShift)
	if Library.Flags then
		Library.Flags.UIKeybind = {
			Mode = "Toggle",
			Key = tostring(Enum.KeyCode.RightShift),
			Toggled = false,
		}
	end
end)

local SilentSection = CombatPage:Section({ Name = "Silent Aim", Side = 1 })
local CamlockSection = CombatPage:Section({ Name = "Camlock", Side = 2 })
local TriggerSection = CombatPage:Section({ Name = "Triggerbot", Side = 2 })
local GunModSection = CombatPage:Section({ Name = "Gun Mods", Side = 1 })
local EspSection = VisualsPage:Section({ Name = "ESP", Side = 1 })
local EspStyleSection = VisualsPage:Section({ Name = "ESP Style", Side = 2 })
local ExtraVisualSection = VisualsPage:Section({ Name = "Extra Visuals", Side = 2 })
local MovementSection = PlayerPage:Section({ Name = "Movement", Side = 1 })
local LocalSection = PlayerPage:Section({ Name = "Local", Side = 2 })
local CombatMoveSection = PlayerPage:Section({ Name = "Combat Move", Side = 2 })
local LightingSection = WorldPage:Section({ Name = "Lighting", Side = 1 })
local VehicleSection = WorldPage:Section({ Name = "Vehicle", Side = 2 })
local InteractSection = WorldPage:Section({ Name = "Interact", Side = 2 })
local TeleportSoonSection = TeleportPage:Section({ Name = "Teleports", Side = 1 })
TeleportSoonSection:Label("Coming Soon")
local MiscSection = MiscPage:Section({ Name = "World", Side = 1 })
local SpectateSection = MiscPage:Section({ Name = "Spectate", Side = 2 })

SilentSection:Toggle({
	Name = "Enabled",
	Flag = "SilentEnabled",
	Default = Config.SilentEnabled,
	Callback = function(Value)
		Config.SilentEnabled = Value
		if SyncCombatHook then
			SyncCombatHook()
		end
	end,
})

SilentSection:Toggle({
	Name = "Show FOV",
	Flag = "SilentShowFov",
	Default = Config.SilentShowFov,
	Callback = function(Value)
		Config.SilentShowFov = Value
	end,
})

SilentSection:Slider({
	Name = "FOV",
	Flag = "SilentFov",
	Min = 20,
	Max = 600,
	Default = Config.SilentFov,
	Decimals = 1,
	Callback = function(Value)
		Config.SilentFov = Value
	end,
})

SilentSection:Dropdown({
	Name = "Hit Part",
	Flag = "SilentHitPart",
	Items = HitParts,
	Default = Config.SilentHitPart,
	Callback = function(Value)
		Config.SilentHitPart = Value
	end,
})

SilentSection:Slider({
	Name = "Max Distance",
	Flag = "SilentMaxDistance",
	Min = 50,
	Max = 2000,
	Default = Config.SilentMaxDistance,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.SilentMaxDistance = Value
	end,
})

SilentSection:Toggle({
	Name = "Sticky Aim",
	Flag = "SilentSticky",
	Default = Config.SilentSticky,
	Callback = function(Value)
		Config.SilentSticky = Value
		if not Value then
			StickySilent = nil
		end
	end,
})

SilentSection:Toggle({
	Name = "Wallbang",
	Flag = "SilentWallBang",
	Default = Config.SilentWallBang,
	Callback = function(Value)
		Config.SilentWallBang = Value
		if SyncCombatHook then
			SyncCombatHook()
		end
	end,
})

SilentSection:Toggle({
	Name = "Gang Check",
	Flag = "SilentGangCheck",
	Default = Config.SilentGangCheck,
	Callback = function(Value)
		Config.SilentGangCheck = Value
	end,
})

SilentSection:Toggle({
	Name = "Airshot",
	Flag = "SilentAirshot",
	Default = Config.SilentAirshot,
	Callback = function(Value)
		Config.SilentAirshot = Value
	end,
})

CamlockSection:Toggle({
	Name = "Enabled",
	Flag = "CamlockEnabled",
	Default = Config.CamlockEnabled,
	Callback = function(Value)
		Config.CamlockEnabled = Value
		Config.CamlockActive = false
		CamlockTarget = nil
		StickyCamlock = nil
	end,
})

CamlockSection:Dropdown({
	Name = "Mode",
	Flag = "CamlockMode",
	Items = { "Toggle", "Hold" },
	Default = Config.CamlockMode,
	Callback = function(Value)
		Config.CamlockMode = Value
		Config.CamlockActive = false
		CamlockTarget = nil
		StickyCamlock = nil
	end,
})

CamlockSection:Dropdown({
	Name = "Key / Button",
	Flag = "CamlockKey",
	Items = { "Q", "E", "C", "V", "X", "ButtonL1", "ButtonR1", "ButtonX", "ButtonY" },
	Default = Config.CamlockKey,
	Callback = function(Value)
		Config.CamlockKey = Value
	end,
})

CamlockSection:Dropdown({
	Name = "Hit Part",
	Flag = "CamlockHitPart",
	Items = HitParts,
	Default = Config.CamlockHitPart,
	Callback = function(Value)
		Config.CamlockHitPart = Value
	end,
})

CamlockSection:Slider({
	Name = "FOV",
	Flag = "CamlockFov",
	Min = 20,
	Max = 600,
	Default = Config.CamlockFov,
	Decimals = 1,
	Callback = function(Value)
		Config.CamlockFov = Value
	end,
})

CamlockSection:Toggle({
	Name = "Show FOV",
	Flag = "CamlockShowFov",
	Default = Config.CamlockShowFov,
	Callback = function(Value)
		Config.CamlockShowFov = Value
	end,
})

CamlockSection:Slider({
	Name = "Smoothness",
	Flag = "CamlockSmoothness",
	Min = 0.01,
	Max = 1,
	Default = Config.CamlockSmoothness,
	Decimals = 0.01,
	Callback = function(Value)
		Config.CamlockSmoothness = Value
	end,
})

CamlockSection:Toggle({
	Name = "Sticky",
	Flag = "CamlockSticky",
	Default = Config.CamlockSticky,
	Callback = function(Value)
		Config.CamlockSticky = Value
		if not Value then
			StickyCamlock = nil
		end
	end,
})

CamlockSection:Toggle({
	Name = "Gang Check",
	Flag = "CamlockGangCheck",
	Default = Config.CamlockGangCheck,
	Callback = function(Value)
		Config.CamlockGangCheck = Value
	end,
})

TriggerSection:Toggle({
	Name = "Enabled",
	Flag = "TriggerbotEnabled",
	Default = Config.TriggerbotEnabled,
	Callback = function(Value)
		Config.TriggerbotEnabled = Value
	end,
})

TriggerSection:Slider({
	Name = "FOV",
	Flag = "TriggerbotFov",
	Min = 5,
	Max = 120,
	Default = Config.TriggerbotFov,
	Decimals = 1,
	Callback = function(Value)
		Config.TriggerbotFov = Value
	end,
})

TriggerSection:Slider({
	Name = "Delay",
	Flag = "TriggerbotDelay",
	Min = 0,
	Max = 0.25,
	Default = Config.TriggerbotDelay,
	Decimals = 0.001,
	Suffix = "s",
	Callback = function(Value)
		Config.TriggerbotDelay = Value
	end,
})

GunModSection:Toggle({
	Name = "No Recoil",
	Flag = "NoRecoil",
	Default = Config.NoRecoil,
	Callback = function(Value)
		Config.NoRecoil = Value
		pcall(ApplyAllGunMods)
	end,
})

GunModSection:Toggle({
	Name = "No Spread",
	Flag = "NoSpread",
	Default = Config.NoSpread,
	Callback = function(Value)
		Config.NoSpread = Value
		pcall(ApplyAllGunMods)
	end,
})

GunModSection:Toggle({
	Name = "Infinite Ammo",
	Flag = "InfiniteAmmo",
	Default = Config.InfiniteAmmo,
	Callback = function(Value)
		Config.InfiniteAmmo = Value
		pcall(ApplyAllGunMods)
		if SyncCombatHook then
			SyncCombatHook()
		end
	end,
})

GunModSection:Toggle({
	Name = "Force Automatic",
	Flag = "ForceAutomatic",
	Default = Config.ForceAutomatic,
	Callback = function(Value)
		Config.ForceAutomatic = Value
		pcall(ApplyAllGunMods)
	end,
})

GunModSection:Toggle({
	Name = "Never Jam",
	Flag = "NeverJam",
	Default = Config.NeverJam,
	Callback = function(Value)
		Config.NeverJam = Value
		pcall(ApplyAllGunMods)
	end,
})

GunModSection:Toggle({
	Name = "Auto Reload",
	Flag = "AutoReload",
	Default = Config.AutoReload,
	Callback = function(Value)
		Config.AutoReload = Value
	end,
})

GunModSection:Toggle({
	Name = "Rapid Fire",
	Flag = "RapidFire",
	Default = Config.RapidFire,
	Callback = function(Value)
		Config.RapidFire = Value
	end,
})

GunModSection:Slider({
	Name = "Rapid Delay",
	Flag = "RapidFireDelay",
	Min = 0.02,
	Max = 0.2,
	Default = Config.RapidFireDelay,
	Decimals = 0.001,
	Suffix = "s",
	Callback = function(Value)
		Config.RapidFireDelay = Value
	end,
})

local KillAuraSection = CombatPage:Section({ Name = "Kill Aura", Side = 1 })

KillAuraSection:Toggle({
	Name = "Enabled",
	Flag = "KillAuraEnabled",
	Default = Config.KillAuraEnabled,
	Callback = function(Value)
		Config.KillAuraEnabled = Value
	end,
})

EspSection:Toggle({
	Name = "Enabled",
	Flag = "EspEnabled",
	Default = Config.EspEnabled,
	Callback = function(Value)
		Config.EspEnabled = Value
		if Esp and Esp.Table then
			Esp.Table.Enabled = Value
		end
	end,
})

EspSection:Slider({
	Name = "Distance",
	Flag = "EspDistance",
	Min = 50,
	Max = 2000,
	Default = Config.EspDistance,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.EspDistance = Value
		if Esp and Esp.Table then
			Esp.Table.Distance = Value
		end
	end,
})

EspSection:Toggle({
	Name = "Boxes",
	Flag = "EspBoxes",
	Default = Config.EspBoxes,
	Callback = function(Value)
		Config.EspBoxes = Value
	end,
})

EspSection:Toggle({
	Name = "Box Glow",
	Flag = "EspBoxGlow",
	Default = Config.EspBoxGlow,
	Callback = function(Value)
		Config.EspBoxGlow = Value
	end,
})

EspSection:Toggle({
	Name = "Filled",
	Flag = "EspFilled",
	Default = Config.EspFilled,
	Callback = function(Value)
		Config.EspFilled = Value
	end,
})

EspSection:Toggle({
	Name = "Health Bar",
	Flag = "EspHealthBar",
	Default = Config.EspHealthBar,
	Callback = function(Value)
		Config.EspHealthBar = Value
	end,
})

EspSection:Toggle({
	Name = "Name",
	Flag = "EspName",
	Default = Config.EspName,
	Callback = function(Value)
		Config.EspName = Value
	end,
})

EspSection:Toggle({
	Name = "Distance Text",
	Flag = "EspDistanceText",
	Default = Config.EspDistanceText,
	Callback = function(Value)
		Config.EspDistanceText = Value
	end,
})

EspSection:Toggle({
	Name = "Weapon",
	Flag = "EspWeapon",
	Default = Config.EspWeapon,
	Callback = function(Value)
		Config.EspWeapon = Value
	end,
})

EspStyleSection:Slider({
	Name = "Color R",
	Flag = "EspColorR",
	Min = 0,
	Max = 255,
	Default = 0,
	Decimals = 1,
	Callback = function(Value)
		Config.EspColor = Color3.fromRGB(Value, Config.EspColor.G * 255, Config.EspColor.B * 255)
	end,
})

EspStyleSection:Slider({
	Name = "Color G",
	Flag = "EspColorG",
	Min = 0,
	Max = 255,
	Default = 255,
	Decimals = 1,
	Callback = function(Value)
		Config.EspColor = Color3.fromRGB(Config.EspColor.R * 255, Value, Config.EspColor.B * 255)
	end,
})

EspStyleSection:Slider({
	Name = "Color B",
	Flag = "EspColorB",
	Min = 0,
	Max = 255,
	Default = 255,
	Decimals = 1,
	Callback = function(Value)
		Config.EspColor = Color3.fromRGB(Config.EspColor.R * 255, Config.EspColor.G * 255, Value)
	end,
})

ExtraVisualSection:Toggle({
	Name = "Player Highlights",
	Flag = "PlayerHighlights",
	Default = Config.PlayerHighlights,
	Callback = function(Value)
		Config.PlayerHighlights = Value
	end,
})

ExtraVisualSection:Toggle({
	Name = "Tracers",
	Flag = "TracerEsp",
	Default = Config.TracerEsp,
	Callback = function(Value)
		Config.TracerEsp = Value
	end,
})

ExtraVisualSection:Toggle({
	Name = "Drop ESP",
	Flag = "DropEsp",
	Default = Config.DropEsp,
	Callback = function(Value)
		Config.DropEsp = Value
	end,
})

ExtraVisualSection:Toggle({
	Name = "Xray [RISK]",
	Flag = "Xray",
	Default = Config.Xray,
	Callback = function(Value)
		Config.Xray = Value
		if Value then
			Library:Notification("Risk", "Xray can get flagged. Use sparingly.", 4)
		else
			pcall(RestoreXray)
		end
	end,
})

MovementSection:Toggle({
	Name = "WalkSpeed",
	Flag = "WalkSpeedEnabled",
	Default = Config.WalkSpeedEnabled,
	Callback = function(Value)
		Config.WalkSpeedEnabled = Value
		if Value then
			Library:Notification("Risk", "Keep speed low. High speed is easy to detect.", 4)
		end
	end,
})

MovementSection:Slider({
	Name = "Speed",
	Flag = "WalkSpeed",
	Min = 16,
	Max = 36,
	Default = Config.WalkSpeed,
	Decimals = 1,
	Callback = function(Value)
		Config.WalkSpeed = Value
	end,
})

MovementSection:Toggle({
	Name = "JumpPower",
	Flag = "JumpPowerEnabled",
	Default = Config.JumpPowerEnabled,
	Callback = function(Value)
		Config.JumpPowerEnabled = Value
	end,
})

MovementSection:Slider({
	Name = "Jump Power",
	Flag = "JumpPower",
	Min = 40,
	Max = 80,
	Default = Config.JumpPower,
	Decimals = 1,
	Callback = function(Value)
		Config.JumpPower = Value
	end,
})

MovementSection:Toggle({
	Name = "Fly [RISK]",
	Flag = "FlyEnabled",
	Default = Config.FlyEnabled,
	Callback = function(Value)
		Config.FlyEnabled = Value
		if Value then
			Library:Notification("Risk", "Fly is heavily detected on this game.", 5)
		end
		if not Value then
			pcall(function()
				if FlyBodyVelocity then
					FlyBodyVelocity:Destroy()
				end
				if FlyBodyGyro then
					FlyBodyGyro:Destroy()
				end
			end)
			FlyBodyVelocity = nil
			FlyBodyGyro = nil
		end
	end,
})

MovementSection:Slider({
	Name = "Fly Speed",
	Flag = "FlySpeed",
	Min = 16,
	Max = 80,
	Default = Config.FlySpeed,
	Decimals = 1,
	Callback = function(Value)
		Config.FlySpeed = Value
	end,
})

LocalSection:Toggle({
	Name = "Infinite Stamina",
	Flag = "InfiniteStamina",
	Default = Config.InfiniteStamina,
	Callback = function(Value)
		Config.InfiniteStamina = Value
	end,
})

LocalSection:Toggle({
	Name = "Hitbox Expander [RISK]",
	Flag = "HitboxEnabled",
	Default = Config.HitboxEnabled,
	Callback = function(Value)
		Config.HitboxEnabled = Value
		if Value then
			Library:Notification("Risk", "Hitbox expander is blatant.", 4)
		end
		if not Value then
			for Part, Size in pairs(HitboxOriginal) do
				if Part and Part.Parent then
					pcall(function()
						Part.Size = Size
						Part.Transparency = 1
						Part.CanCollide = false
					end)
				end
				HitboxOriginal[Part] = nil
			end
		end
	end,
})

LocalSection:Slider({
	Name = "Hitbox Size",
	Flag = "HitboxSize",
	Min = 2,
	Max = 8,
	Default = Config.HitboxSize,
	Decimals = 1,
	Callback = function(Value)
		Config.HitboxSize = Value
	end,
})

CombatMoveSection:Toggle({
	Name = "Infinite Jump",
	Flag = "InfiniteJump",
	Default = Config.InfiniteJump,
	Callback = function(Value)
		Config.InfiniteJump = Value
	end,
})

CombatMoveSection:Toggle({
	Name = "Click TP",
	Flag = "ClickTp",
	Default = Config.ClickTp,
	Callback = function(Value)
		Config.ClickTp = Value
	end,
})

LightingSection:Toggle({
	Name = "Fullbright",
	Flag = "Fullbright",
	Default = Config.Fullbright,
	Callback = function(Value)
		Config.Fullbright = Value
		if not Value and RestoreLighting then
			RestoreLighting()
		end
	end,
})

LightingSection:Toggle({
	Name = "No Fog",
	Flag = "NoFog",
	Default = Config.NoFog,
	Callback = function(Value)
		Config.NoFog = Value
		if not Value and RestoreLighting then
			RestoreLighting()
		end
	end,
})

LightingSection:Toggle({
	Name = "No Shadows",
	Flag = "NoShadows",
	Default = Config.NoShadows,
	Callback = function(Value)
		Config.NoShadows = Value
	end,
})

VehicleSection:Toggle({
	Name = "Vehicle Speed",
	Flag = "VehicleSpeedEnabled",
	Default = Config.VehicleSpeedEnabled,
	Callback = function(Value)
		Config.VehicleSpeedEnabled = Value
	end,
})

VehicleSection:Slider({
	Name = "Speed",
	Flag = "VehicleSpeed",
	Min = 50,
	Max = 300,
	Default = Config.VehicleSpeed,
	Decimals = 1,
	Callback = function(Value)
		Config.VehicleSpeed = Value
	end,
})

InteractSection:Toggle({
	Name = "Instant Interact",
	Flag = "InstantInteract",
	Default = Config.InstantInteract,
	Callback = function(Value)
		Config.InstantInteract = Value
	end,
})

InteractSection:Toggle({
	Name = "Anti Sit",
	Flag = "AntiSit",
	Default = Config.AntiSit,
	Callback = function(Value)
		Config.AntiSit = Value
	end,
})

InteractSection:Slider({
	Name = "Max Zoom",
	Flag = "EchoMaxZoom",
	Min = 20,
	Max = 200,
	Default = 128,
	Decimals = 1,
	Callback = function(Value)
		if typeof(Value) ~= "number" or Value ~= Value or Value < 1 then
			Value = 128
		end
		Config.MaxZoom = Value
		LocalPlayer.CameraMaxZoomDistance = Value
	end,
})

SpectateSection:Toggle({
	Name = "Spectate",
	Flag = "SpectateEnabled",
	Default = Config.SpectateEnabled,
	Callback = function(Value)
		Config.SpectateEnabled = Value
		if not Value then
			local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if Humanoid and Camera then
				Camera.CameraSubject = Humanoid
			end
		end
	end,
})

SpectateSection:Toggle({
	Name = "Freecam",
	Flag = "Freecam",
	Default = Config.Freecam,
	Callback = function(Value)
		Config.Freecam = Value
		if Value then
			if StartFreecam then
				StartFreecam()
			end
		elseif StopFreecam then
			StopFreecam()
		end
	end,
})

SpectateSection:Slider({
	Name = "Freecam Speed",
	Flag = "FreecamSpeed",
	Min = 20,
	Max = 200,
	Default = Config.FreecamSpeed,
	Decimals = 1,
	Callback = function(Value)
		Config.FreecamSpeed = Value
	end,
})

MiscSection:Toggle({
	Name = "Anti AFK",
	Flag = "AntiAfk",
	Default = Config.AntiAfk,
	Callback = function(Value)
		Config.AntiAfk = Value
	end,
})

MiscSection:Toggle({
	Name = "Auto Daily",
	Flag = "AutoDaily",
	Default = Config.AutoDaily,
	Callback = function(Value)
		Config.AutoDaily = Value
	end,
})

MiscSection:Toggle({
	Name = "Custom FOV",
	Flag = "FovEnabled",
	Default = Config.FovEnabled,
	Callback = function(Value)
		Config.FovEnabled = Value
		if not Value and Camera then
			Camera.FieldOfView = 70
		end
	end,
})

MiscSection:Slider({
	Name = "FOV Value",
	Flag = "FovValue",
	Min = 50,
	Max = 120,
	Default = Config.FovValue,
	Decimals = 1,
	Callback = function(Value)
		Config.FovValue = Value
	end,
})

-- // Utilities
local function TrackConnection(Signal, Callback)
	local Connection = Signal:Connect(Callback)
	Connections[#Connections + 1] = Connection
	return Connection
end

local FarmNotifyClock = {}

local function GetCashAndLevel()
	local Data = LocalPlayer:FindFirstChild("Data")
	local Money = Data and Data:FindFirstChild("Money")
	local Level = Data and Data:FindFirstChild("Level")
	return (Money and Money.Value) or 0, (Level and Level.Value) or 0
end

MeetsRequirement = function(MinLevel, MinMoney, FeatureName)
	local Money, Level = GetCashAndLevel()
	if Level < MinLevel then
		local Key = FeatureName .. "_lvl"
		local Now = os.clock()
		if not FarmNotifyClock[Key] or Now - FarmNotifyClock[Key] > 6 then
			FarmNotifyClock[Key] = Now
			Library:Notification("Need Level", FeatureName .. " needs lvl " .. MinLevel .. " (you: " .. Level .. ")", 5)
		end
		return false
	end
	if Money < MinMoney then
		local Key = FeatureName .. "_cash"
		local Now = os.clock()
		if not FarmNotifyClock[Key] or Now - FarmNotifyClock[Key] > 6 then
			FarmNotifyClock[Key] = Now
			Library:Notification("Need Cash", FeatureName .. " needs $" .. MinMoney .. " (you: $" .. Money .. ")", 5)
		end
		return false
	end
	return true
end

local function ResolveFireRemote()
	local Modules = ReplicatedStorage:FindFirstChild("Modules")
	local GunFramework = Modules and Modules:FindFirstChild("GunFramework")
	local Remotes = GunFramework and GunFramework:FindFirstChild("Remotes")
	FireRemote = Remotes and Remotes:FindFirstChild("Fire")
	ReloadRemote = Remotes and Remotes:FindFirstChild("Reload")
	return FireRemote
end

local function IsGunAmmoRemote(Self)
	if typeof(Self) ~= "Instance" or Self.ClassName ~= "RemoteEvent" then
		return false
	end
	if (FireRemote and rawequal(Self, FireRemote)) or (ReloadRemote and rawequal(Self, ReloadRemote)) then
		return true
	end
	if Self.Name == "Fire" or Self.Name == "Reload" then
		local Remotes = Self.Parent
		local GunFramework = Remotes and Remotes.Parent
		if Remotes and Remotes.Name == "Remotes" and GunFramework and GunFramework.Name == "GunFramework" then
			if Self.Name == "Fire" then
				FireRemote = Self
			else
				ReloadRemote = Self
			end
			return true
		end
	end
	return false
end

local function GetPlayerGang(Player)
	local Data = Player:FindFirstChild("Data")
	local Gang = Data and Data:FindFirstChild("Gang")
	if Gang then
		return tostring(Gang.Value)
	end
	return "0"
end

IsFriendly = function(Player, UseGang, UseTeam)
	if Player == LocalPlayer then
		return true
	end
	if UseTeam and Player.Team and LocalPlayer.Team and Player.Team == LocalPlayer.Team and Player.Team.Name ~= "Civilians" then
		return true
	end
	if UseGang then
		local Mine = GetPlayerGang(LocalPlayer)
		local Theirs = GetPlayerGang(Player)
		if Mine ~= "0" and Mine == Theirs then
			return true
		end
	end
	return false
end

local function GetCharacterParts(Character)
	return {
		Head = Character:FindFirstChild("Head"),
		HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart"),
		UpperTorso = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso"),
		Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso"),
		LowerTorso = Character:FindFirstChild("LowerTorso") or Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart"),
	}
end

local function GetHitPart(Character, Name)
	if not Character then
		return nil
	end
	local Parts = GetCharacterParts(Character)
	local Part = Parts[Name] or Character:FindFirstChild(Name)
	if Part and Part:IsA("BasePart") then
		return Part
	end
	return Parts.Head or Parts.HumanoidRootPart
end

local function IsVisible(Origin, TargetPart)
	if not Origin or not TargetPart then
		return false
	end
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = { LocalPlayer.Character, Workspace.CurrentCamera }
	Params.IgnoreWater = true
	local Direction = TargetPart.Position - Origin
	local Result = Workspace:Raycast(Origin, Direction, Params)
	if not Result then
		return true
	end
	return Result.Instance and Result.Instance:IsDescendantOf(TargetPart.Parent)
end

local function GetPredictedPosition(Part, Scale)
	if not Part then
		return nil
	end
	local Position = Part.Position
	if not Scale or Scale <= 0 then
		return Position
	end
	local Velocity = Part.AssemblyLinearVelocity
	return Position + Velocity * Scale
end

local function GetMousePosition()
	local Location = UserInputService:GetMouseLocation()
	local Inset = GuiService:GetGuiInset()
	return Vector2.new(Location.X, Location.Y - Inset.Y)
end

GetClosestPlayer = function(Fov, WallCheck, UseGang, UseTeam, VisibleOnly, HitPartName, MaxDistance)
	Camera = Workspace.CurrentCamera
	if not Camera then
		return nil
	end

	local Origin = Camera.CFrame.Position
	local MousePos = GetMousePosition()
	local BestPlayer = nil
	local BestScore = Fov
	local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local Limit = MaxDistance or 800

	for _, Player in ipairs(Players:GetPlayers()) do
		if not IsFriendly(Player, UseGang, UseTeam) then
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local Root = Character and Character:FindFirstChild("HumanoidRootPart")
			if Humanoid and Root and Humanoid.Health > 0 then
				local Distance = LocalRoot and (Root.Position - LocalRoot.Position).Magnitude or 0
				if Distance <= Limit then
					local Screen, OnScreen = Camera:WorldToViewportPoint(Root.Position)
					if OnScreen or not VisibleOnly then
						local Score = (Vector2.new(Screen.X, Screen.Y) - MousePos).Magnitude
						if Score <= BestScore then
							local Hit = GetHitPart(Character, HitPartName or Config.SilentHitPart)
							local Allowed = true
							if WallCheck and Hit then
								Allowed = IsVisible(Origin, Hit)
							end
							if Allowed then
								BestScore = Score
								BestPlayer = Player
							end
						end
					end
				end
			end
		end
	end

	return BestPlayer
end

local function ValidateSticky(Player, Fov, _WallCheck, UseGang, UseTeam)
	if not Player or not Player.Parent then
		return false
	end
	if IsFriendly(Player, UseGang, UseTeam) then
		return false
	end
	local Character = Player.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Humanoid or not Root or Humanoid.Health <= 0 then
		return false
	end
	Camera = Workspace.CurrentCamera
	if not Camera then
		return false
	end
	local Screen, OnScreen = Camera:WorldToViewportPoint(Root.Position)
	if not OnScreen then
		return false
	end
	local Score = (Vector2.new(Screen.X, Screen.Y) - GetMousePosition()).Magnitude
	if Score > Fov * 1.35 then
		return false
	end
	if WallCheck then
		local Hit = GetHitPart(Character, Config.SilentHitPart)
		if Hit and not IsVisible(Camera.CFrame.Position, Hit) then
			return false
		end
	end
	return true
end

local function ResolveSilentTarget()
	if Config.SilentSticky and ValidateSticky(StickySilent, Config.SilentFov, false, Config.SilentGangCheck, false) then
		SilentTarget = StickySilent
		return SilentTarget
	end

	SilentTarget = GetClosestPlayer(
		Config.SilentFov,
		false,
		Config.SilentGangCheck,
		false,
		false,
		Config.SilentHitPart,
		Config.SilentMaxDistance
	)
	if Config.SilentSticky then
		StickySilent = SilentTarget
	end
	return SilentTarget
end

local function ResolveCamlockTarget()
	if Config.CamlockSticky and ValidateSticky(StickyCamlock, Config.CamlockFov, false, Config.CamlockGangCheck, false) then
		CamlockTarget = StickyCamlock
		return CamlockTarget
	end

	CamlockTarget = GetClosestPlayer(
		Config.CamlockFov,
		false,
		Config.CamlockGangCheck,
		false,
		false,
		Config.CamlockHitPart,
		Config.CamlockMaxDistance
	)
	if Config.CamlockSticky then
		StickyCamlock = CamlockTarget
	end
	return CamlockTarget
end

local function GetAimPosition(Player, HitPartName, UsePrediction, PredictionScale, AllowAirshot)
	local Character = Player and Player.Character
	if not Character then
		return nil
	end

	local PartName = HitPartName
	if AllowAirshot then
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		local Root = Character:FindFirstChild("HumanoidRootPart")
		if Humanoid and Root and Root.AssemblyLinearVelocity.Y > 8 then
			PartName = "HumanoidRootPart"
		elseif Humanoid and Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
			PartName = "HumanoidRootPart"
		end
	end

	local Part = GetHitPart(Character, PartName)
	if not Part then
		return nil
	end
	if UsePrediction then
		return GetPredictedPosition(Part, PredictionScale)
	end
	return Part.Position
end

local function EnsureFovCircle(Name, Color)
	local Gui = EchoUiContainer:FindFirstChild(Name)
	if Gui then
		return Gui
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = Name
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = EchoUiContainer
	EchoUiRoots[#EchoUiRoots + 1] = ScreenGui

	local Frame = Instance.new("Frame")
	Frame.Name = "Circle"
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.BackgroundTransparency = 1
	Frame.Size = UDim2.fromOffset(100, 100)
	Frame.Parent = ScreenGui

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1.4
	Stroke.Color = Color
	Stroke.Transparency = 0.15
	Stroke.Parent = Frame

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(1, 0)
	Corner.Parent = Frame

	return ScreenGui
end

local function UpdateFovVisuals()
	Camera = Workspace.CurrentCamera
	local MousePos = GetMousePosition()

	if Config.SilentEnabled and Config.SilentShowFov then
		FovCircle = EnsureFovCircle("EchoSilentFov", Color3.fromRGB(0, 255, 255))
		local Circle = FovCircle:FindFirstChild("Circle")
		if Circle then
			local Size = Config.SilentFov * 2
			Circle.Position = UDim2.fromOffset(MousePos.X, MousePos.Y)
			Circle.Size = UDim2.fromOffset(Size, Size)
			Circle.Visible = true
		end
	elseif FovCircle then
		local Circle = FovCircle:FindFirstChild("Circle")
		if Circle then
			Circle.Visible = false
		end
	end

	if Config.CamlockEnabled and Config.CamlockShowFov then
		CamFovCircle = EnsureFovCircle("EchoCamFov", Color3.fromRGB(255, 120, 180))
		local Circle = CamFovCircle:FindFirstChild("Circle")
		if Circle then
			local Size = Config.CamlockFov * 2
			Circle.Position = UDim2.fromOffset(MousePos.X, MousePos.Y)
			Circle.Size = UDim2.fromOffset(Size, Size)
			Circle.Visible = true
		end
	elseif CamFovCircle then
		local Circle = CamFovCircle:FindFirstChild("Circle")
		if Circle then
			Circle.Visible = false
		end
	end
end

local function ApplyEspConfig()
	if not Esp or not Esp.Table then
		return
	end

	local Table = Esp.Table
	local Color = Config.EspColor

	Table.Enabled = Config.EspEnabled
	Table.Distance = Config.EspDistance

	if Table.Boxes then
		Table.Boxes.Enabled = Config.EspBoxes
		if Table.Boxes.Gradients then
			Table.Boxes.Gradients.Top = Color
			Table.Boxes.Gradients.Bot = Color
		end
		if Table.Boxes["Bounding Box"] then
			Table.Boxes["Bounding Box"].Enabled = Config.EspBoxes
		end
		if Table.Boxes["Box Glow"] then
			Table.Boxes["Box Glow"].Enabled = Config.EspBoxGlow
			Table.Boxes["Box Glow"].Top = Color
			Table.Boxes["Box Glow"].Bot = Color
		end
		if Table.Boxes.Filled then
			Table.Boxes.Filled.Enabled = Config.EspFilled
			Table.Boxes.Filled.Top = Color
			Table.Boxes.Filled.Bot = Color
		end
	end

	if Table.Bars and Table.Bars["Health Bar"] then
		Table.Bars["Health Bar"].Enabled = Config.EspHealthBar
	end

	if Table.Texts then
		if Table.Texts.Name then
			Table.Texts.Name.Enabled = Config.EspName
			Table.Texts.Name.Color = Color
		end
		if Table.Texts.Distance then
			Table.Texts.Distance.Enabled = Config.EspDistanceText
			Table.Texts.Distance.Color = Color
		end
		if Table.Texts.Weapon then
			Table.Texts.Weapon.Enabled = Config.EspWeapon
			Table.Texts.Weapon.Color = Color
		end
	end
end

local SilentAimPoint = nil

local function IsGunFireRemote(Self)
	if typeof(Self) ~= "Instance" then
		return false
	end
	if FireRemote and rawequal(Self, FireRemote) then
		return true
	end
	if Self.ClassName == "RemoteEvent" and Self.Name == "Fire" then
		local Remotes = Self.Parent
		local GunFramework = Remotes and Remotes.Parent
		if Remotes and Remotes.Name == "Remotes" and GunFramework and GunFramework.Name == "GunFramework" then
			FireRemote = Self
			return true
		end
	end
	return false
end

local function RefreshSilentAimPoint()
	if not Config.SilentEnabled then
		SilentAimPoint = nil
		return
	end

	local Cam = Workspace.CurrentCamera
	local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not Cam then
		SilentAimPoint = nil
		return
	end

	local Look = Cam.CFrame.LookVector
	local Origin = Cam.CFrame.Position
	local BestAim = nil
	local BestAngle = 18
	local Limit = Config.SilentMaxDistance
	if typeof(Limit) ~= "number" or Limit ~= Limit or Limit < 1 then
		Limit = 800
	end
	local MaxAngle = math.clamp((Config.SilentFov or 180) * 0.085, 6, 35)

	for _, Player in ipairs(Players:GetPlayers()) do
		if not IsFriendly(Player, Config.SilentGangCheck, false) then
			local Character = Player.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local Root = Character and Character:FindFirstChild("HumanoidRootPart")
			if Humanoid and Root and Humanoid.Health > 0 then
				local Distance = LocalRoot and (Root.Position - LocalRoot.Position).Magnitude or (Root.Position - Origin).Magnitude
				if Distance <= Limit then
					local Aim = GetAimPosition(Player, Config.SilentHitPart, false, 0, Config.SilentAirshot)
					if Aim then
						local Dx = Aim.X - Origin.X
						local Dy = Aim.Y - Origin.Y
						local Dz = Aim.Z - Origin.Z
						local Mag = math.sqrt(Dx * Dx + Dy * Dy + Dz * Dz)
						if Mag > 0.05 then
							local Ux, Uy, Uz = Dx / Mag, Dy / Mag, Dz / Mag
							local Dot = Look.X * Ux + Look.Y * Uy + Look.Z * Uz
							local Angle = math.deg(math.acos(math.clamp(Dot, -1, 1)))
							if Angle <= MaxAngle and Angle < BestAngle then
								BestAngle = Angle
								BestAim = Aim
								SilentTarget = Player
								if Config.SilentSticky then
									StickySilent = Player
								end
							end
						end
					end
				end
			end
		end
	end

	SilentAimPoint = BestAim
	getgenv().EchoSilentAimPoint = BestAim
end

-- Updated outside namecall (safe). Hook only reads this Instance.
local SilentRayHitPart = nil

local function RefreshSilentRayTarget()
	SilentRayHitPart = nil
	if not (Config.SilentEnabled or Config.SilentWallBang) then
		return
	end

	Camera = Workspace.CurrentCamera
	if not Camera then
		return
	end

	local MousePos = UserInputService:GetMouseLocation()
	local BestPart = nil
	local BestPlayer = nil
	local BestDist = Config.SilentFov or 180
	local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local Limit = Config.SilentMaxDistance or 800

	for _, Enemy in ipairs(Players:GetPlayers()) do
		if not IsFriendly(Enemy, Config.SilentGangCheck, false) then
			local Character = Enemy.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
			local Hit = Character and GetHitPart(Character, Config.SilentHitPart)
			if Humanoid and Hit and Humanoid.Health > 0 then
				local WorldDist = LocalRoot and (Hit.Position - LocalRoot.Position).Magnitude or 0
				if WorldDist <= Limit then
					local Screen, OnScreen = Camera:WorldToViewportPoint(Hit.Position)
					if OnScreen then
						local Dist = (Vector2.new(Screen.X, Screen.Y) - MousePos).Magnitude
						if Dist < BestDist then
							BestDist = Dist
							BestPart = Hit
							BestPlayer = Enemy
						end
					end
				end
			end
		end
	end

	SilentRayHitPart = BestPart
	SilentTarget = BestPlayer
end

local function UninstallCombatHook()
	if not HookInstalled then
		return
	end
	pcall(function()
		if typeof(getgenv().EchoBaseNamecall) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__namecall", getgenv().EchoBaseNamecall)
		end
	end)
	HookInstalled = false
	getgenv().EchoSilentHooked = nil
	OldNamecall = nil
end

local function NeedsCombatHook()
	return Config.InfiniteAmmo or Config.SilentEnabled or Config.SilentWallBang
end

local function InstallSilentHook()
	-- Never hook namecall unless a combat feature that needs it is on
	if not NeedsCombatHook() then
		UninstallCombatHook()
		return
	end
	if HookInstalled then
		return
	end

	ResolveFireRemote()
	if typeof(hookmetamethod) ~= "function" or typeof(getnamecallmethod) ~= "function" then
		warn("[Echo] Combat hooks unavailable on this executor")
		return
	end

	-- Undo a previous Echo hook if one is still stacked
	if typeof(getgenv().EchoBaseNamecall) == "function" then
		pcall(function()
			hookmetamethod(game, "__namecall", getgenv().EchoBaseNamecall)
		end)
	end

	local ClientRuntime = nil
	pcall(function()
		local Scripts = LocalPlayer:FindFirstChild("PlayerScripts")
		ClientRuntime = Scripts and Scripts:FindFirstChild("ClientRuntime")
	end)

	local Shoot = FireRemote
	local Reload = ReloadRemote
	local Old

	-- Keep this closure tiny + error-proof. Heavy logic stays OUT of namecall.
	-- Assign Old in the same statement style so the upvalue is never nil when called.
	local HookOk, HookErr = pcall(function()
		Old = hookmetamethod(game, "__namecall", function(Self, ...)
			if typeof(Old) ~= "function" then
				return
			end

			local Method = getnamecallmethod()

			-- Infinite ammo: only block exact Fire/Reload remotes while enabled
			if Config.InfiniteAmmo and Method == "FireServer" then
				if (Shoot and Self == Shoot) or (Reload and Self == Reload) then
					return
				end
			end

			-- Silent / wallbang: ClientRuntime workspace Raycast only
			if
				(Config.SilentEnabled or Config.SilentWallBang)
				and Method == "Raycast"
				and Self == Workspace
			then
				local Ok, Origin, Direction, RayParams = pcall(function(...)
					local O, D, P = ...
					if not ClientRuntime or typeof(getcallingscript) ~= "function" then
						return O, D, P
					end
					if getcallingscript() ~= ClientRuntime then
						return O, D, P
					end

					local Character = LocalPlayer.Character
					local TargetPart = SilentRayHitPart
					if
						not Character
						or not TargetPart
						or not TargetPart.Parent
						or typeof(O) ~= "Vector3"
						or typeof(D) ~= "Vector3"
						or typeof(P) ~= "RaycastParams"
					then
						return O, D, P
					end

					local Filter = P.FilterDescendantsInstances
					if type(Filter) ~= "table" or Filter[1] ~= Character then
						return O, D, P
					end

					if Config.SilentEnabled then
						D = TargetPart.Position - O
					end
					if Config.SilentWallBang then
						local NewParams = RaycastParams.new()
						NewParams.FilterType = Enum.RaycastFilterType.Include
						NewParams.FilterDescendantsInstances = { TargetPart }
						P = NewParams
					end
					return O, D, P
				end, ...)

				if Ok then
					return Old(Self, Origin, Direction, RayParams)
				end
			end

			return Old(Self, ...)
		end)
	end)

	if not HookOk or typeof(Old) ~= "function" then
		warn("[Echo] namecall hook failed: " .. tostring(HookErr))
		return
	end

	OldNamecall = Old
	getgenv().EchoBaseNamecall = Old
	getgenv().EchoSilentHooked = true
	HookInstalled = true
end

SyncCombatHook = function()
	if NeedsCombatHook() then
		task.defer(function()
			task.wait(1.5)
			local Ok, Err = pcall(InstallSilentHook)
			if not Ok then
				warn("[Echo] silent hook skipped:", Err)
			end
		end)
	else
		UninstallCombatHook()
	end
end

local function RunCamlock()
	if not Config.CamlockEnabled or not Config.CamlockActive then
		return
	end

	Camera = Workspace.CurrentCamera
	if not Camera then
		return
	end

	local Target = ResolveCamlockTarget()
	local Aim = Target and GetAimPosition(Target, Config.CamlockHitPart, false, 0, true)
	if not Aim then
		return
	end

	local Current = Camera.CFrame
	local Goal = CFrame.lookAt(Current.Position, Aim)
	local Alpha = math.clamp(1 - (Config.CamlockSmoothness or 0.18), 0.08, 1)
	Camera.CFrame = Current:Lerp(Goal, Alpha)
end

local function RunTriggerbot()
	if not Config.TriggerbotEnabled then
		return
	end
	if os.clock() - TriggerClock < Config.TriggerbotDelay then
		return
	end

	local Target = ResolveSilentTarget()
	if not Target then
		return
	end

	local Character = Target.Character
	local Hit = GetHitPart(Character, Config.SilentHitPart)
	if not Hit then
		return
	end

	Camera = Workspace.CurrentCamera
	local Screen, OnScreen = Camera:WorldToViewportPoint(Hit.Position)
	if not OnScreen then
		return
	end
	local Dist = (Vector2.new(Screen.X, Screen.Y) - GetMousePosition()).Magnitude
	if Dist > Config.TriggerbotFov then
		return
	end

	TriggerClock = os.clock()
	pcall(function()
		mouse1press()
		task.delay(0.03, mouse1release)
	end)
end

local function RunWalkSpeed()
	if not Config.WalkSpeedEnabled then
		return
	end
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid.WalkSpeed = math.clamp(Config.WalkSpeed, 16, 36)
	end
end

local function RunJumpPower()
	if not Config.JumpPowerEnabled then
		return
	end
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid.UseJumpPower = true
		Humanoid.JumpPower = Config.JumpPower
	end
end

local function StopFly()
	if FlyBodyVelocity then
		pcall(function()
			FlyBodyVelocity:Destroy()
		end)
		FlyBodyVelocity = nil
	end
	if FlyBodyGyro then
		pcall(function()
			FlyBodyGyro:Destroy()
		end)
		FlyBodyGyro = nil
	end
end

local function RunFly()
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Config.FlyEnabled or not Humanoid or not Root or Humanoid.Health <= 0 then
		StopFly()
		return
	end

	if not FlyBodyVelocity or not FlyBodyVelocity.Parent then
		FlyBodyVelocity = Instance.new("BodyVelocity")
		FlyBodyVelocity.Name = "EchoFlyVelocity"
		FlyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		FlyBodyVelocity.Velocity = Vector3.zero
		FlyBodyVelocity.Parent = Root
	end
	if not FlyBodyGyro or not FlyBodyGyro.Parent then
		FlyBodyGyro = Instance.new("BodyGyro")
		FlyBodyGyro.Name = "EchoFlyGyro"
		FlyBodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		FlyBodyGyro.P = 12000
		FlyBodyGyro.D = 400
		FlyBodyGyro.Parent = Root
	end

	Camera = Workspace.CurrentCamera
	local CamCF = Camera and Camera.CFrame or Root.CFrame
	local Move = Vector3.zero
	if FlyKeysHeld.W then
		Move += CamCF.LookVector
	end
	if FlyKeysHeld.S then
		Move -= CamCF.LookVector
	end
	if FlyKeysHeld.D then
		Move += CamCF.RightVector
	end
	if FlyKeysHeld.A then
		Move -= CamCF.RightVector
	end
	if FlyKeysHeld.Space then
		Move += Vector3.new(0, 1, 0)
	end
	if FlyKeysHeld.LeftShift then
		Move -= Vector3.new(0, 1, 0)
	end

	FlyBodyVelocity.Velocity = Move.Magnitude > 0 and Move.Unit * Config.FlySpeed or Vector3.zero
	FlyBodyGyro.CFrame = CamCF
end

local function RunInfiniteStamina()
	if not Config.InfiniteStamina then
		return
	end
	local Data = LocalPlayer:FindFirstChild("Data")
	local Stamina = Data and Data:FindFirstChild("Stamina")
	if Stamina and typeof(Stamina.Value) == "number" then
		Stamina.Value = 100
	end
end

local function RunHitboxes()
	if not Config.HitboxEnabled then
		return
	end

	local Size = Vector3.new(Config.HitboxSize, Config.HitboxSize, Config.HitboxSize)
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and not IsFriendly(Player, Config.SilentGangCheck, false) then
			local Character = Player.Character
			local Root = Character and Character:FindFirstChild("HumanoidRootPart")
			if Root then
				if HitboxOriginal[Root] == nil then
					HitboxOriginal[Root] = Root.Size
				end
				Root.Size = Size
				Root.Transparency = Config.HitboxTransparency
				Root.CanCollide = false
				Root.Massless = true
			end
		end
	end
end

local function IsFiniteNumber(Value)
	return typeof(Value) == "number" and Value == Value and Value ~= math.huge and Value ~= -math.huge
end

RestorePlayerCamera = function()
	Camera = Workspace.CurrentCamera
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Camera then
		return
	end

	local Zoom = Config.MaxZoom
	if not IsFiniteNumber(Zoom) or Zoom < 1 then
		Zoom = 128
		Config.MaxZoom = Zoom
	end
	if not IsFiniteNumber(LocalPlayer.CameraMaxZoomDistance) or LocalPlayer.CameraMaxZoomDistance < 1 then
		LocalPlayer.CameraMaxZoomDistance = Zoom
	end
	if not IsFiniteNumber(LocalPlayer.CameraMinZoomDistance) or LocalPlayer.CameraMinZoomDistance < 0 then
		LocalPlayer.CameraMinZoomDistance = 0.5
	end

	if Config.Freecam then
		return
	end

	if Camera.CameraType ~= Enum.CameraType.Custom then
		Camera.CameraType = Enum.CameraType.Custom
	end
	if Humanoid and Camera.CameraSubject ~= Humanoid then
		Camera.CameraSubject = Humanoid
	end
end

local function RunFov()
	Camera = Workspace.CurrentCamera
	if Config.FovEnabled and Camera and IsFiniteNumber(Config.FovValue) then
		Camera.FieldOfView = Config.FovValue
	end
end

local function CacheLighting()
	if OriginalLighting then
		return
	end
	OriginalLighting = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		FogEnd = Lighting.FogEnd,
		FogStart = Lighting.FogStart,
		GlobalShadows = Lighting.GlobalShadows,
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
	}
end

RestoreLighting = function()
	if not OriginalLighting then
		return
	end
	pcall(function()
		Lighting.Brightness = OriginalLighting.Brightness
		Lighting.ClockTime = OriginalLighting.ClockTime
		Lighting.FogEnd = OriginalLighting.FogEnd
		Lighting.FogStart = OriginalLighting.FogStart
		Lighting.GlobalShadows = OriginalLighting.GlobalShadows
		Lighting.Ambient = OriginalLighting.Ambient
		Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
	end)
end

local function RunLighting()
	CacheLighting()
	if Config.Fullbright then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.Ambient = Color3.new(1, 1, 1)
		Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
	end
	if Config.NoFog then
		Lighting.FogEnd = 100000
		Lighting.FogStart = 100000
	end
	if Config.NoShadows then
		Lighting.GlobalShadows = false
	elseif OriginalLighting then
		Lighting.GlobalShadows = OriginalLighting.GlobalShadows
	end
end

local TeleportBusy = false

local function StepRootTo(Root, Goal, Steps, WaitPer)
	local From = Root.Position
	local StepsCount = math.max(Steps or 8, 1)
	for Index = 1, StepsCount do
		if not Root.Parent then
			return false
		end
		local Alpha = Index / StepsCount
		Root.CFrame = CFrame.new(From:Lerp(Goal, Alpha))
		Root.AssemblyLinearVelocity = Vector3.zero
		Root.AssemblyAngularVelocity = Vector3.zero
		task.wait(WaitPer or 0.03)
	end
	return true
end

SafeTweenTeleport = function(TargetCFrame)
	local Character = LocalPlayer.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Root or not TargetCFrame then
		return false
	end
	if TeleportBusy then
		return false
	end
	TeleportBusy = true

	local Ok = pcall(function()
		local Start = Root.Position
		local Goal = TargetCFrame.Position + Vector3.new(0, 3, 0)
		-- Low flat path (no sky arc) so you don't eat fall damage on land
		local Mid = Start:Lerp(Goal, 0.5) + Vector3.new(0, 6, 0)

		local WasAnchored = Root.Anchored
		Root.Anchored = true
		Root.AssemblyLinearVelocity = Vector3.zero
		Root.AssemblyAngularVelocity = Vector3.zero

		StepRootTo(Root, Mid, 6, 0.02)
		StepRootTo(Root, Goal, 8, 0.02)
		Root.CFrame = CFrame.new(Goal) * (TargetCFrame - TargetCFrame.Position)
		Root.AssemblyLinearVelocity = Vector3.zero
		Root.AssemblyAngularVelocity = Vector3.zero

		if Humanoid then
			pcall(function()
				Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
				Humanoid.PlatformStand = false
			end)
		end

		Root.Anchored = WasAnchored
		-- Hold velocity at zero briefly so the game doesn't register a fall
		for _ = 1, 8 do
			Root.AssemblyLinearVelocity = Vector3.zero
			Root.AssemblyAngularVelocity = Vector3.zero
			task.wait(0.03)
		end
		RestorePlayerCamera()
	end)

	TeleportBusy = false
	pcall(function()
		if Root and Root.Parent then
			Root.Anchored = false
			Root.AssemblyLinearVelocity = Vector3.zero
		end
	end)
	RestorePlayerCamera()
	return Ok and Root.Parent ~= nil and (Root.Position - TargetCFrame.Position).Magnitude < 40
end

TeleportToPoi = function(Name)
	local Track = Workspace:FindFirstChild("POI") and Workspace.POI:FindFirstChild("Track")
	local Marker = Track and Track:FindFirstChild(Name)
	if Marker then
		local Ok, Pivot = pcall(function()
			return Marker:GetPivot()
		end)
		if Ok and Pivot then
			SafeTweenTeleport(Pivot * CFrame.new(0, 4, 0))
			return
		end
		if Marker:IsA("BasePart") then
			SafeTweenTeleport(CFrame.new(Marker.Position + Vector3.new(0, 5, 0)))
			return
		end
	end
	if Name == "GunStore" and Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("GunStore") then
		SafeTweenTeleport(Workspace.Map.GunStore:GetPivot() * CFrame.new(0, 5, 8))
	end
end

local function GetEquippedGun()
	local Character = LocalPlayer.Character
	if not Character then
		return nil
	end
	for _, Child in ipairs(Character:GetChildren()) do
		if Child:IsA("Tool") and (Child:FindFirstChild("Settings") or Child:FindFirstChildWhichIsA("ModuleScript")) then
			return Child
		end
	end
	return nil
end

local function GetReloadRemote()
	ResolveFireRemote()
	return ReloadRemote
end

local function AnyGunModEnabled()
	return Config.NoRecoil
		or Config.NoSpread
		or Config.InfiniteAmmo
		or Config.ForceAutomatic
		or Config.NeverJam
end

local function ModifyGun(Tool)
	if not Tool or not Tool:IsA("Tool") then
		return
	end

	local SettingsModule = Tool:FindFirstChild("Settings") or Tool:FindFirstChildWhichIsA("ModuleScript")
	if not SettingsModule or not SettingsModule:IsA("ModuleScript") then
		return
	end

	local Ok, GunSettings = pcall(require, SettingsModule)
	if not Ok or type(GunSettings) ~= "table" then
		return
	end

	if not OriginalGunSettings[Tool] then
		OriginalGunSettings[Tool] = {
			IsAutomatic = GunSettings.IsAutomatic,
			ForceAutomatic = GunSettings.ForceAutomatic,
			Recoil = GunSettings.Recoil,
			RecoilSpeed = GunSettings.RecoilSpeed,
			SpreadFactor = GunSettings.SpreadFactor,
			JamChance = GunSettings.JamChance,
		}
	end

	local Original = OriginalGunSettings[Tool]

	-- Only patch while a mod is on; otherwise restore stock values so guns stay usable
	if AnyGunModEnabled() then
		GunSettings.ForceAutomatic = Config.ForceAutomatic and true or Original.ForceAutomatic
		GunSettings.Recoil = Config.NoRecoil and 0 or Original.Recoil
		GunSettings.RecoilSpeed = Config.NoRecoil and 0 or Original.RecoilSpeed
		GunSettings.SpreadFactor = Config.NoSpread and 0 or Original.SpreadFactor
		GunSettings.JamChance = Config.NeverJam and 9e8 or Original.JamChance
		if Config.InfiniteAmmo then
			pcall(function()
				Tool:SetAttribute("Ammo_Client", 9e9)
			end)
		end
	else
		GunSettings.ForceAutomatic = Original.ForceAutomatic
		GunSettings.Recoil = Original.Recoil
		GunSettings.RecoilSpeed = Original.RecoilSpeed
		GunSettings.SpreadFactor = Original.SpreadFactor
		GunSettings.JamChance = Original.JamChance
	end
end

ApplyAllGunMods = function()
	local Character = LocalPlayer.Character
	if not Character then
		return
	end
	for _, Item in ipairs(Character:GetChildren()) do
		if Item:IsA("Tool") then
			ModifyGun(Item)
		end
	end
end

local function WatchCharacterGuns(Character)
	if not Character then
		return
	end
	ApplyAllGunMods()
	TrackConnection(Character.ChildAdded, function(Child)
		if Child:IsA("Tool") then
			task.defer(ModifyGun, Child)
		end
	end)
end

local function RunGunMods()
	-- Do not touch guns every frame unless a mod is actually enabled
	if AnyGunModEnabled() then
		local Tool = GetEquippedGun()
		if Tool then
			ModifyGun(Tool)
		end
	end

	if Config.AutoReload and not Config.InfiniteAmmo and os.clock() - ReloadClock > 0.75 and GetEquippedGun() then
		ReloadClock = os.clock()
		local Reload = GetReloadRemote()
		if Reload then
			pcall(function()
				Reload:FireServer()
			end)
		end
	end

	if Config.RapidFire and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
		if os.clock() - RapidClock >= Config.RapidFireDelay then
			RapidClock = os.clock()
			pcall(function()
				mouse1press()
				task.delay(0.01, mouse1release)
			end)
		end
	end
end

local function ResolveKillAuraDeps()
	if KillAuraServerId and KillAuraTokenFn then
		return true
	end

	local Ok = pcall(function()
		local Modules = ReplicatedStorage:WaitForChild("Modules", 5)
		local GunFramework = Modules and Modules:WaitForChild("GunFramework", 5)
		if not GunFramework then
			return
		end

		local GunClient = require(GunFramework:WaitForChild("GunClient"))
		if typeof(getupvalue) == "function" then
			KillAuraTokenFn = function()
				return getupvalue(GunClient.Init, 2)
			end
		end

		-- getgc(true) skipped — hard-crashes Potassium
		if false and typeof(getgc) == "function" and typeof(getupvalue) == "function" then
			for _, Obj in getgc(true) do
				if typeof(Obj) == "table" then
					local FireBullet = rawget(Obj, "FireBullet")
					if FireBullet then
						local OkId, ServerId = pcall(getupvalue, FireBullet, 5)
						if OkId and ServerId ~= nil then
							KillAuraServerId = ServerId
							break
						end
					end
				end
			end
		end
	end)

	return Ok and KillAuraServerId ~= nil and KillAuraTokenFn ~= nil
end

local function GetKillHitRemote()
	local Modules = ReplicatedStorage:FindFirstChild("Modules")
	local GunFramework = Modules and Modules:FindFirstChild("GunFramework")
	local Remotes = GunFramework and GunFramework:FindFirstChild("Remotes")
	if not Remotes then
		return nil
	end
	for _, Child in ipairs(Remotes:GetChildren()) do
		if Child:IsA("RemoteEvent") and string.find(Child.Name, "-", 1, true) then
			return Child
		end
	end
	return nil
end

local function KillAuraDamage(Enemy)
	if not ResolveKillAuraDeps() then
		return
	end

	local Character = LocalPlayer.Character
	local Gun = Character and Character:FindFirstChildOfClass("Tool")
	local GunId = Gun and Gun:GetAttribute("Id")
	if not GunId then
		return
	end

	local EnemyChar = Enemy.Character
	local Head = EnemyChar and EnemyChar:FindFirstChild("Head")
	local Humanoid = EnemyChar and EnemyChar:FindFirstChildOfClass("Humanoid")
	if not Head or not Humanoid or Humanoid.Health <= 0 then
		return
	end

	local Remote = GetKillHitRemote()
	if not Remote then
		return
	end

	local Zero = Vector3.zero
	pcall(function()
		if vector and typeof(vector.create) == "function" then
			Zero = vector.create(0, 0, 0)
		end
	end)

	pcall(function()
		Remote:FireServer(KillAuraServerId, GunId, Head, Zero, nil, KillAuraTokenFn())
	end)
end

local function RunKillAura()
	if not Config.KillAuraEnabled then
		return
	end
	for _, Enemy in ipairs(Players:GetPlayers()) do
		if not IsFriendly(Enemy, Config.SilentGangCheck, false) then
			KillAuraDamage(Enemy)
		end
	end
end

local function RunVehicleSpeed()
	if not Config.VehicleSpeedEnabled then
		return
	end
	local Character = LocalPlayer.Character
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then
		return
	end
	local Seat = Humanoid.SeatPart
	if not Seat then
		return
	end
	local Vehicle = Seat:FindFirstAncestorOfClass("Model")
	if Seat:IsA("VehicleSeat") then
		Seat.MaxSpeed = Config.VehicleSpeed
		Seat.Torque = math.max(Seat.Torque, Config.VehicleSpeed * 20)
	end
	if Vehicle then
		for _, Part in ipairs(Vehicle:GetDescendants()) do
			if Part:IsA("VehicleSeat") then
				Part.MaxSpeed = Config.VehicleSpeed
			elseif Part:IsA("BasePart") and Part.Name:lower():find("wheel") then
				Part.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5)
			end
		end
	end
end

local function RunInstantInteract()
	if not Config.InstantInteract then
		return
	end
	for _, Prompt in ipairs(Workspace:GetDescendants()) do
		if Prompt:IsA("ProximityPrompt") and Prompt.HoldDuration > 0 then
			Prompt.HoldDuration = 0
		end
	end
end

local function RunAntiSit()
	if not Config.AntiSit then
		return
	end
	local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if Humanoid and Humanoid.Sit then
		Humanoid.Sit = false
	end
end

local function GetPromptPart(Prompt)
	local Parent = Prompt and Prompt.Parent
	if not Parent then
		return nil
	end
	if Parent:IsA("BasePart") then
		return Parent
	end
	if Parent:IsA("Attachment") and Parent.Parent and Parent.Parent:IsA("BasePart") then
		return Parent.Parent
	end
	if Parent:IsA("Model") then
		return Parent:FindFirstChild("UpperTorso")
			or Parent:FindFirstChild("HumanoidRootPart")
			or Parent:FindFirstChild("Torso")
			or Parent:FindFirstChildWhichIsA("BasePart", true)
	end
	return Parent:FindFirstChildWhichIsA("BasePart")
end

local function FindJobPrompt(Root, ObjectText, NeedEnabled)
	if not Root then
		return nil
	end
	for _, Desc in ipairs(Root:GetDescendants()) do
		if Desc:IsA("ProximityPrompt") then
			local Match = not ObjectText or Desc.ObjectText == ObjectText
			local EnabledOk = not NeedEnabled or Desc.Enabled
			if Match and EnabledOk then
				return Desc
			end
		end
	end
	return nil
end

local function ColorDistance(A, B)
	if not A or not B then
		return math.huge
	end
	return (Vector3.new(A.R, A.G, A.B) - Vector3.new(B.R, B.G, B.B)).Magnitude
end

local function HasTool(Name)
	local Character = LocalPlayer.Character
	if Character and Character:FindFirstChild(Name) then
		return Character:FindFirstChild(Name)
	end
	local Backpack = LocalPlayer:FindFirstChild("Backpack")
	return Backpack and Backpack:FindFirstChild(Name)
end

local function EquipTool(Name)
	local Tool = HasTool(Name)
	local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if Tool and Humanoid and Tool.Parent ~= LocalPlayer.Character then
		pcall(function()
			Humanoid:EquipTool(Tool)
		end)
		task.wait(0.15)
	end
	return Tool
end

local function FireComplexButton()
	local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
	local Main = PlayerGui and PlayerGui:FindFirstChild("Main")
	local Complex = Main and Main:FindFirstChild("Complex")
	local Button = Complex and Complex:FindFirstChild("Button", true)
	if Button and firesignal then
		pcall(function()
			firesignal(Button.MouseButton1Click)
		end)
		pcall(function()
			firesignal(Button.Activated)
		end)
	end
end

local function SoftMoveTo(Part)
	if not Part then
		return false
	end
	local Goal = CFrame.new(Part.Position + Vector3.new(0, 3, 2.5), Part.Position)
	if not SafeTweenTeleport(Goal) then
		return false
	end
	task.wait(0.25)
	local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	return Root and (Root.Position - Part.Position).Magnitude <= 28
end

local function FirePromptAt(Prompt)
	if not Prompt or not Prompt:IsA("ProximityPrompt") then
		return false
	end
	local Part = GetPromptPart(Prompt)
	if not Part then
		return false
	end
	pcall(function()
		Prompt.HoldDuration = 0
		Prompt.MaxActivationDistance = math.max(Prompt.MaxActivationDistance, 25)
		Prompt.RequiresLineOfSight = false
	end)
	if not SoftMoveTo(Part) then
		return false
	end
	for _ = 1, 2 do
		pcall(fireproximityprompt, Prompt)
		FireComplexButton()
		task.wait(0.25)
	end
	task.wait(0.35)
	RestorePlayerCamera()
	return true
end

local function EnsureHighlightFolder()
	if HighlightFolder and HighlightFolder.Parent then
		return HighlightFolder
	end
	HighlightFolder = Instance.new("Folder")
	HighlightFolder.Name = "EchoHighlights"
	HighlightFolder.Parent = EchoUiContainer
	EchoUiRoots[#EchoUiRoots + 1] = HighlightFolder
	return HighlightFolder
end

ClearHighlights = function()
	if HighlightFolder then
		HighlightFolder:ClearAllChildren()
	end
end

local function RunHighlights()
	if not Config.PlayerHighlights then
		ClearHighlights()
		return
	end
	local Folder = EnsureHighlightFolder()
	local Seen = {}
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and Player.Character then
			Seen[Player.Name] = true
			local Highlight = Folder:FindFirstChild(Player.Name)
			if not Highlight then
				Highlight = Instance.new("Highlight")
				Highlight.Name = Player.Name
				Highlight.FillTransparency = 0.55
				Highlight.OutlineTransparency = 0
				Highlight.Parent = Folder
			end
			Highlight.Adornee = Player.Character
			local Friendly = IsFriendly(Player, Config.SilentGangCheck, false)
			Highlight.FillColor = Friendly and Color3.fromRGB(80, 255, 120) or Config.EspColor
			Highlight.OutlineColor = Highlight.FillColor
		end
	end
	for _, Child in ipairs(Folder:GetChildren()) do
		if not Seen[Child.Name] then
			Child:Destroy()
		end
	end
end

ClearTracers = function()
	for _, Beam in pairs(TracerBeams) do
		pcall(function()
			Beam:Destroy()
		end)
	end
	table.clear(TracerBeams)
end

local function RunTracers()
	if not Config.TracerEsp then
		ClearTracers()
		return
	end
	local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not Root then
		return
	end
	local Attach0 = Root:FindFirstChild("EchoTracerAttach0")
	if not Attach0 then
		Attach0 = Instance.new("Attachment")
		Attach0.Name = "EchoTracerAttach0"
		Attach0.Parent = Root
	end
	local Seen = {}
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and not IsFriendly(Player, Config.SilentGangCheck, false) then
			local TheirRoot = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
			if TheirRoot then
				Seen[Player.Name] = true
				local Pack = TracerBeams[Player.Name]
				if not Pack or not Pack.Parent then
					local Attach1 = Instance.new("Attachment")
					Attach1.Name = "EchoTracerAttach1"
					Attach1.Parent = TheirRoot
					local Beam = Instance.new("Beam")
					Beam.Attachment0 = Attach0
					Beam.Attachment1 = Attach1
					Beam.Width0 = 0.08
					Beam.Width1 = 0.08
					Beam.FaceCamera = true
					Beam.Color = ColorSequence.new(Config.EspColor)
					Beam.Parent = Root
					Pack = Beam
					TracerBeams[Player.Name] = Beam
					Beam:SetAttribute("Attach1", true)
				else
					Pack.Color = ColorSequence.new(Config.EspColor)
				end
			end
		end
	end
	for Name, Beam in pairs(TracerBeams) do
		if not Seen[Name] then
			pcall(function()
				Beam:Destroy()
			end)
			TracerBeams[Name] = nil
		end
	end
end

ClearDropEsp = function()
	for _, Gui in pairs(DropBillboards) do
		pcall(function()
			Gui:Destroy()
		end)
	end
	table.clear(DropBillboards)
end

local function RunDropEsp()
	if not Config.DropEsp then
		ClearDropEsp()
		return
	end
	local LocalRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not LocalRoot then
		return
	end
	local Seen = {}
	for _, Object in ipairs(Workspace:GetChildren()) do
		if Object:IsA("Tool") or Object.Name:lower():find("cash") or Object.Name:lower():find("money") or Object.Name:lower():find("bag") then
			local Part = Object:IsA("BasePart") and Object or Object:FindFirstChild("Handle") or Object:FindFirstChildWhichIsA("BasePart", true)
			if Part and (Part.Position - LocalRoot.Position).Magnitude <= 400 then
				Seen[Object] = true
				local Billboard = DropBillboards[Object]
				if not Billboard then
					Billboard = Instance.new("BillboardGui")
					Billboard.Name = "EchoDropEsp"
					Billboard.Size = UDim2.fromOffset(120, 30)
					Billboard.AlwaysOnTop = true
					Billboard.Adornee = Part
					Billboard.Parent = EchoUiContainer
					local Label = Instance.new("TextLabel")
					Label.BackgroundTransparency = 1
					Label.Size = UDim2.fromScale(1, 1)
					Label.Font = Enum.Font.GothamBold
					Label.TextSize = 12
					Label.TextColor3 = Color3.fromRGB(255, 220, 80)
					Label.TextStrokeTransparency = 0.4
					Label.Parent = Billboard
					DropBillboards[Object] = Billboard
				end
				local Label = Billboard:FindFirstChildOfClass("TextLabel")
				if Label then
					Label.Text = Object.Name
				end
			end
		end
	end
	for Object, Gui in pairs(DropBillboards) do
		if not Seen[Object] then
			pcall(function()
				Gui:Destroy()
			end)
			DropBillboards[Object] = nil
		end
	end
end

RestoreXray = function()
	for Part, Transparency in pairs(XrayParts) do
		if Part and Part.Parent then
			pcall(function()
				Part.LocalTransparencyModifier = 0
				Part.Transparency = Transparency
			end)
		end
		XrayParts[Part] = nil
	end
end

local function RunXray()
	if not Config.Xray then
		RestoreXray()
		return
	end
	local Character = LocalPlayer.Character
	for _, Part in ipairs(Workspace:GetDescendants()) do
		if Part:IsA("BasePart") and not Part:IsDescendantOf(Character) and Part.Transparency < 0.9 then
			if Part.Name ~= "Handle" and not Part:FindFirstAncestorOfClass("Accessory") then
				if XrayParts[Part] == nil then
					XrayParts[Part] = Part.Transparency
				end
				Part.LocalTransparencyModifier = 0.65
			end
		end
	end
end

local function RunSpectate()
	if not Config.SpectateEnabled then
		return
	end
	local Target = SilentTarget or GetClosestPlayer(2000, false, false, false, false, "HumanoidRootPart", 5000)
	local Humanoid = Target and Target.Character and Target.Character:FindFirstChildOfClass("Humanoid")
	if Humanoid and Camera then
		Camera.CameraSubject = Humanoid
	end
end

StopFreecam = function()
	if FreecamConn then
		FreecamConn:Disconnect()
		FreecamConn = nil
	end
	if FreecamPart then
		pcall(function()
			FreecamPart:Destroy()
		end)
		FreecamPart = nil
	end
	local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if Humanoid and Camera then
		Camera.CameraSubject = Humanoid
		Camera.CameraType = Enum.CameraType.Custom
	end
end

StartFreecam = function()
	StopFreecam()
	Camera = Workspace.CurrentCamera
	if not Camera then
		return
	end
	FreecamPart = Instance.new("Part")
	FreecamPart.Name = "EchoFreecam"
	FreecamPart.Anchored = true
	FreecamPart.CanCollide = false
	FreecamPart.Transparency = 1
	FreecamPart.Size = Vector3.new(1, 1, 1)
	FreecamPart.CFrame = Camera.CFrame
	FreecamPart.Parent = Workspace
	Camera.CameraType = Enum.CameraType.Scriptable
	FreecamConn = RunService.RenderStepped:Connect(function(Delta)
		if not Config.Freecam or not FreecamPart then
			return
		end
		local Move = Vector3.zero
		local Speed = Config.FreecamSpeed * Delta
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			Move += FreecamPart.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			Move -= FreecamPart.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			Move += FreecamPart.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			Move -= FreecamPart.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.E) then
			Move += Vector3.new(0, 1, 0)
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Q) then
			Move -= Vector3.new(0, 1, 0)
		end
		if Move.Magnitude > 0 then
			FreecamPart.CFrame += Move.Unit * Speed
		end
		local MouseDelta = UserInputService:GetMouseDelta()
		FreecamPart.CFrame *= CFrame.Angles(-math.rad(MouseDelta.Y * 0.25), -math.rad(MouseDelta.X * 0.25), 0)
		Camera.CFrame = FreecamPart.CFrame
	end)
	Connections[#Connections + 1] = FreecamConn
end

local function RunAutoDaily()
	if not Config.AutoDaily then
		return
	end
	local Daily = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Daily")
	if Daily then
		pcall(function()
			Daily:FireServer()
		end)
	end
end

local function KeyMatches(Input, Name)
	if not Name or not Input then
		return false
	end
	local KeyCode = Enum.KeyCode[Name]
	if KeyCode and Input.KeyCode == KeyCode then
		return true
	end
	-- Q also accepts common controller face/shoulder binds as fallback
	if Name == "Q" then
		return Input.KeyCode == Enum.KeyCode.ButtonL1
			or Input.KeyCode == Enum.KeyCode.ButtonX
	end
	return false
end

local function HandleCamlockBegan(Input)
	if not Config.CamlockEnabled or not KeyMatches(Input, Config.CamlockKey) then
		return
	end
	if Config.CamlockMode == "Hold" then
		Config.CamlockActive = true
	else
		-- Toggle
		Config.CamlockActive = not Config.CamlockActive
		if not Config.CamlockActive then
			CamlockTarget = nil
			StickyCamlock = nil
		end
	end
end

local function HandleCamlockEnded(Input)
	if not Config.CamlockEnabled or not KeyMatches(Input, Config.CamlockKey) then
		return
	end
	if Config.CamlockMode == "Hold" then
		Config.CamlockActive = false
		CamlockTarget = nil
		StickyCamlock = nil
	end
end

TrackConnection(UserInputService.InputBegan, function(Input, GameProcessed)
	-- Camlock must work even when GameProcessed (chat/UI) or on controller
	HandleCamlockBegan(Input)

	if GameProcessed then
		return
	end

	if Input.KeyCode == Enum.KeyCode.W then
		FlyKeysHeld.W = true
	elseif Input.KeyCode == Enum.KeyCode.A then
		FlyKeysHeld.A = true
	elseif Input.KeyCode == Enum.KeyCode.S then
		FlyKeysHeld.S = true
	elseif Input.KeyCode == Enum.KeyCode.D then
		FlyKeysHeld.D = true
	elseif Input.KeyCode == Enum.KeyCode.Space then
		FlyKeysHeld.Space = true
	elseif Input.KeyCode == Enum.KeyCode.LeftShift then
		FlyKeysHeld.LeftShift = true
	end

	if Config.InfiniteJump and Input.KeyCode == Enum.KeyCode.Space then
		local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if Humanoid then
			Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end

	if Config.ClickTp and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and Input.UserInputType == Enum.UserInputType.MouseButton1 then
		local Root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if Root and Mouse.Hit then
			SafeTweenTeleport(CFrame.new(Mouse.Hit.Position + Vector3.new(0, 3, 0)))
		end
	end
end)

TrackConnection(UserInputService.InputEnded, function(Input)
	if Input.KeyCode == Enum.KeyCode.W then
		FlyKeysHeld.W = false
	elseif Input.KeyCode == Enum.KeyCode.A then
		FlyKeysHeld.A = false
	elseif Input.KeyCode == Enum.KeyCode.S then
		FlyKeysHeld.S = false
	elseif Input.KeyCode == Enum.KeyCode.D then
		FlyKeysHeld.D = false
	elseif Input.KeyCode == Enum.KeyCode.Space then
		FlyKeysHeld.Space = false
	elseif Input.KeyCode == Enum.KeyCode.LeftShift then
		FlyKeysHeld.LeftShift = false
	end

	HandleCamlockEnded(Input)
end)

TrackConnection(LocalPlayer.Idled, function()
	if Config.AntiAfk then
		pcall(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end
end)

TrackConnection(Workspace:GetPropertyChangedSignal("CurrentCamera"), function()
	Camera = Workspace.CurrentCamera
end)

-- Do NOT install namecall on load — that was breaking guns.
-- Hook only when Infinite Ammo / Silent / Wallbang is turned on.
UninstallCombatHook()
pcall(SyncCombatHook)
ApplyEspConfig()

if LocalPlayer.Character then
	WatchCharacterGuns(LocalPlayer.Character)
end
TrackConnection(LocalPlayer.CharacterAdded, function(Character)
	task.wait(0.25)
	WatchCharacterGuns(Character)
end)

task.spawn(function()
	while getgenv().EchoConfig == Config do
		if Config.KillAuraEnabled then
			pcall(RunKillAura)
		end
		task.wait(0.1)
	end
end)

local StreetVisualClock = 0
TrackConnection(RunService.RenderStepped, function()
	Camera = Workspace.CurrentCamera
	-- Silent aim point must stay per-frame; FOV/ESP visuals throttled
	pcall(RefreshSilentAimPoint)
	pcall(RefreshSilentRayTarget)
	local Now = os.clock()
	if Now - StreetVisualClock >= 0.1 then
		StreetVisualClock = Now
		pcall(UpdateFovVisuals)
		pcall(ApplyEspConfig)
	end
end)

-- Camlock after camera module so it actually sticks
pcall(function()
	RunService:UnbindFromRenderStep("EchoCamlock")
end)
RunService:BindToRenderStep("EchoCamlock", Enum.RenderPriority.Camera.Value + 1, function()
	pcall(RunCamlock)
end)

local StreetHbClock = 0
TrackConnection(RunService.Heartbeat, function()
	if not FireRemote then
		ResolveFireRemote()
	end
	pcall(ResolveSilentTarget)
	pcall(RunTriggerbot)
	pcall(RunWalkSpeed)
	pcall(RunJumpPower)
	pcall(RunFly)
	pcall(RunInfiniteStamina)
	pcall(RunHitboxes)
	pcall(RunGunMods)
	pcall(RunVehicleSpeed)
	pcall(RunAntiSit)
	pcall(RunSpectate)
	pcall(RestorePlayerCamera)

	local Now = os.clock()
	if Now - StreetHbClock >= 0.12 then
		StreetHbClock = Now
		pcall(RunFov)
		pcall(RunLighting)
		if Config.PlayerHighlights then
			pcall(RunHighlights)
		else
			pcall(ClearHighlights)
		end
		if Config.TracerEsp then
			pcall(RunTracers)
		else
			pcall(ClearTracers)
		end
		if Config.DropEsp then
			pcall(RunDropEsp)
		else
			pcall(ClearDropEsp)
		end
		if Config.Xray then
			pcall(RunXray)
		end
	end
end)

task.spawn(function()
	while task.wait(2) do
		if getgenv().EchoConfig ~= Config then
			break
		end
		pcall(RunInstantInteract)
		pcall(RunAutoDaily)
	end
end)

getgenv().EchoCleanup = function()
	Config.SilentEnabled = false
	Config.CamlockEnabled = false
	Config.CamlockActive = false
	Config.TriggerbotEnabled = false
	Config.EspEnabled = false
	Config.WalkSpeedEnabled = false
	Config.JumpPowerEnabled = false
	Config.FlyEnabled = false
	Config.HitboxEnabled = false
	Config.InfiniteStamina = false
	Config.FovEnabled = false
	Config.NoRecoil = false
	Config.NoSpread = false
	Config.InfiniteAmmo = false
	Config.ForceAutomatic = false
	Config.NeverJam = false
	Config.KillAuraEnabled = false
	Config.SilentWallBang = false
	Config.AutoReload = false
	Config.RapidFire = false
	pcall(UninstallCombatHook)
	pcall(function()
		RunService:UnbindFromRenderStep("EchoCamlock")
	end)
	Config.Fullbright = false
	Config.NoFog = false
	Config.Xray = false
	Config.PlayerHighlights = false
	Config.DropEsp = false
	Config.TracerEsp = false
	Config.VehicleSpeedEnabled = false
	Config.InstantInteract = false
	Config.Freecam = false
	Config.SpectateEnabled = false
	Config.AutoDaily = false

	StopFly()
	StopFreecam()
	RestoreLighting()
	RestoreXray()
	ClearHighlights()
	ClearTracers()
	ClearDropEsp()
	ApplyEspConfig()

	for Part, Size in pairs(HitboxOriginal) do
		if Part and Part.Parent then
			pcall(function()
				Part.Size = Size
				Part.Transparency = 1
			end)
		end
		HitboxOriginal[Part] = nil
	end

	if Esp and Esp.Unload then
		pcall(function()
			Esp:Unload()
		end)
	end

	for _, Root in ipairs(EchoUiRoots) do
		pcall(function()
			Root:Destroy()
		end)
	end
	table.clear(EchoUiRoots)

	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)

	pcall(function()
		if Library and Library.Unload then
			Library:Unload()
		end
	end)

	pcall(function()
		if typeof(getgenv().EchoBaseNamecall) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__namecall", getgenv().EchoBaseNamecall)
		elseif typeof(restorefunction) == "function" then
			local Meta = getrawmetatable(game)
			if Meta and typeof(Meta.__namecall) == "function" then
				restorefunction(Meta.__namecall)
			end
		end
	end)
	getgenv().EchoBaseNamecall = nil
	getgenv().EchoSilentHooked = nil
	getgenv().EchoSilentAimPoint = nil
	getgenv().EchoNamecallRef = nil
	OldNamecall = nil
	HookInstalled = false

	pcall(function()
		EchoUiContainer:Destroy()
	end)

	if getgenv().Library == Library then
		getgenv().Library = nil
	end

	getgenv().EchoConfig = nil
end

getgenv().EchoConfig = Config

do
	local Defaults = {
		SilentFov = 180,
		SilentMaxDistance = 800,
		CamlockFov = 220,
		CamlockSmoothness = 0.18,
		CamlockMaxDistance = 800,
		TriggerbotDelay = 0.04,
		TriggerbotFov = 40,
		RapidFireDelay = 0.05,
		EspDistance = 500,
		WalkSpeed = 22,
		JumpPower = 55,
		FlySpeed = 40,
		HitboxSize = 3.5,
		HitboxTransparency = 0.7,
		VehicleSpeed = 120,
		MaxZoom = 128,
		FreecamSpeed = 60,
		FovValue = 90,
	}
	for Key, Default in pairs(Defaults) do
		local Value = Config[Key]
		if typeof(Value) ~= "number" or Value ~= Value or Value == math.huge or Value == -math.huge then
			Config[Key] = Default
		end
	end
	if Library and Library.Flags then
		for Key, Default in pairs(Defaults) do
			local FlagValue = Library.Flags[Key]
			if typeof(FlagValue) ~= "number" or FlagValue ~= FlagValue then
				Library.Flags[Key] = Config[Key] or Default
			end
		end
	end
end

pcall(RestorePlayerCamera)
if IsFiniteNumber(Config.MaxZoom) then
	LocalPlayer.CameraMaxZoomDistance = Config.MaxZoom
else
	Config.MaxZoom = 128
	LocalPlayer.CameraMaxZoomDistance = 128
end

-- Force menu close key (GitHub UI may still ship RightControl)
pcall(function()
	Library.MenuKeybind = tostring(Enum.KeyCode.RightShift)
end)

Library:Notification(
	"Echo Loaded",
	"Street Life ready in " .. string.format("%.3f", os.clock() - LoadTick) .. "s",
	6
)
]====], "Echo_Street_Life")
	if not EchoChunk then
		error("[Echo] Street Life compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsOT7() then
-- Echo Hub: OT7
do
	local EchoChunk, EchoChunkErr = loadstring([====[
pcall(function()
	-- Adonis V5+ Emulator (OT7)
	-- Hooks Detected/Kill, steals or handshakes session key.

	if not LPH_OBFUSCATED then
		function LPH_NO_VIRTUALIZE(F)
			return F
		end
	end

	if _G.__AdonisEmu then
		return _G.Adonis
	end
	_G.__AdonisEmu = true

	local Plrs = game:GetService("Players")
	local RS = game:GetService("ReplicatedStorage")
	local Http = game:GetService("HttpService")
	local Me = Plrs.LocalPlayer

	local StartTime = os.clock()
	local LogBuf = {}
	local DbgMode = false

	local function Log(Tag, Msg)
		local Entry = {
			time = math.floor((os.clock() - StartTime) * 1000),
			tag = Tag,
			msg = Msg,
		}
		table.insert(LogBuf, Entry)
		if DbgMode then
			print(("[+%dms] [%s] %s"):format(Entry.time, Tag, Msg))
		end
	end

	local ArgPreview = LPH_NO_VIRTUALIZE(function(Args)
		local Parts = {}
		for I = 1, math.min(#Args, 4) do
			local V = Args[I]
			local S = type(V) == "table" and "{table}" or tostring(V)
			if #S > 40 then
				S = S:sub(1, 37) .. "..."
			end
			Parts[I] = S
		end
		if #Args > 4 then
			Parts[#Parts + 1] = ("...+%d"):format(#Args - 4)
		end
		return table.concat(Parts, ", ")
	end)

	Log("BOOT", "handshake-only Adonis (no getgc — Potassium crash safe)")

	-- Intentionally skip Detected/Kill getgc hooks — getgc(true) hard-crashes Potassium.

	local ECache = {}
	local DCache = {}

	local Xor = LPH_NO_VIRTUALIZE(function(S, K, Cache)
		if not K or not S or S == "" then
			return S
		end
		Cache = Cache or ECache
		local KC = Cache[K]
		if not KC then
			KC = {}
			Cache[K] = KC
		end
		if KC[S] then
			return KC[S]
		end

		local Raw = buffer.fromstring(S)
		local RK = KC[1] or buffer.fromstring(K)
		local Len = #K

		for I = 0, #S - 1 do
			buffer.writeu8(Raw, I, bit32.bxor(buffer.readu8(Raw, I), buffer.readu8(RK, I % Len)))
		end

		KC[1] = RK
		local Out = buffer.tostring(Raw)
		KC[S] = Out
		return Out
	end)

	local RName = nil
	local Deps = nil
	local Key = nil
	local Ev = nil
	local Fn = nil
	local TxCount = 0
	local RxCount = 0
	local Waiting = {}
	local SpecEv = nil

	local function GrabSpecial(Child)
		if Child.Name ~= "Adonis_Container" then
			return
		end
		local Folder = Child:FindFirstChildOfClass("Folder") or Child:FindFirstChild("Adonis_Client")
		if not Folder then
			return
		end
		local SV = Folder:FindFirstChild("Special")
		if not SV then
			local Ok, R = pcall(function()
				return Folder:WaitForChild("Special", 3)
			end)
			SV = Ok and R or nil
		end
		if not SV or SV.Value == "" then
			return
		end
		local RN, DN = string.match(SV.Value, "(.*)\\(.*)")
		if not RN then
			return
		end
		RName = RN
		Deps = DN
		if SpecEv then
			SpecEv:Disconnect()
			SpecEv = nil
		end
	end

	local function StealKey()
		-- Disabled: getgc(true) crashes Potassium. Use Special + handshake only.
		return false
	end

	local function GetRemote()
		if RName and RName ~= "" then
			local E = RS:FindFirstChild(RName)
			if E and E:IsA("RemoteEvent") then
				Ev = E
				Fn = E:FindFirstChild("__FUNCTION")
				if Fn then
					return true
				end
			end
		end

		for _, Child in pairs(RS:GetChildren()) do
			if Child:IsA("RemoteEvent") then
				local F = Child:FindFirstChild("__FUNCTION")
				if F and F:IsA("RemoteFunction") then
					Ev = Child
					Fn = F
					RName = Child.Name
					return true
				end
			end
		end

		local Found = false
		local C = RS.ChildAdded:Connect(function(Child)
			if Found or not Child:IsA("RemoteEvent") then
				return
			end
			local F = Child:FindFirstChild("__FUNCTION") or Child:WaitForChild("__FUNCTION", 5)
			if F and F:IsA("RemoteFunction") then
				Ev = Child
				Fn = F
				RName = Child.Name
				Found = true
			end
		end)

		local T = os.clock() + 30
		while not Found and os.clock() < T do
			task.wait(0.1)
		end
		C:Disconnect()
		return Found
	end

	local function DoHandshake()
		if not Deps then
			return false
		end

		local Ok, Ret = pcall(function()
			TxCount += 1
			return Fn:InvokeServer({ Mode = "Get", Sent = TxCount, Received = RxCount }, Deps .. "GET_KEY")
		end)

		if Ok and type(Ret) == "string" and Ret ~= "" then
			Key = Ret
			return true
		end

		local Got = false
		local C = Ev.OnClientEvent:Connect(function(Data, Com, ...)
			if type(Com) == "string" and Com == Deps .. "GIVE_KEY" then
				local A = { ... }
				if type(A[1]) == "string" and A[1] ~= "" then
					Key = A[1]
					Got = true
				end
			end
		end)

		TxCount += 1
		Ev:FireServer({ Mode = "Fire", Sent = TxCount, Received = RxCount }, Deps .. "GET_KEY")

		local T = os.clock() + 10
		while not Got and os.clock() < T do
			task.wait(0.05)
		end
		C:Disconnect()
		return Got
	end

	local OnRecv = LPH_NO_VIRTUALIZE(function(Data, Com, ...)
		if type(Com) ~= "string" then
			return
		end
		RxCount += 1

		if Deps and Com == Deps .. "GIVE_KEY" then
			local A = { ... }
			if not Key and type(A[1]) == "string" and A[1] ~= "" then
				Key = A[1]
			end
			return
		end

		if not Key then
			return
		end

		local Dec = Xor(Com, Key, DCache)
		local Mode = Data and Data.Mode or "Fire"
		local Args = { ... }

		if Mode == "Get" then
			if Dec == "ClientHooked" then
				return Deps
			end
			if Dec == "Ping" then
				return "Pong"
			end
			if Dec == "Test" then
				return "HELLO FROM THE CLIENT SIDE :)!"
			end
			if Dec == "UIKeepAlive" then
				return true
			end
			return nil
		end

		if Dec == "GiveReturn" then
			local ID = Args[1]
			local CB = ID and Waiting[ID]
			if CB then
				Waiting[ID] = nil
				CB(table.unpack(Args, 2))
			end
		end
	end)

	local Adonis = {}
	_G.Adonis = Adonis

	task.spawn(function()
		task.wait(1) -- let UI / game scripts settle before Adonis GC / handshake
		local Grabbed = StealKey()

		if Grabbed then
			if not GetRemote() then
				warn("[AdonisEmu] stole key but no remote")
				return
			end
		else
			local PG = Me:FindFirstChildOfClass("PlayerGui") or Me:WaitForChild("PlayerGui", 30)
			if PG then
				for _, Child in pairs(PG:GetChildren()) do
					pcall(GrabSpecial, Child)
				end
				if not RName then
					SpecEv = PG.ChildAdded:Connect(function(Child)
						pcall(GrabSpecial, Child)
					end)
				end
			end

			local T = os.clock() + 15
			while not RName and os.clock() < T do
				task.wait(0.1)
			end
			if SpecEv then
				SpecEv:Disconnect()
				SpecEv = nil
			end

			if not GetRemote() then
				warn("[AdonisEmu] no remote")
				return
			end

			if not DoHandshake() then
				warn("[AdonisEmu] handshake failed")
				return
			end

			task.wait(0.1)
			TxCount += 1
			Ev:FireServer(
				{ Mode = "Fire", Sent = TxCount, Received = RxCount },
				Xor("ClientLoaded", Key, ECache)
			)
		end

		Ev.OnClientEvent:Connect(function(...)
			pcall(OnRecv, ...)
		end)

		pcall(function()
			local Old = Fn.OnClientInvoke
			Fn.OnClientInvoke = function(Data, Com, ...)
				local R = OnRecv(Data, Com, ...)
				if R ~= nil then
					return R
				end
				if Old then
					return Old(Data, Com, ...)
				end
			end
		end)

		task.spawn(function()
			task.wait(5)
			while Key and Ev do
				task.wait(30)
				if Key then
					pcall(function()
						TxCount += 1
						Ev:FireServer(
							{ Mode = "Fire", Sent = TxCount, Received = RxCount },
							Xor("ClientCheck", Key, ECache),
							{ Sent = TxCount, Received = RxCount },
							Deps
						)
					end)
				end
			end
		end)

		Adonis.Key = Key
		Adonis.DepsName = Deps
		Adonis.RemoteName = RName
		Adonis.RemoteEvent = Ev
		Adonis.RemoteFunction = Fn
		print("[AdonisEmu] connected")
	end)

	function Adonis.Send(Cmd, ...)
		assert(Key, "[AdonisEmu] not connected")
		TxCount += 1
		Ev:FireServer({ Mode = "Fire", Sent = TxCount, Received = RxCount }, Xor(Cmd, Key, ECache), ...)
	end

	function Adonis.Get(Cmd, ...)
		assert(Key, "[AdonisEmu] not connected")
		TxCount += 1
		local Ret = Fn:InvokeServer({ Mode = "Get", Sent = TxCount, Received = RxCount }, Xor(Cmd, Key, ECache), ...)
		if type(Ret) == "table" then
			return table.unpack(Ret)
		end
		return Ret
	end

	function Adonis.GetReturn(Name, ...)
		assert(Key, "[AdonisEmu] not connected")
		local Out, Done = nil, false
		local ID = Http:GenerateGUID(false)
		Waiting[ID] = function(...)
			Out = { ... }
			Done = true
		end
		Adonis.Send("GetReturn", Name, ID, ...)
		local T = os.clock() + 10
		while not Done and os.clock() < T do
			task.wait(0.05)
		end
		Waiting[ID] = nil
		return Out and table.unpack(Out)
	end

	function Adonis.ProcessCommand(Cmd)
		assert(type(Cmd) == "string")
		Adonis.Send("ProcessCommand", Cmd)
	end

	function Adonis.GetAdminLevel()
		return Adonis.Get("AdminLevel")
	end
	function Adonis.GetPlayerData()
		return Adonis.Get("PlayerData")
	end
	function Adonis.CheckAdmin()
		return Adonis.Get("CheckAdmin")
	end
	function Adonis.Ping()
		local T = os.clock()
		Adonis.Get("Ping")
		return math.round((os.clock() - T) * 1000)
	end

	function Adonis.Encrypt(S)
		assert(Key, "[AdonisEmu] not connected")
		return Xor(S, Key, ECache)
	end

	function Adonis.Decrypt(S)
		assert(Key, "[AdonisEmu] not connected")
		return Xor(S, Key, DCache)
	end

	function Adonis.GetLogs()
		return LogBuf
	end

	function Adonis.DumpLogs()
		for I = 1, #LogBuf do
			local E = LogBuf[I]
			print(("[+%dms] [%s] %s"):format(E.time, E.tag, E.msg))
		end
	end

	function Adonis.ClearLogs()
		table.clear(LogBuf)
	end

	Adonis.Debug = false
	setmetatable(Adonis, {
		__newindex = function(T, K, V)
			if K == "Debug" then
				DbgMode = V == true
			end
			rawset(T, K, V)
		end,
	})

	return Adonis
end)

-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

-- Adonis AC bypass is prepended by build_loader. Local execute fallback:
pcall(function()
	if _G.__AdonisEmu then
		return
	end
	if typeof(readfile) ~= "function" then
		return
	end
	local Candidates = {
		"C:/Users/Beyond/Desktop/Echo/Script-Hub/OT7-Football/AdonisEmu.lua",
		"Script-Hub/OT7-Football/AdonisEmu.lua",
		"OT7-Football/AdonisEmu.lua",
	}
	for _, Path in ipairs(Candidates) do
		local Ok, Src = pcall(readfile, Path)
		if Ok and type(Src) == "string" and #Src > 100 then
			local Fn = loadstring(Src)
			if Fn then
				pcall(Fn)
			end
			break
		end
	end
end)

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

getgenv().gethui = function()
	return EchoUiContainer
end

local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoScootUI then
		return getgenv().__EchoScootUI
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/saintsrevival1/eee/refs/heads/main/UI-Source.lua"))()
	getgenv().__EchoScootUI = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
	return
end

local Library = LibraryOrErr

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local GameRemotes = ReplicatedStorage:FindFirstChild("GameRemotes")
local FootballEvent = GameRemotes and GameRemotes:FindFirstChild("FootballEvent")
local HitboxEvent = GameRemotes and GameRemotes:FindFirstChild("HitboxEvent")
local GameData = ReplicatedStorage:FindFirstChild("GameData")

local Config = {
	CatchMagnetEnabled = false,
	CatchMagnetRange = 28,
	CatchMagnetHitbox = false,

	BallExpanderEnabled = false,
	BallExpanderScale = 12,
	BallExpanderShowHitbox = false,

	PullVectorEnabled = false,
	PullVectorRange = 22,
	PullVectorStrength = 140,

	AutoCatchEnabled = false,
	AutoCatchRange = 30,
	AutoCatchHold = 0.9,

	AutotuckEnabled = false,
	StickyCatchEnabled = false,
	StickyCatchTime = 0.4,

	DiveBoostEnabled = false,
	DivePower = 4.2,
	AutoDiveEnabled = false,
	AutoDiveRange = 18,

	BlockExtenderEnabled = false,
	BlockExtenderReach = 12,
	BlockExtenderShow = false,

	RouteMarkersEnabled = false,

	OneHandCatch = false,
	AutoHikeEnabled = false,
	QuickTuckKey = Enum.KeyCode.E,

	WalkSpeedEnabled = false,
	WalkSpeed = 24,
	JumpPowerEnabled = false,
	JumpPower = 70,

	AntiJamEnabled = false,
	AntiDownedEnabled = false,
	NoPlatformStand = false,

	ThrowPowerLock = false,
	ThrowPowerValue = 85,

	BallEspEnabled = false,
	CarrierEspEnabled = false,
	TeammateEspEnabled = false,
}

local Connections = {}
local CachedBalls = {}
local BallCacheClock = 0
local MagExpanderClock = 0
local ExpanderVisualParts = setmetatable({}, { __mode = "k" })
local MagnetHitboxPart = nil
local AutotuckLatched = false
local CatchRequestLatched = false
local CatchRequestToken = 0
local StickyToken = 0
local StickyRoot = nil
local StickyWasAnchored = false
local EspBillboards = {}
local EchoUiRoots = { EchoUiContainer }
local ControlsState = nil
local StockDivingPower = 2.9
local StockCatchType = "Regular"
local StockJumpPower = nil
local DiveBoostLatched = false
local OneHandLatched = false
local JumpLatched = false
local LoopToken = {}
getgenv().EchoOT7LoopToken = LoopToken
getgenv().EchoConfig = Config
local LastHikeClock = 0
local HadFootball = false
local LastAutoDiveClock = 0
local BlockExtenderPart = nil
local BlockExtenderTouchClock = 0
local RouteHighlights = {}
local ArmOriginalSizes = setmetatable({}, { __mode = "k" })

pcall(function()
	if typeof(setsimulationradius) == "function" then
		setsimulationradius(10000, 10000)
	end
end)

local Window = Library:Window({
	Logo = "72316209028225",
	FadeTime = 0.3,
})

local Watermark = Library:Watermark("Echo | OT7")
local KeybindList = Library:KeybindList()

local CatchPage = Window:Page({ Name = "Catching", Columns = 2 })
local BallPage = Window:Page({ Name = "Ball", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local MagnetSection = CatchPage:Section({ Name = "Catch Magnet", Side = 1 })
local ExpanderSection = CatchPage:Section({ Name = "Ball Expander", Side = 1 })
local PullSection = CatchPage:Section({ Name = "Pull Vector", Side = 2 })
local AutoCatchSection = CatchPage:Section({ Name = "Auto Catch", Side = 2 })

local CarrySection = BallPage:Section({ Name = "Carry", Side = 1 })
local ThrowSection = BallPage:Section({ Name = "Throw Helpers", Side = 1 })
local DiveSection = BallPage:Section({ Name = "Dive", Side = 2 })
local HikeSection = BallPage:Section({ Name = "Hike", Side = 2 })
local BlockSection = PlayerPage:Section({ Name = "Block Extender", Side = 1 })
local RouteSection = PlayerPage:Section({ Name = "Route Markers", Side = 2 })

local MoveSection = PlayerPage:Section({ Name = "Movement", Side = 1 })
local ProtectSection = PlayerPage:Section({ Name = "Protection", Side = 1 })
local EspSection = PlayerPage:Section({ Name = "ESP", Side = 2 })
local UtilSection = PlayerPage:Section({ Name = "Utility", Side = 2 })

-- // UI
MagnetSection:Toggle({
	Name = "Enabled",
	Flag = "CatchMagnetEnabled",
	Default = Config.CatchMagnetEnabled,
	Callback = function(Value)
		Config.CatchMagnetEnabled = Value == true
		getgenv().EchoConfig = Config
		CachedBalls = {}
		BallCacheClock = 0
	end,
})

MagnetSection:Slider({
	Name = "Range",
	Flag = "CatchMagnetRange",
	Min = 1,
	Max = 50,
	Default = Config.CatchMagnetRange,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.CatchMagnetRange = Value
	end,
})

MagnetSection:Toggle({
	Name = "Show Range",
	Flag = "CatchMagnetHitbox",
	Default = Config.CatchMagnetHitbox,
	Callback = function(Value)
		Config.CatchMagnetHitbox = Value
	end,
})

ExpanderSection:Toggle({
	Name = "Enabled",
	Flag = "BallExpanderEnabled",
	Default = Config.BallExpanderEnabled,
	Callback = function(Value)
		Config.BallExpanderEnabled = Value == true
		getgenv().EchoConfig = Config
	end,
})

ExpanderSection:Slider({
	Name = "Scale",
	Flag = "BallExpanderScale",
	Min = 2,
	Max = 25,
	Default = Config.BallExpanderScale,
	Decimals = 1,
	Suffix = "x",
	Callback = function(Value)
		Config.BallExpanderScale = Value
	end,
})

ExpanderSection:Toggle({
	Name = "Visualize Size",
	Flag = "BallExpanderShowHitbox",
	Default = Config.BallExpanderShowHitbox,
	Callback = function(Value)
		Config.BallExpanderShowHitbox = Value == true
		getgenv().EchoConfig = Config
	end,
})

PullSection:Toggle({
	Name = "Enabled",
	Flag = "PullVectorEnabled",
	Default = Config.PullVectorEnabled,
	Callback = function(Value)
		Config.PullVectorEnabled = Value
	end,
})

PullSection:Slider({
	Name = "Range",
	Flag = "PullVectorRange",
	Min = 1,
	Max = 30,
	Default = Config.PullVectorRange,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.PullVectorRange = Value
	end,
})

PullSection:Slider({
	Name = "Strength",
	Flag = "PullVectorStrength",
	Min = 10,
	Max = 200,
	Default = Config.PullVectorStrength,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.PullVectorStrength = Value
	end,
})

AutoCatchSection:Toggle({
	Name = "Enabled",
	Flag = "AutoCatchEnabled",
	Default = Config.AutoCatchEnabled,
	Callback = function(Value)
		Config.AutoCatchEnabled = Value == true
		getgenv().EchoConfig = Config
		if not Config.AutoCatchEnabled and not Config.CatchMagnetEnabled and not Config.PullVectorEnabled and not Config.BallExpanderEnabled then
			CatchRequestToken += 1
			CatchRequestLatched = false
			pcall(function()
				if HitboxEvent then
					HitboxEvent:FireServer({ "UnRequest Catching" })
				end
			end)
		end
	end,
})

AutoCatchSection:Slider({
	Name = "Range",
	Flag = "AutoCatchRange",
	Min = 5,
	Max = 50,
	Default = Config.AutoCatchRange,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.AutoCatchRange = Value
	end,
})

AutoCatchSection:Slider({
	Name = "Hold Time",
	Flag = "AutoCatchHold",
	Min = 0.3,
	Max = 2,
	Default = Config.AutoCatchHold,
	Decimals = 0.05,
	Suffix = "s",
	Callback = function(Value)
		Config.AutoCatchHold = Value
	end,
})

AutoCatchSection:Toggle({
	Name = "One Hand Catch",
	Flag = "OneHandCatch",
	Default = Config.OneHandCatch,
	Callback = function(Value)
		Config.OneHandCatch = Value == true
		getgenv().EchoConfig = Config
		if not Config.OneHandCatch then
			local State = ControlsState
			if State then
				State.CatchType = StockCatchType
			end
			OneHandLatched = false
		end
	end,
})

CarrySection:Toggle({
	Name = "Autotuck",
	Flag = "AutotuckEnabled",
	Default = Config.AutotuckEnabled,
	Callback = function(Value)
		Config.AutotuckEnabled = Value
		if not Value then
			AutotuckLatched = false
		end
	end,
})

CarrySection:Toggle({
	Name = "Sticky Catch",
	Flag = "StickyCatchEnabled",
	Default = Config.StickyCatchEnabled,
	Callback = function(Value)
		Config.StickyCatchEnabled = Value
		if not Value then
			StickyToken += 1
			if StickyRoot and StickyRoot.Parent then
				pcall(function()
					StickyRoot.Anchored = StickyWasAnchored
				end)
			end
			StickyRoot = nil
		end
	end,
})

CarrySection:Slider({
	Name = "Sticky Time",
	Flag = "StickyCatchTime",
	Min = 0.1,
	Max = 2,
	Default = Config.StickyCatchTime,
	Decimals = 0.05,
	Suffix = "s",
	Callback = function(Value)
		Config.StickyCatchTime = Value
	end,
})

ThrowSection:Toggle({
	Name = "Power Lock",
	Flag = "ThrowPowerLock",
	Default = Config.ThrowPowerLock,
	Callback = function(Value)
		Config.ThrowPowerLock = Value
	end,
})

ThrowSection:Slider({
	Name = "Locked Power",
	Flag = "ThrowPowerValue",
	Min = 30,
	Max = 100,
	Default = Config.ThrowPowerValue,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.ThrowPowerValue = Value
	end,
})

DiveSection:Toggle({
	Name = "Dive Boost",
	Flag = "DiveBoostEnabled",
	Default = Config.DiveBoostEnabled,
	Callback = function(Value)
		Config.DiveBoostEnabled = Value == true
		getgenv().EchoConfig = Config
		if not Config.DiveBoostEnabled then
			local State = ControlsState
			if State then
				State.DivingPower = StockDivingPower
			end
			DiveBoostLatched = false
		end
	end,
})

DiveSection:Slider({
	Name = "Dive Power",
	Flag = "DivePower",
	Min = 2.5,
	Max = 8,
	Default = Config.DivePower,
	Decimals = 0.1,
	Suffix = "x",
	Callback = function(Value)
		Config.DivePower = Value
	end,
})

DiveSection:Toggle({
	Name = "Auto Dive",
	Flag = "AutoDiveEnabled",
	Default = Config.AutoDiveEnabled,
	Callback = function(Value)
		Config.AutoDiveEnabled = Value == true
		getgenv().EchoConfig = Config
	end,
})

DiveSection:Slider({
	Name = "Auto Dive Range",
	Flag = "AutoDiveRange",
	Min = 5,
	Max = 35,
	Default = Config.AutoDiveRange,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.AutoDiveRange = Value
	end,
})

HikeSection:Toggle({
	Name = "Auto Hike",
	Flag = "AutoHikeEnabled",
	Default = Config.AutoHikeEnabled,
	Callback = function(Value)
		Config.AutoHikeEnabled = Value
	end,
})

BlockSection:Toggle({
	Name = "Enabled",
	Flag = "BlockExtenderEnabled",
	Default = Config.BlockExtenderEnabled,
	Callback = function(Value)
		Config.BlockExtenderEnabled = Value == true
		getgenv().EchoConfig = Config
	end,
})

BlockSection:Slider({
	Name = "Reach",
	Flag = "BlockExtenderReach",
	Min = 4,
	Max = 28,
	Default = Config.BlockExtenderReach,
	Decimals = 1,
	Suffix = "st",
	Callback = function(Value)
		Config.BlockExtenderReach = Value
	end,
})

BlockSection:Toggle({
	Name = "Show Hitbox",
	Flag = "BlockExtenderShow",
	Default = Config.BlockExtenderShow,
	Callback = function(Value)
		Config.BlockExtenderShow = Value == true
		getgenv().EchoConfig = Config
	end,
})

RouteSection:Toggle({
	Name = "Enabled",
	Flag = "RouteMarkersEnabled",
	Default = Config.RouteMarkersEnabled,
	Callback = function(Value)
		Config.RouteMarkersEnabled = Value == true
		getgenv().EchoConfig = Config
		if not Config.RouteMarkersEnabled then
			for _, Highlight in pairs(RouteHighlights) do
				pcall(function()
					Highlight:Destroy()
				end)
			end
			table.clear(RouteHighlights)
		end
	end,
})

MoveSection:Toggle({
	Name = "Walk Speed",
	Flag = "WalkSpeedEnabled",
	Default = Config.WalkSpeedEnabled,
	Callback = function(Value)
		Config.WalkSpeedEnabled = Value == true
		getgenv().EchoConfig = Config
	end,
})

MoveSection:Slider({
	Name = "Speed",
	Flag = "WalkSpeed",
	Min = 12,
	Max = 45,
	Default = Config.WalkSpeed,
	Decimals = 1,
	Suffix = " st/s",
	Callback = function(Value)
		Config.WalkSpeed = Value
	end,
})

MoveSection:Toggle({
	Name = "Jump Power",
	Flag = "JumpPowerEnabled",
	Default = Config.JumpPowerEnabled,
	Callback = function(Value)
		Config.JumpPowerEnabled = Value == true
		getgenv().EchoConfig = Config
		if not Config.JumpPowerEnabled then
			pcall(function()
				local Character = LocalPlayer.Character
				local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
				if Humanoid and StockJumpPower then
					Humanoid.JumpPower = StockJumpPower
				end
			end)
			JumpLatched = false
		end
	end,
})

MoveSection:Slider({
	Name = "Jump",
	Flag = "JumpPower",
	Min = 40,
	Max = 110,
	Default = Config.JumpPower,
	Decimals = 1,
	Suffix = "",
	Callback = function(Value)
		Config.JumpPower = Value
	end,
})

ProtectSection:Toggle({
	Name = "Anti Jam",
	Flag = "AntiJamEnabled",
	Default = Config.AntiJamEnabled,
	Callback = function(Value)
		Config.AntiJamEnabled = Value
	end,
})

ProtectSection:Toggle({
	Name = "Anti Downed",
	Flag = "AntiDownedEnabled",
	Default = Config.AntiDownedEnabled,
	Callback = function(Value)
		Config.AntiDownedEnabled = Value
	end,
})

ProtectSection:Toggle({
	Name = "No PlatformStand",
	Flag = "NoPlatformStand",
	Default = Config.NoPlatformStand,
	Callback = function(Value)
		Config.NoPlatformStand = Value
	end,
})

EspSection:Toggle({
	Name = "Ball",
	Flag = "BallEspEnabled",
	Default = Config.BallEspEnabled,
	Callback = function(Value)
		Config.BallEspEnabled = Value
	end,
})

EspSection:Toggle({
	Name = "Ball Carrier",
	Flag = "CarrierEspEnabled",
	Default = Config.CarrierEspEnabled,
	Callback = function(Value)
		Config.CarrierEspEnabled = Value
	end,
})

EspSection:Toggle({
	Name = "Teammates",
	Flag = "TeammateEspEnabled",
	Default = Config.TeammateEspEnabled,
	Callback = function(Value)
		Config.TeammateEspEnabled = Value
	end,
})

UtilSection:Button({
	Name = "Rejoin",
	Callback = function()
		pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
		end)
	end,
})

UtilSection:Button({
	Name = "Server Hop",
	Callback = function()
		pcall(function()
			TeleportService:Teleport(game.PlaceId, LocalPlayer)
		end)
	end,
})

-- // Helpers
local function Track(Connection)
	Connections[#Connections + 1] = Connection
	return Connection
end

local function GetCharacter()
	return LocalPlayer.Character
end

local function GetRoot(Character)
	Character = Character or GetCharacter()
	return Character and (Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso"))
end

local function GetHumanoid(Character)
	Character = Character or GetCharacter()
	return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function HoldingFootball(Character)
	Character = Character or GetCharacter()
	local Football = Character and Character:FindFirstChild("Football")
	return Football ~= nil, Football
end

local function FindControlsState()
	if ControlsState and type(ControlsState) == "table" then
		return ControlsState
	end
	local Character = GetCharacter()
	local Primary = Character and Character:FindFirstChild("Primary")
	local Controls = Primary and Primary:FindFirstChild("ControlsClient")
	if not Controls or typeof(getupvalues) ~= "function" then
		return nil
	end
	local Ok, Values = pcall(getupvalues, Controls)
	if not Ok or type(Values) ~= "table" then
		-- LocalScripts often need getupvalue on closures; try debug.getupvalue via getgc later
		return nil
	end
	for _, Value in pairs(Values) do
		if type(Value) == "table" and Value.CanCatch ~= nil and Value.DivingPower ~= nil then
			ControlsState = Value
			return ControlsState
		end
	end
	return nil
end

local ControlsStateScanClock = 0
local function RefreshControlsState()
	-- Disabled getgc controls resolve — crashes Potassium. Catch features that need
	-- ControlsState will no-op until another resolve path exists.
	ControlsStateScanClock = os.clock()
	return
end

local function IsLooseFootball(Instance)
	if not Instance then
		return nil
	end
	-- OT7 loose ball is a MeshPart named Football parented to Workspace
	if Instance:IsA("BasePart") and Instance.Name == "Football" and Instance.Parent == Workspace then
		return Instance
	end
	return nil
end

local function GetLooseBalls()
	local Now = os.clock()
	if Now - BallCacheClock < 0.02 and #CachedBalls > 0 then
		local Alive = {}
		for Index = 1, #CachedBalls do
			local Part = CachedBalls[Index]
			if Part and Part.Parent == Workspace and Part.Name == "Football" then
				Alive[#Alive + 1] = Part
			end
		end
		CachedBalls = Alive
		if #Alive > 0 then
			return CachedBalls
		end
	end

	BallCacheClock = Now
	local Results = {}
	for _, Child in ipairs(Workspace:GetChildren()) do
		local Part = IsLooseFootball(Child)
		if Part then
			Results[#Results + 1] = Part
		end
	end
	CachedBalls = Results
	return Results
end

local function GetClosestLooseBall(Origin, MaxRange)
	local Best, BestDistance = nil, MaxRange or math.huge
	for _, Ball in ipairs(GetLooseBalls()) do
		local Distance = (Ball.Position - Origin).Magnitude
		if Distance < BestDistance then
			Best = Ball
			BestDistance = Distance
		end
	end
	return Best, BestDistance
end

local function GetTouchParts(Character)
	local Parts = {}
	for _, Name in ipairs({ "Right Arm", "Left Arm", "Torso", "HumanoidRootPart", "Head" }) do
		local Part = Character:FindFirstChild(Name)
		if Part and Part:IsA("BasePart") then
			pcall(function()
				Part.CanTouch = true
			end)
			Parts[#Parts + 1] = Part
		end
	end
	return Parts
end

local CatchWindowOpen = false
local LastCatchFireClock = 0
local LastNativeCatchClock = 0

local function EnsureControls()
	if ControlsState and type(ControlsState) == "table" and type(ControlsState.RequestCatch) == "function" then
		return ControlsState
	end
	RefreshControlsState()
	return ControlsState
end

local function OpenCatchWindow()
	if not HitboxEvent then
		return
	end
	CatchWindowOpen = true
	-- refresh often so server doesn't drop the catch state mid-flight
	if os.clock() - LastCatchFireClock >= 0.2 then
		LastCatchFireClock = os.clock()
		pcall(function()
			HitboxEvent:FireServer({ "Request Catching" })
		end)
	end
end

local function CloseCatchWindow()
	if not CatchWindowOpen then
		return
	end
	CatchWindowOpen = false
	CatchRequestLatched = false
	pcall(function()
		if HitboxEvent then
			HitboxEvent:FireServer({ "UnRequest Catching" })
		end
	end)
end

local function SpoofBallDistance(Distance)
	local State = EnsureControls()
	if State then
		State.BallDistance = Distance
		-- recover if the native catch cooldown got stuck
		if State.CanCatch == false and os.clock() - LastNativeCatchClock > 2 then
			State.CanCatch = true
		end
	end
end

local function NativeCatch(Ball)
	local State = EnsureControls()
	if not State or type(State.RequestCatch) ~= "function" or not Ball then
		OpenCatchWindow()
		return
	end
	if State.CanCatch == false then
		OpenCatchWindow()
		return
	end
	if os.clock() - LastNativeCatchClock < 0.9 then
		OpenCatchWindow()
		return
	end
	LastNativeCatchClock = os.clock()
	local Root = GetRoot()
	local Distance = Root and (Root.Position - Ball.Position).Magnitude or 2
	SpoofBallDistance(math.min(Distance, 1.5))
	task.spawn(function()
		pcall(State.RequestCatch, Ball)
	end)
end

local function ApplyStickyCatch()
	if not Config.StickyCatchEnabled then
		return
	end
	local Root = GetRoot()
	if not Root then
		return
	end
	StickyToken += 1
	local Token = StickyToken
	StickyRoot = Root
	StickyWasAnchored = Root.Anchored
	pcall(function()
		Root.Anchored = true
		Root.AssemblyLinearVelocity = Vector3.zero
		Root.AssemblyAngularVelocity = Vector3.zero
	end)
	task.delay(math.clamp(tonumber(Config.StickyCatchTime) or 0.4, 0.1, 2), function()
		if Token ~= StickyToken then
			return
		end
		if StickyRoot and StickyRoot.Parent then
			pcall(function()
				StickyRoot.Anchored = StickyWasAnchored
			end)
		end
		StickyRoot = nil
	end)
end

local function AttractBall(Ball, TargetPart, Strength)
	if not Ball or not TargetPart then
		return
	end
	local Offset = TargetPart.Position - Ball.Position
	local Distance = Offset.Magnitude
	if Distance < 0.05 then
		return
	end
	pcall(function()
		Ball.CanCollide = false
		Ball.CanTouch = true
		Ball.Anchored = false
		if Distance <= 10 then
			Ball.CFrame = TargetPart.CFrame * CFrame.new(0, 0.4, -1.1)
			Ball.AssemblyLinearVelocity = Vector3.zero
			Ball.AssemblyAngularVelocity = Vector3.zero
		else
			Ball.AssemblyLinearVelocity = Offset.Unit * Strength + Vector3.new(0, 8, 0)
		end
	end)
end

local function AnyCatchAssistEnabled()
	return Config.CatchMagnetEnabled or Config.BallExpanderEnabled or Config.PullVectorEnabled or Config.AutoCatchEnabled
end

local function RunAutoCatch()
	if not Config.AutoCatchEnabled then
		return
	end
	local Character = GetCharacter()
	local Root = GetRoot(Character)
	if not Character or not Root or HoldingFootball(Character) then
		return
	end

	local Range = math.clamp(tonumber(Config.AutoCatchRange) or 24, 5, 60)
	local Ball, Distance = GetClosestLooseBall(Root.Position, Range + 20)
	if not Ball then
		return
	end

	local Predicted = Ball.Position + Ball.AssemblyLinearVelocity * 0.15
	local PredictedDistance = (Root.Position - Predicted).Magnitude
	if Distance > Range and PredictedDistance > Range then
		return
	end

	SpoofBallDistance(math.min(Distance, 1.5))
	OpenCatchWindow()
	AttractBall(Ball, Root, 110)
	if Distance <= 8 then
		NativeCatch(Ball)
		ApplyStickyCatch()
	end
end

local function RunCatchMagnet()
	if not Config.CatchMagnetEnabled then
		return
	end
	local Character = GetCharacter()
	local Root = GetRoot(Character)
	if not Character or not Root or HoldingFootball(Character) then
		return
	end

	local Range = math.clamp(tonumber(Config.CatchMagnetRange) or 18, 1, 50)
	local Ball, Distance = GetClosestLooseBall(Root.Position, Range + 25)
	if not Ball then
		return
	end

	local Predicted = Ball.Position + Ball.AssemblyLinearVelocity * 0.15
	local PredictedDistance = (Root.Position - Predicted).Magnitude
	if Distance > Range and PredictedDistance > Range then
		return
	end

	local TouchParts = GetTouchParts(Character)
	local Hands = Character:FindFirstChild("Torso") or TouchParts[1] or Root

	-- hold catch window + pull ball in (do NOT UnRequest early)
	SpoofBallDistance(1)
	OpenCatchWindow()
	AttractBall(Ball, Hands, 130)

	-- only fire native catch anim when already close so it doesn't UnRequest mid-magnet
	if Distance <= 7 then
		NativeCatch(Ball)
	end
end

local function UpdateMagnetHitbox()
	local Root = GetRoot()
	local Holding = HoldingFootball()
	if not Config.CatchMagnetEnabled or not Config.CatchMagnetHitbox or not Root or Holding then
		if MagnetHitboxPart then
			MagnetHitboxPart:Destroy()
			MagnetHitboxPart = nil
		end
		return
	end

	if not MagnetHitboxPart then
		MagnetHitboxPart = Instance.new("Part")
		MagnetHitboxPart.Name = "EchoCatchMagnet"
		MagnetHitboxPart.Shape = Enum.PartType.Ball
		MagnetHitboxPart.Material = Enum.Material.ForceField
		MagnetHitboxPart.Color = Color3.fromRGB(180, 207, 229)
		MagnetHitboxPart.Transparency = 0.72
		MagnetHitboxPart.Anchored = true
		MagnetHitboxPart.CanCollide = false
		MagnetHitboxPart.CanTouch = false
		MagnetHitboxPart.CanQuery = false
		MagnetHitboxPart.CastShadow = false
		MagnetHitboxPart.Parent = Workspace
	end

	local Diameter = math.clamp(tonumber(Config.CatchMagnetRange) or 18, 1, 50) * 2
	MagnetHitboxPart.Size = Vector3.new(Diameter, Diameter, Diameter)
	MagnetHitboxPart.CFrame = Root.CFrame
end

local function ClearExpanderVisuals()
	for Ball, Visual in pairs(ExpanderVisualParts) do
		if Visual then
			pcall(function()
				Visual:Destroy()
			end)
		end
		ExpanderVisualParts[Ball] = nil
	end
end

local function GetExpanderReach(Ball, Scale)
	local Size = Ball.Size
	local Base = math.max(Size.X, Size.Y, Size.Z)
	return Base * math.clamp(tonumber(Scale) or 12, 2, 25) * 0.6
end

local function UpdateExpanderVisual(Ball, Reach)
	if not Config.BallExpanderShowHitbox or not Ball or not Ball.Parent then
		local Existing = ExpanderVisualParts[Ball]
		if Existing then
			pcall(function()
				Existing:Destroy()
			end)
			ExpanderVisualParts[Ball] = nil
		end
		return
	end

	local Visual = ExpanderVisualParts[Ball]
	if not Visual or not Visual.Parent then
		Visual = Instance.new("Part")
		Visual.Name = "EchoBallExpandVisual"
		Visual.Shape = Enum.PartType.Ball
		Visual.Material = Enum.Material.ForceField
		Visual.Color = Color3.fromRGB(255, 196, 92)
		Visual.Transparency = 0.7
		Visual.Anchored = true
		Visual.CanCollide = false
		Visual.CanTouch = false
		Visual.CanQuery = false
		Visual.CastShadow = false
		Visual.Parent = Workspace
		ExpanderVisualParts[Ball] = Visual
	end

	local Diameter = math.max(Reach * 2, 2)
	Visual.Size = Vector3.new(Diameter, Diameter, Diameter)
	Visual.CFrame = Ball.CFrame
end

local function RunBallExpander()
	if not Config.BallExpanderEnabled then
		ClearExpanderVisuals()
		return
	end

	local Now = os.clock()
	if Now - MagExpanderClock < 0.03 then
		return
	end
	MagExpanderClock = Now

	local Character = GetCharacter()
	local Root = GetRoot(Character)
	local Scale = math.clamp(tonumber(Config.BallExpanderScale) or 12, 2, 25)
	local Active = {}

	for _, Ball in ipairs(GetLooseBalls()) do
		Active[Ball] = true
		-- keep real ball mesh normal size — expand is virtual catch radius only
		pcall(function()
			Ball.CanCollide = false
			Ball.CanTouch = true
		end)

		local Reach = GetExpanderReach(Ball, Scale)
		UpdateExpanderVisual(Ball, Reach)

		if Root and not HoldingFootball(Character) then
			local Distance = (Root.Position - Ball.Position).Magnitude
			if Distance <= Reach + 6 then
				SpoofBallDistance(1)
				OpenCatchWindow()
				AttractBall(Ball, Root, 120)
				if Distance <= 8 then
					NativeCatch(Ball)
				end
			end
		end
	end

	for Ball, Visual in pairs(ExpanderVisualParts) do
		if not Active[Ball] then
			pcall(function()
				Visual:Destroy()
			end)
			ExpanderVisualParts[Ball] = nil
		end
	end
end

local function RunPullVector()
	if not Config.PullVectorEnabled then
		return
	end
	local Character = GetCharacter()
	local Root = GetRoot(Character)
	if not Character or not Root or HoldingFootball(Character) then
		return
	end

	local Range = math.clamp(tonumber(Config.PullVectorRange) or 14, 1, 40)
	local Strength = math.clamp(tonumber(Config.PullVectorStrength) or 85, 10, 220)
	local PullTarget = Character:FindFirstChild("Torso") or Root

	local Ball, Distance = GetClosestLooseBall(Root.Position, Range + 12)
	if not Ball or Distance > Range then
		return
	end

	SpoofBallDistance(1)
	OpenCatchWindow()
	AttractBall(Ball, PullTarget, Strength)
	if Distance <= 7 then
		NativeCatch(Ball)
	end
end

local function MaintainCatchWindow()
	if HoldingFootball() then
		CloseCatchWindow()
		return
	end
	if not AnyCatchAssistEnabled() then
		CloseCatchWindow()
		return
	end
	local Root = GetRoot()
	if not Root then
		CloseCatchWindow()
		return
	end
	local MaxRange = math.max(
		tonumber(Config.CatchMagnetRange) or 0,
		tonumber(Config.PullVectorRange) or 0,
		tonumber(Config.AutoCatchRange) or 0,
		25
	) + 15
	local Ball = GetClosestLooseBall(Root.Position, MaxRange)
	if not Ball then
		CloseCatchWindow()
	elseif CatchWindowOpen then
		-- keep alive
		OpenCatchWindow()
	end
end

local function RunAutotuck()
	if not Config.AutotuckEnabled or not FootballEvent then
		AutotuckLatched = false
		return
	end
	local Character = GetCharacter()
	if not HoldingFootball(Character) then
		AutotuckLatched = false
		return
	end
	if Character:GetAttribute("Tucking") == true then
		AutotuckLatched = true
		return
	end
	if AutotuckLatched then
		return
	end
	AutotuckLatched = true
	pcall(function()
		FootballEvent:FireServer("Request Tucking")
	end)
end

local function RunAutoHike()
	if not Config.AutoHikeEnabled or not FootballEvent then
		return
	end
	if os.clock() - LastHikeClock < 0.75 then
		return
	end
	local Character = GetCharacter()
	local Root = GetRoot(Character)
	if not Character or not Root then
		return
	end
	if Character:GetAttribute("UnderCenter") ~= true or HoldingFootball(Character) then
		return
	end
	local GameFolder = Workspace:FindFirstChild("GameFolder")
	local ThrowerPad = GameFolder and GameFolder:FindFirstChild("ThrowerPad")
	if not ThrowerPad or ThrowerPad:GetAttribute("CurrentThrower") ~= Character.Name then
		return
	end
	LastHikeClock = os.clock()
	pcall(function()
		FootballEvent:FireServer({ "Request Hike", Root.Position, 45 })
	end)
end

local function SyncConfigFromFlags()
	local Flags = Library.Flags
	if not Flags then
		return
	end

	local function SyncBool(FlagName, ConfigKey)
		local Value = Flags[FlagName]
		if typeof(Value) == "boolean" then
			Config[ConfigKey] = Value
		end
	end

	local function SyncNumber(FlagName, ConfigKey)
		local Value = Flags[FlagName]
		if typeof(Value) == "number" then
			Config[ConfigKey] = Value
		end
	end

	SyncBool("CatchMagnetEnabled", "CatchMagnetEnabled")
	SyncBool("BallExpanderEnabled", "BallExpanderEnabled")
	SyncBool("BallExpanderShowHitbox", "BallExpanderShowHitbox")
	SyncBool("PullVectorEnabled", "PullVectorEnabled")
	SyncBool("AutoCatchEnabled", "AutoCatchEnabled")
	SyncBool("OneHandCatch", "OneHandCatch")
	SyncBool("AutotuckEnabled", "AutotuckEnabled")
	SyncBool("StickyCatchEnabled", "StickyCatchEnabled")
	SyncBool("DiveBoostEnabled", "DiveBoostEnabled")
	SyncBool("AutoDiveEnabled", "AutoDiveEnabled")
	SyncBool("BlockExtenderEnabled", "BlockExtenderEnabled")
	SyncBool("BlockExtenderShow", "BlockExtenderShow")
	SyncBool("RouteMarkersEnabled", "RouteMarkersEnabled")
	SyncBool("AutoHikeEnabled", "AutoHikeEnabled")
	SyncBool("WalkSpeedEnabled", "WalkSpeedEnabled")
	SyncBool("JumpPowerEnabled", "JumpPowerEnabled")
	SyncBool("AntiJamEnabled", "AntiJamEnabled")
	SyncBool("AntiDownedEnabled", "AntiDownedEnabled")
	SyncBool("NoPlatformStand", "NoPlatformStand")
	SyncBool("ThrowPowerLock", "ThrowPowerLock")
	SyncBool("BallEspEnabled", "BallEspEnabled")
	SyncBool("CarrierEspEnabled", "CarrierEspEnabled")
	SyncBool("TeammateEspEnabled", "TeammateEspEnabled")
	SyncBool("CatchMagnetHitbox", "CatchMagnetHitbox")

	SyncNumber("CatchMagnetRange", "CatchMagnetRange")
	SyncNumber("BallExpanderScale", "BallExpanderScale")
	SyncNumber("PullVectorRange", "PullVectorRange")
	SyncNumber("PullVectorStrength", "PullVectorStrength")
	SyncNumber("AutoCatchRange", "AutoCatchRange")
	SyncNumber("AutoCatchHold", "AutoCatchHold")
	SyncNumber("StickyCatchTime", "StickyCatchTime")
	SyncNumber("DivePower", "DivePower")
	SyncNumber("AutoDiveRange", "AutoDiveRange")
	SyncNumber("BlockExtenderReach", "BlockExtenderReach")
	SyncNumber("WalkSpeed", "WalkSpeed")
	SyncNumber("JumpPower", "JumpPower")
	SyncNumber("ThrowPowerValue", "ThrowPowerValue")

	getgenv().EchoConfig = Config
end

local function RunDiveBoost()
	local State = ControlsState
	if not State then
		RefreshControlsState()
		State = ControlsState
	end
	if not State then
		return
	end

	if Config.DiveBoostEnabled then
		if not DiveBoostLatched then
			local Current = tonumber(State.DivingPower)
			if Current and Current <= 3.2 then
				StockDivingPower = Current
			else
				StockDivingPower = 2.9
			end
			DiveBoostLatched = true
		end
		State.DivingPower = math.clamp(tonumber(Config.DivePower) or 4.2, 2.5, 8)
	elseif DiveBoostLatched or (tonumber(State.DivingPower) or 0) > 3.2 then
		State.DivingPower = StockDivingPower or 2.9
		DiveBoostLatched = false
	end
end

local function GetBallCarrierRoot()
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer then
			local Character = Player.Character
			local Football = Character and Character:FindFirstChild("Football")
			local Root = Character and Character:FindFirstChild("HumanoidRootPart")
			if Football and Root then
				return Root, Player
			end
		end
	end
	return nil, nil
end

local function RunAutoDive()
	if not Config.AutoDiveEnabled then
		return
	end
	if os.clock() - LastAutoDiveClock < 2.1 then
		return
	end

	local Character = GetCharacter()
	local Root = GetRoot(Character)
	local Humanoid = GetHumanoid(Character)
	if not Character or not Root or not Humanoid then
		return
	end
	if HoldingFootball(Character) then
		return
	end
	if Humanoid.Health <= 0 or Humanoid.PlatformStand then
		return
	end
	if Humanoid.MoveDirection.Magnitude < 0.05 then
		return
	end
	if Character:GetAttribute("Downed") == true then
		return
	end

	local Range = math.clamp(tonumber(Config.AutoDiveRange) or 18, 5, 35)
	local Ball, BallDistance = GetClosestLooseBall(Root.Position, Range + 5)
	local CarrierRoot = GetBallCarrierRoot()
	local CarrierDistance = CarrierRoot and (CarrierRoot.Position - Root.Position).Magnitude or math.huge

	local TargetDistance = math.min(BallDistance or math.huge, CarrierDistance)
	if TargetDistance > Range then
		return
	end

	-- CanDiveCondition requires Sneaked; force it for assist dives
	pcall(function()
		if GameData then
			GameData:SetAttribute("Sneaked", true)
		end
	end)

	local State = EnsureControls()
	if not State or type(State.RequestDive) ~= "function" then
		return
	end
	if State.CanDive == false then
		return
	end

	LastAutoDiveClock = os.clock()
	task.spawn(function()
		pcall(State.RequestDive)
	end)
end

local function ClearBlockExtender()
	if BlockExtenderPart then
		pcall(function()
			BlockExtenderPart:Destroy()
		end)
		BlockExtenderPart = nil
	end
	for Arm, Size in pairs(ArmOriginalSizes) do
		if Arm and Arm.Parent then
			pcall(function()
				Arm.Size = Size
			end)
		end
		ArmOriginalSizes[Arm] = nil
	end
end

local function RunBlockExtender()
	if not Config.BlockExtenderEnabled then
		ClearBlockExtender()
		return
	end

	local Character = GetCharacter()
	local Root = GetRoot(Character)
	if not Character or not Root or HoldingFootball(Character) then
		ClearBlockExtender()
		return
	end

	local Reach = math.clamp(tonumber(Config.BlockExtenderReach) or 12, 4, 28)

	if not BlockExtenderPart or not BlockExtenderPart.Parent then
		BlockExtenderPart = Instance.new("Part")
		BlockExtenderPart.Name = "EchoBlockExtender"
		BlockExtenderPart.Shape = Enum.PartType.Ball
		BlockExtenderPart.Material = Enum.Material.ForceField
		BlockExtenderPart.Color = Color3.fromRGB(180, 207, 229)
		BlockExtenderPart.Anchored = false
		BlockExtenderPart.CanCollide = false
		BlockExtenderPart.CanTouch = false
		BlockExtenderPart.CanQuery = false
		BlockExtenderPart.Massless = true
		BlockExtenderPart.CastShadow = false
		BlockExtenderPart.CFrame = Root.CFrame
		BlockExtenderPart.Parent = Character

		local Weld = Instance.new("WeldConstraint")
		Weld.Part0 = Root
		Weld.Part1 = BlockExtenderPart
		Weld.Parent = BlockExtenderPart
	end

	BlockExtenderPart.Size = Vector3.new(Reach, Reach, Reach)
	BlockExtenderPart.Transparency = Config.BlockExtenderShow and 0.72 or 1

	-- stretch arms slightly for bigger client contact
	for _, Name in ipairs({ "Left Arm", "Right Arm" }) do
		local Arm = Character:FindFirstChild(Name)
		if Arm and Arm:IsA("BasePart") then
			if not ArmOriginalSizes[Arm] then
				ArmOriginalSizes[Arm] = Arm.Size
			end
			local Original = ArmOriginalSizes[Arm]
			pcall(function()
				Arm.Size = Vector3.new(Original.X * 1.35, Original.Y, Original.Z * 1.35)
				Arm.CanTouch = true
			end)
		end
	end

	local NearThreat = false
	local HalfReach = Reach * 0.55
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer then
			local Other = Player.Character
			local OtherRoot = Other and Other:FindFirstChild("HumanoidRootPart")
			if OtherRoot and (OtherRoot.Position - Root.Position).Magnitude <= HalfReach then
				local SameTeam = LocalPlayer.Team and Player.Team and LocalPlayer.Team == Player.Team
				if not SameTeam then
					NearThreat = true
					if typeof(firetouchinterest) == "function" and os.clock() - BlockExtenderTouchClock >= 0.15 then
						local MyPart = Character:FindFirstChild("Torso") or Root
						local TheirPart = Other:FindFirstChild("Torso") or OtherRoot
						BlockExtenderTouchClock = os.clock()
						pcall(function()
							firetouchinterest(MyPart, TheirPart, 0)
							firetouchinterest(TheirPart, MyPart, 0)
							task.delay(0.08, function()
								pcall(firetouchinterest, MyPart, TheirPart, 1)
								pcall(firetouchinterest, TheirPart, MyPart, 1)
							end)
						end)
					end
				end
			end
		end
	end

	if NearThreat then
		pcall(function()
			Character:SetAttribute("Blocking", true)
		end)
	end
end

local function ClearRouteMarkers()
	for Key, Highlight in pairs(RouteHighlights) do
		pcall(function()
			Highlight:Destroy()
		end)
		RouteHighlights[Key] = nil
	end
end

local function RunRouteMarkers()
	if not Config.RouteMarkersEnabled then
		ClearRouteMarkers()
		return
	end

	local Character = GetCharacter()
	local Holding = HoldingFootball(Character)
	local LivePlay = GameData and GameData:GetAttribute("LivePlay") == true
	-- show while you have the ball (QB/routes) or during live play if you just hiked
	if not Holding and not LivePlay then
		ClearRouteMarkers()
		return
	end
	if not Holding and Character and Character:GetAttribute("UnderCenter") ~= true then
		-- still allow during live play after hike if you were thrower recently — keep simple: only while holding
		ClearRouteMarkers()
		return
	end

	local Keep = {}
	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer and LocalPlayer.Team and Player.Team == LocalPlayer.Team then
			local TheirCharacter = Player.Character
			local Humanoid = TheirCharacter and TheirCharacter:FindFirstChildOfClass("Humanoid")
			if TheirCharacter and Humanoid and Humanoid.Health > 0 and not TheirCharacter:FindFirstChild("Football") then
				local Key = Player.UserId
				Keep[Key] = true
				local Highlight = RouteHighlights[Key]
				if not Highlight or not Highlight.Parent then
					Highlight = Instance.new("Highlight")
					Highlight.Name = "EchoRouteMarker"
					Highlight.FillTransparency = 1
					Highlight.OutlineTransparency = 0
					Highlight.OutlineColor = Player.TeamColor and Player.TeamColor.Color or Color3.fromRGB(140, 210, 255)
					Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					Highlight.Parent = TheirCharacter
					RouteHighlights[Key] = Highlight
				else
					Highlight.Adornee = TheirCharacter
					Highlight.Parent = TheirCharacter
				end
			end
		end
	end

	for Key, Highlight in pairs(RouteHighlights) do
		if not Keep[Key] then
			pcall(function()
				Highlight:Destroy()
			end)
			RouteHighlights[Key] = nil
		end
	end
end

local function RunOneHandPrefer()
	local State = ControlsState
	if not State then
		return
	end

	if Config.OneHandCatch then
		if not OneHandLatched then
			StockCatchType = State.CatchType or "Regular"
			OneHandLatched = true
		end
		State.CatchType = "OneHand"
	elseif OneHandLatched then
		State.CatchType = StockCatchType or "Regular"
		OneHandLatched = false
	end
end

local function RunMovement()
	local Humanoid = GetHumanoid()
	if not Humanoid then
		return
	end

	if Config.WalkSpeedEnabled then
		Humanoid.WalkSpeed = math.clamp(tonumber(Config.WalkSpeed) or 24, 12, 45)
	end

	if Config.JumpPowerEnabled then
		if not JumpLatched then
			StockJumpPower = Humanoid.JumpPower
			JumpLatched = true
		end
		pcall(function()
			Humanoid.UseJumpPower = true
			Humanoid.JumpPower = math.clamp(tonumber(Config.JumpPower) or 70, 40, 110)
		end)
	elseif JumpLatched then
		if StockJumpPower then
			pcall(function()
				Humanoid.JumpPower = StockJumpPower
			end)
		end
		JumpLatched = false
	end
end

local function RunProtection()
	local Character = GetCharacter()
	if not Character then
		return
	end
	if Config.AntiJamEnabled and Character:GetAttribute("Jammed") == true then
		pcall(function()
			Character:SetAttribute("Jammed", false)
		end)
	end
	if Config.AntiDownedEnabled and Character:GetAttribute("Downed") == true then
		pcall(function()
			Character:SetAttribute("Downed", false)
			local Humanoid = GetHumanoid(Character)
			if Humanoid then
				Humanoid.PlatformStand = false
				Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
			end
		end)
	end
	if Config.NoPlatformStand then
		local Humanoid = GetHumanoid(Character)
		if Humanoid and Humanoid.PlatformStand and Character:GetAttribute("Downed") ~= true then
			-- allow intentional dives briefly; only clear when not diving recently
			if Character:GetAttribute("Tucking") ~= true then
				Humanoid.PlatformStand = false
			end
		end
	end
end

local function UpdateThrowPowerUi()
	if not Config.ThrowPowerLock then
		return
	end
	local Gui = LocalPlayer:FindFirstChild("PlayerGui")
	local ThrowUi = Gui and Gui:FindFirstChild("ThrowPowerUI")
	local Container = ThrowUi and ThrowUi:FindFirstChild("Container")
	local PowerLabel = Container and Container:FindFirstChild("Power")
	local FillBar = Container and Container:FindFirstChild("FillBar")
	if not PowerLabel then
		return
	end
	local Power = math.clamp(tonumber(Config.ThrowPowerValue) or 85, 30, 100)
	-- game stores internal u3 as power-35 (-5..65)
	local Internal = Power - 35
	local Alpha = math.clamp((Internal - -5) / 70, 0, 1)
	PowerLabel.Text = tostring(Power)
	if FillBar then
		FillBar.Size = UDim2.new(Alpha, 0, 1, 0)
	end
end

local function UpsertEsp(Key, Adornee, Text, Color)
	local Billboard = EspBillboards[Key]
	if not Billboard or not Billboard.Parent then
		Billboard = Instance.new("BillboardGui")
		Billboard.Name = "EchoEsp_" .. Key
		Billboard.Size = UDim2.fromOffset(130, 22)
		Billboard.AlwaysOnTop = true
		Billboard.StudsOffset = Vector3.new(0, 3, 0)
		local Label = Instance.new("TextLabel")
		Label.Name = "Label"
		Label.BackgroundTransparency = 1
		Label.Size = UDim2.fromScale(1, 1)
		Label.Font = Enum.Font.GothamMedium
		Label.TextSize = 13
		Label.TextStrokeTransparency = 0.4
		Label.Parent = Billboard
		Billboard.Parent = EchoUiContainer
		EspBillboards[Key] = Billboard
	end
	Billboard.Adornee = Adornee
	Billboard.Enabled = Adornee ~= nil
	local Label = Billboard:FindFirstChild("Label")
	if Label then
		Label.Text = Text
		Label.TextColor3 = Color or Color3.fromRGB(220, 230, 240)
	end
end

local function UpdateEsp()
	local Keep = {}

	if Config.BallEspEnabled then
		for Index, Ball in ipairs(GetLooseBalls()) do
			local Key = "ball_" .. Index
			Keep[Key] = true
			UpsertEsp(Key, Ball, "Ball", Color3.fromRGB(255, 196, 92))
		end
	end

	for _, Player in ipairs(Players:GetPlayers()) do
		if Player ~= LocalPlayer then
			local Character = Player.Character
			local Root = Character and Character:FindFirstChild("HumanoidRootPart")
			if Root then
				if Config.CarrierEspEnabled and Character:FindFirstChild("Football") then
					local Key = "carrier_" .. Player.UserId
					Keep[Key] = true
					UpsertEsp(Key, Root, Player.Name .. " | Ball", Color3.fromRGB(255, 120, 120))
				elseif Config.TeammateEspEnabled and LocalPlayer.Team and Player.Team == LocalPlayer.Team then
					local Key = "tm_" .. Player.UserId
					Keep[Key] = true
					UpsertEsp(Key, Root, Player.Name, Color3.fromRGB(140, 210, 255))
				end
			end
		end
	end

	for Key, Billboard in pairs(EspBillboards) do
		if not Keep[Key] then
			pcall(function()
				Billboard:Destroy()
			end)
			EspBillboards[Key] = nil
		end
	end
end

Track(LocalPlayer.CharacterAdded:Connect(function()
	ControlsState = nil
	AutotuckLatched = false
	CatchRequestLatched = false
	task.delay(1, RefreshControlsState)
end))

task.defer(RefreshControlsState)

local EspClock = 0
Track(RunService.Heartbeat:Connect(function()
	if getgenv().EchoOT7LoopToken ~= LoopToken then
		return
	end

	pcall(SyncConfigFromFlags)

	local Holding = HoldingFootball()
	if Holding and not HadFootball then
		ApplyStickyCatch()
	end
	HadFootball = Holding

	pcall(RunAutoCatch)
	pcall(RunCatchMagnet)
	pcall(RunBallExpander)
	pcall(RunPullVector)
	pcall(MaintainCatchWindow)
	pcall(RunAutotuck)
	pcall(RunAutoHike)
	pcall(RunDiveBoost)
	pcall(RunAutoDive)
	pcall(RunBlockExtender)
	pcall(RunRouteMarkers)
	pcall(RunOneHandPrefer)
	pcall(RunMovement)
	pcall(RunProtection)

	-- ESP / UI visuals at ~10Hz instead of every render frame
	local Now = os.clock()
	if Now - EspClock >= 0.1 then
		EspClock = Now
		pcall(UpdateEsp)
		pcall(UpdateThrowPowerUi)
	end
end))

Track(RunService.RenderStepped:Connect(function()
	if getgenv().EchoOT7LoopToken ~= LoopToken then
		return
	end
	pcall(UpdateMagnetHitbox)
end))

getgenv().EchoCleanup = function()
	getgenv().EchoOT7LoopToken = {}

	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)

	CatchRequestToken += 1
	StickyToken += 1
	CatchWindowOpen = false
	ClearExpanderVisuals()
	ClearBlockExtender()
	ClearRouteMarkers()

	pcall(function()
		if HitboxEvent then
			HitboxEvent:FireServer({ "UnRequest Catching" })
		end
	end)

	if MagnetHitboxPart then
		pcall(function()
			MagnetHitboxPart:Destroy()
		end)
		MagnetHitboxPart = nil
	end

	for Key, Billboard in pairs(EspBillboards) do
		pcall(function()
			Billboard:Destroy()
		end)
		EspBillboards[Key] = nil
	end

	pcall(function()
		if HitboxEvent then
			HitboxEvent:FireServer({ "UnRequest Catching" })
		end
	end)

	for _, Root in ipairs(EchoUiRoots) do
		pcall(function()
			Root:Destroy()
		end)
	end

	pcall(function()
		if Library and Library.Unload then
			Library:Unload()
		end
	end)
end

print(string.format("[Echo] OT7 loaded in %.2fs (no namecall)", os.clock() - LoadTick))
]====], "Echo_OT7")
	if not EchoChunk then
		error("[Echo] OT7 compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsRivals() then
-- Echo Hub: RIVALS
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")

-- // Place gate (hub also routes; keep local safety)
do
	local PlaceIdStr = tostring(game.PlaceId)
	local GameIdStr = tostring(game.GameId)
	local Allowed = {
		["17625359962"] = true,
		["17625359963"] = true,
	}
	if not Allowed[PlaceIdStr] and GameIdStr ~= "6035872082" then
		warn("[Echo] RIVALS module loaded on unsupported place PlaceId=" .. PlaceIdStr)
		return
	end
end

-- // Variables
local LoadTick = os.clock()
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

if getgenv().EchoCleanup then
	pcall(getgenv().EchoCleanup)
end

-- Restore prior Echo hooks before stacking (deferred — sync hookmetamethod freezes Potassium)
task.defer(function()
	task.wait(0.35)
	pcall(function()
		if typeof(getgenv().EchoBaseNamecall) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__namecall", getgenv().EchoBaseNamecall)
		end
		if typeof(getgenv().EchoBaseIndex) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__index", getgenv().EchoBaseIndex)
		end
		getgenv().EchoBaseNamecall = nil
		getgenv().EchoBaseIndex = nil
		getgenv().EchoSilentHooked = nil
	end)
end)

local EchoUiContainer = Instance.new("Folder")
EchoUiContainer.Name = "EchoContainer"
pcall(function()
	EchoUiContainer.Parent = CoreGui
end)
if not EchoUiContainer.Parent then
	EchoUiContainer.Parent = LocalPlayer:WaitForChild("PlayerGui", 10)
end

getgenv().gethui = function()
	return EchoUiContainer
end

-- Yield once so the executor can breathe before HttpGet + UI build
task.wait()

local LibraryOk, LibraryOrErr = pcall(function()
	if getgenv().__EchoScootUI then
		return getgenv().__EchoScootUI
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/saintsrevival1/eee/refs/heads/main/UI-Source.lua"))()
	getgenv().__EchoScootUI = Lib
	return Lib
end)

if not LibraryOk then
	warn("[Echo] Library failed to load: " .. tostring(LibraryOrErr))
	return
end

local Library = LibraryOrErr
getgenv().Library = Library

pcall(function()
	Library.Round = function(_, Number, Float)
		if typeof(Number) ~= "number" or Number ~= Number then
			return 0
		end
		if typeof(Float) ~= "number" or Float ~= Float or Float == 0 then
			Float = 1
		end
		local Multiplier = 1 / Float
		return math.floor(Number * Multiplier + 1e-9) / Multiplier
	end
end)

pcall(function()
	if Library.Holder and Library.Holder.Instance then
		Library.Holder.Instance.Parent = EchoUiContainer
	end
	if Library.UnusedHolder and Library.UnusedHolder.Instance then
		Library.UnusedHolder.Instance.Parent = EchoUiContainer
	end
end)

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsGamepadPreferred = UserInputService.GamepadEnabled and not UserInputService.KeyboardEnabled

local Config = {
	Aimbot = false,
	AimbotSmooth = false,
	AimbotSmoothness = 12,
	AimbotFov = 280,
	AimbotDrawFov = false,
	AimbotZone = false,
	AimbotZoneDist = 400,
	AimbotPrediction = false,
	AimbotPersistent = false,
	AimbotWalls = false,
	TeamCheck = true,
	AimLockKey = IsMobile and "ButtonL2" or "Q",
	AimToggleKey = IsMobile and "ButtonR1" or "V",

	Silent = false,
	SilentFov = 180,
	SilentShowFov = false,
	SilentHitPart = "Head",
	SilentSticky = true,
	SilentMaxDistance = 600,
	SilentWalls = false,
	SilentToggleKey = IsMobile and "ButtonL1" or "C",

	AutoShoot = false,
	AutoShootKey = IsMobile and "ButtonR2" or "Y",

	SixthSense = false,

	Chams = false,
	ChamsColor = Color3.fromRGB(80, 180, 255),
	GlowChams = false,
	GlowIntensity = 50,
	HealthBars = false,
	EspBoxes = false,
	EspBoxColor = Color3.fromRGB(80, 180, 255),
	HideSmoke = false,
	HideFlash = false,
	EnemyWeapons = false,

	Noclip = false,
	NoclipKey = IsMobile and "ButtonX" or "N",
	Stick = false,
	StickKey = IsMobile and "ButtonY" or "I",
	StickSmooth = false,
	StickSmoothness = 20,
	StickBeneath = false,
	Fly = false,
	FlyKey = IsMobile and "ButtonB" or "F",
	FlySpeed = 40,

	DeviceSpoof = IsMobile and "Phone" or "PC",
	ModelsColor = false,
	ModelsColorValue = Color3.fromRGB(120, 200, 255),
	LightingBoost = false,
	LightingIntensity = 100,
	ShowFps = false,
	MobileButtons = IsMobile or IsGamepadPreferred,
}
getgenv().EchoConfig = Config

local State = {
	AimForce = false,
	AimLmb = false,
	Persistent = nil,
	AimHistory = {},
	TeammateCache = {},
	Chams = {},
	Glow = {},
	Boxes = {},
	Health = {},
	WeaponLabels = {},
	TripLabels = {},
	TripParts = {},
	ModelColors = {},
	SavedLighting = nil,
	FlyHeight = nil,
	FlyMove = { W = false, A = false, S = false, D = false, Up = false, Down = false },
	StickTarget = nil,
	NoclipOrig = {},
	FovCircle = nil,
	SilentFovCircle = nil,
	SilentTarget = nil,
	StickySilent = nil,
	SilentPart = nil,
	SilentHooked = false,
	OldIndex = nil,
	OldNamecall = nil,
	FpsGui = nil,
	WeaponGui = nil,
	MobileGui = nil,
	KatanaLabel = nil,
	LastDevice = nil,
	PrevPlatformStand = nil,
	EspClock = 0,
	WeaponClock = 0,
	SenseClock = 0,
	VisualFrame = 0,
}

local Connections = {}
local EchoUiRoots = { EchoUiContainer }
local KeyItems = {
	"Q", "E", "R", "T", "Y", "U", "I", "O", "P", "F", "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M",
	"Insert", "LeftAlt", "LeftControl",
	"ButtonA", "ButtonB", "ButtonX", "ButtonY", "ButtonL1", "ButtonR1", "ButtonL2", "ButtonR2", "ButtonL3", "ButtonR3",
}
local HitParts = { "Head", "HumanoidRootPart", "UpperTorso", "LowerTorso" }

local Window = Library:Window({
	Logo = "72316209028225",
	FadeTime = 0.3,
})

local Watermark = Library:Watermark("Echo | RIVALS")
local KeybindList = Library:KeybindList()

local CombatPage = Window:Page({ Name = "Combat", Columns = 2 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 2 })
local RagePage = Window:Page({ Name = "Rage", Columns = 2 })
local MiscPage = Window:Page({ Name = "Misc", Columns = 2 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local AimSection = CombatPage:Section({ Name = "Aimbot", Side = 1 })
local AimTuneSection = CombatPage:Section({ Name = "Aimbot Tuning", Side = 1 })
local SilentSection = CombatPage:Section({ Name = "Silent Aim", Side = 2 })
local ShootSection = CombatPage:Section({ Name = "Auto Shoot", Side = 2 })
local SenseSection = CombatPage:Section({ Name = "Awareness", Side = 2 })

local PlayerVisSection = VisualsPage:Section({ Name = "Player Visuals", Side = 1 })
local WorldVisSection = VisualsPage:Section({ Name = "World Visuals", Side = 2 })

local MoveSection = RagePage:Section({ Name = "Movement", Side = 1 })
local StickSection = RagePage:Section({ Name = "Stick", Side = 2 })

local SpoofSection = MiscPage:Section({ Name = "Spoof / Lighting", Side = 1 })
local ExtraSection = MiscPage:Section({ Name = "Extras", Side = 2 })

local function Track(Signal, Callback)
	local Conn = Signal:Connect(Callback)
	Connections[#Connections + 1] = Conn
	return Conn
end

local function IsAlive(Model)
	if not Model then
		return false
	end
	local Hum = Model:FindFirstChildOfClass("Humanoid")
	return Hum ~= nil and Hum.Health > 0
end

local function IsTeammate(Pl)
	if not Pl or Pl == LocalPlayer then
		return false
	end
	if not Config.TeamCheck then
		return false
	end
	local Cached = State.TeammateCache[Pl]
	if Cached ~= nil then
		return Cached
	end
	local Ok, Res = pcall(function()
		local LocalTeam = LocalPlayer:GetAttribute("TeamID")
		local TheirTeam = Pl:GetAttribute("TeamID")
		if LocalTeam ~= nil and TheirTeam ~= nil then
			return tostring(LocalTeam) == tostring(TheirTeam)
		end
		if LocalPlayer.Team and Pl.Team then
			return LocalPlayer.Team == Pl.Team
		end
		local Char = Pl.Character
		local Hrp = Char and (Char:FindFirstChild("HumanoidRootPart") or Char.PrimaryPart)
		if Hrp and Hrp:FindFirstChild("TeammateLabel", true) then
			return true
		end
		if Char and Char:FindFirstChild("TeammateLabel", true) then
			return true
		end
		return false
	end)
	State.TeammateCache[Pl] = Ok and Res or false
	return State.TeammateCache[Pl]
end

local function IsEnemy(Pl)
	return Pl and Pl ~= LocalPlayer and not IsTeammate(Pl)
end

local function KeyMatches(Name, Input)
	if not Name or not Input then
		return false
	end
	local Code = Enum.KeyCode[Name]
	if not Code then
		return false
	end
	if Input.UserInputType == Enum.UserInputType.Keyboard or Input.UserInputType == Enum.UserInputType.Gamepad1
		or Input.UserInputType == Enum.UserInputType.Gamepad2 or Input.UserInputType == Enum.UserInputType.Gamepad3
		or Input.UserInputType == Enum.UserInputType.Gamepad4
	then
		return Input.KeyCode == Code
	end
	return false
end

local function GetHitPart(Character, PartName)
	if not Character then
		return nil
	end
	local Part = Character:FindFirstChild(PartName or "Head")
	if Part and Part:IsA("BasePart") then
		return Part
	end
	return Character:FindFirstChild("Head") or Character:FindFirstChild("HumanoidRootPart") or Character.PrimaryPart
end

local function ScreenDistTo(Part, FovRadius)
	local Cam = Workspace.CurrentCamera
	if not Cam or not Part then
		return nil
	end
	local Sp = Cam:WorldToViewportPoint(Part.Position)
	if Sp.Z <= 0 then
		return nil
	end
	local Vs = Cam.ViewportSize
	local Dx = Sp.X - Vs.X * 0.5
	local Dy = Sp.Y - Vs.Y * 0.5
	local Dist = math.sqrt(Dx * Dx + Dy * Dy)
	if Dist > (FovRadius or 1e9) then
		return nil
	end
	return Dist, Sp
end

local function IsVisiblePart(Part, Character)
	local Cam = Workspace.CurrentCamera
	if not Cam or not Part then
		return false
	end
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = { LocalPlayer.Character, Character, Cam }
	Params.IgnoreWater = true
	local Hit = Workspace:Raycast(Cam.CFrame.Position, Part.Position - Cam.CFrame.Position, Params)
	return Hit == nil
end

local function FindClosestEnemy(FovRadius, MaxDist, HitPartName, AllowWalls)
	local Cam = Workspace.CurrentCamera
	if not Cam then
		return nil, nil
	end
	local BestPl, BestPart, BestDist = nil, nil, math.huge
	for _, Pl in ipairs(Players:GetPlayers()) do
		if IsEnemy(Pl) and Pl.Character and IsAlive(Pl.Character) then
			local Part = GetHitPart(Pl.Character, HitPartName)
			if Part then
				local WorldDist = (Part.Position - Cam.CFrame.Position).Magnitude
				if WorldDist <= (MaxDist or 1e9) then
					local Dist = ScreenDistTo(Part, FovRadius)
					if Dist and Dist < BestDist then
						if AllowWalls or IsVisiblePart(Part, Pl.Character) then
							BestDist = Dist
							BestPl = Pl
							BestPart = Part
						end
					end
				end
			end
		end
	end
	return BestPl, BestPart
end

local function ResolveSilentTarget()
	if Config.SilentSticky and State.StickySilent and IsEnemy(State.StickySilent) and State.StickySilent.Character and IsAlive(State.StickySilent.Character) then
		local Part = GetHitPart(State.StickySilent.Character, Config.SilentHitPart)
		if Part and ScreenDistTo(Part, Config.SilentFov) then
			if Config.SilentWalls or IsVisiblePart(Part, State.StickySilent.Character) then
				State.SilentTarget = State.StickySilent
				State.SilentPart = Part
				return State.SilentTarget, Part
			end
		end
	end
	local Pl, Part = FindClosestEnemy(Config.SilentFov, Config.SilentMaxDistance, Config.SilentHitPart, Config.SilentWalls)
	State.SilentTarget = Pl
	State.SilentPart = Part
	if Config.SilentSticky then
		State.StickySilent = Pl
	end
	return Pl, Part
end

local function SyncSilentHooks()
	local function Uninstall()
		pcall(function()
			if typeof(State.OldIndex) == "function" and typeof(hookmetamethod) == "function" then
				hookmetamethod(game, "__index", State.OldIndex)
			end
			if typeof(State.OldNamecall) == "function" and typeof(hookmetamethod) == "function" then
				hookmetamethod(game, "__namecall", State.OldNamecall)
			end
		end)
		State.OldIndex = nil
		State.OldNamecall = nil
		State.SilentHooked = false
		getgenv().EchoBaseIndex = nil
		getgenv().EchoBaseNamecall = nil
		getgenv().EchoSilentHooked = nil
	end

	if not Config.Silent then
		Uninstall()
		if State.SilentFovCircle then
			pcall(function()
				State.SilentFovCircle:Remove()
			end)
			State.SilentFovCircle = nil
		end
		return
	end

	if State.SilentHooked then
		return
	end
	if typeof(hookmetamethod) ~= "function" then
		warn("[Echo] Silent aim unavailable (no hookmetamethod)")
		return
	end

	task.defer(function()
		task.wait(1.25)
		if not Config.Silent or State.SilentHooked then
			return
		end
		pcall(Uninstall)

		local OkIndex, ErrIndex = pcall(function()
			-- Glory-style Mouse.Hit / Mouse.Target redirect (guns that read mouse aim)
			State.OldIndex = hookmetamethod(game, "__index", function(Self, Key)
				if checkcaller and checkcaller() then
					return State.OldIndex(Self, Key)
				end
				if not Config.Silent or Self ~= Mouse then
					return State.OldIndex(Self, Key)
				end
				if Key ~= "Hit" and Key ~= "Target" then
					return State.OldIndex(Self, Key)
				end
				local _, Part = ResolveSilentTarget()
				if not Part then
					return State.OldIndex(Self, Key)
				end
				if Key == "Hit" then
					return CFrame.new(Part.Position)
				end
				return Part
			end)
		end)

		local OkName, ErrName = pcall(function()
			if typeof(getnamecallmethod) ~= "function" then
				return
			end
			-- Street-style ray redirect for client gun traces (filter starts with local character)
			State.OldNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
				if checkcaller and checkcaller() then
					return State.OldNamecall(Self, ...)
				end
				local Method = getnamecallmethod()
				if Config.Silent and Method == "Raycast" and Self == Workspace then
					local Ok, Origin, Direction, Params = pcall(function(...)
						local O, D, P = ...
						local Char = LocalPlayer.Character
						local TargetPart = State.SilentPart
						if
							not Char
							or not TargetPart
							or not TargetPart.Parent
							or typeof(O) ~= "Vector3"
							or typeof(D) ~= "Vector3"
							or typeof(P) ~= "RaycastParams"
						then
							return O, D, P
						end
						local Filter = P.FilterDescendantsInstances
						if type(Filter) ~= "table" or Filter[1] ~= Char then
							return O, D, P
						end
						D = TargetPart.Position - O
						if Config.SilentWalls then
							local NewParams = RaycastParams.new()
							NewParams.FilterType = Enum.RaycastFilterType.Include
							NewParams.FilterDescendantsInstances = { TargetPart }
							P = NewParams
						end
						return O, D, P
					end, ...)
					if Ok then
						return State.OldNamecall(Self, Origin, Direction, Params)
					end
				end
				return State.OldNamecall(Self, ...)
			end)
		end)

		if OkIndex and typeof(State.OldIndex) == "function" then
			getgenv().EchoBaseIndex = State.OldIndex
			State.SilentHooked = true
			getgenv().EchoSilentHooked = true
		else
			warn("[Echo] Silent index hook failed:", ErrIndex)
		end
		if OkName and typeof(State.OldNamecall) == "function" then
			getgenv().EchoBaseNamecall = State.OldNamecall
		elseif not OkName then
			warn("[Echo] Silent namecall hook skipped:", ErrName)
		end
	end)
end

local function GetHeldWeapon(PlayerOrNil)
	local ViewModels = Workspace:FindFirstChild("ViewModels")
	if not ViewModels then
		return nil, nil
	end
	if PlayerOrNil == nil or PlayerOrNil == LocalPlayer then
		local Fp = ViewModels:FindFirstChild("FirstPerson")
		if not Fp then
			return nil, nil
		end
		for _, Child in ipairs(Fp:GetChildren()) do
			if Child:IsA("Model") then
				local Parts = string.split(Child.Name, " - ")
				local Raw = Parts[3] or Parts[2] or Child.Name
				return Raw, Child
			end
		end
		return nil, nil
	end
	local TargetName = typeof(PlayerOrNil) == "Instance" and PlayerOrNil.Name or tostring(PlayerOrNil)
	for _, Vm in ipairs(ViewModels:GetChildren()) do
		if Vm:IsA("Model") then
			local Parts = string.split(Vm.Name, " - ")
			if Parts[1] == TargetName then
				local Raw = Parts[3] or Parts[2] or Vm.Name
				return Raw, Vm
			end
		end
	end
	return nil, nil
end

local function WeaponHas(Name, Needle)
	return type(Name) == "string" and string.find(string.lower(Name), Needle, 1, true) ~= nil
end

-- // FOV circle
local function RefreshFovCircle()
	if Config.AimbotDrawFov then
		if not State.FovCircle and typeof(Drawing) == "table" and Drawing.new then
			local Ok, Circle = pcall(function()
				return Drawing.new("Circle")
			end)
			if Ok and Circle then
				Circle.Color = Color3.fromRGB(255, 255, 255)
				Circle.Thickness = 1
				Circle.Filled = false
				Circle.Visible = true
				State.FovCircle = Circle
			end
		end
	else
		if State.FovCircle then
			pcall(function()
				State.FovCircle:Remove()
			end)
			State.FovCircle = nil
		end
	end
end

local function RefreshSilentFov()
	if Config.Silent and Config.SilentShowFov then
		if not State.SilentFovCircle and typeof(Drawing) == "table" and Drawing.new then
			local Ok, Circle = pcall(function()
				return Drawing.new("Circle")
			end)
			if Ok and Circle then
				Circle.Color = Color3.fromRGB(120, 220, 255)
				Circle.Thickness = 1.5
				Circle.Filled = false
				Circle.Visible = true
				State.SilentFovCircle = Circle
			end
		end
	elseif State.SilentFovCircle then
		pcall(function()
			State.SilentFovCircle:Remove()
		end)
		State.SilentFovCircle = nil
	end
end

local function FindAimHead()
	local _, Part = FindClosestEnemy(
		Config.AimbotFov,
		Config.AimbotZone and Config.AimbotZoneDist or 2000,
		"Head",
		Config.AimbotWalls
	)
	return Part
end

local function AimAt(Head, Dt)
	local Cam = Workspace.CurrentCamera
	if not Cam or not Head then
		return
	end
	local Predicted = Head.Position
	if Config.AimbotPrediction then
		local Root = Head.Parent and (Head.Parent:FindFirstChild("HumanoidRootPart") or Head.Parent:FindFirstChild("Torso"))
		local Vel = Root and Root:IsA("BasePart") and Root.AssemblyLinearVelocity or Vector3.zero
		local Dist = (Head.Position - Cam.CFrame.Position).Magnitude
		local Tt = Dist / 900
		Predicted = Predicted + Vel * Tt
	end
	local Ok, Screen = pcall(function()
		return Cam:WorldToViewportPoint(Predicted)
	end)
	if not Ok or not Screen or Screen.Z <= 0 then
		return
	end
	local MousePos = UserInputService:GetMouseLocation()
	local Dx = Screen.X - MousePos.X
	local Dy = Screen.Y - MousePos.Y
	if Config.AimbotSmooth then
		local Sv = math.max(Config.AimbotSmoothness or 1, 1)
		Dx = Dx / Sv
		Dy = Dy / Sv
	end
	pcall(function()
		mousemoverel(Dx, Dy)
	end)
end

Track(RunService.RenderStepped, function(Dt)
	Camera = Workspace.CurrentCamera
	if State.FovCircle and Camera then
		local Vs = Camera.ViewportSize
		State.FovCircle.Position = Vector2.new(Vs.X * 0.5, Vs.Y * 0.5)
		State.FovCircle.Radius = Config.AimbotFov
		State.FovCircle.Visible = Config.AimbotDrawFov
	end
	if Config.Silent then
		pcall(ResolveSilentTarget)
		if State.SilentFovCircle and Camera then
			local Vs = Camera.ViewportSize
			State.SilentFovCircle.Position = Vector2.new(Vs.X * 0.5, Vs.Y * 0.5)
			State.SilentFovCircle.Radius = Config.SilentFov
			State.SilentFovCircle.Visible = Config.SilentShowFov
		end
	end

	local Active = Config.Aimbot and (State.AimLmb or State.AimForce)
	if not Active then
		return
	end

	local Head = FindAimHead()
	local Now = tick()
	if Head and Config.AimbotPersistent then
		State.Persistent = {
			Model = Head.Parent,
			Player = Players:GetPlayerFromCharacter(Head.Parent),
			LastPos = Head.Position,
			T = Now,
		}
	elseif not Head and Config.AimbotPersistent and State.Persistent and State.Persistent.Model and State.Persistent.Model.Parent then
		local Model = State.Persistent.Model
		if IsAlive(Model) then
			Head = Model:FindFirstChild("Head") or Model:FindFirstChild("HumanoidRootPart")
		else
			State.Persistent = nil
		end
	end
	if Head then
		AimAt(Head, Dt)
	end
end)

Track(UserInputService.InputBegan, function(Input, Gp)
	if Gp then
		return
	end
	if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
		State.AimLmb = true
	end
	if Input.UserInputType ~= Enum.UserInputType.Keyboard
		and Input.UserInputType ~= Enum.UserInputType.Gamepad1
		and Input.UserInputType ~= Enum.UserInputType.Gamepad2
		and Input.UserInputType ~= Enum.UserInputType.Gamepad3
		and Input.UserInputType ~= Enum.UserInputType.Gamepad4
	then
		return
	end
	if KeyMatches(Config.AimLockKey, Input) then
		State.AimForce = true
	end
	if KeyMatches(Config.AimToggleKey, Input) then
		Config.Aimbot = not Config.Aimbot
	end
	if KeyMatches(Config.SilentToggleKey, Input) then
		Config.Silent = not Config.Silent
		SyncSilentHooks()
		RefreshSilentFov()
	end
	if KeyMatches(Config.AutoShootKey, Input) then
		Config.AutoShoot = not Config.AutoShoot
	end
	if KeyMatches(Config.NoclipKey, Input) then
		Config.Noclip = not Config.Noclip
	end
	if KeyMatches(Config.StickKey, Input) then
		Config.Stick = not Config.Stick
		if not Config.Stick then
			State.StickTarget = nil
		end
	end
	if KeyMatches(Config.FlyKey, Input) then
		Config.Fly = not Config.Fly
		if not Config.Fly then
			State.FlyHeight = nil
			local Char = LocalPlayer.Character
			local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
			if Hum and State.PrevPlatformStand ~= nil then
				Hum.PlatformStand = State.PrevPlatformStand
			end
		end
	end
	local K = Input.KeyCode
	if K == Enum.KeyCode.W then
		State.FlyMove.W = true
	elseif K == Enum.KeyCode.A then
		State.FlyMove.A = true
	elseif K == Enum.KeyCode.S then
		State.FlyMove.S = true
	elseif K == Enum.KeyCode.D then
		State.FlyMove.D = true
	elseif K == Enum.KeyCode.Space then
		State.FlyMove.Up = true
	elseif K == Enum.KeyCode.LeftShift or K == Enum.KeyCode.RightShift then
		State.FlyMove.Down = true
	end
end)

Track(UserInputService.InputEnded, function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
		State.AimLmb = false
		if not State.AimForce then
			State.Persistent = nil
		end
	end
	if Input.UserInputType == Enum.UserInputType.Keyboard
		or Input.UserInputType == Enum.UserInputType.Gamepad1
		or Input.UserInputType == Enum.UserInputType.Gamepad2
		or Input.UserInputType == Enum.UserInputType.Gamepad3
		or Input.UserInputType == Enum.UserInputType.Gamepad4
	then
		if KeyMatches(Config.AimLockKey, Input) then
			State.AimForce = false
			if not State.AimLmb then
				State.Persistent = nil
			end
		end
		local K = Input.KeyCode
		if K == Enum.KeyCode.W then
			State.FlyMove.W = false
		elseif K == Enum.KeyCode.A then
			State.FlyMove.A = false
		elseif K == Enum.KeyCode.S then
			State.FlyMove.S = false
		elseif K == Enum.KeyCode.D then
			State.FlyMove.D = false
		elseif K == Enum.KeyCode.Space then
			State.FlyMove.Up = false
		elseif K == Enum.KeyCode.LeftShift or K == Enum.KeyCode.RightShift then
			State.FlyMove.Down = false
		end
	end
end)

-- // Auto shoot
do
	local Firing = false
	Track(RunService.Heartbeat, function()
		if not Config.AutoShoot then
			if Firing then
				pcall(mouse1release)
				Firing = false
				State.AimForce = false
			end
			return
		end
		local Head = FindAimHead()
		if not Head then
			if Firing then
				pcall(mouse1release)
				Firing = false
			end
			State.AimForce = false
			return
		end
		local Pl = Players:GetPlayerFromCharacter(Head.Parent)
		local Raw = GetHeldWeapon(Pl)
		local LocalRaw = GetHeldWeapon(nil)
		local Block = WeaponHas(Raw, "katana") or WeaponHas(Raw, "shield") or WeaponHas(LocalRaw, "shield")
		State.AimForce = true
		if Block and not WeaponHas(LocalRaw, "spray") then
			if Firing then
				pcall(mouse1release)
				Firing = false
			end
			return
		end
		if not Firing then
			Firing = true
			pcall(mouse1press)
		end
	end)
end

-- // Chams / glow
local function ClearChams()
	for Pl, Hl in pairs(State.Chams) do
		pcall(function()
			Hl:Destroy()
		end)
		State.Chams[Pl] = nil
	end
end

local function ClearGlow()
	for Pl, Data in pairs(State.Glow) do
		pcall(function()
			if Data.Hl then
				Data.Hl:Destroy()
			end
			if Data.Lights then
				for _, L in ipairs(Data.Lights) do
					L:Destroy()
				end
			end
		end)
		State.Glow[Pl] = nil
	end
end

local function ApplyChams(Pl)
	if not Pl or Pl == LocalPlayer or not Config.Chams then
		return
	end
	local Char = Pl.Character
	if not Char then
		return
	end
	if State.Chams[Pl] then
		pcall(function()
			State.Chams[Pl]:Destroy()
		end)
	end
	local Ok, Hl = pcall(function()
		local H = Instance.new("Highlight")
		H.Name = "Echo_RivalsChams"
		H.Adornee = Char
		H.FillColor = Config.ChamsColor
		H.OutlineColor = Color3.fromRGB(20, 20, 20)
		H.FillTransparency = 0.45
		H.Parent = EchoUiContainer
		return H
	end)
	if Ok then
		State.Chams[Pl] = Hl
	end
end

local function ApplyGlow(Pl)
	if not Pl or Pl == LocalPlayer or not Config.GlowChams then
		return
	end
	local Char = Pl.Character
	if not Char then
		return
	end
	if State.Glow[Pl] then
		pcall(function()
			local D = State.Glow[Pl]
			if D.Hl then
				D.Hl:Destroy()
			end
			if D.Lights then
				for _, L in ipairs(D.Lights) do
					L:Destroy()
				end
			end
		end)
	end
	local Intensity = Config.GlowIntensity or 50
	local Ok, Data = pcall(function()
		local H = Instance.new("Highlight")
		H.Name = "Echo_RivalsGlow"
		H.Adornee = Char
		H.FillColor = Config.ChamsColor
		H.OutlineColor = Config.ChamsColor
		H.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		local T = math.clamp(1 - Intensity / 100, 0, 1)
		H.FillTransparency = T * 0.6
		H.OutlineTransparency = T * 0.35
		H.Parent = EchoUiContainer
		local Lights = {}
		for _, Name in ipairs({ "Head", "HumanoidRootPart" }) do
			local Part = Char:FindFirstChild(Name)
			if Part and Part:IsA("BasePart") then
				local Plight = Instance.new("PointLight")
				Plight.Name = "Echo_GlowLight"
				Plight.Color = Config.ChamsColor
				Plight.Range = 6 + Intensity / 100 * 24
				Plight.Brightness = 1 + Intensity / 100 * 4
				Plight.Shadows = false
				Plight.Parent = Part
				Lights[#Lights + 1] = Plight
			end
		end
		return { Hl = H, Lights = Lights }
	end)
	if Ok then
		State.Glow[Pl] = Data
	end
end

local function RefreshAllVisualPlayers()
	for _, Pl in ipairs(Players:GetPlayers()) do
		if Pl ~= LocalPlayer then
			if Config.Chams then
				ApplyChams(Pl)
			end
			if Config.GlowChams then
				ApplyGlow(Pl)
			end
		end
	end
end

Track(Players.PlayerAdded, function(Pl)
	State.TeammateCache[Pl] = nil
	Track(Pl.CharacterAdded, function()
		task.defer(function()
			if Config.Chams then
				ApplyChams(Pl)
			end
			if Config.GlowChams then
				ApplyGlow(Pl)
			end
		end)
	end)
end)

Track(Players.PlayerRemoving, function(Pl)
	State.TeammateCache[Pl] = nil
	if State.Chams[Pl] then
		pcall(function()
			State.Chams[Pl]:Destroy()
		end)
		State.Chams[Pl] = nil
	end
	if State.Glow[Pl] then
		pcall(function()
			local D = State.Glow[Pl]
			if D.Hl then
				D.Hl:Destroy()
			end
			if D.Lights then
				for _, L in ipairs(D.Lights) do
					L:Destroy()
				end
			end
		end)
		State.Glow[Pl] = nil
	end
	if State.Boxes[Pl] then
		pcall(function()
			State.Boxes[Pl]:Remove()
		end)
		State.Boxes[Pl] = nil
	end
	if State.Health[Pl] then
		local H = State.Health[Pl]
		pcall(function()
			if H.Bg then
				H.Bg:Remove()
			end
			if H.Fill then
				H.Fill:Remove()
			end
			if H.Text then
				H.Text:Remove()
			end
		end)
		State.Health[Pl] = nil
	end
end)

for _, Pl in ipairs(Players:GetPlayers()) do
	if Pl ~= LocalPlayer then
		Track(Pl.CharacterAdded, function()
			task.defer(function()
				if Config.Chams then
					ApplyChams(Pl)
				end
				if Config.GlowChams then
					ApplyGlow(Pl)
				end
			end)
		end)
	end
end

-- // ESP boxes + health
local function EnsureBox(Pl)
	if State.Boxes[Pl] or typeof(Drawing) ~= "table" then
		return State.Boxes[Pl]
	end
	local Ok, Box = pcall(function()
		return Drawing.new("Square")
	end)
	if Ok and Box then
		Box.Filled = false
		Box.Thickness = 2
		Box.Color = Config.EspBoxColor
		Box.Visible = false
		State.Boxes[Pl] = Box
	end
	return State.Boxes[Pl]
end

local function EnsureHealth(Pl)
	if State.Health[Pl] or typeof(Drawing) ~= "table" then
		return State.Health[Pl]
	end
	local Ok, Bg = pcall(function()
		return Drawing.new("Square")
	end)
	local Ok2, Fill = pcall(function()
		return Drawing.new("Square")
	end)
	local Ok3, Text = pcall(function()
		return Drawing.new("Text")
	end)
	if Ok and Ok2 and Ok3 then
		Bg.Filled = true
		Bg.Color = Color3.fromRGB(30, 30, 30)
		Bg.Visible = false
		Fill.Filled = true
		Fill.Color = Color3.fromRGB(0, 200, 80)
		Fill.Visible = false
		Text.Center = true
		Text.Outline = true
		Text.Size = 14
		Text.Color = Color3.new(1, 1, 1)
		Text.Visible = false
		State.Health[Pl] = { Bg = Bg, Fill = Fill, Text = Text }
	end
	return State.Health[Pl]
end

Track(RunService.RenderStepped, function()
	State.VisualFrame = (State.VisualFrame or 0) + 1
	if State.VisualFrame % 2 ~= 0 then
		return
	end
	if not (Config.EspBoxes or Config.HealthBars) then
		return
	end
	local Cam = Workspace.CurrentCamera
	if not Cam then
		return
	end
	local CamPos = Cam.CFrame.Position
	for _, Pl in ipairs(Players:GetPlayers()) do
		if Pl == LocalPlayer then
			continue
		end
		local Char = Pl.Character
		local Root = Char and (Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart"))
		local Dist = Root and (Root.Position - CamPos).Magnitude or 1e9

		if Config.EspBoxes and Root and Dist <= 300 and IsAlive(Char) then
			local Box = EnsureBox(Pl)
			if Box then
				local Ok, Cf, Size = pcall(function()
					return Char:GetBoundingBox()
				end)
				if Ok and Cf and Size then
					local Hx, Hy, Hz = Size.X / 2, Size.Y / 2, Size.Z / 2
					local MinX, MinY, MaxX, MaxY = math.huge, math.huge, -math.huge, -math.huge
					local Any = false
					for _, Off in ipairs({
						Vector3.new(-Hx, -Hy, -Hz),
						Vector3.new(-Hx, -Hy, Hz),
						Vector3.new(-Hx, Hy, -Hz),
						Vector3.new(-Hx, Hy, Hz),
						Vector3.new(Hx, -Hy, -Hz),
						Vector3.new(Hx, -Hy, Hz),
						Vector3.new(Hx, Hy, -Hz),
						Vector3.new(Hx, Hy, Hz),
					}) do
						local Sp = Cam:WorldToViewportPoint((Cf * CFrame.new(Off)).Position)
						if Sp.Z > 0 then
							Any = true
							MinX = math.min(MinX, Sp.X)
							MaxX = math.max(MaxX, Sp.X)
							MinY = math.min(MinY, Sp.Y)
							MaxY = math.max(MaxY, Sp.Y)
						end
					end
					if Any then
						Box.Position = Vector2.new(MinX - 4, MinY - 4)
						Box.Size = Vector2.new(math.max(4, MaxX - MinX + 8), math.max(4, MaxY - MinY + 8))
						Box.Color = Config.EspBoxColor
						Box.Visible = true
					else
						Box.Visible = false
					end
				end
			end
		elseif State.Boxes[Pl] then
			State.Boxes[Pl].Visible = false
		end

		if Config.HealthBars and Root and Dist <= 350 and IsAlive(Char) then
			local Data = EnsureHealth(Pl)
			if Data then
				local Hum = Char:FindFirstChildOfClass("Humanoid")
				local Head = Char:FindFirstChild("Head") or Root
				local Sp = Cam:WorldToViewportPoint(Head.Position + Vector3.new(0, 2.2, 0))
				if Sp.Z > 0 then
					local Pct = Hum and math.clamp(Hum.Health / math.max(Hum.MaxHealth, 1), 0, 1) or 0
					local W = 70
					Data.Bg.Size = Vector2.new(W, 8)
					Data.Bg.Position = Vector2.new(Sp.X - W / 2, Sp.Y)
					Data.Bg.Visible = true
					Data.Fill.Size = Vector2.new(math.max(2, W * Pct), 8)
					Data.Fill.Position = Vector2.new(Sp.X - W / 2, Sp.Y)
					Data.Fill.Visible = true
					Data.Text.Text = string.format("%d/%d", math.floor(Hum and Hum.Health or 0), math.floor(Hum and Hum.MaxHealth or 0))
					Data.Text.Position = Vector2.new(Sp.X, Sp.Y - 2)
					Data.Text.Visible = true
				else
					Data.Bg.Visible = false
					Data.Fill.Visible = false
					Data.Text.Visible = false
				end
			end
		elseif State.Health[Pl] then
			State.Health[Pl].Bg.Visible = false
			State.Health[Pl].Fill.Visible = false
			State.Health[Pl].Text.Visible = false
		end
	end
end)

-- // Hide smoke / flash
Track(Workspace.DescendantAdded, function(Child)
	if Config.HideSmoke and Child.Name == "Smoke Grenade" then
		task.defer(function()
			pcall(function()
				Child:Destroy()
			end)
		end)
	end
	if Config.HideFlash and Child.Name == "FlashbangEffect" then
		task.defer(function()
			pcall(function()
				Child:Destroy()
			end)
		end)
	end
end)

-- // Enemy weapons panel
do
	local Gui = Instance.new("Frame")
	Gui.Name = "EchoEnemyWeapons"
	Gui.Size = UDim2.new(0, 220, 0, 140)
	Gui.Position = UDim2.new(1, -240, 0, 24)
	Gui.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	Gui.BackgroundTransparency = 0.15
	Gui.Visible = false
	Gui.Parent = EchoUiContainer
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Gui
	local Layout = Instance.new("UIListLayout")
	Layout.Padding = UDim.new(0, 4)
	Layout.Parent = Gui
	State.WeaponGui = Gui

	local function EnsureLabel(Name)
		local L = State.WeaponLabels[Name]
		if L then
			return L
		end
		L = Instance.new("TextLabel")
		L.Size = UDim2.new(1, -8, 0, 22)
		L.BackgroundTransparency = 1
		L.Font = Enum.Font.GothamSemibold
		L.TextSize = 13
		L.TextColor3 = Color3.fromRGB(230, 230, 235)
		L.TextXAlignment = Enum.TextXAlignment.Left
		L.Parent = Gui
		State.WeaponLabels[Name] = L
		return L
	end

	Track(RunService.Heartbeat, function()
		local Now = tick()
		if Now - (State.WeaponClock or 0) < 0.2 then
			return
		end
		State.WeaponClock = Now
		if not Config.EnemyWeapons then
			Gui.Visible = false
			return
		end
		Gui.Visible = true
		local Active = {}
		local ViewModels = Workspace:FindFirstChild("ViewModels")
		if ViewModels then
			for _, Vm in ipairs(ViewModels:GetChildren()) do
				if Vm:IsA("Model") then
					local Parts = string.split(Vm.Name, " - ")
					local Pn = Parts[1]
					local Wn = Parts[3] or Parts[2] or "?"
					local Pl = Players:FindFirstChild(Pn)
					if Pl and IsEnemy(Pl) then
						Active[Pn] = true
						local L = EnsureLabel(Pn)
						L.Text = "  " .. Pn .. " | " .. Wn
						L.Visible = true
					end
				end
			end
		end
		for Name, L in pairs(State.WeaponLabels) do
			if not Active[Name] then
				L.Visible = false
			end
		end
	end)
end

-- // Sixth sense (tripmines + katana) — cached parts, no GetDescendants spam
do
	local function IsTrip(Part)
		if not Part or not Part:IsA("BasePart") then
			return false
		end
		local Name = string.lower(Part.Name)
		if string.find(Name, "tripmine", 1, true) then
			return true
		end
		local Anc = Part:FindFirstAncestorOfClass("Model")
		return Anc ~= nil and string.find(string.lower(Anc.Name), "tripmine", 1, true) ~= nil
	end

	local function TryAddTrip(Inst)
		if IsTrip(Inst) then
			State.TripParts[Inst] = true
		elseif Inst:IsA("Model") or Inst:IsA("Folder") then
			for _, Child in ipairs(Inst:GetChildren()) do
				if Child:IsA("BasePart") and IsTrip(Child) then
					State.TripParts[Child] = true
				end
			end
		end
	end

	Track(Workspace.DescendantAdded, function(Desc)
		if Config.SixthSense then
			TryAddTrip(Desc)
		end
	end)
	Track(Workspace.DescendantRemoving, function(Desc)
		if State.TripParts[Desc] then
			State.TripParts[Desc] = nil
			local Draw = State.TripLabels[Desc]
			if Draw then
				pcall(function()
					Draw:Remove()
				end)
				State.TripLabels[Desc] = nil
			end
		end
	end)

	Track(RunService.Heartbeat, function()
		local Now = tick()
		if Now - (State.SenseClock or 0) < 0.12 then
			return
		end
		State.SenseClock = Now

		if not Config.SixthSense then
			for Part, Draw in pairs(State.TripLabels) do
				pcall(function()
					Draw:Remove()
				end)
				State.TripLabels[Part] = nil
			end
			if State.KatanaLabel then
				State.KatanaLabel.Visible = false
			end
			return
		end

		local Cam = Workspace.CurrentCamera
		if not Cam or typeof(Drawing) ~= "table" then
			return
		end
		local Count = 0
		for Part in pairs(State.TripParts) do
			if Count >= 40 then
				break
			end
			if not Part.Parent then
				State.TripParts[Part] = nil
				local Dead = State.TripLabels[Part]
				if Dead then
					pcall(function()
						Dead:Remove()
					end)
					State.TripLabels[Part] = nil
				end
			else
				local Draw = State.TripLabels[Part]
				if not Draw then
					local Ok, T = pcall(function()
						return Drawing.new("Text")
					end)
					if Ok and T then
						T.Text = "Tripmine"
						T.Size = 16
						T.Center = true
						T.Outline = true
						T.Color = Color3.fromRGB(255, 120, 120)
						State.TripLabels[Part] = T
						Draw = T
					end
				end
				if Draw then
					local Sp, On = Cam:WorldToViewportPoint(Part.Position)
					if On and Sp.Z > 0 and (Part.Position - Cam.CFrame.Position).Magnitude <= 300 then
						Draw.Position = Vector2.new(Sp.X, Sp.Y)
						Draw.Visible = true
						Count += 1
					else
						Draw.Visible = false
					end
				end
			end
		end

		local LpRoot = LocalPlayer.Character and (LocalPlayer.Character.PrimaryPart or LocalPlayer.Character:FindFirstChild("HumanoidRootPart"))
		local ShowKatana = false
		if LpRoot then
			for _, Pl in ipairs(Players:GetPlayers()) do
				if IsEnemy(Pl) then
					local Raw = GetHeldWeapon(Pl)
					if WeaponHas(Raw, "katana") and Pl.Character then
						local Hrp = Pl.Character:FindFirstChild("HumanoidRootPart")
						if Hrp and (LpRoot.Position - Hrp.Position).Magnitude <= 150 then
							local Dir = (LpRoot.Position - Hrp.Position)
							if Dir.Magnitude > 0 and Hrp.CFrame.LookVector:Dot(Dir.Unit) >= 0.3 then
								ShowKatana = true
								break
							end
						end
					end
				end
			end
		end
		if ShowKatana then
			if not State.KatanaLabel then
				local L = Instance.new("TextLabel")
				L.Name = "EchoKatanaWarn"
				L.Size = UDim2.new(0, 280, 0, 28)
				L.Position = UDim2.new(0.5, -140, 0, 12)
				L.BackgroundColor3 = Color3.fromRGB(40, 12, 12)
				L.TextColor3 = Color3.fromRGB(255, 200, 200)
				L.Font = Enum.Font.GothamBold
				L.TextSize = 16
				L.Text = "Enemy holding Katana nearby"
				L.Parent = EchoUiContainer
				local C = Instance.new("UICorner")
				C.CornerRadius = UDim.new(0, 6)
				C.Parent = L
				State.KatanaLabel = L
			end
			State.KatanaLabel.Visible = true
		elseif State.KatanaLabel then
			State.KatanaLabel.Visible = false
		end
	end)
end

-- // Noclip
Track(RunService.Heartbeat, function()
	local Char = LocalPlayer.Character
	if not Char then
		return
	end
	if Config.Noclip then
		for _, Part in ipairs(Char:GetDescendants()) do
			if Part:IsA("BasePart") then
				if State.NoclipOrig[Part] == nil then
					State.NoclipOrig[Part] = Part.CanCollide
				end
				Part.CanCollide = false
			end
		end
	else
		for Part, Orig in pairs(State.NoclipOrig) do
			if Part and Part.Parent then
				Part.CanCollide = Orig
			end
			State.NoclipOrig[Part] = nil
		end
	end
end)

-- // Stick / stick beneath
local function FindStickTarget()
	local Cam = Workspace.CurrentCamera
	if not Cam then
		return nil
	end
	local Look = Cam.CFrame.LookVector
	local Origin = Cam.CFrame.Position
	local Best, BestDist = nil, math.huge
	for _, Pl in ipairs(Players:GetPlayers()) do
		if IsEnemy(Pl) and Pl.Character and IsAlive(Pl.Character) then
			local Pp = Pl.Character.PrimaryPart or Pl.Character:FindFirstChild("HumanoidRootPart")
			if Pp then
				local To = Pp.Position - Origin
				if To.Magnitude > 0 and Look:Dot(To.Unit) > 0.6 and To.Magnitude < 300 and To.Magnitude < BestDist then
					Best = Pl
					BestDist = To.Magnitude
				end
			end
		end
	end
	return Best
end

Track(RunService.Heartbeat, function(Dt)
	if not (Config.Stick or Config.StickBeneath) then
		State.StickTarget = nil
		return
	end
	local Char = LocalPlayer.Character
	local Root = Char and (Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart"))
	if not Root then
		return
	end
	if not State.StickTarget or not IsEnemy(State.StickTarget) or not IsAlive(State.StickTarget.Character) then
		State.StickTarget = FindStickTarget()
	end
	local Target = State.StickTarget
	if not Target or not Target.Character then
		return
	end
	local Tp = Target.Character.PrimaryPart or Target.Character:FindFirstChild("HumanoidRootPart")
	if not Tp then
		return
	end

	local Dest
	if Config.StickBeneath then
		for _, Part in ipairs(Char:GetDescendants()) do
			if Part:IsA("BasePart") then
				Part.CanCollide = false
			end
		end
		local Angle = tick() * 8
		Dest = CFrame.new(Tp.Position + Vector3.new(math.cos(Angle), -6.5, math.sin(Angle)), Tp.Position)
	else
		local Raw = GetHeldWeapon(Target)
		if WeaponHas(Raw, "knife") then
			local Push = (Root.Position - Tp.Position)
			if Push.Magnitude == 0 then
				Push = Vector3.new(1, 0, 0)
			end
			Dest = CFrame.new(Tp.Position + Push.Unit * 15 + Vector3.new(0, 6.4, 0), Tp.Position)
		else
			Dest = CFrame.new(Tp.Position + Vector3.new(0, 6.4, 0) - Tp.CFrame.LookVector * 6, Tp.Position)
		end
	end

	if Config.StickSmooth then
		local Alpha = math.clamp((Config.StickSmoothness / 100) * (Dt * 8), 0, 1)
		Char:SetPrimaryPartCFrame(Root.CFrame:Lerp(Dest, Alpha))
	else
		Char:SetPrimaryPartCFrame(Dest)
	end
end)

-- // Fly
Track(RunService.Heartbeat, function(Dt)
	if not Config.Fly then
		return
	end
	local Char = LocalPlayer.Character
	local Root = Char and (Char.PrimaryPart or Char:FindFirstChild("HumanoidRootPart"))
	local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
	local Cam = Workspace.CurrentCamera
	if not Root or not Cam then
		return
	end
	if Hum then
		if State.PrevPlatformStand == nil then
			State.PrevPlatformStand = Hum.PlatformStand
		end
		Hum.PlatformStand = true
	end
	if State.FlyHeight == nil then
		State.FlyHeight = Root.Position.Y
	end
	local Forward = Cam.CFrame.LookVector
	local Right = Cam.CFrame.RightVector
	local Hor = Vector3.zero
	if State.FlyMove.W then
		Hor += Vector3.new(Forward.X, 0, Forward.Z)
	end
	if State.FlyMove.S then
		Hor -= Vector3.new(Forward.X, 0, Forward.Z)
	end
	if State.FlyMove.D then
		Hor += Vector3.new(Right.X, 0, Right.Z)
	end
	if State.FlyMove.A then
		Hor -= Vector3.new(Right.X, 0, Right.Z)
	end
	if State.FlyMove.Up then
		State.FlyHeight += Config.FlySpeed * Dt
	end
	if State.FlyMove.Down then
		State.FlyHeight -= Config.FlySpeed * Dt
	end
	Root.AssemblyLinearVelocity = Vector3.zero
	local Move = Hor.Magnitude > 0 and Hor.Unit * Config.FlySpeed * Dt or Vector3.zero
	local NewPos = Vector3.new(Root.Position.X + Move.X, State.FlyHeight, Root.Position.Z + Move.Z)
	Char:SetPrimaryPartCFrame(CFrame.new(NewPos, NewPos + Vector3.new(Forward.X, 0, Forward.Z)))
end)

-- // Device spoof
do
	local Map = {
		PC = "MouseKeyboard",
		Phone = "Touch",
		Controller = "Gamepad",
		VR = "VR",
	}
	local Acc = 0
	Track(RunService.Heartbeat, function(Dt)
		Acc += Dt
		if Acc < 1 then
			return
		end
		Acc = 0
		local Mapped = Map[Config.DeviceSpoof] or "MouseKeyboard"
		if Mapped == State.LastDevice then
			return
		end
		local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
		local Replication = Remotes and Remotes:FindFirstChild("Replication")
		local Fighter = Replication and Replication:FindFirstChild("Fighter")
		local SetControls = Fighter and Fighter:FindFirstChild("SetControls")
		if SetControls then
			pcall(function()
				SetControls:FireServer(Mapped)
			end)
			State.LastDevice = Mapped
		end
	end)
end

-- // Models color
local function RevertModels()
	for Part, Color in pairs(State.ModelColors) do
		if Part and Part.Parent then
			Part.Color = Color
		end
		State.ModelColors[Part] = nil
	end
end

local function ApplyModels(Color)
	RevertModels()
	task.spawn(function()
		local Batch = 0
		for _, Obj in ipairs(Workspace:GetDescendants()) do
			if not Config.ModelsColor then
				return
			end
			if Obj:IsA("BasePart") and Obj.Transparency < 0.99 then
				State.ModelColors[Obj] = Obj.Color
				Obj.Color = Color
			end
			Batch += 1
			if Batch >= 120 then
				Batch = 0
				task.wait()
			end
		end
	end)
end

Track(Workspace.DescendantAdded, function(Desc)
	if Config.ModelsColor and Desc:IsA("BasePart") and Desc.Transparency < 0.99 and not State.ModelColors[Desc] then
		State.ModelColors[Desc] = Desc.Color
		Desc.Color = Config.ModelsColorValue
	end
end)

-- // Lighting
local function RestoreLighting()
	if not State.SavedLighting then
		return
	end
	Lighting.Brightness = State.SavedLighting.Brightness
	Lighting.Ambient = State.SavedLighting.Ambient
	Lighting.OutdoorAmbient = State.SavedLighting.OutdoorAmbient
	State.SavedLighting = nil
end

local function ApplyLighting(V)
	if not State.SavedLighting then
		State.SavedLighting = {
			Brightness = Lighting.Brightness,
			Ambient = Lighting.Ambient,
			OutdoorAmbient = Lighting.OutdoorAmbient,
		}
	end
	local Mult = math.clamp((V or 100) / 100, 0.01, 2)
	local S = State.SavedLighting
	Lighting.Brightness = S.Brightness * Mult
	Lighting.Ambient = Color3.new(S.Ambient.R * Mult, S.Ambient.G * Mult, S.Ambient.B * Mult)
	Lighting.OutdoorAmbient = Color3.new(S.OutdoorAmbient.R * Mult, S.OutdoorAmbient.G * Mult, S.OutdoorAmbient.B * Mult)
end

-- // FPS
local function DestroyFps()
	if State.FpsGui then
		State.FpsGui:Destroy()
		State.FpsGui = nil
	end
end

local function CreateFps()
	DestroyFps()
	local Gui = Instance.new("ScreenGui")
	Gui.Name = "EchoFps"
	Gui.ResetOnSpawn = false
	Gui.Parent = EchoUiContainer
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(0, 110, 0, 36)
	Label.Position = UDim2.new(0.5, -55, 0, 10)
	Label.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
	Label.TextColor3 = Color3.fromRGB(80, 180, 255)
	Label.Font = Enum.Font.GothamBold
	Label.TextSize = 18
	Label.Text = "FPS: 0"
	Label.Parent = Gui
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Label
	State.FpsGui = Gui
	local Frames, Last = 0, tick()
	Track(RunService.RenderStepped, function()
		if not Config.ShowFps or not Label.Parent then
			return
		end
		Frames += 1
		local Now = tick()
		if Now - Last >= 0.5 then
			Label.Text = "FPS: " .. math.floor(Frames / (Now - Last))
			Frames = 0
			Last = Now
		end
	end)
end

-- // UI
AimSection:Toggle({
	Name = "Aimbot",
	Flag = "RivalsAimbot",
	Default = Config.Aimbot,
	Callback = function(V)
		Config.Aimbot = V
	end,
})
AimSection:Dropdown({
	Name = "Toggle Key",
	Flag = "RivalsAimToggleKey",
	Items = KeyItems,
	Default = Config.AimToggleKey,
	Callback = function(V)
		Config.AimToggleKey = V
	end,
})
AimSection:Dropdown({
	Name = "Aim Lock Key",
	Flag = "RivalsAimLockKey",
	Items = KeyItems,
	Default = Config.AimLockKey,
	Callback = function(V)
		Config.AimLockKey = V
	end,
})
AimSection:Toggle({
	Name = "Team Check",
	Flag = "RivalsTeamCheck",
	Default = Config.TeamCheck,
	Callback = function(V)
		Config.TeamCheck = V
		table.clear(State.TeammateCache)
	end,
})
AimSection:Toggle({
	Name = "Persistent Lock",
	Flag = "RivalsPersistent",
	Default = Config.AimbotPersistent,
	Callback = function(V)
		Config.AimbotPersistent = V
	end,
})
AimSection:Toggle({
	Name = "Target Behind Walls",
	Flag = "RivalsWalls",
	Default = Config.AimbotWalls,
	Callback = function(V)
		Config.AimbotWalls = V
	end,
})

AimTuneSection:Toggle({
	Name = "Smoothing",
	Flag = "RivalsSmooth",
	Default = Config.AimbotSmooth,
	Callback = function(V)
		Config.AimbotSmooth = V
	end,
})
AimTuneSection:Slider({
	Name = "Smooth Amount",
	Flag = "RivalsSmoothAmt",
	Min = 1,
	Max = 100,
	Default = Config.AimbotSmoothness,
	Decimals = 0,
	Callback = function(V)
		Config.AimbotSmoothness = V
	end,
})
AimTuneSection:Slider({
	Name = "FOV",
	Flag = "RivalsFov",
	Min = 20,
	Max = 1000,
	Default = Config.AimbotFov,
	Decimals = 0,
	Callback = function(V)
		Config.AimbotFov = V
	end,
})
AimTuneSection:Toggle({
	Name = "Draw FOV",
	Flag = "RivalsDrawFov",
	Default = Config.AimbotDrawFov,
	Callback = function(V)
		Config.AimbotDrawFov = V
		RefreshFovCircle()
	end,
})
AimTuneSection:Toggle({
	Name = "Target Zone",
	Flag = "RivalsZone",
	Default = Config.AimbotZone,
	Callback = function(V)
		Config.AimbotZone = V
	end,
})
AimTuneSection:Slider({
	Name = "Zone Distance",
	Flag = "RivalsZoneDist",
	Min = 50,
	Max = 900,
	Default = Config.AimbotZoneDist,
	Decimals = 0,
	Callback = function(V)
		Config.AimbotZoneDist = V
	end,
})
AimTuneSection:Toggle({
	Name = "Prediction",
	Flag = "RivalsPredict",
	Default = Config.AimbotPrediction,
	Callback = function(V)
		Config.AimbotPrediction = V
	end,
})

SilentSection:Toggle({
	Name = "Silent Aim",
	Flag = "RivalsSilent",
	Default = Config.Silent,
	Callback = function(V)
		Config.Silent = V
		SyncSilentHooks()
		RefreshSilentFov()
	end,
})
SilentSection:Toggle({
	Name = "Show Silent FOV",
	Flag = "RivalsSilentShowFov",
	Default = Config.SilentShowFov,
	Callback = function(V)
		Config.SilentShowFov = V
		RefreshSilentFov()
	end,
})
SilentSection:Slider({
	Name = "Silent FOV",
	Flag = "RivalsSilentFov",
	Min = 20,
	Max = 600,
	Default = Config.SilentFov,
	Decimals = 0,
	Callback = function(V)
		Config.SilentFov = V
	end,
})
SilentSection:Dropdown({
	Name = "Hit Part",
	Flag = "RivalsSilentHit",
	Items = HitParts,
	Default = Config.SilentHitPart,
	Callback = function(V)
		Config.SilentHitPart = V
	end,
})
SilentSection:Slider({
	Name = "Max Distance",
	Flag = "RivalsSilentDist",
	Min = 50,
	Max = 1200,
	Default = Config.SilentMaxDistance,
	Decimals = 0,
	Callback = function(V)
		Config.SilentMaxDistance = V
	end,
})
SilentSection:Toggle({
	Name = "Sticky Target",
	Flag = "RivalsSilentSticky",
	Default = Config.SilentSticky,
	Callback = function(V)
		Config.SilentSticky = V
	end,
})
SilentSection:Toggle({
	Name = "Ignore Walls",
	Flag = "RivalsSilentWalls",
	Default = Config.SilentWalls,
	Callback = function(V)
		Config.SilentWalls = V
	end,
})
SilentSection:Dropdown({
	Name = "Toggle Key",
	Flag = "RivalsSilentKey",
	Items = KeyItems,
	Default = Config.SilentToggleKey,
	Callback = function(V)
		Config.SilentToggleKey = V
	end,
})

ShootSection:Toggle({
	Name = "Auto Shoot",
	Flag = "RivalsAutoShoot",
	Default = Config.AutoShoot,
	Callback = function(V)
		Config.AutoShoot = V
	end,
})
ShootSection:Dropdown({
	Name = "Toggle Key",
	Flag = "RivalsAutoShootKey",
	Items = KeyItems,
	Default = Config.AutoShootKey,
	Callback = function(V)
		Config.AutoShootKey = V
	end,
})

SenseSection:Toggle({
	Name = "Sixth Sense",
	Flag = "RivalsSixth",
	Default = Config.SixthSense,
	Callback = function(V)
		Config.SixthSense = V
		if V then
			task.spawn(function()
				local Batch = 0
				for _, Desc in ipairs(Workspace:GetDescendants()) do
					if Desc:IsA("BasePart") then
						local Name = string.lower(Desc.Name)
						if string.find(Name, "tripmine", 1, true) then
							State.TripParts[Desc] = true
						else
							local Anc = Desc:FindFirstAncestorOfClass("Model")
							if Anc and string.find(string.lower(Anc.Name), "tripmine", 1, true) then
								State.TripParts[Desc] = true
							end
						end
					end
					Batch += 1
					if Batch >= 200 then
						Batch = 0
						task.wait()
					end
				end
			end)
		else
			table.clear(State.TripParts)
		end
	end,
})

-- // Mobile / gamepad quick buttons
do
	local function BuildMobileHud()
		if State.MobileGui then
			State.MobileGui:Destroy()
			State.MobileGui = nil
		end
		if not Config.MobileButtons then
			return
		end
		local Gui = Instance.new("ScreenGui")
		Gui.Name = "EchoMobileHud"
		Gui.ResetOnSpawn = false
		Gui.IgnoreGuiInset = true
		Gui.Parent = EchoUiContainer
		State.MobileGui = Gui
		EchoUiRoots[#EchoUiRoots + 1] = Gui

		local Holder = Instance.new("Frame")
		Holder.Size = UDim2.new(1, -16, 0, 54)
		Holder.Position = UDim2.new(0, 8, 1, -62)
		Holder.BackgroundTransparency = 1
		Holder.Parent = Gui
		local Layout = Instance.new("UIListLayout")
		Layout.FillDirection = Enum.FillDirection.Horizontal
		Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		Layout.Padding = UDim.new(0, 6)
		Layout.Parent = Holder

		local function MakeBtn(Text, Get, Set)
			local B = Instance.new("TextButton")
			B.Size = UDim2.new(0, 72, 0, 48)
			B.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
			B.TextColor3 = Color3.fromRGB(230, 230, 235)
			B.Font = Enum.Font.GothamBold
			B.TextSize = 12
			B.Text = Text
			B.AutoButtonColor = true
			B.Parent = Holder
			local C = Instance.new("UICorner")
			C.CornerRadius = UDim.new(0, 8)
			C.Parent = B
			local function Paint()
				B.BackgroundColor3 = Get() and Color3.fromRGB(40, 110, 180) or Color3.fromRGB(22, 24, 30)
			end
			Paint()
			B.MouseButton1Click:Connect(function()
				Set(not Get())
				Paint()
			end)
			return B
		end

		MakeBtn("Aim", function()
			return Config.Aimbot
		end, function(V)
			Config.Aimbot = V
		end)
		MakeBtn("Silent", function()
			return Config.Silent
		end, function(V)
			Config.Silent = V
			SyncSilentHooks()
			RefreshSilentFov()
		end)
		MakeBtn("Shoot", function()
			return Config.AutoShoot
		end, function(V)
			Config.AutoShoot = V
		end)
		MakeBtn("Fly", function()
			return Config.Fly
		end, function(V)
			Config.Fly = V
			if not V then
				State.FlyHeight = nil
			end
		end)
		MakeBtn("Clip", function()
			return Config.Noclip
		end, function(V)
			Config.Noclip = V
		end)
		MakeBtn("Stick", function()
			return Config.Stick
		end, function(V)
			Config.Stick = V
			if not V then
				State.StickTarget = nil
			end
		end)
	end

	ExtraSection:Toggle({
		Name = "Mobile Buttons",
		Flag = "RivalsMobileBtns",
		Default = Config.MobileButtons,
		Callback = function(V)
			Config.MobileButtons = V
			BuildMobileHud()
		end,
	})

	task.defer(BuildMobileHud)
end

PlayerVisSection:Toggle({
	Name = "Player Chams",
	Flag = "RivalsChams",
	Default = Config.Chams,
	Callback = function(V)
		Config.Chams = V
		if V then
			RefreshAllVisualPlayers()
		else
			ClearChams()
		end
	end,
})
PlayerVisSection:Toggle({
	Name = "Glow Chams",
	Flag = "RivalsGlow",
	Default = Config.GlowChams,
	Callback = function(V)
		Config.GlowChams = V
		if V then
			RefreshAllVisualPlayers()
		else
			ClearGlow()
		end
	end,
})
PlayerVisSection:Slider({
	Name = "Glow Intensity",
	Flag = "RivalsGlowInt",
	Min = 0,
	Max = 100,
	Default = Config.GlowIntensity,
	Decimals = 0,
	Callback = function(V)
		Config.GlowIntensity = V
		if Config.GlowChams then
			RefreshAllVisualPlayers()
		end
	end,
})
PlayerVisSection:Toggle({
	Name = "Health Bars",
	Flag = "RivalsHealth",
	Default = Config.HealthBars,
	Callback = function(V)
		Config.HealthBars = V
	end,
})
PlayerVisSection:Toggle({
	Name = "ESP Boxes",
	Flag = "RivalsBoxes",
	Default = Config.EspBoxes,
	Callback = function(V)
		Config.EspBoxes = V
	end,
})

WorldVisSection:Toggle({
	Name = "Hide Smoke",
	Flag = "RivalsHideSmoke",
	Default = Config.HideSmoke,
	Callback = function(V)
		Config.HideSmoke = V
	end,
})
WorldVisSection:Toggle({
	Name = "Hide Flashbang",
	Flag = "RivalsHideFlash",
	Default = Config.HideFlash,
	Callback = function(V)
		Config.HideFlash = V
	end,
})
WorldVisSection:Toggle({
	Name = "Enemy Weapons",
	Flag = "RivalsEnemyWeps",
	Default = Config.EnemyWeapons,
	Callback = function(V)
		Config.EnemyWeapons = V
	end,
})

MoveSection:Toggle({
	Name = "Noclip",
	Flag = "RivalsNoclip",
	Default = Config.Noclip,
	Callback = function(V)
		Config.Noclip = V
	end,
})
MoveSection:Dropdown({
	Name = "Noclip Key",
	Flag = "RivalsNoclipKey",
	Items = KeyItems,
	Default = Config.NoclipKey,
	Callback = function(V)
		Config.NoclipKey = V
	end,
})
MoveSection:Toggle({
	Name = "Fly",
	Flag = "RivalsFly",
	Default = Config.Fly,
	Callback = function(V)
		Config.Fly = V
		if not V then
			State.FlyHeight = nil
			local Char = LocalPlayer.Character
			local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
			if Hum and State.PrevPlatformStand ~= nil then
				Hum.PlatformStand = State.PrevPlatformStand
			end
		end
	end,
})
MoveSection:Dropdown({
	Name = "Fly Key",
	Flag = "RivalsFlyKey",
	Items = KeyItems,
	Default = Config.FlyKey,
	Callback = function(V)
		Config.FlyKey = V
	end,
})
MoveSection:Slider({
	Name = "Fly Speed",
	Flag = "RivalsFlySpeed",
	Min = 5,
	Max = 400,
	Default = Config.FlySpeed,
	Decimals = 0,
	Callback = function(V)
		Config.FlySpeed = V
	end,
})

StickSection:Toggle({
	Name = "Stick To Target",
	Flag = "RivalsStick",
	Default = Config.Stick,
	Callback = function(V)
		Config.Stick = V
		if V then
			Config.StickBeneath = false
		end
		if not V then
			State.StickTarget = nil
		end
	end,
})
StickSection:Dropdown({
	Name = "Stick Key",
	Flag = "RivalsStickKey",
	Items = KeyItems,
	Default = Config.StickKey,
	Callback = function(V)
		Config.StickKey = V
	end,
})
StickSection:Toggle({
	Name = "Smooth Stick",
	Flag = "RivalsStickSmooth",
	Default = Config.StickSmooth,
	Callback = function(V)
		Config.StickSmooth = V
	end,
})
StickSection:Slider({
	Name = "Smooth Intensity",
	Flag = "RivalsStickSmoothAmt",
	Min = 1,
	Max = 100,
	Default = Config.StickSmoothness,
	Decimals = 0,
	Callback = function(V)
		Config.StickSmoothness = V
	end,
})
StickSection:Toggle({
	Name = "Stick Beneath",
	Flag = "RivalsStickBeneath",
	Default = Config.StickBeneath,
	Callback = function(V)
		Config.StickBeneath = V
		if V then
			Config.Stick = true
		end
	end,
})

SpoofSection:Dropdown({
	Name = "Device Spoof",
	Flag = "RivalsDevice",
	Items = { "PC", "Phone", "Controller", "VR" },
	Default = Config.DeviceSpoof,
	Callback = function(V)
		Config.DeviceSpoof = V
		State.LastDevice = nil
	end,
})
SpoofSection:Toggle({
	Name = "Models Color",
	Flag = "RivalsModels",
	Default = Config.ModelsColor,
	Callback = function(V)
		Config.ModelsColor = V
		if V then
			ApplyModels(Config.ModelsColorValue)
		else
			RevertModels()
		end
	end,
})
SpoofSection:Toggle({
	Name = "Lighting Boost",
	Flag = "RivalsLighting",
	Default = Config.LightingBoost,
	Callback = function(V)
		Config.LightingBoost = V
		if V then
			ApplyLighting(Config.LightingIntensity)
		else
			RestoreLighting()
		end
	end,
})
SpoofSection:Slider({
	Name = "Lighting Intensity",
	Flag = "RivalsLightingAmt",
	Min = 1,
	Max = 200,
	Default = Config.LightingIntensity,
	Decimals = 0,
	Callback = function(V)
		Config.LightingIntensity = V
		if Config.LightingBoost then
			ApplyLighting(V)
		end
	end,
})

ExtraSection:Toggle({
	Name = "Show FPS",
	Flag = "RivalsFps",
	Default = Config.ShowFps,
	Callback = function(V)
		Config.ShowFps = V
		if V then
			CreateFps()
		else
			DestroyFps()
		end
	end,
})

getgenv().EchoCleanup = function()
	Config.Aimbot = false
	Config.Silent = false
	Config.AutoShoot = false
	Config.Noclip = false
	Config.Stick = false
	Config.StickBeneath = false
	Config.Fly = false
	Config.Chams = false
	Config.GlowChams = false
	Config.HealthBars = false
	Config.EspBoxes = false
	Config.SixthSense = false
	Config.EnemyWeapons = false
	Config.ModelsColor = false
	Config.LightingBoost = false
	Config.ShowFps = false
	Config.MobileButtons = false
	State.AimForce = false
	pcall(mouse1release)
	pcall(function()
		if typeof(State.OldIndex) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__index", State.OldIndex)
		end
		if typeof(State.OldNamecall) == "function" and typeof(hookmetamethod) == "function" then
			hookmetamethod(game, "__namecall", State.OldNamecall)
		end
	end)
	State.OldIndex = nil
	State.OldNamecall = nil
	State.SilentHooked = false
	getgenv().EchoBaseIndex = nil
	getgenv().EchoBaseNamecall = nil
	getgenv().EchoSilentHooked = nil
	ClearChams()
	ClearGlow()
	RevertModels()
	RestoreLighting()
	DestroyFps()
	if State.FovCircle then
		pcall(function()
			State.FovCircle:Remove()
		end)
		State.FovCircle = nil
	end
	if State.SilentFovCircle then
		pcall(function()
			State.SilentFovCircle:Remove()
		end)
		State.SilentFovCircle = nil
	end
	if State.MobileGui then
		pcall(function()
			State.MobileGui:Destroy()
		end)
		State.MobileGui = nil
	end
	for _, Box in pairs(State.Boxes) do
		pcall(function()
			Box:Remove()
		end)
	end
	table.clear(State.Boxes)
	for _, H in pairs(State.Health) do
		pcall(function()
			if H.Bg then
				H.Bg:Remove()
			end
			if H.Fill then
				H.Fill:Remove()
			end
			if H.Text then
				H.Text:Remove()
			end
		end)
	end
	table.clear(State.Health)
	for _, Draw in pairs(State.TripLabels) do
		pcall(function()
			Draw:Remove()
		end)
	end
	table.clear(State.TripLabels)
	table.clear(State.TripParts)
	for Index = 1, #Connections do
		pcall(function()
			Connections[Index]:Disconnect()
		end)
	end
	table.clear(Connections)
	for _, Root in ipairs(EchoUiRoots) do
		pcall(function()
			Root:Destroy()
		end)
	end
	table.clear(EchoUiRoots)
	getgenv().EchoCleanup = nil
end

print(string.format("[Echo] RIVALS loaded in %.2fs", os.clock() - LoadTick))

]====], "Echo_RIVALS")
	if not EchoChunk then
		error("[Echo] RIVALS compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsDaHood() then
-- Echo Hub: Da Hood
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- echohublol | Da Hood (Glory aim + Adonis bypass)
if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or function(...) return ... end
end


-- ===== _adonis_shield.luau =====
-- shield FIRST — no __namecall (Da Hood fingerprints it)
-- Extra Adonis / Da Hood client shields
-- NO hookmetamethod(__namecall) — Da Hood fingerprints that specifically.
-- Blocks Detected via hookfunction on FireServer / InvokeServer / Kick instead.
pcall(function()
    if not LPH_OBFUSCATED then
        LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or function(...) return ... end
    end

    local SHIELD_VER = 4
    if not hookfunction then
        warn("[Echo] Adonis shield needs hookfunction (no namecall fallback)")
        return
    end

    local ALLOW_CMDS = {
        ClientCheck = true,
        ClientLoaded = true,
        Ping = true,
        Pong = true,
        ProcessCommand = true,
        GetReturn = true,
        UIKeepAlive = true,
        Test = true,
        ClientHooked = true,
        SettingUpdate = true,
        UpdateSetting = true,
    }

    local function deepBad(v, depth)
        depth = depth or 0
        if depth > 5 then return false end
        local t = type(v)
        if t == "string" then
            local s = string.lower(v)
            if s:find("detect", 1, true) then return true end
            if s:find("clientcheck", 1, true) and s:find("fail", 1, true) then return true end
            if s == "kick" or s:find("kickplayer", 1, true) then return true end
            if s == "ban" or s:find("banplayer", 1, true) then return true end
            if s == "kill" or s == "crash" or s == "abort" then return true end
            if s:find("exploit", 1, true) then return true end
            if s:find("tamper", 1, true) then return true end
            if s:find("namecall", 1, true) then return true end
            if s:find("metamethod", 1, true) then return true end
            if s:find("hookmetamethod", 1, true) then return true end
            if s:find("hookfunction", 1, true) then return true end
            if s:find("method hook", 1, true) then return true end
            if s:find("integrity", 1, true) then return true end
            return false
        elseif t == "table" then
            for k, val in pairs(v) do
                if deepBad(k, depth + 1) or deepBad(val, depth + 1) then
                    return true
                end
            end
        end
        return false
    end

    local function isAdonisRemote(inst)
        if typeof(inst) ~= "Instance" then return false end
        if inst:IsA("RemoteEvent") and inst:FindFirstChild("__FUNCTION") then
            return true
        end
        local cur = inst
        while cur do
            local n = string.lower(cur.Name)
            if n:find("adonis", 1, true) or n:find("antidote", 1, true) then
                return true
            end
            cur = cur.Parent
        end
        return false
    end

    local function looksLikeAdonisPayload(args)
        local a1 = args[1]
        return type(a1) == "table" and a1.Mode ~= nil and a1.Sent ~= nil
    end

    local function tryDecryptCmd(cmd)
        if type(cmd) ~= "string" then return nil end
        local ad = rawget(_G, "Adonis")
        if type(ad) == "table" and type(ad.Decrypt) == "function" and ad.Key then
            local ok, plain = pcall(ad.Decrypt, cmd)
            if ok and type(plain) == "string" and plain ~= "" then
                return plain
            end
        end
        return nil
    end

    local function isHandshakePlain(cmd)
        if type(cmd) ~= "string" then return false end
        return cmd:find("GET_KEY", 1, true) ~= nil or cmd:find("GIVE_KEY", 1, true) ~= nil
    end

    local function shouldBlockRemote(self, args)
        for i = 1, #args do
            if deepBad(args[i]) then
                return true
            end
        end

        local adonisLike = isAdonisRemote(self) or looksLikeAdonisPayload(args)
        if not adonisLike then
            return false
        end

        local cmd = args[2]
        if isHandshakePlain(cmd) then
            return false
        end

        local plain = tryDecryptCmd(cmd)
        if plain then
            if deepBad(plain) then
                return true
            end
            if ALLOW_CMDS[plain] then
                return false
            end
            return true
        end

        -- Fail closed on encrypted Adonis cmds (Detected is always encrypted)
        if type(cmd) == "string" and looksLikeAdonisPayload(args) then
            return true
        end

        return false
    end

    ----------------------------------------------------------------
    -- Global FireServer / InvokeServer hooks (NO __namecall)
    ----------------------------------------------------------------
    if getgenv().__EchoAdonisShieldVer ~= SHIELD_VER or not getgenv().__EchoAdonisShieldHook then
        getgenv().__EchoAdonisShieldHook = true
        getgenv().__EchoAdonisShieldVer = SHIELD_VER

        pcall(function()
            local dummyEv = Instance.new("RemoteEvent")
            local fireRef = dummyEv.FireServer
            dummyEv:Destroy()

            local oldFire
            oldFire = hookfunction(fireRef, LPH_NO_VIRTUALIZE(function(self, ...)
                if checkcaller and checkcaller() then
                    return oldFire(self, ...)
                end
                if typeof(self) == "Instance" and self:IsA("RemoteEvent") then
                    if shouldBlockRemote(self, { ... }) then
                        return
                    end
                end
                return oldFire(self, ...)
            end))
        end)

        pcall(function()
            local dummyFn = Instance.new("RemoteFunction")
            local invRef = dummyFn.InvokeServer
            dummyFn:Destroy()

            local oldInv
            oldInv = hookfunction(invRef, LPH_NO_VIRTUALIZE(function(self, ...)
                if checkcaller and checkcaller() then
                    return oldInv(self, ...)
                end
                if typeof(self) == "Instance" and self:IsA("RemoteFunction") then
                    local parent = self.Parent
                    if shouldBlockRemote(parent or self, { ... }) then
                        return
                    end
                end
                return oldInv(self, ...)
            end))
        end)
    end

    ----------------------------------------------------------------
    -- Kick block (method hook, not namecall)
    ----------------------------------------------------------------
    pcall(function()
        local lp = game:GetService("Players").LocalPlayer
        if not lp then return end
        if getgenv().__EchoKickHookedVer == SHIELD_VER then return end
        getgenv().__EchoKickHookedVer = SHIELD_VER
        local oldKick
        oldKick = hookfunction(lp.Kick, LPH_NO_VIRTUALIZE(function(self, ...)
            if self == lp then
                return
            end
            return oldKick(self, ...)
        end))
    end)

    ----------------------------------------------------------------
    -- Soft getgc(false) neuter of Detected closures (never getgc(true))
    ----------------------------------------------------------------
    pcall(function()
        if type(getgc) ~= "function" then return end
        if getgenv().__EchoDetectedHookedVer == SHIELD_VER then return end
        getgenv().__EchoDetectedHookedVer = SHIELD_VER

        for _, obj in ipairs(getgc(false)) do
            if type(obj) == "function" then
                local ok, consts = pcall(function()
                    if debug and debug.getconstants then
                        return debug.getconstants(obj)
                    end
                    return nil
                end)
                if ok and type(consts) == "table" then
                    for _, c in ipairs(consts) do
                        if c == "Detected" or c == "Method hook detected" then
                            pcall(function()
                                hookfunction(obj, LPH_NO_VIRTUALIZE(function() end))
                            end)
                            break
                        end
                    end
                end
            end
        end
    end)

    ----------------------------------------------------------------
    -- Disable Adonis / Antidote client scripts
    ----------------------------------------------------------------
    local function neuterTree(inst)
        if not inst then return end
        pcall(function()
            for _, d in ipairs(inst:GetDescendants()) do
                if d:IsA("LocalScript") or d:IsA("Script") then
                    pcall(function()
                        d.Disabled = true
                    end)
                end
            end
            if inst:IsA("LocalScript") or inst:IsA("Script") then
                pcall(function()
                    inst.Disabled = true
                end)
            end
        end)
    end

    local function maybeNeuter(inst)
        if not inst or not inst.Name then return end
        local n = string.lower(inst.Name)
        if n:find("adonis", 1, true) or n:find("antidote", 1, true) then
            neuterTree(inst)
        end
    end

    local function watch(container)
        if not container then return end
        pcall(function()
            for _, c in ipairs(container:GetChildren()) do
                maybeNeuter(c)
            end
            container.ChildAdded:Connect(function(c)
                task.defer(maybeNeuter, c)
            end)
        end)
    end

    local lp = game:GetService("Players").LocalPlayer
    local RS = game:GetService("ReplicatedStorage")
    watch(lp:FindFirstChildOfClass("PlayerGui"))
    watch(lp:FindFirstChild("PlayerScripts"))
    watch(game:GetService("ReplicatedFirst"))
    watch(RS)
    pcall(function()
        watch(game:GetService("CoreGui"))
    end)
    lp.ChildAdded:Connect(function(c)
        if c:IsA("PlayerGui") or c.Name == "PlayerGui" then
            task.defer(watch, c)
        end
    end)

    getgenv().__EchoAdonisShield = true
    getgenv().__EchoAdonisShieldVer = SHIELD_VER
    print("[Echo] Adonis shield v" .. tostring(SHIELD_VER) .. " armed (no namecall)")
end)


-- ===== _adonis_emu.luau =====
-- handshake / key steal
pcall(function()
	-- Adonis V5+ Emulator (OT7)
	-- Hooks Detected/Kill, steals or handshakes session key.

	if not LPH_OBFUSCATED then
		function LPH_NO_VIRTUALIZE(F)
			return F
		end
	end

	if _G.__AdonisEmu then
		return _G.Adonis
	end
	_G.__AdonisEmu = true

	local Plrs = game:GetService("Players")
	local RS = game:GetService("ReplicatedStorage")
	local Http = game:GetService("HttpService")
	local Me = Plrs.LocalPlayer

	local StartTime = os.clock()
	local LogBuf = {}
	local DbgMode = false

	local function Log(Tag, Msg)
		local Entry = {
			time = math.floor((os.clock() - StartTime) * 1000),
			tag = Tag,
			msg = Msg,
		}
		table.insert(LogBuf, Entry)
		if DbgMode then
			print(("[+%dms] [%s] %s"):format(Entry.time, Tag, Msg))
		end
	end

	local ArgPreview = LPH_NO_VIRTUALIZE(function(Args)
		local Parts = {}
		for I = 1, math.min(#Args, 4) do
			local V = Args[I]
			local S = type(V) == "table" and "{table}" or tostring(V)
			if #S > 40 then
				S = S:sub(1, 37) .. "..."
			end
			Parts[I] = S
		end
		if #Args > 4 then
			Parts[#Parts + 1] = ("...+%d"):format(#Args - 4)
		end
		return table.concat(Parts, ", ")
	end)

	Log("BOOT", "handshake-only Adonis (no getgc â€” Potassium crash safe)")

	-- Intentionally skip Detected/Kill getgc hooks â€” getgc(true) hard-crashes Potassium.

	local ECache = {}
	local DCache = {}

	local Xor = LPH_NO_VIRTUALIZE(function(S, K, Cache)
		if not K or not S or S == "" then
			return S
		end
		Cache = Cache or ECache
		local KC = Cache[K]
		if not KC then
			KC = {}
			Cache[K] = KC
		end
		if KC[S] then
			return KC[S]
		end

		local Raw = buffer.fromstring(S)
		local RK = KC[1] or buffer.fromstring(K)
		local Len = #K

		for I = 0, #S - 1 do
			buffer.writeu8(Raw, I, bit32.bxor(buffer.readu8(Raw, I), buffer.readu8(RK, I % Len)))
		end

		KC[1] = RK
		local Out = buffer.tostring(Raw)
		KC[S] = Out
		return Out
	end)

	local RName = nil
	local Deps = nil
	local Key = nil
	local Ev = nil
	local Fn = nil
	local TxCount = 0
	local RxCount = 0
	local Waiting = {}
	local SpecEv = nil

	local function GrabSpecial(Child)
		if Child.Name ~= "Adonis_Container" then
			return
		end
		local Folder = Child:FindFirstChildOfClass("Folder") or Child:FindFirstChild("Adonis_Client")
		if not Folder then
			return
		end
		local SV = Folder:FindFirstChild("Special")
		if not SV then
			local Ok, R = pcall(function()
				return Folder:WaitForChild("Special", 3)
			end)
			SV = Ok and R or nil
		end
		if not SV or SV.Value == "" then
			return
		end
		local RN, DN = string.match(SV.Value, "(.*)\\(.*)")
		if not RN then
			return
		end
		RName = RN
		Deps = DN
		if SpecEv then
			SpecEv:Disconnect()
			SpecEv = nil
		end
	end

	local function StealKey()
		-- Disabled: getgc(true) crashes Potassium. Use Special + handshake only.
		return false
	end

	local function GetRemote()
		if RName and RName ~= "" then
			local E = RS:FindFirstChild(RName)
			if E and E:IsA("RemoteEvent") then
				Ev = E
				Fn = E:FindFirstChild("__FUNCTION")
				if Fn then
					return true
				end
			end
		end

		for _, Child in pairs(RS:GetChildren()) do
			if Child:IsA("RemoteEvent") then
				local F = Child:FindFirstChild("__FUNCTION")
				if F and F:IsA("RemoteFunction") then
					Ev = Child
					Fn = F
					RName = Child.Name
					return true
				end
			end
		end

		local Found = false
		local C = RS.ChildAdded:Connect(function(Child)
			if Found or not Child:IsA("RemoteEvent") then
				return
			end
			local F = Child:FindFirstChild("__FUNCTION") or Child:WaitForChild("__FUNCTION", 5)
			if F and F:IsA("RemoteFunction") then
				Ev = Child
				Fn = F
				RName = Child.Name
				Found = true
			end
		end)

		local T = os.clock() + 30
		while not Found and os.clock() < T do
			task.wait(0.1)
		end
		C:Disconnect()
		return Found
	end

	local function DoHandshake()
		if not Deps then
			return false
		end

		local Ok, Ret = pcall(function()
			TxCount += 1
			return Fn:InvokeServer({ Mode = "Get", Sent = TxCount, Received = RxCount }, Deps .. "GET_KEY")
		end)

		if Ok and type(Ret) == "string" and Ret ~= "" then
			Key = Ret
			return true
		end

		local Got = false
		local C = Ev.OnClientEvent:Connect(function(Data, Com, ...)
			if type(Com) == "string" and Com == Deps .. "GIVE_KEY" then
				local A = { ... }
				if type(A[1]) == "string" and A[1] ~= "" then
					Key = A[1]
					Got = true
				end
			end
		end)

		TxCount += 1
		Ev:FireServer({ Mode = "Fire", Sent = TxCount, Received = RxCount }, Deps .. "GET_KEY")

		local T = os.clock() + 10
		while not Got and os.clock() < T do
			task.wait(0.05)
		end
		C:Disconnect()
		return Got
	end

	local OnRecv = LPH_NO_VIRTUALIZE(function(Data, Com, ...)
		if type(Com) ~= "string" then
			return
		end
		RxCount += 1

		if Deps and Com == Deps .. "GIVE_KEY" then
			local A = { ... }
			if not Key and type(A[1]) == "string" and A[1] ~= "" then
				Key = A[1]
			end
			return
		end

		if not Key then
			return
		end

		local Dec = Xor(Com, Key, DCache)
		local Mode = Data and Data.Mode or "Fire"
		local Args = { ... }

		if Mode == "Get" then
			if Dec == "ClientHooked" then
				return Deps
			end
			if Dec == "Ping" then
				return "Pong"
			end
			if Dec == "Test" then
				return "HELLO FROM THE CLIENT SIDE :)!"
			end
			if Dec == "UIKeepAlive" then
				return true
			end
			return nil
		end

		if Dec == "GiveReturn" then
			local ID = Args[1]
			local CB = ID and Waiting[ID]
			if CB then
				Waiting[ID] = nil
				CB(table.unpack(Args, 2))
			end
		end
	end)

	local Adonis = {}
	_G.Adonis = Adonis

	task.spawn(function()
		task.wait(1) -- let UI / game scripts settle before Adonis GC / handshake
		local Grabbed = StealKey()

		if Grabbed then
			if not GetRemote() then
				warn("[AdonisEmu] stole key but no remote")
				return
			end
		else
			local PG = Me:FindFirstChildOfClass("PlayerGui") or Me:WaitForChild("PlayerGui", 30)
			if PG then
				for _, Child in pairs(PG:GetChildren()) do
					pcall(GrabSpecial, Child)
				end
				if not RName then
					SpecEv = PG.ChildAdded:Connect(function(Child)
						pcall(GrabSpecial, Child)
					end)
				end
			end

			local T = os.clock() + 15
			while not RName and os.clock() < T do
				task.wait(0.1)
			end
			if SpecEv then
				SpecEv:Disconnect()
				SpecEv = nil
			end

			if not GetRemote() then
				warn("[AdonisEmu] no remote")
				return
			end

			if not DoHandshake() then
				warn("[AdonisEmu] handshake failed")
				return
			end

			task.wait(0.1)
			TxCount += 1
			Ev:FireServer(
				{ Mode = "Fire", Sent = TxCount, Received = RxCount },
				Xor("ClientLoaded", Key, ECache)
			)
		end

		Ev.OnClientEvent:Connect(function(...)
			pcall(OnRecv, ...)
		end)

		pcall(function()
			local Old = Fn.OnClientInvoke
			Fn.OnClientInvoke = function(Data, Com, ...)
				local R = OnRecv(Data, Com, ...)
				if R ~= nil then
					return R
				end
				if Old then
					return Old(Data, Com, ...)
				end
			end
		end)

		task.spawn(function()
			task.wait(5)
			while Key and Ev do
				task.wait(30)
				if Key then
					pcall(function()
						TxCount += 1
						Ev:FireServer(
							{ Mode = "Fire", Sent = TxCount, Received = RxCount },
							Xor("ClientCheck", Key, ECache),
							{ Sent = TxCount, Received = RxCount },
							Deps
						)
					end)
				end
			end
		end)

		Adonis.Key = Key
		Adonis.DepsName = Deps
		Adonis.RemoteName = RName
		Adonis.RemoteEvent = Ev
		Adonis.RemoteFunction = Fn
		print("[AdonisEmu] connected")
	end)

	function Adonis.Send(Cmd, ...)
		assert(Key, "[AdonisEmu] not connected")
		TxCount += 1
		Ev:FireServer({ Mode = "Fire", Sent = TxCount, Received = RxCount }, Xor(Cmd, Key, ECache), ...)
	end

	function Adonis.Get(Cmd, ...)
		assert(Key, "[AdonisEmu] not connected")
		TxCount += 1
		local Ret = Fn:InvokeServer({ Mode = "Get", Sent = TxCount, Received = RxCount }, Xor(Cmd, Key, ECache), ...)
		if type(Ret) == "table" then
			return table.unpack(Ret)
		end
		return Ret
	end

	function Adonis.GetReturn(Name, ...)
		assert(Key, "[AdonisEmu] not connected")
		local Out, Done = nil, false
		local ID = Http:GenerateGUID(false)
		Waiting[ID] = function(...)
			Out = { ... }
			Done = true
		end
		Adonis.Send("GetReturn", Name, ID, ...)
		local T = os.clock() + 10
		while not Done and os.clock() < T do
			task.wait(0.05)
		end
		Waiting[ID] = nil
		return Out and table.unpack(Out)
	end

	function Adonis.ProcessCommand(Cmd)
		assert(type(Cmd) == "string")
		Adonis.Send("ProcessCommand", Cmd)
	end

	function Adonis.GetAdminLevel()
		return Adonis.Get("AdminLevel")
	end
	function Adonis.GetPlayerData()
		return Adonis.Get("PlayerData")
	end
	function Adonis.CheckAdmin()
		return Adonis.Get("CheckAdmin")
	end
	function Adonis.Ping()
		local T = os.clock()
		Adonis.Get("Ping")
		return math.round((os.clock() - T) * 1000)
	end

	function Adonis.Encrypt(S)
		assert(Key, "[AdonisEmu] not connected")
		return Xor(S, Key, ECache)
	end

	function Adonis.Decrypt(S)
		assert(Key, "[AdonisEmu] not connected")
		return Xor(S, Key, DCache)
	end

	function Adonis.GetLogs()
		return LogBuf
	end

	function Adonis.DumpLogs()
		for I = 1, #LogBuf do
			local E = LogBuf[I]
			print(("[+%dms] [%s] %s"):format(E.time, E.tag, E.msg))
		end
	end

	function Adonis.ClearLogs()
		table.clear(LogBuf)
	end

	Adonis.Debug = false
	setmetatable(Adonis, {
		__newindex = function(T, K, V)
			if K == "Debug" then
				DbgMode = V == true
			end
			rawset(T, K, V)
		end,
	})

	return Adonis
end)


-- ===== _glory_core.luau =====
-- Glory aim + features
if not LPH_OBFUSCATED then
    LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or function(...) return ... end
end

--all fov dont work
shared.Glory = {
    ['settings'] = {
        ['knock check'] = true,
        ['visible check'] = false,
        ['self knock check'] = true,
        ['knife check'] = true,
    },

    ['targeting'] = {
        ['mode'] = 'Automatic', -- Select/Automatic
    },

    ['binds'] = {
        ['silent aim'] = 'C',
        ['cam lock'] = 'X',
        ['triggerbot'] = 'B',
        ['super jump'] = 'Z',
        ['esp'] = 'H',
        ['speed'] = 'V',
    },

    ['silent aimbot'] = {
        ['enabled'] = true,
        ['mode'] = 'Toggle',
        ['hitpart'] = 'Head',
        ['use prediction'] = true,
        ['prediction'] = {
            ['x'] = 0.133,
            ['y'] = 0.133,
            ['z'] = 0.133,
        },
        ['fov'] = {
            ['enabled'] = false,
            ['visible'] = false,
            ['mode'] = '2D', -- 3D/2D
            ['active color'] = Color3.fromRGB(0, 17, 255),
            ['size'] = {
                ['x'] = 15,
                ['y'] = 15,
                ['z'] = 15,
            },
        },
        ['distance check'] = {
            ['enabled'] = true,
            ['max distance'] = 300,
        },
    },

    ['camera aimbot'] = {
        ['enabled'] = true,
        ['mode'] = 'Toggle',
        ['hitpart'] = 'Head',
        ['smoothing'] = {
            ['x'] = 5,
            ['y'] = 5,
            ['z'] = 5,
        },
        ['use prediction'] = true,
        ['prediction'] = {
            ['x'] = 0.133,
            ['y'] = 0.133,
            ['z'] = 0.133,
        },
        ['fov'] = {
            ['enabled'] = false,
            ['visible'] = false,
            ['mode'] = '3D', -- 3D/2D
            ['active color'] = Color3.fromRGB(0, 17, 255),
            ['size'] = {
                ['x'] = 10,
                ['y'] = 10,
                ['z'] = 10,
            },
        },
        ['distance check'] = {
            ['enabled'] = true,
            ['max distance'] = 300,
        },
    },

    ['trigger bot'] = {
        ['enabled'] = false,
        ['mode'] = 'Hold',
        ['delay'] = 0.01,
        ['require target'] = true,
        ['specific weapons'] = {
            ['enabled'] = false,
            ['weapons'] = {
                '[Double-Barrel SG]',
                '[Revolver]',
                '[TacticalShotgun]',
            },
        },
        ['fov'] = {
            ['enabled'] = true,
            ['visible'] = true,
            ['mode'] = '3D', -- 3D/2D
            ['active color'] = Color3.fromRGB(0, 17, 255),
            ['size'] = {
                ['x'] = 10,
                ['y'] = 10,
                ['z'] = 10,
            },
        },
        ['distance check'] = {
            ['enabled'] = true,
            ['max distance'] = 300,
        },
    },

    ['target line'] = {
        ['enabled'] = true,
        ['thickness'] = 0.5,
        ['transparency'] = 0.8,
        ['vulnerable'] = Color3.fromRGB(255, 85, 85),
        ['invulnerable'] = Color3.fromRGB(150, 150, 150),
    },

    ['spread modifications'] = {
        ['enabled'] = true,
        ['amount'] = 1, -- 1-100
        ['specific weapons'] = {
            ['enabled'] = false,
            ['weapons'] = {
                '[Double-Barrel SG]',
                '[TacticalShotgun]',
            },
        },
    },

    ['super jump'] = {
        ['enabled'] = true,
        ['jump power'] = 200,
    },

    ['rapid fire'] = {
        ['enabled'] = true,
        ['delay'] = 0.000000001,
        ['specific weapons'] = {
            ['enabled'] = false,
            ['weapons'] = {
                '[Revolver]',
            },
        },
    },

    ['hitbox expander'] = {
        ['enabled'] = true,
        ['size'] = 7,
    },

    ['spiderman'] = {
        ['enabled'] = false,
        ['jumppower'] = 20,
        ['knifejumppower'] = 30,
    },

    ['speed modifications'] = {
        ['enabled'] = true,
        ['multiplier'] = 400,
    },

    ['esp'] = {
        ['enabled'] = true,
        ['color'] = Color3.fromRGB(255, 255, 255),
        ['target color'] = Color3.fromRGB(255, 0, 0),
        ['use display name'] = true,
        ['name above'] = false,
    },

    ['skins'] = {
        ['enabled'] = true,
        ['weapons'] = {
            ['[Double-Barrel SG]'] = "Golden Age",
            ['[Revolver]'] = "Golden Age",
            ['[TacticalShotgun]'] = "Patriot",
            ['[Knife]'] = "GPO-Knife Prestige",
        },
    },

    ['headless'] = {
        ['enabled'] = false,
        ['remove face accessories'] = true,
    },
}
local cfg = shared.Glory
local players = game:GetService("Players")
local uis = game:GetService("UserInputService")
local runservice = game:GetService("RunService")
local workspace = game:GetService("Workspace")
local replicatedstorage = game:GetService("ReplicatedStorage")
local camera = workspace.CurrentCamera
local localplayer = players.LocalPlayer
local mouse = localplayer:GetMouse()

local currenttarget = nil
local silentaimactive = false
local camlockactive = false
local triggerenabled = false
local esplabels = {}
local superjumpenabled = false
local speedenabled = false
local isfiring = false
local lastrapidfire = 0
local lastvisibletarget = nil
local lasttriggerclick = 0
local lasttargetscan = 0
local scanrate = 1 / 20

local haswalljumped = false
local walljumpconnection = nil

local rayparams = RaycastParams.new()
rayparams.FilterType = Enum.RaycastFilterType.Exclude
rayparams.IgnoreWater = true

local knifedata = {}

local knifeskins = {
    ["Golden Age Tanto"] = {soundid = "rbxassetid://5917819099", animationid = "rbxassetid://13473404819", positionoffset = Vector3.new(0, -0.20, -1.2), rotationoffset = Vector3.new(90, 263.7, 180)},
    ["GPO-Knife"] = {soundid = "rbxassetid://4604390759", animationid = "rbxassetid://14014278925", positionoffset = Vector3.new(0.00, -0.32, -1.07), rotationoffset = Vector3.new(90, -97.4, 90)},
    ["GPO-Knife Prestige"] = {soundid = "rbxassetid://4604390759", animationid = "rbxassetid://14014278925", positionoffset = Vector3.new(0.00, -0.32, -1.07), rotationoffset = Vector3.new(90, -97.4, 90)},
    ["Heaven"] = {soundid = "rbxassetid://14489860007", animationid = "rbxassetid://14500266726", positionoffset = Vector3.new(-0.02, -0.82, 0.20), rotationoffset = Vector3.new(64.42, 3.79, 0.00)},
    ["Love Kukri"] = {soundid = "", animationid = "", positionoffset = Vector3.new(-0.14, 0.14, -1.62), rotationoffset = Vector3.new(-90.00, 180.00, -4.97), particle = true, textureid = "rbxassetid://12124159284"},
    ["Purple Dagger"] = {soundid = "rbxassetid://17822743153", animationid = "rbxassetid://17824999722", positionoffset = Vector3.new(-0.13, -0.24, -1.80), rotationoffset = Vector3.new(89.05, 96.63, 180.00)},
    ["Blue Dagger"] = {soundid = "rbxassetid://17822737046", animationid = "rbxassetid://17824995184", positionoffset = Vector3.new(-0.13, -0.24, -1.80), rotationoffset = Vector3.new(89.05, 96.63, 180.00)},
    ["Green Dagger"] = {soundid = "rbxassetid://17822741762", animationid = "rbxassetid://17825004320", positionoffset = Vector3.new(-0.13, -0.24, -1.07), rotationoffset = Vector3.new(89.05, 96.63, 180.00)},
    ["Red Dagger"] = {soundid = "rbxassetid://17822952417", animationid = "rbxassetid://17825008844", positionoffset = Vector3.new(-0.13, -0.24, -1.07), rotationoffset = Vector3.new(89.05, 96.63, 180.00)},
    ["Portal"] = {soundid = "rbxassetid://16058846352", animationid = "rbxassetid://16058633881", positionoffset = Vector3.new(-0.13, -0.35, -0.57), rotationoffset = Vector3.new(89.05, 96.63, 180.00)},
    ["Emerald Butterfly"] = {soundid = "rbxassetid://14931902491", animationid = "rbxassetid://14918231706", positionoffset = Vector3.new(-0.02, -0.30, -0.65), rotationoffset = Vector3.new(180.00, 90.95, 180.00)},
    ["Boy"] = {soundid = "rbxassetid://18765078331", animationid = "rbxassetid://18789158908", positionoffset = Vector3.new(-0.02, -0.09, -0.73), rotationoffset = Vector3.new(89.05, -88.11, 180.00)},
    ["Girl"] = {soundid = "rbxassetid://18765078331", animationid = "rbxassetid://18789162944", positionoffset = Vector3.new(-0.02, -0.16, -0.73), rotationoffset = Vector3.new(89.05, -88.11, 180.00)},
    ["Dragon"] = {soundid = "rbxassetid://14217789230", animationid = "rbxassetid://14217804400", positionoffset = Vector3.new(-0.02, -0.32, -0.98), rotationoffset = Vector3.new(89.05, 90.95, 180.00)},
    ["Void"] = {soundid = "rbxassetid://14756591763", animationid = "rbxassetid://14774699952", positionoffset = Vector3.new(-0.02, -0.22, -0.85), rotationoffset = Vector3.new(180.00, 90.95, 180.00)},
    ["Wild West"] = {soundid = "rbxassetid://16058689026", animationid = "rbxassetid://16058148839", positionoffset = Vector3.new(-0.02, -0.24, -1.15), rotationoffset = Vector3.new(-91.89, 90.95, 180.00)},
    ["Iced Out"] = {soundid = "rbxassetid://14924261405", animationid = "rbxassetid://18465353361", positionoffset = Vector3.new(0.02, -0.08, 0.99), rotationoffset = Vector3.new(180.00, -90.95, -180.00)},
    ["Reptile"] = {soundid = "rbxassetid://18765103349", animationid = "rbxassetid://18788955930", positionoffset = Vector3.new(-0.03, -0.06, -0.92), rotationoffset = Vector3.new(168.63, 90.00, -180.00)},
    ["Emerald"] = {soundid = "", animationid = "", positionoffset = Vector3.new(-0.03, -0.06, -0.92), rotationoffset = Vector3.new(168.63, 90.00, 108.00)},
    ["Ribbon"] = {soundid = "rbxassetid://130974579277249", animationid = "rbxassetid://124102609796063", positionoffset = Vector3.new(0.02, -0.25, -0.05), rotationoffset = Vector3.new(90.00, 0.00, 180.00)},
}

local fovparts = {
    silentaim = Instance.new("Part"),
    camlock = Instance.new("Part"),
    triggerbot = Instance.new("Part"),
}

for name, part in pairs(fovparts) do
    part.Anchored = true
    part.CanCollide = false
    part.CanQuery = false
    part.CanTouch = false
    part.CastShadow = false
    part.Transparency = 1
    part.BrickColor = BrickColor.new("Grey")
    part.Material = Enum.Material.Neon
    part.Name = "fovoutline3d_" .. name
    part.Parent = workspace
end

local fov2dboxes = {
    silentaim = {},
    camlock = {},
    triggerbot = {},
}

for key in pairs(fov2dboxes) do
    for i = 1, 4 do
        local line = Drawing.new("Line")
        line.Thickness = 1.5
        line.Color = Color3.fromRGB(150, 150, 150)
        line.Visible = false
        line.ZIndex = 5
        fov2dboxes[key][i] = line
    end
end

local targetline = Drawing.new("Line")
targetline.Visible = false
targetline.Thickness = cfg['target line']['thickness']
targetline.Transparency = cfg['target line']['transparency']
targetline.ZIndex = 999

local function clearmesh(tool, exclude)
    local children = tool:GetChildren()
    for i = 1, #children do
        local v = children[i]
        if v:IsA("MeshPart") and v ~= exclude then
            v:Destroy()
        end
    end
end

local function applygun(tool, name)
    local orig = tool:FindFirstChildOfClass("MeshPart")
    if not orig then return end

    local skinmodules = replicatedstorage:FindFirstChild("SkinModules")
    if not skinmodules then return end

    local ok, skinmodulesreq = pcall(function()
        return require(skinmodules)
    end)
    if not ok or not skinmodulesreq then return end

    local info = skinmodulesreq[tool.Name] and skinmodulesreq[tool.Name][name]
    if not info then return end

    clearmesh(tool, orig)

    local skinpart = info.TextureID
    if typeof(skinpart) == "Instance" then
        local clone = skinpart:Clone()
        clone.Parent = tool
        clone.CFrame = orig.CFrame
        clone.Name = "CurrentSkin"

        local w = Instance.new("Weld")
        w.Part0 = clone
        w.Part1 = orig
        w.C0 = info.CFrame:Inverse()
        w.Parent = clone

        orig.Transparency = 1
    else
        orig.TextureID = skinpart
        orig.Transparency = 0
    end

    local handle = tool:FindFirstChild("Handle")
    if not handle then return end

    local shoot = handle:FindFirstChild("ShootSound")
    if shoot then
        local skinassets = replicatedstorage:FindFirstChild("SkinAssets")
        if skinassets then
            local gunsounds = skinassets:FindFirstChild("GunShootSounds")
            if gunsounds then
                local sounds = gunsounds:FindFirstChild(tool.Name)
                local obj = sounds and sounds:FindFirstChild(name)
                if obj then
                    shoot.SoundId = obj.Value
                end
            end
        end
    end

    local skinassets = replicatedstorage:FindFirstChild("SkinAssets")
    if skinassets then
        local particlefolder = skinassets:FindFirstChild("GunHandleParticle")
        if particlefolder then
            local particlesource = particlefolder:FindFirstChild(name)
            if particlesource then
                local pe = particlesource:FindFirstChild("ParticleEmitter")
                if pe then
                    for _, existing in ipairs(handle:GetChildren()) do
                        if existing:IsA("ParticleEmitter") then
                            existing:Destroy()
                        end
                    end
                    pe:Clone().Parent = handle
                end
            end
        end
    end

    handle:SetAttribute("SkinName", name)
end

local function cleanknife(tool)
    local data = knifedata[tool]
    if data then
        if data.track then
            data.track:Stop()
            data.track:Destroy()
            data.track = nil
        end
        if data.welds then
            for _, w in ipairs(data.welds) do
                if w then w:Destroy() end
            end
        end
        if data.sounds then
            for _, s in ipairs(data.sounds) do
                if s and s.Parent then s:Destroy() end
            end
        end
    end

    local mesh = tool:FindFirstChild("Default")
    if mesh then
        local children = mesh:GetChildren()
        for i = 1, #children do
            local v = children[i]
            if v.Name == "Handle.R" or v:IsA("Model") or (v:IsA("BasePart") and v.Name ~= "Default") then
                v:Destroy()
            end
        end
        mesh.Transparency = 0
    end

    knifedata[tool] = nil
end

local function applyknife(char, tool, skin)
    local skincfg = knifeskins[skin]
    if not skincfg then return end

    local hum = char:FindFirstChild("Humanoid")
    local rhand = char:FindFirstChild("RightHand")
    if not hum or not rhand then return end

    cleanknife(tool)
    knifedata[tool] = {track = nil, welds = {}, sounds = {}}
    local data = knifedata[tool]

    local mesh = tool:FindFirstChild("Default")
    if not mesh then return end
    mesh.Transparency = 1

    local skinmodules = replicatedstorage:FindFirstChild("SkinModules")
    if not skinmodules then return end
    local knives = skinmodules:FindFirstChild("Knives")
    if not knives then return end

    local skinmodel = knives:FindFirstChild(skin)
    if not skinmodel then return end
    local clone = skinmodel:Clone()
    clone.Name = skin

    local handr = Instance.new("Part")
    handr.Name = "Handle.R"
    handr.Transparency = 1
    handr.CanCollide = false
    handr.Anchored = false
    handr.Size = Vector3.new(0.001, 0.001, 0.001)
    handr.Massless = true
    handr.Parent = mesh

    local m6d = Instance.new("Motor6D")
    m6d.Name = "Handle.R"
    m6d.Part0 = rhand
    m6d.Part1 = handr
    m6d.Parent = handr

    local offset = CFrame.new(skincfg.positionoffset) * CFrame.Angles(math.rad(skincfg.rotationoffset.X), math.rad(skincfg.rotationoffset.Y), math.rad(skincfg.rotationoffset.Z))

    if clone:IsA("Model") then
        if not clone.PrimaryPart then
            local children = clone:GetChildren()
            for i = 1, #children do
                local c = children[i]
                if c:IsA("BasePart") then
                    clone.PrimaryPart = c
                    break
                end
            end
        end
        if clone.PrimaryPart then
            local descendants = clone:GetDescendants()
            for i = 1, #descendants do
                local p = descendants[i]
                if p:IsA("BasePart") then
                    p.CanCollide = false
                    p.Massless = true
                    p.Anchored = false
                    local w = Instance.new("Weld")
                    w.Part0 = handr
                    w.Part1 = p
                    w.C0 = offset
                    w.C1 = p.CFrame:ToObjectSpace(clone.PrimaryPart.CFrame)
                    w.Parent = p
                    table.insert(data.welds, w)
                end
            end
        end
        clone.Parent = mesh
    elseif clone:IsA("BasePart") then
        clone.CanCollide = false
        clone.Massless = true
        clone.Anchored = false

        if clone:IsA("MeshPart") and skincfg.textureid then
            clone.TextureID = skincfg.textureid
        end

        if skincfg.particle then
            local skinassets = replicatedstorage:FindFirstChild("SkinAssets")
            if skinassets then
                local particlefolder = skinassets:FindFirstChild("GunHandleParticle")
                if particlefolder then
                    local particlesource = particlefolder:FindFirstChild(skin)
                    if particlesource then
                        local pe = particlesource:FindFirstChild("ParticleEmitter")
                        if pe then
                            pe:Clone().Parent = clone
                        end
                    end
                end
            end
        end

        clone.Parent = mesh
        local w = Instance.new("Weld")
        w.Part0 = handr
        w.Part1 = clone
        w.C0 = offset
        w.Parent = clone
        table.insert(data.welds, w)
    end

    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = hum
    end
    if skincfg.animationid and skincfg.animationid ~= "" then
        local anim = Instance.new("Animation")
        anim.AnimationId = skincfg.animationid
        local track = animator:LoadAnimation(anim)
        track.Looped = false
        track:Play()
        data.track = track
        anim:Destroy()
        track.Ended:Once(function()
            if data.track == track then
                data.track = nil
            end
            track:Destroy()
        end)
    end
    if skincfg.soundid and skincfg.soundid ~= "" then
        local snd = Instance.new("Sound")
        snd.SoundId = skincfg.soundid
        snd.Parent = workspace
        snd:Play()
        table.insert(data.sounds, snd)
        snd.Ended:Connect(function()
            snd:Destroy()
        end)
    end

    tool:SetAttribute("CurrentKnifeSkin", skin)
end

local toolregistry = {}

local function setuptool(tool)
    if not tool:IsA("Tool") then return end
    if toolregistry[tool] then return end
    toolregistry[tool] = true

    tool.Equipped:Connect(function()
        if not cfg['skins']['enabled'] then return end

        local char = tool.Parent
        if char ~= localplayer.Character then return end

        local skin = cfg['skins']['weapons'][tool.Name]
        if not skin or skin == "" then return end

        if tool.Name == "[Knife]" then
            applyknife(char, tool, skin)
        else
            applygun(tool, skin)
        end
    end)

    tool.Unequipped:Connect(function()
        if tool.Name == "[Knife]" then
            local data = knifedata[tool]
            if not data then return end
            if data.welds then
                for _, w in ipairs(data.welds) do
                    if w then w:Destroy() end
                end
                data.welds = {}
            end
            if data.sounds then
                for _, s in ipairs(data.sounds) do
                    if s and s.Parent then s:Destroy() end
                end
                data.sounds = {}
            end
            local mesh = tool:FindFirstChild("Default")
            if mesh then
                local children = mesh:GetChildren()
                for i = 1, #children do
                    local v = children[i]
                    if v.Name == "Handle.R" or v:IsA("Model") or (v:IsA("MeshPart") and v.Name ~= "Default") then
                        v:Destroy()
                    end
                end
                mesh.Transparency = 0
            end
        end
    end)

    if tool.Parent == localplayer.Character then
        if not cfg['skins']['enabled'] then return end

        local skin = cfg['skins']['weapons'][tool.Name]
        if skin and skin ~= "" then
            if tool.Name == "[Knife]" then
                task.spawn(function()
                    applyknife(localplayer.Character, tool, skin)
                end)
            else
                task.spawn(function()
                    applygun(tool, skin)
                end)
            end
        end
    end
end

local function watchchar(char)
    if not char then return end
    local children = char:GetChildren()
    for i = 1, #children do
        local v = children[i]
        if v:IsA("Tool") then
            setuptool(v)
        end
    end
    char.ChildAdded:Connect(function(v)
        if v:IsA("Tool") then
            setuptool(v)
        end
    end)
end

local function applyheadless(char)
    if not cfg['headless']['enabled'] then return end
    if not char then return end

    local head = char:FindFirstChild("Head")
    if head then
        head.Transparency = 1
        head.CanCollide = false
        local face = head:FindFirstChild("face")
        if face then
            face.Transparency = 1
        end
    end

    if cfg['headless']['remove face accessories'] then
        for _, accessory in ipairs(char:GetChildren()) do
            if accessory:IsA("Accessory") then
                if accessory.AccessoryType == Enum.AccessoryType.Face then
                    local handle = accessory:FindFirstChild("Handle")
                    if handle then
                        handle.Transparency = 1
                        handle.CanCollide = false
                    end
                end
            end
        end
    end

    char.ChildAdded:Connect(function(child)
        if not cfg['headless']['enabled'] then return end
        if child:IsA("Accessory") and child.AccessoryType == Enum.AccessoryType.Face then
            if not cfg['headless']['remove face accessories'] then return end
            local handle = child:FindFirstChild("Handle")
            if not handle then
                handle = child:WaitForChild("Handle", 5)
            end
            if handle then
                handle.Transparency = 1
                handle.CanCollide = false
            end
        end
    end)
end

local function elasticout(t)
    local p = 0.3
    return math.pow(2, -10 * t) * math.sin((t - p / 4) * (2 * math.pi) / p) + 1
end

local function sineinout(t)
    return -(math.cos(math.pi * t) - 1) / 2
end

local function holdingknife()
    if not cfg['settings']['knife check'] then return false end

    local char = localplayer.Character
    if not char then return false end

    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name == "[Knife]" then return true end

    return false
end

local function playerknocked(player)
    if not cfg['settings']['knock check'] then return false end

    if player.Character then
        local bodyeffects = player.Character:FindFirstChild("BodyEffects")
        if bodyeffects then
            local ko = bodyeffects:FindFirstChild("K.O")
            if ko and ko.Value == true then return true end

            local knocked = bodyeffects:FindFirstChild("Knocked")
            if knocked and knocked.Value == true then return true end
        end
    end

    return false
end

local function selfknocked()
    if not cfg['settings']['self knock check'] then return false end

    if localplayer.Character then
        local bodyeffects = localplayer.Character:FindFirstChild("BodyEffects")
        if bodyeffects then
            local ko = bodyeffects:FindFirstChild("K.O")
            if ko and ko.Value == true then return true end

            local knocked = bodyeffects:FindFirstChild("Knocked")
            if knocked and knocked.Value == true then return true end
        end
    end
    return false
end

local function cansee(part)
    if not cfg['settings']['visible check'] then return true end
    if not part or not part.Parent then return false end

    local char = part.Parent
    local origin = camera.CFrame.Position
    local dir = (part.Position - origin).Unit * (part.Position - origin).Magnitude

    rayparams.FilterDescendantsInstances = {localplayer.Character, char, fovparts.silentaim, fovparts.camlock, fovparts.triggerbot}

    local result = workspace:Raycast(origin, dir, rayparams)

    return result == nil or result.Instance:IsDescendantOf(char)
end

local function withindistance(part, distcfg)
    if not distcfg or not distcfg['enabled'] then return true end
    if not part or not part.Parent then return false end

    local char = localplayer.Character
    if not char then return false end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    return (hrp.Position - part.Position).Magnitude <= distcfg['max distance']
end

local function getbodyparts(char)
    return {
        char:FindFirstChild("Head"),
        char:FindFirstChild("UpperTorso"),
        char:FindFirstChild("HumanoidRootPart"),
        char:FindFirstChild("LowerTorso"),
        char:FindFirstChild("LeftUpperArm"),
        char:FindFirstChild("RightUpperArm"),
        char:FindFirstChild("LeftLowerArm"),
        char:FindFirstChild("RightLowerArm"),
        char:FindFirstChild("LeftHand"),
        char:FindFirstChild("RightHand"),
        char:FindFirstChild("LeftUpperLeg"),
        char:FindFirstChild("RightUpperLeg"),
        char:FindFirstChild("LeftLowerLeg"),
        char:FindFirstChild("RightLowerLeg"),
        char:FindFirstChild("LeftFoot"),
        char:FindFirstChild("RightFoot"),
    }
end

local function closestbodypart(char)
    local closestpart = nil
    local shortestdist = math.huge

    local bodyparts = getbodyparts(char)
    local mousepos = uis:GetMouseLocation()

    for _, part in pairs(bodyparts) do
        if part then
            local screenpos, onscreen = camera:WorldToViewportPoint(part.Position)

            if onscreen then
                local dist = math.sqrt(
                    (screenpos.X - mousepos.X)^2 +
                    (screenpos.Y - mousepos.Y)^2
                )

                if dist < shortestdist then
                    shortestdist = dist
                    closestpart = part
                end
            end
        end
    end

    return closestpart
end

local function mouseinfov3d(fovpart)
    if not fovpart.Parent then return false end

    local mpos = uis:GetMouseLocation()
    local ray = camera:ViewportPointToRay(mpos.X, mpos.Y)

    local cf = fovpart.CFrame
    local size = fovpart.Size / 2

    local localorigin = cf:PointToObjectSpace(ray.Origin)
    local localdir = cf:VectorToObjectSpace(ray.Direction * 1000)

    local tmin, tmax = -math.huge, math.huge

    for _, axis in ipairs({"X", "Y", "Z"}) do
        local o = localorigin[axis]
        local d = localdir[axis]
        local s = size[axis]

        if math.abs(d) < 1e-8 then
            if o < -s or o > s then return false end
        else
            local t1 = (-s - o) / d
            local t2 = ( s - o) / d
            if t1 > t2 then t1, t2 = t2, t1 end
            tmin = math.max(tmin, t1)
            tmax = math.min(tmax, t2)
            if tmin > tmax then return false end
        end
    end

    return tmax > 0
end

local function partinfov3d(part, fovcfg)
    if not fovcfg['enabled'] then return true end

    local char = part.Parent
    if not char then return false end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local sx = fovcfg['size']['x']
    local sy = fovcfg['size']['y']
    local sz = fovcfg['size']['z']

    local fovsize = hrp.Size + Vector3.new(sx, sy, sz)
    local fovcf = hrp.CFrame

    local mpos = uis:GetMouseLocation()
    local ray = camera:ViewportPointToRay(mpos.X, mpos.Y)

    local cf = fovcf
    local size = fovsize / 2

    local localorigin = cf:PointToObjectSpace(ray.Origin)
    local localdir = cf:VectorToObjectSpace(ray.Direction * 1000)

    local tmin, tmax = -math.huge, math.huge

    for _, axis in ipairs({"X", "Y", "Z"}) do
        local o = localorigin[axis]
        local d = localdir[axis]
        local s = size[axis]

        if math.abs(d) < 1e-8 then
            if o < -s or o > s then return false end
        else
            local t1 = (-s - o) / d
            local t2 = ( s - o) / d
            if t1 > t2 then t1, t2 = t2, t1 end
            tmin = math.max(tmin, t1)
            tmax = math.min(tmax, t2)
            if tmin > tmax then return false end
        end
    end

    return tmax > 0
end

local function mouseinfovconfig(fovcfg, targetpart)
    if not fovcfg['enabled'] then return true end
    if not targetpart or not targetpart.Parent then return false end
    if fovcfg['mode'] == '2D' then
        local char = targetpart.Parent
        if not char then return false end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end
        local sx = (hrp.Size.X + fovcfg['size']['x']) / 2
        local sy = (hrp.Size.Y + fovcfg['size']['y']) / 2
        local sz = (hrp.Size.Z + fovcfg['size']['z']) / 2
        local cf = hrp.CFrame
        local offsets = {
            Vector3.new( sx,  sy,  sz), Vector3.new(-sx,  sy,  sz),
            Vector3.new( sx, -sy,  sz), Vector3.new(-sx, -sy,  sz),
            Vector3.new( sx,  sy, -sz), Vector3.new(-sx,  sy, -sz),
            Vector3.new( sx, -sy, -sz), Vector3.new(-sx, -sy, -sz),
        }
        local minx, miny =  math.huge,  math.huge
        local maxx, maxy = -math.huge, -math.huge
        local valid = false
        for _, offset in ipairs(offsets) do
            local screen = camera:WorldToViewportPoint(cf:PointToWorldSpace(offset))
            if screen.Z > 0 then
                valid = true
                if screen.X < minx then minx = screen.X end
                if screen.Y < miny then miny = screen.Y end
                if screen.X > maxx then maxx = screen.X end
                if screen.Y > maxy then maxy = screen.Y end
            end
        end
        if not valid then return false end
        local mpos = uis:GetMouseLocation()
        return mpos.X >= minx and mpos.X <= maxx and mpos.Y >= miny and mpos.Y <= maxy
    end
    return partinfov3d(targetpart, fovcfg)
end

local function getscreenbounds2d(hrp, fovcfg)
    local sx = (hrp.Size.X + fovcfg['size']['x']) / 2
    local sy = (hrp.Size.Y + fovcfg['size']['y']) / 2
    local sz = (hrp.Size.Z + fovcfg['size']['z']) / 2
    local cf = hrp.CFrame
    local offsets = {
        Vector3.new( sx,  sy,  sz), Vector3.new(-sx,  sy,  sz),
        Vector3.new( sx, -sy,  sz), Vector3.new(-sx, -sy,  sz),
        Vector3.new( sx,  sy, -sz), Vector3.new(-sx,  sy, -sz),
        Vector3.new( sx, -sy, -sz), Vector3.new(-sx, -sy, -sz),
    }
    local minx, miny =  math.huge,  math.huge
    local maxx, maxy = -math.huge, -math.huge
    local valid = false
    for _, offset in ipairs(offsets) do
        local screen = camera:WorldToViewportPoint(cf:PointToWorldSpace(offset))
        if screen.Z > 0 then
            valid = true
            if screen.X < minx then minx = screen.X end
            if screen.Y < miny then miny = screen.Y end
            if screen.X > maxx then maxx = screen.X end
            if screen.Y > maxy then maxy = screen.Y end
        end
    end
    if not valid then return nil, nil end
    return Vector2.new(minx, miny), Vector2.new(maxx, maxy)
end

local function setbox2d(lines, tl, br, color)
    lines[1].From = tl
    lines[1].To   = Vector2.new(br.X, tl.Y)
    lines[2].From = Vector2.new(tl.X, br.Y)
    lines[2].To   = br
    lines[3].From = tl
    lines[3].To   = Vector2.new(tl.X, br.Y)
    lines[4].From = Vector2.new(br.X, tl.Y)
    lines[4].To   = br
    for _, l in ipairs(lines) do
        l.Color   = color
        l.Visible = true
    end
end

local function hidebox2d(lines)
    for _, l in ipairs(lines) do
        l.Visible = false
    end
end

local function findtarget(fovcfg, distcfg, knifecheck)
    if knifecheck and holdingknife() then return nil end

    local besttarget = nil
    local bestdist = math.huge
    local mpos = uis:GetMouseLocation()

    for _, player in pairs(players:GetPlayers()) do
        if player ~= localplayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not playerknocked(player) then
                local char = player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then continue end

                local screenpos, onscreen = camera:WorldToViewportPoint(hrp.Position)
                if not onscreen then continue end

                if fovcfg and fovcfg['enabled'] and not mouseinfovconfig(fovcfg, hrp) then continue end
                if not cansee(hrp) then continue end
                if not withindistance(hrp, distcfg) then continue end

                local dist = math.sqrt(
                    (screenpos.X - mpos.X)^2 +
                    (screenpos.Y - mpos.Y)^2
                )

                if dist < bestdist then
                    bestdist = dist
                    besttarget = hrp
                end
            end
        end
    end

    if besttarget then
        local char = besttarget.Parent
        local hitpart = cfg['silent aimbot']['hitpart']
        if hitpart == 'Closest Part' then
            return closestbodypart(char) or besttarget
        end
        return char:FindFirstChild(hitpart) or closestbodypart(char) or besttarget
    end

    return nil
end

local function predictedpos(part, config)
    if not config['use prediction'] then return part.Position end

    local vel = part.AssemblyLinearVelocity
    local prediction = config['prediction']

    local predval
    if type(prediction) == "table" then
        predval = prediction['x'] or prediction['y'] or prediction['z'] or 0.133
    else
        predval = (prediction == 0) and 0.133 or prediction
    end

    return part.Position + Vector3.new(
        vel.X * predval,
        vel.Y * predval,
        vel.Z * predval
    )
end

local function getsilentaimpoint()
    if not cfg['silent aimbot']['enabled'] then return nil end
    if not silentaimactive then return nil end
    if not currenttarget or not currenttarget.Parent then return nil end

    local player = players:GetPlayerFromCharacter(currenttarget.Parent)
    if not player then return nil end
    if playerknocked(player) then return nil end
    if not cansee(currenttarget) then return nil end
    if not withindistance(currenttarget, cfg['silent aimbot']['distance check']) then return nil end
    if cfg['silent aimbot']['fov']['enabled'] and not mouseinfovconfig(cfg['silent aimbot']['fov'], currenttarget) then
        return nil
    end

    return predictedpos(currenttarget, cfg['silent aimbot'])
end

local function writemousepos(pos)
    local sources = {}
    local char = localplayer.Character
    if char then
        table.insert(sources, char)
    end
    local wp = workspace:FindFirstChild("Players")
    local model = wp and wp:FindFirstChild(localplayer.Name)
    if model then
        table.insert(sources, model)
    end

    for _, root in ipairs(sources) do
        local be = root:FindFirstChild("BodyEffects")
        local mp = be and be:FindFirstChild("MousePos")
        if mp and mp:IsA("Vector3Value") then
            pcall(function()
                mp.Value = pos
            end)
        end
    end
end

local function getcamlocktarget()
    if camlockactive and currenttarget then
        local player = players:GetPlayerFromCharacter(currenttarget.Parent)
        if player and not playerknocked(player) then
            local targetpart = nil

            if cfg['camera aimbot']['hitpart'] == 'Closest Part' then
                local now = tick()
                if now - lasttargetscan >= scanrate then
                    lasttargetscan = now
                    targetpart = closestbodypart(currenttarget.Parent)
                    if targetpart then
                        currenttarget = targetpart
                    end
                else
                    targetpart = currenttarget
                end
            else
                targetpart = currenttarget.Parent:FindFirstChild(cfg['camera aimbot']['hitpart'])
            end

            if targetpart then
                if cansee(targetpart) and withindistance(targetpart, cfg['camera aimbot']['distance check']) then
                    lastvisibletarget = targetpart
                    return targetpart
                else
                    return nil
                end
            end
        else
            currenttarget = nil
            camlockactive = false
            lastvisibletarget = nil
            targetline.Visible = false
            return nil
        end

        return nil
    else
        return findtarget(cfg['camera aimbot']['fov'], cfg['camera aimbot']['distance check'], true)
    end
end

local function applycamlock()
    if not camlockactive then return end

    if selfknocked() then
        currenttarget = nil
        camlockactive = false
        lastvisibletarget = nil
        targetline.Visible = false
        return
    end

    if holdingknife() then return end

    if cfg['camera aimbot']['fov']['enabled'] and currenttarget and not mouseinfovconfig(cfg['camera aimbot']['fov'], currenttarget) then
        return
    end

    local target = getcamlocktarget()

    if target then
        local targetpos = predictedpos(target, cfg['camera aimbot'])

        local camcf = camera.CFrame
        local targetcf = CFrame.new(camcf.Position, targetpos)

        local smoothcfg = cfg['camera aimbot']['smoothing']
        local bax = 1 / smoothcfg['x']
        local bay = 1 / smoothcfg['y']
        local baz = 1 / smoothcfg['z']

        local eax = elasticout(math.min(bax, 1))
        local eay = elasticout(math.min(bay, 1))
        local eaz = elasticout(math.min(baz, 1))

        local avgea = (eax + eay + eaz) / 3
        local avgba = (bax + bay + baz) / 3

        local smoothcf = camcf:Lerp(targetcf, avgea * avgba)

        local sinea = sineinout(math.min(avgba, 1))
        camera.CFrame = smoothcf:Lerp(targetcf, sinea * avgba)
    else
        if lastvisibletarget then
            local player = players:GetPlayerFromCharacter(lastvisibletarget.Parent)
            if player and not playerknocked(player) then
                local tp = lastvisibletarget
                if tp and cansee(tp) and withindistance(tp, cfg['camera aimbot']['distance check']) then
                    currenttarget = lastvisibletarget
                end
            end
        end
    end
end

local function updatefovbox(fovpart, lines2d, fovcfg, isactive)
    if not fovcfg['enabled'] then
        fovpart.Transparency = 1
        hidebox2d(lines2d)
        return
    end

    if isactive and currenttarget and currenttarget.Parent then
        local char = currenttarget.Parent
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if hrp then
            local sx = fovcfg['size']['x']
            local sy = fovcfg['size']['y']
            local sz = fovcfg['size']['z']

            if fovcfg['mode'] == '2D' then
                fovpart.Transparency = 1
                if fovcfg['visible'] then
                    local tl, br = getscreenbounds2d(hrp, fovcfg)
                    if tl and br then
                        local mpos = uis:GetMouseLocation()
                        local inside = mpos.X >= tl.X and mpos.X <= br.X
                                   and mpos.Y >= tl.Y and mpos.Y <= br.Y
                        local color = inside and fovcfg['active color'] or Color3.fromRGB(150, 150, 150)
                        setbox2d(lines2d, tl, br, color)
                    else
                        hidebox2d(lines2d)
                    end
                else
                    hidebox2d(lines2d)
                end
            else
                hidebox2d(lines2d)
                fovpart.Size = hrp.Size + Vector3.new(sx, sy, sz)
                fovpart.CFrame = hrp.CFrame

                if fovcfg['visible'] then
                    fovpart.Transparency = 0.85
                    if mouseinfov3d(fovpart) then
                        fovpart.BrickColor = BrickColor.new(fovcfg['active color'])
                    else
                        fovpart.BrickColor = BrickColor.new("Grey")
                    end
                else
                    fovpart.Transparency = 1
                end
            end
        else
            fovpart.Transparency = 1
            hidebox2d(lines2d)
        end
    else
        fovpart.Transparency = 1
        hidebox2d(lines2d)
    end
end

local function updatetargetline()
    if not cfg['target line']['enabled'] then
        targetline.Visible = false
        return
    end

    if not currenttarget or not currenttarget.Parent or (not silentaimactive and not camlockactive) then
        targetline.Visible = false
        return
    end

    local char = currenttarget.Parent
    local hrp = char:FindFirstChild("HumanoidRootPart")

    if not hrp then
        targetline.Visible = false
        return
    end

    local screenpos, onscreen = camera:WorldToViewportPoint(hrp.Position)

    if onscreen and screenpos.Z > 0 then
        local mpos = uis:GetMouseLocation()

        targetline.From = Vector2.new(mpos.X, mpos.Y)
        targetline.To = Vector2.new(screenpos.X, screenpos.Y)
        targetline.Thickness = cfg['target line']['thickness']
        targetline.Transparency = cfg['target line']['transparency']

        if cansee(currenttarget) then
            targetline.Color = cfg['target line']['vulnerable']
        else
            targetline.Color = cfg['target line']['invulnerable']
        end

        targetline.Visible = true
    else
        targetline.Visible = false
    end
end

local function triggerbot()
    if not cfg['trigger bot']['enabled'] then return end
    if not triggerenabled then return end
    if holdingknife() then return end
    if tick() - lasttriggerclick < cfg['trigger bot']['delay'] then return end
    if cfg['trigger bot']['require target'] and not currenttarget then return end

    if currenttarget then
        local char = currenttarget.Parent
        if not char then return end

        local player = players:GetPlayerFromCharacter(char)
        if not player then return end

        if playerknocked(player) then return end
        if not cansee(currenttarget) then return end
        if not withindistance(currenttarget, cfg['trigger bot']['distance check']) then return end
        if cfg['trigger bot']['fov']['enabled'] and not mouseinfovconfig(cfg['trigger bot']['fov'], currenttarget) then return end
    end

    local tool = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Tool")
    if not tool then return end

    if cfg['trigger bot']['specific weapons']['enabled'] then
        local valid = false
        for _, wname in pairs(cfg['trigger bot']['specific weapons']['weapons']) do
            local clean = wname:gsub("%[", ""):gsub("%]", "")
            if tool.Name == wname or tool.Name:find(clean) then
                valid = true
                break
            end
        end
        if not valid then return end
    end

    tool:Activate()
    lasttriggerclick = tick()
end

local function getrapidgun()
    local char = localplayer.Character
    if not char then return nil end
    for _, tool in next, char:GetChildren() do
        if tool:IsA("Tool") and tool:FindFirstChild("Ammo") then
            return tool
        end
    end
    return nil
end

local function patchtool(tool)
    pcall(function()
        for _, conn in pairs(getconnections(tool.Activated)) do
            local info = debug.getinfo(conn.Function)
            for i = 1, info.nups do
                local val = debug.getupvalue(conn.Function, i)
                if type(val) == "number" then
                    debug.setupvalue(conn.Function, i, 0)
                end
            end
        end
    end)
end

local function oncharrapidfire(char)
    isfiring = false
    char.ChildAdded:Connect(function(tool)
        if tool:IsA("Tool") and cfg['rapid fire']['enabled'] then
            patchtool(tool)
        end
    end)
end

local function rapidfire()
    if not cfg['rapid fire']['enabled'] then
        isfiring = false
        return
    end

    if not isfiring then return end

    local gun = getrapidgun()
    if not gun then return end

    -- The server enforces each gun's ShootingCooldown and ammo on its side;
    -- shots activated faster than that play VFX locally but deal NO damage
    -- (ghost shots). Pace to the server-accepted rate so every shot registers.
    -- Fire at the exact server cooldown. RenderStepped naturally advances to
    -- the first frame at or after this threshold.
    local cooldown = 0
    local cd = gun:FindFirstChild("ShootingCooldown")
    if cd and type(cd.Value) == "number" then
        cooldown = cd.Value
    end
    local delay = cfg['rapid fire']['delay']
    if type(delay) ~= "number" or delay ~= delay then delay = 0 end
    delay = math.max(delay, cooldown)
    if tick() - lastrapidfire < delay then return end

    -- Out of ammo: the gun's own client script drops the shot anyway,
    -- so don't burn the pacing window on a guaranteed ghost shot.
    local ammo = gun:FindFirstChild("Ammo")
    if ammo and ammo.Value < 1 then return end

    if cfg['rapid fire']['specific weapons']['enabled'] then
        local valid = false
        for _, wname in pairs(cfg['rapid fire']['specific weapons']['weapons']) do
            local clean = wname:gsub("%[", ""):gsub("%]", "")
            if gun.Name == wname or gun.Name:find(clean) then
                valid = true
                break
            end
        end
        if not valid then
            isfiring = false
            return
        end
    end

    gun:Activate()
    lastrapidfire = tick()
end

local function ensureesp(player)
    local esp = esplabels[player.UserId]
    if esp then return esp end

    esp = {
        player = player,
        nametag = Drawing.new("Text"),
        corners = {},
    }

    esp.nametag.Size = 14
    esp.nametag.Center = true
    esp.nametag.Outline = true
    esp.nametag.OutlineColor = Color3.fromRGB(0, 0, 0)
    esp.nametag.Color = cfg['esp']['color']
    esp.nametag.Font = Drawing.Fonts.UI
    esp.nametag.Visible = false
    esp.nametag.ZIndex = 1000

    for i = 1, 8 do
        local line = Drawing.new("Line")
        line.Thickness = 1
        line.Transparency = 1
        line.Color = cfg['esp']['color']
        line.Visible = false
        line.ZIndex = 999
        esp.corners[i] = line
    end

    esplabels[player.UserId] = esp
    return esp
end

local function clearesp(userid)
    local esp = esplabels[userid]
    if not esp then return end
    pcall(function() esp.nametag:Remove() end)
    for _, line in ipairs(esp.corners or {}) do
        pcall(function() line:Remove() end)
    end
    esplabels[userid] = nil
end

local function hideesp(esp)
    esp.nametag.Visible = false
    for _, line in ipairs(esp.corners or {}) do
        line.Visible = false
    end
end

local function refreshesp()
    if not cfg['esp']['enabled'] then
        for userid in pairs(esplabels) do
            clearesp(userid)
        end
        return
    end

    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localplayer then
            ensureesp(player)
        end
    end

    for userid, esp in pairs(esplabels) do
        local player = esp.player
        if not player or not player.Parent then
            clearesp(userid)
            continue
        end

        local char = player.Character
        if not (char and char.Parent and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Head")) then
            hideesp(esp)
            continue
        end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 or playerknocked(player) then
            hideesp(esp)
            continue
        end

        local head = char.Head
        local hrp = char.HumanoidRootPart
        local hrpScreen, onScreen = camera:WorldToViewportPoint(hrp.Position)
        if not onScreen or hrpScreen.Z <= 0 then
            hideesp(esp)
            continue
        end

        local isTarget = currenttarget and currenttarget.Parent == char
        local color = isTarget and cfg['esp']['target color'] or cfg['esp']['color']

        -- Exile-style name ESP (bottom of body by default)
        local nameWorld
        if cfg['esp']['name above'] then
            nameWorld = head.Position + Vector3.new(0, 1.2, 0)
        else
            nameWorld = hrp.Position - Vector3.new(0, 3, 0)
        end
        local namePos = camera:WorldToViewportPoint(nameWorld)
        esp.nametag.Text = cfg['esp']['use display name'] and player.DisplayName or player.Name
        esp.nametag.Color = color
        esp.nametag.Position = Vector2.new(namePos.X, namePos.Y)
        esp.nametag.Visible = namePos.Z > 0

        -- Corner box (old exile DrawESP style)
        local top = camera:WorldToViewportPoint(hrp.Position + Vector3.new(0, 2.6, 0))
        local bottom = camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
        local charSize = math.abs(top.Y - bottom.Y) / 2
        if charSize < 4 then charSize = 4 end

        local boxWidth = math.floor(charSize * 1.1)
        local boxHeight = math.floor(charSize * 1.9)
        local boxPos = Vector2.new(hrpScreen.X - boxWidth / 2, hrpScreen.Y - boxHeight / 2)
        local lw = boxWidth / 5
        local lh = boxHeight / 6
        local t = 2

        local c = esp.corners
        c[1].From = Vector2.new(boxPos.X - t, boxPos.Y - t)
        c[1].To = Vector2.new(boxPos.X + lw, boxPos.Y - t)
        c[2].From = Vector2.new(boxPos.X - t, boxPos.Y - t)
        c[2].To = Vector2.new(boxPos.X - t, boxPos.Y + lh)

        c[3].From = Vector2.new(boxPos.X + boxWidth - lw, boxPos.Y - t)
        c[3].To = Vector2.new(boxPos.X + boxWidth + t, boxPos.Y - t)
        c[4].From = Vector2.new(boxPos.X + boxWidth + t, boxPos.Y - t)
        c[4].To = Vector2.new(boxPos.X + boxWidth + t, boxPos.Y + lh)

        c[5].From = Vector2.new(boxPos.X - t, boxPos.Y + boxHeight - lh)
        c[5].To = Vector2.new(boxPos.X - t, boxPos.Y + boxHeight + t)
        c[6].From = Vector2.new(boxPos.X - t, boxPos.Y + boxHeight + t)
        c[6].To = Vector2.new(boxPos.X + lw, boxPos.Y + boxHeight + t)

        c[7].From = Vector2.new(boxPos.X + boxWidth - lw, boxPos.Y + boxHeight + t)
        c[7].To = Vector2.new(boxPos.X + boxWidth + t, boxPos.Y + boxHeight + t)
        c[8].From = Vector2.new(boxPos.X + boxWidth + t, boxPos.Y + boxHeight + t)
        c[8].To = Vector2.new(boxPos.X + boxWidth + t, boxPos.Y + boxHeight - lh)

        for _, line in ipairs(c) do
            line.Color = color
            line.Visible = true
        end
    end
end

local function touchingwall()
    local char = localplayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local params = RaycastParams.new()
    params.FilterDescendantsInstances = {char}
    params.FilterType = Enum.RaycastFilterType.Exclude

    local dirs = {
        hrp.CFrame.LookVector * 2.5,
        -hrp.CFrame.LookVector * 2.5,
        hrp.CFrame.RightVector * 2.5,
        -hrp.CFrame.RightVector * 2.5
    }

    for _, dir in pairs(dirs) do
        if workspace:Raycast(hrp.Position, dir, params) then
            return true
        end
    end

    return false
end

local function getjumppower()
    local char = localplayer.Character
    if not char then return cfg['spiderman']['jumppower'] end

    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tool.Name == "[Knife]" then
        return cfg['spiderman']['knifejumppower']
    end

    return cfg['spiderman']['jumppower']
end

local function setupwalljumpreset()
    if walljumpconnection then
        walljumpconnection:Disconnect()
        walljumpconnection = nil
    end

    haswalljumped = false

    local char = localplayer.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        task.wait(0.5)
        hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
    end

    walljumpconnection = hum.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Landed or
           new == Enum.HumanoidStateType.Running or
           new == Enum.HumanoidStateType.RunningNoPhysics or
           new == Enum.HumanoidStateType.Jumping then
            haswalljumped = false
        end
    end)
end

local function oncharspiderman(char)
    haswalljumped = false
    task.wait(0.1)
    setupwalljumpreset()
end

local function silentaimindex(self, key, oldindex)
    if checkcaller() or self ~= mouse or not cfg['silent aimbot']['enabled'] then
        return oldindex(self, key)
    end

    if cfg['targeting']['mode'] == 'Automatic' then
        silentaimactive = currenttarget ~= nil
    end

    local predpos = getsilentaimpoint()
    if not predpos then
        return oldindex(self, key)
    end

    -- This place's GunHandler / MainModule read UnitRay + BodyEffects.MousePos,
    -- not only Mouse.Hit — redirect all of them.
    if key == "Hit" or key == "hit" then
        return CFrame.new(predpos)
    end

    if key == "Target" or key == "target" then
        return currenttarget
    end

    if key == "UnitRay" or key == "unitRay" then
        local mpos = uis:GetMouseLocation()
        local viewport = camera:ViewportPointToRay(mpos.X, mpos.Y)
        local origin = viewport.Origin
        local dir = (predpos - origin)
        if dir.Magnitude < 0.001 then
            dir = viewport.Direction
        else
            dir = dir.Unit
        end
        return Ray.new(origin, dir)
    end

    return oldindex(self, key)
end

if hookmetamethod then
    local oldindex
    oldindex = hookmetamethod(game, "__index", LPH_NO_VIRTUALIZE(function(self, key)
        return silentaimindex(self, key, oldindex)
    end))
else
    local grm = getrawmetatable(game)
    local oldindex = grm.__index
    setreadonly(grm, false)

    grm.__index = LPH_NO_VIRTUALIZE(function(self, key)
        return silentaimindex(self, key, oldindex)
    end)
end

-- Real Da Hood gun silent aim.
--
-- Guns fire through the tool's GunClient like this:
--   local dir = GunHandler.getAim(muzzlePos)              -- reads the RAW mouse screen pos
--   local aim = muzzlePos + dir * 200
--   local hit = GunHandler.shoot({ AimPosition = aim, ... }) -- raycasts, returns the hit instance
--   MainEvent:FireServer("ShootGun", Handle, muzzlePos, hit, hitPos, normal)
--
-- The SERVER independently re-derives the shot direction from BodyEffects.MousePos.Value
-- (see ReplicatedStorage.RemoteFunction: (MousePos.Value - origin).unit). If the client's
-- hit/direction disagrees with MousePos.Value the shot is rejected => "no damage".
--
-- Therefore silent aim MUST keep getAim, shoot's raycast AND MousePos all pointing at the
-- SAME target point. getAim/Mouse.Hit hooks alone are NOT enough on this place.
do
    local function isLocalShooter(shooter)
        local char = localplayer.Character
        if not char then return false end
        if shooter == char then return true end
        if typeof(shooter) == "Instance" and shooter:IsDescendantOf(char) then return true end
        return false
    end

    local function isLocalOrigin(origin)
        local char = localplayer.Character
        if not (char and typeof(origin) == "Vector3") then return false end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp and (hrp.Position - origin).Magnitude <= 30 then
            return true
        end
        local tool = char:FindFirstChildWhichIsA("Tool")
        local handle = tool and tool:FindFirstChild("Handle")
        if handle and (handle.Position - origin).Magnitude <= 25 then
            return true
        end
        return false
    end

    -- Returns the (predicted) silent-aim world point or nil, and keeps
    -- BodyEffects.MousePos synced so the server's own aim check agrees with us.
    local function silentPoint()
        if not cfg['silent aimbot']['enabled'] then return nil end
        if cfg['targeting']['mode'] == 'Automatic' then
            if not currenttarget or not currenttarget.Parent then
                currenttarget = findtarget(cfg['silent aimbot']['fov'], cfg['silent aimbot']['distance check'], false)
            end
            silentaimactive = currenttarget ~= nil
        end
        local hit = getsilentaimpoint()
        if hit then
            writemousepos(hit)
        end
        return hit
    end

    -- Hook GunHandler.getAim so the gun aims at the target instead of the mouse.
    -- getAim(origin[, range]) must return (unitDirection, magnitude).
    pcall(function()
        local modules = replicatedstorage:FindFirstChild("Modules")
        local mod = modules and modules:FindFirstChild("GunHandler")
        if not mod then return end
        local GunHandler = require(mod)
        if type(GunHandler) ~= "table" then return end

        local getAimKey = type(GunHandler.getAim) == "function" and "getAim" or "GetAim"
        if type(GunHandler[getAimKey]) == "function" then
            local originalGetAim = GunHandler.__EchoOriginalGetAim or GunHandler[getAimKey]
            GunHandler.__EchoOriginalGetAim = originalGetAim
            GunHandler[getAimKey] = LPH_NO_VIRTUALIZE(function(origin, ...)
                if isLocalOrigin(origin) then
                    local hit = silentPoint()
                    if hit then
                        local delta = hit - origin
                        if delta.Magnitude > 0.001 then
                            return delta.Unit, delta.Magnitude
                        end
                    end
                end
                return originalGetAim(origin, ...)
            end)
        end

        -- shoot() builds the bullet raycast from ForcedOrigin toward AimPosition and
        -- returns the hit instance that gets sent to the server. Force AimPosition to
        -- run through the target so the returned hit instance is the target.
        local shootKey = type(GunHandler.shoot) == "function" and "shoot" or "Shoot"
        if type(GunHandler[shootKey]) == "function" then
            local originalShoot = GunHandler.__EchoOriginalShoot or GunHandler[shootKey]
            GunHandler.__EchoOriginalShoot = originalShoot
            GunHandler[shootKey] = LPH_NO_VIRTUALIZE(function(args)
                if type(args) == "table" and isLocalShooter(args.Shooter or args.shooter) then
                    local hit = silentPoint()
                    if hit then
                        local origin = args.ForcedOrigin
                        if typeof(origin) ~= "Vector3" then
                            local handle = args.Handle
                            if typeof(handle) == "Instance" then
                                local muzzle = handle:FindFirstChild("Muzzle")
                                origin = (muzzle and muzzle.WorldPosition) or handle.Position
                            end
                        end
                        if typeof(origin) == "Vector3" then
                            local delta = hit - origin
                            if delta.Magnitude > 0.001 then
                                -- aim slightly past the target so the ray lands on the part
                                args.AimPosition = origin + delta.Unit * (delta.Magnitude + 6)
                            else
                                args.AimPosition = hit
                            end
                        else
                            args.AimPosition = hit
                        end
                        args.aimPosition = args.AimPosition
                    end
                end
                return originalShoot(args)
            end)
        end
    end)

    -- Keep BodyEffects.MousePos pinned to the target every frame (after the game's own
    -- writers) so the server-side aim check stays consistent between shots.
    pcall(function()
        runservice:BindToRenderStep("EchoSilentMousePos", Enum.RenderPriority.Last.Value, LPH_NO_VIRTUALIZE(function()
            silentPoint()
        end))
    end)

    runservice.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
        silentPoint()
    end))
end

local oldrandom
oldrandom = hookfunction(math.random, LPH_NO_VIRTUALIZE(function(...)
    local args = {...}
    if checkcaller() then
        return oldrandom(...)
    end

    if (#args == 0) or (args[1] == -0.05 and args[2] == 0.05) or (args[1] == -0.1) or (args[1] == -0.05) then
        if cfg['spread modifications']['enabled'] then
            if cfg['spread modifications']['specific weapons']['enabled'] then
                local tool = localplayer.Character and localplayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    local wname = tool.Name
                    local found = false

                    for _, weapon in pairs(cfg['spread modifications']['specific weapons']['weapons']) do
                        if wname == weapon then
                            found = true
                            break
                        end
                    end

                    if found then
                        return oldrandom(...) * (cfg['spread modifications']['amount'] / 100)
                    end
                end
            else
                return oldrandom(...) * (cfg['spread modifications']['amount'] / 100)
            end
        end
    end

    return oldrandom(...)
end))

local function addesp(player)
    if player == localplayer then return end
    if not cfg['esp']['enabled'] then return end
    ensureesp(player)
end

local function removeesp(player)
    clearesp(player.UserId)
end

for _, player in pairs(players:GetPlayers()) do
    if player ~= localplayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        addesp(player)
    end

    player.CharacterAdded:Connect(function(char)
        removeesp(player)
        char:WaitForChild("HumanoidRootPart")
        task.wait(0.1)
        addesp(player)
    end)

    player.CharacterRemoving:Connect(function()
        removeesp(player)
    end)
end

players.PlayerAdded:Connect(function(player)
    if player ~= localplayer then
        player.CharacterAdded:Connect(function(char)
            removeesp(player)
            char:WaitForChild("HumanoidRootPart")
            task.wait(0.1)
            addesp(player)
        end)

        player.CharacterRemoving:Connect(function()
            removeesp(player)
        end)
    end
end)

players.PlayerRemoving:Connect(function(player)
    removeesp(player)
end)

if localplayer.Character then
    watchchar(localplayer.Character)
    oncharspiderman(localplayer.Character)
    applyheadless(localplayer.Character)
    oncharrapidfire(localplayer.Character)
end

localplayer.CharacterAdded:Connect(function(char)
    speedenabled = false
    watchchar(char)
    oncharspiderman(char)
    oncharrapidfire(char)
    task.defer(function()
        applyheadless(char)
    end)
end)

local backpacktools = localplayer.Backpack:GetChildren()
for i = 1, #backpacktools do
    local v = backpacktools[i]
    if v:IsA("Tool") then
        setuptool(v)
    end
end

localplayer.Backpack.ChildAdded:Connect(function(v)
    if v:IsA("Tool") then
        setuptool(v)
    end
end)

task.spawn(function()
    while task.wait(2) do
        if localplayer.Character then
            local hum = localplayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and not walljumpconnection then
                setupwalljumpreset()
            end
        end
    end
end)

uis.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.Space then
        if cfg['spiderman']['enabled'] then
            local char = localplayer.Character
            if char then
                local hum = char:FindFirstChild("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hum and hrp then
                    local state = hum:GetState()
                    if state == Enum.HumanoidStateType.Freefall and touchingwall() and not haswalljumped then
                        haswalljumped = true
                        local power = getjumppower()
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                        local elapsed = 0
                        task.spawn(function()
                            while elapsed < 0.1 do
                                local dt = task.wait()
                                elapsed = elapsed + dt
                                if hrp and hrp.Parent then
                                    hrp.AssemblyLinearVelocity = Vector3.new(
                                        hrp.AssemblyLinearVelocity.X,
                                        power,
                                        hrp.AssemblyLinearVelocity.Z
                                    )
                                end
                            end
                        end)
                    end
                end
            end
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['silent aim']] then
        if cfg['targeting']['mode'] == 'Select' then
            if cfg['silent aimbot']['mode'] == 'Toggle' then
                silentaimactive = not silentaimactive
                if not silentaimactive then
                    if not camlockactive then
                        currenttarget = nil
                        lastvisibletarget = nil
                        targetline.Visible = false
                    end
                else
                    local target = findtarget(cfg['silent aimbot']['fov'], cfg['silent aimbot']['distance check'], false)
                    if target then
                        currenttarget = target
                        lastvisibletarget = target
                        updatefovbox(fovparts.silentaim, fov2dboxes.silentaim, cfg['silent aimbot']['fov'], true)
                    end
                end
            elseif cfg['silent aimbot']['mode'] == 'Hold' then
                local target = findtarget(cfg['silent aimbot']['fov'], cfg['silent aimbot']['distance check'], false)
                if target then
                    currenttarget = target
                    lastvisibletarget = target
                    silentaimactive = true
                    updatefovbox(fovparts.silentaim, fov2dboxes.silentaim, cfg['silent aimbot']['fov'], true)
                end
            end
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['cam lock']] then
        if cfg['camera aimbot']['mode'] == 'Toggle' then
            if camlockactive then
                camlockactive = false
                if not silentaimactive and cfg['targeting']['mode'] ~= 'Automatic' then
                    currenttarget = nil
                    lastvisibletarget = nil
                    targetline.Visible = false
                end
            else
                local target = findtarget(cfg['camera aimbot']['fov'], cfg['camera aimbot']['distance check'], true)
                if target then
                    currenttarget = target
                    lastvisibletarget = target
                    camlockactive = true
                    updatefovbox(fovparts.camlock, fov2dboxes.camlock, cfg['camera aimbot']['fov'], true)
                end
            end
        elseif cfg['camera aimbot']['mode'] == 'Hold' then
            local target = findtarget(cfg['camera aimbot']['fov'], cfg['camera aimbot']['distance check'], true)
            if target then
                currenttarget = target
                lastvisibletarget = target
                camlockactive = true
                updatefovbox(fovparts.camlock, fov2dboxes.camlock, cfg['camera aimbot']['fov'], true)
            end
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['triggerbot']] then
        if cfg['trigger bot']['mode'] == 'Toggle' then
            triggerenabled = not triggerenabled
        elseif cfg['trigger bot']['mode'] == 'Hold' then
            triggerenabled = true
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['super jump']] then
        if cfg['super jump']['enabled'] then
            superjumpenabled = not superjumpenabled
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['esp']] then
        cfg['esp']['enabled'] = not cfg['esp']['enabled']
        if cfg['esp']['enabled'] then
            for _, player in pairs(players:GetPlayers()) do
                if player ~= localplayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    if not esplabels[player.UserId] then
                        addesp(player)
                    end
                end
            end
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['speed']] then
        if cfg['speed modifications']['enabled'] then
            speedenabled = not speedenabled
        end
    end

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        if cfg['rapid fire']['enabled'] then
            local gun = getrapidgun()
            if gun then
                isfiring = true
            end
        end
    end
end)

uis.InputEnded:Connect(function(input, processed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        isfiring = false
    end

    if processed then return end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['silent aim']] then
        if cfg['targeting']['mode'] == 'Select' then
            if cfg['silent aimbot']['mode'] == 'Hold' then
                silentaimactive = false
                if not camlockactive then
                    currenttarget = nil
                    lastvisibletarget = nil
                    targetline.Visible = false
                end
            end
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['cam lock']] then
        if cfg['camera aimbot']['mode'] == 'Hold' then
            camlockactive = false
            if not silentaimactive and cfg['targeting']['mode'] ~= 'Automatic' then
                currenttarget = nil
                lastvisibletarget = nil
                targetline.Visible = false
            end
        end
    end

    if input.KeyCode == Enum.KeyCode[cfg['binds']['triggerbot']] then
        if cfg['trigger bot']['mode'] == 'Hold' then
            triggerenabled = false
        end
    end
end)

runservice.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(dt)
    if cfg['targeting']['mode'] == 'Automatic' then
        -- Retarget every frame so MousePos stays locked to the closest player
        currenttarget = findtarget(cfg['silent aimbot']['fov'], cfg['silent aimbot']['distance check'], false)
        silentaimactive = currenttarget ~= nil
    elseif silentaimactive and currenttarget and currenttarget.Parent then
        -- Keep locked hitpart fresh while Select-mode is active
        local hitpart = cfg['silent aimbot']['hitpart']
        if hitpart == 'Closest Part' then
            currenttarget = closestbodypart(currenttarget.Parent) or currenttarget
        else
            currenttarget = currenttarget.Parent:FindFirstChild(hitpart) or currenttarget
        end
    end

    if selfknocked() then
        currenttarget = nil
        silentaimactive = false
        camlockactive = false
        lastvisibletarget = nil
        targetline.Visible = false
    end

    -- Critical for real Da Hood: guns aim via BodyEffects.MousePos, not Mouse.Hit alone
    local aimPoint = getsilentaimpoint()
    if aimPoint then
        writemousepos(aimPoint)
    end

    triggerbot()
    rapidfire()

    if superjumpenabled and cfg['super jump']['enabled'] then
        local hum = localplayer.Character and localplayer.Character:FindFirstChild("Humanoid")
        if hum then
            if hum.JumpPower ~= cfg['super jump']['jump power'] then
                hum.JumpPower = cfg['super jump']['jump power']
            end
        end
    end

    if cfg['speed modifications']['enabled'] and speedenabled then
        local hum = localplayer.Character and localplayer.Character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = 16 * cfg['speed modifications']['multiplier']
        end
    end

    if cfg['hitbox expander']['enabled'] then
        for _, player in pairs(players:GetPlayers()) do
            if player ~= localplayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Size = Vector3.new(cfg['hitbox expander']['size'], cfg['hitbox expander']['size'], cfg['hitbox expander']['size'])

                    if cfg['hitbox expander']['Visualize'] then
                        hrp.Transparency = 0.7
                        hrp.BrickColor = BrickColor.new("Really blue")
                        hrp.Material = "Neon"
                        hrp.CanCollide = false
                    else
                        hrp.Transparency = 1
                    end
                end
            end
        end
    end

    updatefovbox(fovparts.silentaim, fov2dboxes.silentaim, cfg['silent aimbot']['fov'], silentaimactive)
    updatefovbox(fovparts.camlock, fov2dboxes.camlock, cfg['camera aimbot']['fov'], camlockactive)
    updatefovbox(fovparts.triggerbot, fov2dboxes.triggerbot, cfg['trigger bot']['fov'], triggerenabled)

    updatetargetline()
    refreshesp()

    if cfg['camera aimbot']['enabled'] then
        applycamlock()
    end
end))


-- ===== _dahood_ui.luau =====
-- UI
-- EchoHublol Scoot UI wired to shared.Glory
do
    local cfg = shared.Glory
    if not cfg then
        warn("[echohublol] Glory config missing")
        return
    end

    local UserInputService = game:GetService("UserInputService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")

    local ok, Library = pcall(function()
        if getgenv().__EchoSametScootLib then
            return getgenv().__EchoSametScootLib
        end
        local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sametexe001/sametlibs/refs/heads/main/Scoot/Library.lua"))()
        getgenv().__EchoSametScootLib = Lib
        return Lib
    end)

    if not (ok and Library) then
        warn("[echohublol] failed to load Scoot UI library")
        return
    end

    pcall(function()
        local old = game:GetService("CoreGui"):FindFirstChild("EchoHubDaHood")
        if old then old:Destroy() end
    end)

    local Window = Library:Window({
        Logo = "77218680285262",
        FadeTime = 0.05,
    })

    local Watermark = Library:Watermark("echohublol | Da Hood")
    local KeybindList = Library:KeybindList()

    local AimPage = Window:Page({ Name = "Aim", Columns = 2 })
    local MiscPage = Window:Page({ Name = "Misc", Columns = 2 })
    local SkinsPage = Window:Page({ Name = "Skins", Columns = 2 })
    local BindsPage = Window:Page({ Name = "Keybinds", Columns = 1 })
    Library:CreateSettingsPage(Window, Watermark, KeybindList)

    local KeyNames = {
        "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
        "LeftShift","RightShift","LeftControl","RightControl","LeftAlt","RightAlt","Tab","CapsLock","Space",
        "One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Zero","None",
    }

    local Hitparts = { "Head", "HumanoidRootPart", "UpperTorso", "Closest Part" }

    local Silent = AimPage:Section({ Name = "Silent Aim", Side = 1 })
    Silent:Toggle({
        Name = "Enabled",
        Flag = "GHSilent",
        Default = cfg['silent aimbot']['enabled'],
        Callback = function(v)
            cfg['silent aimbot']['enabled'] = v
        end,
    })
    Silent:Dropdown({
        Name = "Targeting",
        Flag = "GHTargeting",
        Items = { "Automatic", "Select" },
        Default = cfg['targeting']['mode'] or "Automatic",
        Multi = false,
        Callback = function(v)
            cfg['targeting']['mode'] = v
        end,
    })
    Silent:Dropdown({
        Name = "Mode",
        Flag = "GHSilentMode",
        Items = { "Toggle", "Hold" },
        Default = cfg['silent aimbot']['mode'] or "Toggle",
        Multi = false,
        Callback = function(v)
            cfg['silent aimbot']['mode'] = v
        end,
    })
    Silent:Dropdown({
        Name = "Hitpart",
        Flag = "GHSilentHit",
        Items = Hitparts,
        Default = cfg['silent aimbot']['hitpart'] or "Head",
        Multi = false,
        Callback = function(v)
            cfg['silent aimbot']['hitpart'] = v
        end,
    })
    Silent:Toggle({
        Name = "Prediction",
        Flag = "GHSilentPred",
        Default = cfg['silent aimbot']['use prediction'],
        Callback = function(v)
            cfg['silent aimbot']['use prediction'] = v
        end,
    })
    Silent:Slider({
        Name = "Prediction X",
        Flag = "GHSilentPredX",
        Min = 0,
        Max = 0.5,
        Default = cfg['silent aimbot']['prediction']['x'] or 0.133,
        Decimals = 0.001,
        Callback = function(v)
            cfg['silent aimbot']['prediction']['x'] = v
            cfg['silent aimbot']['prediction']['y'] = v
            cfg['silent aimbot']['prediction']['z'] = v
        end,
    })
    Silent:Toggle({
        Name = "Distance Check",
        Flag = "GHSilentDist",
        Default = cfg['silent aimbot']['distance check']['enabled'],
        Callback = function(v)
            cfg['silent aimbot']['distance check']['enabled'] = v
        end,
    })
    Silent:Slider({
        Name = "Max Distance",
        Flag = "GHSilentMaxDist",
        Min = 50,
        Max = 1000,
        Default = cfg['silent aimbot']['distance check']['max distance'] or 300,
        Decimals = 1,
        Suffix = " studs",
        Callback = function(v)
            cfg['silent aimbot']['distance check']['max distance'] = v
        end,
    })

    local Checks = AimPage:Section({ Name = "Checks", Side = 1 })
    Checks:Toggle({
        Name = "Knock Check",
        Flag = "GHKnock",
        Default = cfg['settings']['knock check'],
        Callback = function(v) cfg['settings']['knock check'] = v end,
    })
    Checks:Toggle({
        Name = "Visible Check",
        Flag = "GHVisible",
        Default = cfg['settings']['visible check'],
        Callback = function(v) cfg['settings']['visible check'] = v end,
    })
    Checks:Toggle({
        Name = "Self Knock Check",
        Flag = "GHSelfKnock",
        Default = cfg['settings']['self knock check'],
        Callback = function(v) cfg['settings']['self knock check'] = v end,
    })
    Checks:Toggle({
        Name = "Knife Check",
        Flag = "GHKnife",
        Default = cfg['settings']['knife check'],
        Callback = function(v) cfg['settings']['knife check'] = v end,
    })

    local Cam = AimPage:Section({ Name = "Camera Aimbot", Side = 2 })
    Cam:Toggle({
        Name = "Enabled",
        Flag = "GHCam",
        Default = cfg['camera aimbot']['enabled'],
        Callback = function(v) cfg['camera aimbot']['enabled'] = v end,
    })
    Cam:Dropdown({
        Name = "Mode",
        Flag = "GHCamMode",
        Items = { "Toggle", "Hold" },
        Default = cfg['camera aimbot']['mode'] or "Toggle",
        Multi = false,
        Callback = function(v) cfg['camera aimbot']['mode'] = v end,
    })
    Cam:Dropdown({
        Name = "Hitpart",
        Flag = "GHCamHit",
        Items = Hitparts,
        Default = cfg['camera aimbot']['hitpart'] or "Head",
        Multi = false,
        Callback = function(v) cfg['camera aimbot']['hitpart'] = v end,
    })
    Cam:Slider({
        Name = "Smoothing",
        Flag = "GHCamSmooth",
        Min = 1,
        Max = 20,
        Default = cfg['camera aimbot']['smoothing']['x'] or 5,
        Decimals = 1,
        Callback = function(v)
            cfg['camera aimbot']['smoothing']['x'] = v
            cfg['camera aimbot']['smoothing']['y'] = v
            cfg['camera aimbot']['smoothing']['z'] = v
        end,
    })

    local Trig = AimPage:Section({ Name = "Triggerbot", Side = 2 })
    Trig:Toggle({
        Name = "Enabled",
        Flag = "GHTrig",
        Default = cfg['trigger bot']['enabled'],
        Callback = function(v) cfg['trigger bot']['enabled'] = v end,
    })
    Trig:Dropdown({
        Name = "Mode",
        Flag = "GHTrigMode",
        Items = { "Toggle", "Hold" },
        Default = cfg['trigger bot']['mode'] or "Hold",
        Multi = false,
        Callback = function(v) cfg['trigger bot']['mode'] = v end,
    })
    Trig:Slider({
        Name = "Delay",
        Flag = "GHTrigDelay",
        Min = 0,
        Max = 0.2,
        Default = cfg['trigger bot']['delay'] or 0.01,
        Decimals = 0.001,
        Suffix = "s",
        Callback = function(v) cfg['trigger bot']['delay'] = v end,
    })

    local Rapid = AimPage:Section({ Name = "Rapid Fire", Side = 2 })
    Rapid:Toggle({
        Name = "Rapid Fire",
        Flag = "GHRapid",
        Default = cfg['rapid fire']['enabled'],
        Callback = function(v) cfg['rapid fire']['enabled'] = v end,
    })
    Rapid:Slider({
        Name = "Fire Delay",
        Flag = "GHRapidDelay",
        Min = 0,
        Max = 0.05,
        Default = math.min(cfg['rapid fire']['delay'] or 0, 0.05),
        Decimals = 0.000001,
        Suffix = "s",
        Callback = function(v) cfg['rapid fire']['delay'] = v end,
    })

    local MiscSec = MiscPage:Section({ Name = "Player", Side = 1 })
    MiscSec:Toggle({
        Name = "Speed Modification",
        Flag = "GHSpeed",
        Default = cfg['speed modifications']['enabled'],
        Callback = function(v) cfg['speed modifications']['enabled'] = v end,
    })
    MiscSec:Slider({
        Name = "Speed Multiplier",
        Flag = "GHSpeedMult",
        Min = 16,
        Max = 800,
        Default = cfg['speed modifications']['multiplier'] or 400,
        Decimals = 1,
        Callback = function(v) cfg['speed modifications']['multiplier'] = v end,
    })
    MiscSec:Toggle({
        Name = "Super Jump",
        Flag = "GHJump",
        Default = cfg['super jump']['enabled'],
        Callback = function(v) cfg['super jump']['enabled'] = v end,
    })
    MiscSec:Slider({
        Name = "Jump Power",
        Flag = "GHJumpPower",
        Min = 50,
        Max = 400,
        Default = cfg['super jump']['jump power'] or 200,
        Decimals = 1,
        Callback = function(v) cfg['super jump']['jump power'] = v end,
    })
    MiscSec:Toggle({
        Name = "Hitbox Expander",
        Flag = "GHHitbox",
        Default = cfg['hitbox expander']['enabled'],
        Callback = function(v) cfg['hitbox expander']['enabled'] = v end,
    })
    MiscSec:Slider({
        Name = "Hitbox Size",
        Flag = "GHHitboxSize",
        Min = 2,
        Max = 20,
        Default = cfg['hitbox expander']['size'] or 7,
        Decimals = 1,
        Callback = function(v) cfg['hitbox expander']['size'] = v end,
    })
    MiscSec:Toggle({
        Name = "No Spread",
        Flag = "GHSpread",
        Default = cfg['spread modifications']['enabled'],
        Callback = function(v) cfg['spread modifications']['enabled'] = v end,
    })
    MiscSec:Slider({
        Name = "Spread Amount",
        Flag = "GHSpreadAmt",
        Min = 1,
        Max = 100,
        Default = cfg['spread modifications']['amount'] or 1,
        Decimals = 1,
        Callback = function(v) cfg['spread modifications']['amount'] = v end,
    })

    local EspSec = MiscPage:Section({ Name = "ESP / Visuals", Side = 2 })
    EspSec:Toggle({
        Name = "ESP",
        Flag = "GHESP",
        Default = cfg['esp']['enabled'],
        Callback = function(v) cfg['esp']['enabled'] = v end,
    })
    EspSec:Toggle({
        Name = "Target Line",
        Flag = "GHLine",
        Default = cfg['target line']['enabled'],
        Callback = function(v) cfg['target line']['enabled'] = v end,
    })
    EspSec:Toggle({
        Name = "Headless",
        Flag = "GHHeadless",
        Default = cfg['headless']['enabled'],
        Callback = function(v) cfg['headless']['enabled'] = v end,
    })
    EspSec:Toggle({
        Name = "Spiderman",
        Flag = "GHSpider",
        Default = cfg['spiderman']['enabled'],
        Callback = function(v) cfg['spiderman']['enabled'] = v end,
    })

    -- Skins
    local SkinSec = SkinsPage:Section({ Name = "Weapon Skins", Side = 1 })
    SkinSec:Toggle({
        Name = "Skin Changer",
        Flag = "GHSkins",
        Default = cfg['skins']['enabled'],
        Callback = function(v) cfg['skins']['enabled'] = v end,
    })

    local WeaponOrder = {
        "[Revolver]", "[Double-Barrel SG]", "[TacticalShotgun]", "[Shotgun]", "[Drum-Shotgun]",
        "[SMG]", "[P90]", "[AR]", "[SilencerAR]", "[AK47]", "[AUG]", "[Rifle]",
        "[Glock]", "[Silencer]", "[LMG]", "[Flamethrower]", "[RPG]", "[DrumGun]", "[Knife]",
    }

    local function CollectSkins(weapon)
        local items = { "None" }
        local okReq, modules = pcall(function()
            local sm = ReplicatedStorage:FindFirstChild("SkinModules")
            if not sm then return nil end
            return require(sm)
        end)
        if okReq and type(modules) == "table" and modules[weapon] then
            local names = {}
            for name in pairs(modules[weapon]) do
                table.insert(names, name)
            end
            table.sort(names)
            for _, name in ipairs(names) do
                table.insert(items, name)
            end
        end
        -- always include configured defaults even if require failed
        local current = cfg['skins']['weapons'][weapon]
        if current and current ~= "" then
            local found = false
            for _, n in ipairs(items) do
                if n == current then found = true break end
            end
            if not found then
                table.insert(items, 2, current)
            end
        end
        return items
    end

    for _, weapon in ipairs(WeaponOrder) do
        local skins = CollectSkins(weapon)
        if #skins > 1 then
            SkinSec:Dropdown({
                Name = weapon,
                Flag = "GHSkin_" .. weapon:gsub("%W", ""),
                Items = skins,
                Default = cfg['skins']['weapons'][weapon] or "None",
                Multi = false,
                Callback = function(v)
                    if v == "None" then
                        cfg['skins']['weapons'][weapon] = nil
                    else
                        cfg['skins']['weapons'][weapon] = v
                    end
                end,
            })
        end
    end

    local Binds = BindsPage:Section({ Name = "Feature Keybinds", Side = 1 })
    local function BindDropdown(label, bindKey)
        Binds:Dropdown({
            Name = label,
            Flag = "GHBind_" .. bindKey:gsub("%s", ""),
            Items = KeyNames,
            Default = cfg['binds'][bindKey] or "C",
            Multi = false,
            Callback = function(v)
                cfg['binds'][bindKey] = v
            end,
        })
    end
    BindDropdown("Silent Aim", "silent aim")
    BindDropdown("Cam Lock", "cam lock")
    BindDropdown("Triggerbot", "triggerbot")
    BindDropdown("Super Jump", "super jump")
    BindDropdown("ESP", "esp")
    BindDropdown("Speed", "speed")

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe or UserInputService:GetFocusedTextBox() then return end
        if input.KeyCode == Enum.KeyCode.RightShift then
            pcall(function()
                if Window.SetOpen then
                    Window:SetOpen(not Window.IsOpen)
                elseif Library.Toggle then
                    Library:Toggle()
                end
            end)
        end
    end)

    print("[echohublol] Da Hood UI loaded — Right Shift to toggle (Glory aim)")
end


]====], "Echo_Da_Hood")
	if not EchoChunk then
		error("[Echo] Da Hood compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

elseif IsNFLUniverse() then
-- Echo Hub: NFL Universe
do
	local EchoChunk, EchoChunkErr = loadstring([====[
-- // Echo Hub | NFL Universe
-- Scoot UI + NFL ThrowBall/arc logic + Echo QB controls. Optimized for low FPS cost.

local LoadTick = os.clock()
local cloneref = cloneref or function(v) return v end

do
	local uiRoot = game:GetService("CoreGui")
	for _, gui in ipairs(uiRoot:GetChildren()) do
		if gui:IsA("ScreenGui") and (gui.Name == "EchoHUD" or gui.Name == "EchoNFLMobile" or gui.Name == "EchoNFL") then
			pcall(function()
				gui:Destroy()
			end)
		end
	end
end

local Library = (function()
	if getgenv().__EchoSametScootLib then
		return getgenv().__EchoSametScootLib
	end
	local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/sametexe001/sametlibs/refs/heads/main/Scoot/Library.lua"))()
	getgenv().__EchoSametScootLib = Lib
	return Lib
end)()

local Window = Library:Window({
	Logo = "77218680285262",
	FadeTime = 0.05,
})

local Services = setmetatable({}, {
	__index = function(_, name)
		return cloneref(game:GetService(name))
	end,
})

local Players = Services.Players
local Workspace = Services.Workspace
local ReplicatedStorage = Services.ReplicatedStorage
local RunService = Services.RunService
local UserInputService = Services.UserInputService
local VirtualUser = Services.VirtualUser
local Debris = Services.Debris
local Lighting = Services.Lighting

local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()
local Mouse = LocalPlayer:GetMouse()

local Character = LocalPlayer.Character
local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

local function RefreshCharacter(char)
	Character = char
	Humanoid = char and char:FindFirstChildOfClass("Humanoid")
	HumanoidRootPart = char and char:FindFirstChild("HumanoidRootPart")
	if char and (not Humanoid or not HumanoidRootPart) then
		task.defer(function()
			if Character ~= char then
				return
			end
			Humanoid = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
			HumanoidRootPart = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart", 5)
		end)
	end
end

LocalPlayer.CharacterAdded:Connect(RefreshCharacter)

----------------------------------------------------------------------
-- Config (Echo-style)
----------------------------------------------------------------------
local Echo = {
	Pull = {
		Enabled = false,
		Smooth = false,
		Offset = 15,
		Smoothness = 0.2,
		MaxDistance = 35,
		AutoOffset = false,
	},
	Magnet = {
		Enabled = false,
		Distance = 120,
		ShowHitbox = false,
	},
	Player = {
		WalkSpeed = false,
		WS = 25,
		JumpPower = false,
		JP = 50,
		Fly = false,
		FlySpeed = 50,
		InfiniteStamina = false,
		JumpBoost = false,
		AlwaysBoost = false,
		BoostForce = 32,
		DiveBoost = false,
		DivePower = 2.2,
		TeleportForward = false,
		AntiAFK = true,
	},
	Hitbox = {
		BigHead = false,
		HeadSize = 1,
		PlayerHitbox = false,
		Size = 5,
		Transparency = 0.7,
		TackleReach = false,
		ReachDistance = 5,
	},
	Auto = {
		FollowCarrier = false,
		FollowBlatancy = 0.5,
		AutoSack = false,
		AntiBlock = false,
	},
	QB = {
		Enabled = false,
		CustomLead = 0,
		FOV = 500,
		ShowFOV = false,
		TargetLock = true,
		TeamCheck = true,
		LockedTarget = nil,
		TargetPriority = "Closest To Mouse",
		SmoothEnabled = false,
		SmoothFactor = 5,
		AutoPower = true,
		NormalPower = 100,
		ShowHUD = true,
		Auto = true,
		BeamMode = true,
		PredictionColor = Color3.fromRGB(202, 243, 255),
	},
	Visuals = {
		Potato = false,
	},
}

local Conn = {}
local function Bind(name, connection)
	if Conn[name] then
		Conn[name]:Disconnect()
	end
	Conn[name] = connection
	return connection
end

local function Unbind(name)
	if Conn[name] then
		Conn[name]:Disconnect()
		Conn[name] = nil
	end
end

----------------------------------------------------------------------
-- Football cache (no per-frame GetDescendants)
----------------------------------------------------------------------
local CachedFootball = nil
local CachedFootballId = nil

local function IsFootballPart(obj)
	return obj
		and obj:IsA("BasePart")
		and (
			obj.Name == "Football"
			or obj.Name == "Football MeshPart"
			or obj.Name == "918f5408-d86a-4fb8-a88c-5cab57410acf"
		)
end

local function RefreshFootballCache()
	CachedFootball = nil
	local parkMap = Workspace:FindFirstChild("ParkMap")
	if parkMap then
		local fields = parkMap:FindFirstChild("Replicated") and parkMap.Replicated:FindFirstChild("Fields")
		if fields then
			for _, name in ipairs({
				"LeftField",
				"RightField",
				"BLeftField",
				"BRightField",
				"HighField",
				"TLeftField",
				"TRightField",
			}) do
				local field = fields:FindFirstChild(name)
				local ball = field and field:FindFirstChild("Replicated") and field.Replicated:FindFirstChild("Football")
				if ball and ball:IsA("BasePart") then
					CachedFootball = ball
					return ball
				end
			end
		end
	end

	local parkMatch = Workspace:FindFirstChild("ParkMatchMap")
	if parkMatch then
		local fields = parkMatch:FindFirstChild("Replicated") and parkMatch.Replicated:FindFirstChild("Fields")
		local match = fields and fields:FindFirstChild("MatchField")
		local ball = match and match:FindFirstChild("Replicated") and match.Replicated:FindFirstChild("Football")
		if ball and ball:IsA("BasePart") then
			CachedFootball = ball
			return ball
		end
	end

	for _, folderName in ipairs({ "Games", "MiniGames" }) do
		local folder = Workspace:FindFirstChild(folderName)
		if folder then
			for _, gameInst in ipairs(folder:GetChildren()) do
				local rep = gameInst:FindFirstChild("Replicated")
				if rep then
					local kickoff = rep:FindFirstChild("918f5408-d86a-4fb8-a88c-5cab57410acf")
					if kickoff and kickoff:IsA("BasePart") then
						CachedFootball = kickoff
						return kickoff
					end
					local ball = rep:FindFirstChild("Football")
					if ball and ball:IsA("BasePart") then
						CachedFootball = ball
						return ball
					end
				end
			end
		end
	end
	return nil
end

local function GetFootball()
	if CachedFootball and CachedFootball.Parent then
		return CachedFootball
	end
	return RefreshFootballCache()
end

Workspace.DescendantAdded:Connect(function(obj)
	if IsFootballPart(obj) then
		CachedFootball = obj
	end
end)
Workspace.DescendantRemoving:Connect(function(obj)
	if obj == CachedFootball then
		CachedFootball = nil
	end
end)
task.defer(RefreshFootballCache)

----------------------------------------------------------------------
-- Helpers
----------------------------------------------------------------------
local MechMod = nil
do
	local assets = ReplicatedStorage:FindFirstChild("Assets")
	local modules = assets and assets:FindFirstChild("Modules")
	local client = modules and modules:FindFirstChild("Client")
	local mechanics = client and client:FindFirstChild("Mechanics")
	if mechanics then
		local ok, mod = pcall(require, mechanics)
		if ok then
			MechMod = mod
		end
	end
end

local function GetBallCarrier()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Football") then
			return player
		end
	end
	return nil
end

local function GetPlayerTeam(player)
	-- Prefer replicated TeamID (reliable in-game)
	local rep = player and player:FindFirstChild("Replicated")
	local teamId = rep and rep:FindFirstChild("TeamID")
	if teamId ~= nil and teamId.Value ~= nil and tostring(teamId.Value) ~= "" then
		return tostring(teamId.Value)
	end
	if player and player.Team then
		return player.Team.Name
	end

	local menu = LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild("Menu")
	local frame = menu
		and menu:FindFirstChild("Basis")
		and menu.Basis:FindFirstChild("Window")
		and menu.Basis.Window:FindFirstChild("AddFriends")
		and menu.Basis.Window.AddFriends:FindFirstChild("Basis")
		and menu.Basis.Window.AddFriends.Basis:FindFirstChild("Frame")
	if not frame then
		return nil
	end
	local home = frame:FindFirstChild("HomeTeam")
	local away = frame:FindFirstChild("AwayTeam")
	if home and home:FindFirstChild("Frame") and home.Frame:FindFirstChild(player.Name) then
		return "Home"
	end
	if away and away:FindFirstChild("Frame") and away.Frame:FindFirstChild(player.Name) then
		return "Away"
	end
	return nil
end

local function IsTeammate(player)
	if not player or player == LocalPlayer then
		return false
	end
	local mine = GetPlayerTeam(LocalPlayer)
	local theirs = GetPlayerTeam(player)
	if mine and theirs then
		return mine == theirs
	end
	-- If team info missing, don't allow (safer for QB — avoids throwing to defense)
	return false
end

local function TeleportToBall(smooth)
	local ball, root = GetFootball(), HumanoidRootPart
	if not (ball and root) then
		return
	end
	if Workspace:FindFirstChild("ParkMap") then
		if (ball.Position - root.Position).Magnitude > Echo.Pull.MaxDistance then
			return
		end
	end
	local vel = ball.AssemblyLinearVelocity
	if vel.Magnitude < 0.01 then
		vel = ball.Velocity
	end
	local dir = vel.Magnitude > 0.1 and vel.Unit or root.CFrame.LookVector
	local offset = Echo.Pull.Offset
	if Echo.Pull.AutoOffset then
		local speed = vel.Magnitude
		offset = speed > 80 and 12 or speed > 50 and 8 or speed > 25 and 5 or 3
	end
	local target = ball.Position + dir * offset + Vector3.new(0, smooth and 3 or -0.63, 0)
	local look = ball.Position - root.Position
	if look.Magnitude < 0.01 then
		look = dir
	end
	local desired = CFrame.new(target, target + look.Unit)
	root.CFrame = smooth and root.CFrame:Lerp(desired, Echo.Pull.Smoothness) or desired
end

----------------------------------------------------------------------
-- Magnets (desync) — stable: no Heartbeat yields, re-acquire ball, closest in range
----------------------------------------------------------------------
local MagnetHitbox = nil
local MagnetState = {
	hrp = nil,
	theonern = nil,
	posCache = {},
	prvnt = false,
	og1 = CFrame.new(),
	oind = nil,
	busy = false,
	setup = false,
	lastScan = 0,
}

local function MagnetClearHitbox()
	if MagnetHitbox then
		pcall(function()
			MagnetHitbox:Destroy()
		end)
		MagnetHitbox = nil
	end
end

local function IsFootballHeld(fb)
	if not (fb and fb.Parent) then
		return true
	end
	local parent = fb.Parent
	if parent:IsA("Model") and Players:GetPlayerFromCharacter(parent) then
		return true
	end
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character and fb:IsDescendantOf(player.Character) then
			return true
		end
		-- NFL often parents held ball under Workspace[PlayerName]
		local folder = Workspace:FindFirstChild(player.Name)
		if folder and fb:IsDescendantOf(folder) then
			return true
		end
	end
	return false
end

local function MagnetFindBestFootball(hrp)
	local best, bestDist = nil, math.huge
	local maxDist = Echo.Magnet.Distance

	local function consider(fb)
		if not IsFootballPart(fb) or not fb.Parent or IsFootballHeld(fb) then
			return
		end
		local dist = (hrp.Position - fb.Position).Magnitude
		if dist <= maxDist and dist < bestDist then
			best, bestDist = fb, dist
		end
	end

	-- Prefer live cache / known ball
	consider(GetFootball())
	consider(MagnetState.theonern)

	-- Periodic full scan when we don't have a valid target (ball respawns often)
	local now = os.clock()
	if (not best) or (now - MagnetState.lastScan) > 0.35 then
		MagnetState.lastScan = now
		for _, d in ipairs(Workspace:GetDescendants()) do
			if IsFootballPart(d) then
				consider(d)
			end
		end
	end

	return best
end

local function StopMagnets()
	Unbind("MagnetHB")
	Unbind("MagnetRender")
	MagnetState.busy = false
	MagnetState.prvnt = false
	MagnetClearHitbox()
end

local function StartMagnets()
	local executor = (identifyexecutor and identifyexecutor()) or "None"
	if string.split(executor, " ")[1] == "Xeno" then
		Echo.Magnet.Enabled = false
		Library:Notification("Magnets", "Not supported on Xeno", 3)
		return
	end
	if type(hookmetamethod) ~= "function" or type(checkcaller) ~= "function" then
		Library:Notification("Magnets", "Executor missing hookmetamethod/checkcaller", 3)
		return
	end

	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	MagnetState.hrp = char:WaitForChild("HumanoidRootPart")
	MagnetState.busy = false
	MagnetState.prvnt = false
	MagnetState.posCache = {}

	-- Hook once (compare against MagnetState.hrp so respawns stay valid)
	if not MagnetState.oind then
		MagnetState.oind = hookmetamethod(game, "__index", function(self, key)
			if Echo.Magnet.Enabled and not checkcaller() and key == "CFrame" and self == MagnetState.hrp and MagnetState.prvnt then
				return MagnetState.og1
			end
			return MagnetState.oind(self, key)
		end)
	end

	if not MagnetState.setup then
		MagnetState.setup = true
		Bind("MagnetAdd", Workspace.DescendantAdded:Connect(function(d)
			if IsFootballPart(d) then
				MagnetState.theonern = d
				CachedFootball = d
				pcall(function()
					MagnetState.posCache[tostring(d:GetDebugId())] = d.Position
				end)
			end
		end))
		Bind("MagnetRem", Workspace.DescendantRemoving:Connect(function(d)
			if d == MagnetState.theonern then
				MagnetState.theonern = nil
			end
			if d == CachedFootball then
				CachedFootball = nil
			end
		end))
		Bind("MagnetChar", LocalPlayer.CharacterAdded:Connect(function(c)
			MagnetState.hrp = c:WaitForChild("HumanoidRootPart")
			MagnetState.prvnt = false
			MagnetState.busy = false
			MagnetState.posCache = {}
			MagnetClearHitbox()
		end))
	end

	-- Seed ball reference
	pcall(RefreshFootballCache)
	local seed = GetFootball()
	if seed then
		MagnetState.theonern = seed
	end

	Unbind("MagnetHB")
	Bind("MagnetHB", RunService.Heartbeat:Connect(function()
		if not Echo.Magnet.Enabled then
			MagnetState.prvnt = false
			MagnetState.busy = false
			MagnetClearHitbox()
			return
		end

		local hrp = MagnetState.hrp
		if not hrp or not hrp.Parent then
			local c = LocalPlayer.Character
			if c then
				MagnetState.hrp = c:FindFirstChild("HumanoidRootPart")
				hrp = MagnetState.hrp
			end
			if not hrp then
				return
			end
		end

		-- Always re-resolve best loose ball in range (fixes "stops after a while")
		local theonern = MagnetFindBestFootball(hrp)
		MagnetState.theonern = theonern
		if not theonern then
			MagnetState.prvnt = false
			MagnetState.busy = false
			if Echo.Magnet.ShowHitbox then
				MagnetClearHitbox()
			end
			return
		end

		-- Skip overlapping ticks (old code yielded and stacked heartbeats → broken desync)
		if MagnetState.busy then
			-- Failsafe: if restore never ran, unblock after a short time
			if MagnetState.busyAt and (os.clock() - MagnetState.busyAt) > 0.2 then
				MagnetState.busy = false
				MagnetState.prvnt = false
			else
				return
			end
		end
		MagnetState.busy = true
		MagnetState.busyAt = os.clock()

		local id = "fb"
		pcall(function()
			id = tostring(theonern:GetDebugId())
		end)
		local pos = theonern.Position
		local old = MagnetState.posCache[id] or pos
		MagnetState.posCache[id] = pos

		local ping = 0
		pcall(function()
			ping = LocalPlayer:GetNetworkPing() * 1000
		end)
		local pingMult = ping > 250 and 2.5 or ping > 200 and 2.0 or ping > 150 and 1.7 or ping > 100 and 1.4 or ping > 50 and 1.2 or 1.0
		local vel = pos - old
		local int1 = vel.Magnitude > 0.1 and (pos + vel.Unit * 8 * pingMult) or (pos + Vector3.new(5, 0, 5) * pingMult)
		int1 = Vector3.new(int1.X, math.max(int1.Y, pos.Y), int1.Z)

		MagnetState.og1 = hrp.CFrame
		MagnetState.prvnt = true
		hrp.CFrame = CFrame.new(int1)

		-- Restore next render frame WITHOUT yielding Heartbeat (prevents races / stuck mags)
		Unbind("MagnetRender")
		Bind("MagnetRender", RunService.RenderStepped:Connect(function()
			Unbind("MagnetRender")
			local root = MagnetState.hrp
			if root and root.Parent then
				root.CFrame = MagnetState.og1
			end
			MagnetState.prvnt = false
			MagnetState.busy = false
		end))

		if Echo.Magnet.ShowHitbox then
			if not MagnetHitbox or not MagnetHitbox.Parent then
				MagnetHitbox = Instance.new("Part")
				MagnetHitbox.Name = "EchoMagnetHitbox"
				MagnetHitbox.Shape = Enum.PartType.Ball
				MagnetHitbox.Anchored = true
				MagnetHitbox.CanCollide = false
				MagnetHitbox.Transparency = 0.7
				MagnetHitbox.Material = Enum.Material.ForceField
				MagnetHitbox.Color = Color3.fromRGB(138, 43, 226)
				MagnetHitbox.CastShadow = false
				MagnetHitbox.Parent = Workspace
			end
			local d = Echo.Magnet.Distance * 2
			MagnetHitbox.Size = Vector3.new(d, d, d)
			MagnetHitbox.CFrame = theonern.CFrame
		else
			MagnetClearHitbox()
		end
	end))
end

----------------------------------------------------------------------
-- QB Aimbot (NFL arcs + Echo controls/HUD)
----------------------------------------------------------------------
local FIELD_Y = 3
-- NFL FootballMath uses g=-28 (NOT Workspace.Gravity 196). Wrong g = rainbow air time.
local FootballMath = nil
pcall(function()
	FootballMath = require(ReplicatedStorage.Assets.Modules.Shared.Services.FootballMath)
end)
local BALL_G = (FootballMath and FootballMath.Settings and FootballMath.Settings.Gravity) or -28
local BALL_G_VEC = Vector3.new(0, BALL_G, 0)
local MIN_POWER = (FootballMath and FootballMath.Settings and FootballMath.Settings.MinPower) or 30
local MAX_POWER = (FootballMath and FootballMath.Settings and FootballMath.Settings.MaxPower) or 100
local PWR_COEF = (FootballMath and FootballMath.Settings and FootballMath.Settings.MaximumPowerCoefficient) or 0.95
local MIN_SPEED, MAX_SPEED = 40, 100
local GRAVITY = math.abs(BALL_G) -- magnitude for any leftover helpers

local ArcStationary = {
	[120] = { { 324, 230 }, { 335, 250 }, { 355, 320 }, { 360, 370 }, { 380, 420 }, { 317, 260 } },
	[100] = {
		{ 40, 6 },
		{ 50, 9 },
		{ 60, 13 },
		{ 70, 17 },
		{ 80, 21 },
		{ 90, 23 },
		{ 100, 24 },
		{ 110, 28 },
		{ 120, 32 },
		{ 130, 36 },
		{ 140, 40 },
		{ 150, 44 },
		{ 160, 50 },
		{ 170, 55 },
		{ 178, 65 },
		{ 190, 75 },
		{ 200, 85 },
		{ 220, 95 },
		{ 233, 105 },
		{ 264, 140 },
		{ 274, 170 },
		{ 317, 200 },
		{ 332, 220 },
		{ 360, 270 },
	},
	[80] = {
		{ 4, 2 },
		{ 13, 4 },
		{ 31, 6 },
		{ 33, 7 },
		{ 40, 8 },
		{ 50, 13 },
		{ 60, 15 },
		{ 68, 18 },
		{ 75, 20 },
		{ 80, 12 },
		{ 89, 13 },
		{ 100, 15 },
		{ 150, 38 },
		{ 170, 55 },
		{ 185, 70 },
		{ 200, 120 },
		{ 233, 140 },
		{ 264, 180 },
		{ 274, 210 },
		{ 317, 220 },
		{ 332, 250 },
	},
}

local ArcMoving = {
	[120] = { { 324, 250 }, { 335, 270 }, { 355, 340 }, { 360, 390 } },
	[100] = {
		{ 40, 15 },
		{ 45, 15 },
		{ 50, 16 },
		{ 55, 17 },
		{ 60, 18 },
		{ 65, 18 },
		{ 70, 20 },
		{ 75, 21 },
		{ 80, 22 },
		{ 85, 23 },
		{ 90, 25 },
		{ 95, 27 },
		{ 100, 28 },
		{ 105, 30 },
		{ 110, 32 },
		{ 115, 34 },
		{ 120, 36 },
		{ 125, 39 },
		{ 130, 41 },
		{ 135, 44 },
		{ 140, 46 },
		{ 145, 49 },
		{ 150, 52 },
		{ 155, 55 },
		{ 160, 58 },
		{ 165, 61 },
		{ 170, 64 },
		{ 175, 68 },
		{ 180, 71 },
		{ 185, 75 },
		{ 190, 79 },
		{ 195, 82 },
		{ 200, 86 },
		{ 205, 90 },
		{ 210, 95 },
		{ 215, 99 },
		{ 220, 103 },
		{ 225, 108 },
		{ 230, 112 },
		{ 235, 117 },
		{ 240, 122 },
		{ 245, 127 },
		{ 250, 132 },
		{ 255, 137 },
		{ 260, 142 },
		{ 265, 148 },
		{ 270, 153 },
		{ 275, 159 },
		{ 280, 165 },
		{ 285, 171 },
		{ 290, 176 },
		{ 295, 183 },
		{ 300, 189 },
		{ 305, 195 },
		{ 310, 201 },
		{ 315, 208 },
		{ 320, 214 },
		{ 325, 221 },
		{ 330, 228 },
		{ 332, 231 },
		{ 335, 235 },
	},
	[80] = {
		{ 4, 7 },
		{ 13, 7 },
		{ 31, 9 },
		{ 33, 10 },
		{ 40, 11 },
		{ 50, 13 },
		{ 54, 14 },
		{ 60, 16 },
		{ 80, 23 },
		{ 89, 26 },
		{ 100, 31 },
		{ 150, 61 },
		{ 170, 76 },
		{ 185, 88 },
		{ 200, 102 },
	},
}

local ReceiverHistory = {}
local PlayerTrack = {}
local LastQBHud = { power = 0, route = "—", name = "—", dist = 0 }
local SmoothedDir = Vector3.zero
local CachedThrowEvent = nil
local CachedThrowEventAt = 0

local function GetArcY(tbl, power, dist)
	local points = tbl[power] or tbl[100]
	if not points or #points == 0 then
		return FIELD_Y
	end
	if dist <= points[1][1] then
		return points[1][2]
	end
	if dist >= points[#points][1] then
		return points[#points][2]
	end
	for i = 2, #points do
		local a, b = points[i - 1], points[i]
		if dist <= b[1] then
			local t = (dist - a[1]) / math.max(b[1] - a[1], 1e-3)
			return a[2] + t * (b[2] - a[2])
		end
	end
	return points[#points][2]
end

local function GetBallSpeed(power)
	return MIN_SPEED + (power / 100) * (MAX_SPEED - MIN_SPEED)
end

local function UpdateReceiverHistory(pos)
	ReceiverHistory[#ReceiverHistory + 1] = pos
	if #ReceiverHistory > 5 then
		table.remove(ReceiverHistory, 1)
	end
end

local function GetRouteType()
	if #ReceiverHistory < 4 then
		return "streak", false
	end
	local p1 = ReceiverHistory[#ReceiverHistory - 3]
	local p3 = ReceiverHistory[#ReceiverHistory - 1]
	local p4 = ReceiverHistory[#ReceiverHistory]
	local overall = (p4 - p1)
	local recent = (p4 - p3)
	if overall.Magnitude < 0.1 or recent.Magnitude < 0.1 then
		return "streak", false
	end
	local overallDir, recentDir = overall.Unit, recent.Unit
	local angle = math.deg(math.acos(math.clamp(overallDir:Dot(recentDir), -1, 1)))
	local isFake = angle > 60 and recent.Magnitude < (ReceiverHistory[#ReceiverHistory - 2] - p1).Magnitude * 0.7
	local ox, oz = overallDir.X, overallDir.Z
	if math.abs(ox) < 0.3 and oz > 0.7 then
		return "streak", isFake
	elseif ox > 0.7 and oz > 0.5 then
		return "corner_right", isFake
	elseif ox < -0.7 and oz > 0.5 then
		return "corner_left", isFake
	elseif ox > 0.7 and math.abs(oz) < 0.3 then
		return "out_right", isFake
	elseif ox < -0.7 and math.abs(oz) < 0.3 then
		return "out_left", isFake
	elseif ox > 0.7 and oz < -0.5 then
		return "slant_right", isFake
	elseif ox < -0.7 and oz < -0.5 then
		return "slant_left", isFake
	elseif oz < -0.5 and angle > 90 then
		return "curl", isFake
	end
	return "streak", isFake
end

local function ChoosePower(dist, velMag)
	if dist >= 220 then
		return 100
	end
	if Echo.QB.AutoPower then
		if velMag > 12 or dist > 100 then
			return 95
		end
		if dist < 45 then
			return 70
		end
		return 85
	end
	return math.clamp(Echo.QB.NormalPower, MIN_POWER, MAX_POWER)
end

local function GetThrowEvent()
	if CachedThrowEvent and CachedThrowEvent.Parent and (os.clock() - CachedThrowEventAt) < 2 then
		return CachedThrowEvent
	end
	local function find(folderName, spotName)
		local ws = Workspace:FindFirstChild(folderName)
		local rs = ReplicatedStorage:FindFirstChild(folderName)
		if not (ws and rs) then
			return nil
		end
		for _, obj in ipairs(ws:GetChildren()) do
			if obj:IsA("Model") then
				local rep = obj:FindFirstChild("Replicated")
				if rep and rep:FindFirstChild(spotName) then
					local remoteFolder = rs:FindFirstChild(obj.Name)
					local event = remoteFolder and remoteFolder:FindFirstChild("ReEvent")
					if event and event:IsA("RemoteEvent") then
						return event
					end
				end
			end
		end
		return nil
	end
	CachedThrowEvent = find("MiniGames", "SpotTags") or find("Games", "ActiveSpots")
	CachedThrowEventAt = os.clock()
	return CachedThrowEvent
end

local function GetNearestReceiver()
	if Echo.QB.TargetLock and Echo.QB.LockedTarget then
		local locked = Echo.QB.LockedTarget
		if locked.Parent and locked.Character and locked.Character:FindFirstChild("HumanoidRootPart") then
			if not Echo.QB.TeamCheck or IsTeammate(locked) then
				return locked
			end
		end
		Echo.QB.LockedTarget = nil
	end

	local camera = Workspace.CurrentCamera
	if not camera then
		return nil
	end
	local mousePos = Vector2.new(Mouse.X, Mouse.Y)
	local best, bestScore = nil, math.huge
	local fov = Echo.QB.FOV
	-- Auto always tracks closest-to-mouse; FOV only gates manual mode
	local useFov = fov > 0 and not Echo.QB.Auto

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and (not Echo.QB.TeamCheck or IsTeammate(player)) then
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			local hum = player.Character:FindFirstChildOfClass("Humanoid")
			if hrp and hum and hum.Health > 0 then
				local screen, onScreen = camera:WorldToViewportPoint(hrp.Position)
				if (onScreen or Echo.QB.Auto) and screen.Z > 0 then
					local dist = (Vector2.new(screen.X, screen.Y) - mousePos).Magnitude
					if not useFov or dist <= fov then
						local score = dist
						if Echo.QB.TargetPriority == "Furthest Downfield" and HumanoidRootPart then
							score = -math.abs(hrp.Position.Z - HumanoidRootPart.Position.Z)
						end
						if score < bestScore then
							best, bestScore = player, score
						end
					end
				end
			end
		end
	end

	if Echo.QB.TargetLock and best then
		Echo.QB.LockedTarget = best
	end
	return best
end

-- Sticky: once selected (H / throw), ONLY that receiver is thrown to until you re-select
local function GetActiveReceiver()
	if Echo.QB.LockedTarget then
		local locked = Echo.QB.LockedTarget
		if locked.Parent and locked.Character then
			local hrp = locked.Character:FindFirstChild("HumanoidRootPart")
			local hum = locked.Character:FindFirstChildOfClass("Humanoid")
			if hrp and hum and hum.Health > 0 then
				if not Echo.QB.TeamCheck or IsTeammate(locked) then
					return locked
				end
			end
		end
		Echo.QB.LockedTarget = nil
	end
	return GetNearestReceiver()
end

local function GetCatchBox(player)
	if not player then
		return nil
	end
	local ok, box = pcall(function()
		local gameId = LocalPlayer:FindFirstChild("Replicated") and LocalPlayer.Replicated:FindFirstChild("GameID")
		if not gameId then
			return nil
		end
		local folder = (Workspace:FindFirstChild("Games") and Workspace.Games:FindFirstChild(gameId.Value))
			or (Workspace:FindFirstChild("MiniGames") and Workspace.MiniGames:FindFirstChild(gameId.Value))
		local boxes = folder and folder:FindFirstChild("Replicated") and folder.Replicated:FindFirstChild("Hitboxes")
		local hb = boxes and boxes:FindFirstChild(player.Name)
		return hb and hb:FindFirstChild("CatchBox")
	end)
	if ok then
		return box
	end
	return nil
end

local function GetGroundY()
	local ok, y = pcall(function()
		local gameId = LocalPlayer:FindFirstChild("Replicated") and LocalPlayer.Replicated:FindFirstChild("GameID")
		if not gameId then
			return nil
		end
		local folder = (Workspace:FindFirstChild("Games") and Workspace.Games:FindFirstChild(gameId.Value))
			or (Workspace:FindFirstChild("MiniGames") and Workspace.MiniGames:FindFirstChild(gameId.Value))
		local rep = folder and folder:FindFirstChild("Replicated")
		local primary = rep and (rep.PrimaryPart or rep:FindFirstChild("PrimaryPart") or rep:FindFirstChildWhichIsA("BasePart"))
		if primary then
			return primary.Position.Y + 0.4
		end
		local center = rep and rep:FindFirstChild("Center")
		if center and center:IsA("BasePart") then
			return center.Position.Y + 0.5
		end
		return nil
	end)
	if ok and typeof(y) == "number" then
		return y
	end
	if HumanoidRootPart then
		return HumanoidRootPart.Position.Y - 2.9
	end
	return FIELD_Y + 0.4
end

-- Exact FootballMath pass into landPos; pick TOF so speed ≈ preferred power (higher catch = not too low)
local function SolveGameThrow(origin, landPos, preferredPower)
	local horiz = Vector3.new(landPos.X - origin.X, 0, landPos.Z - origin.Z)
	local horizDist = horiz.Magnitude
	if horizDist < 0.5 then
		return nil
	end

	local want = math.clamp(preferredPower or 90, MIN_POWER, MAX_POWER)

	local function velocityForTime(t)
		if FootballMath and FootballMath.GetVelocityForPass then
			return FootballMath:GetVelocityForPass(origin, landPos, t)
		end
		return (landPos - BALL_G_VEC * (t * t) / 2 - origin) / t
	end

	local bestT, bestVel, bestDiff = nil, nil, math.huge
	for t = 0.38, 2.15, 0.02 do
		local vel = velocityForTime(t)
		local mag = vel.Magnitude
		if mag <= MAX_POWER + 0.5 then
			local diff = math.abs(mag - want)
			-- Prefer closer power; on ties prefer slightly shorter air time
			if diff < bestDiff or (math.abs(diff - bestDiff) < 0.05 and bestT and t < bestT) then
				bestDiff = diff
				bestT = t
				bestVel = vel
			end
		end
	end
	if not bestVel then
		-- Fallback: stretch TOF until under max power
		local t = math.clamp(horizDist / math.max(want * 0.85, 35), 0.5, 2.4)
		bestVel = velocityForTime(t)
		local guard = 0
		while bestVel.Magnitude > MAX_POWER and t < 2.8 and guard < 20 do
			t += 0.06
			bestVel = velocityForTime(t)
			guard += 1
		end
		bestT = t
	end

	local throwPower = math.clamp(bestVel.Magnitude, MIN_POWER, MAX_POWER)
	local targetPos = origin + bestVel.Unit * 1000

	return {
		target = targetPos,
		power = throwPower,
		beamVelocity = bestVel.Unit * throwPower,
		flightTime = bestT,
		landPos = landPos,
	}
end

local function BuildThrowSolution(target)
	if not target or not HumanoidRootPart then
		return nil
	end
	local receiverRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
	if not receiverRoot then
		return nil
	end

	local ownerFolder = Workspace:FindFirstChild(LocalPlayer.Name)
	local football = (ownerFolder and ownerFolder:FindFirstChild("Football"))
		or (Character and Character:FindFirstChild("Football"))
	local origin = (football and football:IsA("BasePart") and football.Position)
		or (HumanoidRootPart.CFrame * CFrame.new(0, 1.6, -0.4)).Position

	local receiverVel = receiverRoot.AssemblyLinearVelocity
	local track = PlayerTrack[target] or { history = {} }
	track.history[#track.history + 1] = receiverVel
	if #track.history > 5 then
		table.remove(track.history, 1)
	end
	local avgVel = Vector3.zero
	for _, v in ipairs(track.history) do
		avgVel += v
	end
	avgVel = avgVel / #track.history
	PlayerTrack[target] = track

	UpdateReceiverHistory(receiverRoot.Position)
	local routeType, isFake = GetRouteType()
	local dist = (receiverRoot.Position - origin).Magnitude
	local moving = avgVel.Magnitude > 3
	local power = ChoosePower(dist, avgVel.Magnitude)

	if dist < 55 and (routeType == "curl" or routeType == "out_right" or routeType == "out_left") then
		power = 75
	elseif dist > 180 then
		power = 100
	elseif moving then
		power = math.max(power, 90)
	end
	power = math.clamp(power, MIN_POWER, MAX_POWER)

	local flightGuess = dist / math.max(power * 0.9, 1)
	local leadMult = 1
	if moving then
		if isFake then
			leadMult = 0.45
		elseif routeType == "streak" then
			leadMult = 1.05
		elseif routeType == "corner_right" or routeType == "corner_left" or routeType == "slant_right" or routeType == "slant_left" or routeType == "out_right" or routeType == "out_left" then
			leadMult = 1.55
		elseif routeType == "curl" then
			leadMult = 0
		end
	end

	local predicted = receiverRoot.Position
	for _ = 1, 3 do
		if moving and avgVel.Magnitude > 0.1 then
			predicted = receiverRoot.Position + avgVel * flightGuess * leadMult
		else
			predicted = receiverRoot.Position
		end
		local horizToPred = (Vector3.new(predicted.X, origin.Y, predicted.Z) - Vector3.new(origin.X, origin.Y, origin.Z)).Magnitude
		flightGuess = math.clamp(horizToPred / math.max(power * 0.9, 1), 0.38, 2.0)
	end

	if Echo.QB.CustomLead ~= 0 and avgVel.Magnitude > 0.1 then
		local flat = Vector3.new(avgVel.X, 0, avgVel.Z)
		if flat.Magnitude > 0 then
			predicted += flat.Unit * (Echo.QB.CustomLead * 0.15)
		end
	end

	if Echo.QB.SmoothEnabled then
		local dir = predicted - origin
		if dir.Magnitude > 0 then
			local factor = math.clamp(Echo.QB.SmoothFactor, 1, 20)
			SmoothedDir = SmoothedDir:Lerp(dir.Unit, 1 / factor)
			predicted = origin + SmoothedDir * dir.Magnitude
		end
	end

	-- Catch height above receiver — high enough to not be "too low", tight to selected catch box
	local catchLift = 7.25
	if dist > 120 then
		catchLift = 8.5
	elseif dist < 40 then
		catchLift = 6.0
	end
	local landPos = Vector3.new(predicted.X, receiverRoot.Position.Y + catchLift, predicted.Z)

	local solved = SolveGameThrow(origin, landPos, power)
	if not solved then
		return nil
	end

	LastQBHud.power = math.floor(solved.power + 0.5)
	LastQBHud.route = routeType
	LastQBHud.name = target.DisplayName or target.Name
	LastQBHud.dist = math.floor(dist)

	return {
		target = solved.target,
		power = solved.power,
		route = routeType,
		origin = origin,
		receiver = target,
		flightTime = solved.flightTime,
		beamVelocity = solved.beamVelocity,
		catchPos = landPos,
		landPos = landPos,
		groundY = GetGroundY(),
		catchBox = GetCatchBox(target),
	}
end

local GRAVITY_VEC = BALL_G_VEC
local CurrentBeam, BeamA0, BeamA1
local AutoThrowClock = 0

local function HoldingFootball()
	local folder = Workspace:FindFirstChild(LocalPlayer.Name)
	if folder and folder:FindFirstChild("Football") then
		return true
	end
	return Character ~= nil and Character:FindFirstChild("Football") ~= nil
end

local function BeamProjectile(g, v0, x0, t1)
	local c = 0.5 * 0.5 * 0.5
	local p3 = 0.5 * g * t1 * t1 + v0 * t1 + x0
	local p2 = p3 - (g * t1 * t1 + v0 * t1) / 3
	local p1 = (c * g * t1 * t1 + 0.5 * v0 * t1 + x0 - c * (x0 + p3)) / (3 * c) - p2

	local d1 = p1 - x0
	local d2 = p2 - p3
	if d1.Magnitude < 1e-4 or d2.Magnitude < 1e-4 then
		return nil
	end

	local curve0 = d1.Magnitude
	local curve1 = d2.Magnitude
	local r1 = d1.Unit
	local r2 = d2.Unit
	local worldUp = Vector3.new(0, 1, 0)

	local b1 = math.abs(r1:Dot(worldUp)) < 0.999 and r1:Cross(worldUp).Unit or r1:Cross(Vector3.new(1, 0, 0)).Unit
	local u1 = b1:Cross(r1).Unit
	local b2 = math.abs(r2:Dot(worldUp)) < 0.999 and r2:Cross(worldUp).Unit or r2:Cross(Vector3.new(1, 0, 0)).Unit
	local u2 = b2:Cross(r2).Unit

	local cf1 = CFrame.new(x0.X, x0.Y, x0.Z, r1.X, u1.X, b1.X, r1.Y, u1.Y, b1.Y, r1.Z, u1.Z, b1.Z)
	local cf2 = CFrame.new(p3.X, p3.Y, p3.Z, r2.X, u2.X, b2.X, r2.Y, u2.Y, b2.Y, r2.Z, u2.Z, b2.Z)
	return curve0, -curve1, cf1, cf2
end

local function DestroyTrajectoryBeam()
	if CurrentBeam then
		pcall(function()
			CurrentBeam:Destroy()
		end)
		CurrentBeam = nil
	end
	if BeamA0 then
		pcall(function()
			BeamA0:Destroy()
		end)
		BeamA0 = nil
	end
	if BeamA1 then
		pcall(function()
			BeamA1:Destroy()
		end)
		BeamA1 = nil
	end
end

pcall(function()
	for _, obj in ipairs(Workspace.Terrain:GetChildren()) do
		if (obj:IsA("Beam") and obj.Name == "EchoNFLBeam")
			or (obj:IsA("Attachment") and (obj.Name == "EchoNFLA0" or obj.Name == "EchoNFLA1"))
		then
			obj:Destroy()
		end
	end
end)

local function ApplyBeamLook(beam, color)
	local h, s, v = Color3.toHSV(color)
	local midColor = Color3.fromHSV(h, math.max(s - 0.1, 0), math.min(v + 0.08, 1))
	beam.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, color),
		ColorSequenceKeypoint.new(0.55, midColor),
		ColorSequenceKeypoint.new(1, color),
	})
	-- Fully solid to the tip — no fade-out
	beam.Transparency = NumberSequence.new(0)
end

local function UpdateTrajectoryBeam(solution)
	if not Echo.QB.BeamMode or not solution or not solution.beamVelocity or not solution.flightTime then
		DestroyTrajectoryBeam()
		return
	end

	local p0 = solution.origin
	if not p0 then
		DestroyTrajectoryBeam()
		return
	end

	local curve0, curve1, cf1, cf2
	-- Prefer official FootballMath.BeamDirection (g=-28) so arc matches real ball path to land
	if FootballMath and FootballMath.BeamDirection then
		local ok, a, b, c, d = pcall(function()
			return FootballMath:BeamDirection(solution.beamVelocity, p0, solution.flightTime)
		end)
		if ok and a and c then
			curve0, curve1, cf1, cf2 = a, b, c, d
		end
	end
	if not curve0 then
		curve0, curve1, cf1, cf2 = BeamProjectile(GRAVITY_VEC, solution.beamVelocity, p0, solution.flightTime)
	end
	if not curve0 or not cf1 or not cf2 then
		DestroyTrajectoryBeam()
		return
	end

	local color = Echo.QB.PredictionColor or Color3.fromRGB(202, 243, 255)

	if CurrentBeam and BeamA0 and BeamA1 then
		BeamA0.WorldCFrame = cf1
		BeamA1.WorldCFrame = cf2
		CurrentBeam.CurveSize0 = curve0
		CurrentBeam.CurveSize1 = curve1
		ApplyBeamLook(CurrentBeam, color)
		return
	end

	DestroyTrajectoryBeam()
	local a0 = Instance.new("Attachment")
	a0.Name = "EchoNFLA0"
	a0.WorldCFrame = cf1
	a0.Parent = Workspace.Terrain

	local a1 = Instance.new("Attachment")
	a1.Name = "EchoNFLA1"
	a1.WorldCFrame = cf2
	a1.Parent = Workspace.Terrain

	local beam = Instance.new("Beam")
	beam.Name = "EchoNFLBeam"
	beam.Attachment0 = a0
	beam.Attachment1 = a1
	ApplyBeamLook(beam, color)
	beam.Width0 = 3.2
	beam.Width1 = 1.4
	beam.CurveSize0 = curve0
	beam.CurveSize1 = curve1
	beam.FaceCamera = true
	beam.Segments = 1200
	beam.LightEmission = 0.9
	beam.Brightness = 4
	beam.TextureSpeed = 2.5
	beam.TextureLength = 12
	beam.Texture = "rbxassetid://18527302693"
	beam.Parent = Workspace.Terrain

	CurrentBeam = beam
	BeamA0 = a0
	BeamA1 = a1
end

local function DoQBThrow(silent)
	if not Echo.QB.Enabled then
		return
	end
	local target = GetActiveReceiver()
	if not target then
		if not silent then
			Library:Notification("QB Aimbot", "Press H to select a receiver first", 2)
		end
		return
	end
	-- Stick selection so only this player is targeted
	Echo.QB.LockedTarget = target
	Echo.QB.TargetLock = true

	local solution = BuildThrowSolution(target)
	if not solution then
		return
	end
	local event = GetThrowEvent()
	if not event then
		if not silent then
			Library:Notification("QB Aimbot", "Throw remote not found", 2)
		end
		return
	end
	local payload = {
		Target = solution.target,
		AutoThrow = solution.catchBox ~= nil,
		Power = solution.power,
	}
	if solution.catchBox then
		payload.PlayerTarget = solution.catchBox
	end
	event:FireServer("Mechanics", "ThrowBall", payload)
end

local function TryAutoThrow()
	if not Echo.QB.Enabled or not Echo.QB.Auto then
		return
	end
	if not HoldingFootball() then
		return
	end
	local now = os.clock()
	if now - AutoThrowClock < 0.35 then
		return
	end
	AutoThrowClock = now
	DoQBThrow(true)
end

-- When Auto is on, rewrite any client ThrowBall so normal click/throw uses QB aimbot (no T)
if type(hookmetamethod) == "function" and type(checkcaller) == "function" and type(getnamecallmethod) == "function" then
	if not getgenv().__EchoNFLAutoThrowHook or getgenv().__EchoNFLAutoThrowHook < 6 then
		getgenv().__EchoNFLAutoThrowHook = 6
		local oldNamecall
		oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
			local method = getnamecallmethod()
			if method == "FireServer" and not checkcaller() then
				local a1, a2 = ...
				if Echo.QB.Enabled and Echo.QB.Auto and a1 == "Mechanics" and a2 == "ThrowBall" then
					local target = GetActiveReceiver()
					if target then
						Echo.QB.LockedTarget = target
						Echo.QB.TargetLock = true
						local solution = BuildThrowSolution(target)
						if solution then
							local payload = {
								Target = solution.target,
								AutoThrow = solution.catchBox ~= nil,
								Power = solution.power,
							}
							if solution.catchBox then
								payload.PlayerTarget = solution.catchBox
							end
							return oldNamecall(self, "Mechanics", "ThrowBall", payload)
						end
					end
				end
			end
			return oldNamecall(self, ...)
		end)
	end
end

local function SelectReceiver()
	-- Temporarily unlock so H can pick a new mouse-nearest receiver
	Echo.QB.TargetLock = false
	Echo.QB.LockedTarget = nil
	local nearest = GetNearestReceiver()
	Echo.QB.LockedTarget = nearest
	Echo.QB.TargetLock = true
	ReceiverHistory = {}
	if nearest then
		Library:Notification("QB Aimbot", "Selected only: " .. (nearest.DisplayName or nearest.Name), 2)
	else
		Library:Notification("QB Aimbot", "No receiver near mouse", 2)
	end
end

-- Compact Echo HUD
local EchoHUD = Instance.new("ScreenGui")
EchoHUD.Name = "EchoHUD"
EchoHUD.ResetOnSpawn = false
EchoHUD.Enabled = false
EchoHUD.Parent = (gethui and gethui()) or game:GetService("CoreGui")

do
	local BG = Color3.fromRGB(14, 17, 15)
	local ACCENT = Color3.fromRGB(202, 243, 255)
	local TEXT = Color3.fromRGB(235, 235, 235)
	local DIM = Color3.fromRGB(150, 155, 150)
	local panel = Instance.new("Frame")
	panel.AnchorPoint = Vector2.new(0.5, 0)
	panel.Position = UDim2.new(0.5, 0, 0, 10)
	panel.Size = UDim2.fromOffset(420, 54)
	panel.BackgroundColor3 = BG
	panel.BorderSizePixel = 0
	panel.Parent = EchoHUD
	Instance.new("UIStroke", panel).Color = Color3.fromRGB(12, 12, 12)
	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(10, 4)
	title.Size = UDim2.new(1, -20, 0, 16)
	title.Font = Enum.Font.Code
	title.TextSize = 12
	title.TextColor3 = ACCENT
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = "echo — nfl qb"
	title.Parent = panel
	local info = Instance.new("TextLabel")
	info.Name = "Info"
	info.BackgroundTransparency = 1
	info.Position = UDim2.fromOffset(10, 24)
	info.Size = UDim2.new(1, -20, 0, 24)
	info.Font = Enum.Font.Code
	info.TextSize = 12
	info.TextColor3 = TEXT
	info.TextXAlignment = Enum.TextXAlignment.Left
	info.Text = "—"
	info.Parent = panel
	EchoHUD:SetAttribute("Ready", true)
end

local function UpdateQBHud()
	if not Echo.QB.ShowHUD or not Echo.QB.Enabled then
		EchoHUD.Enabled = false
		return
	end
	EchoHUD.Enabled = true
	local info = EchoHUD:FindFirstChild("Frame") and EchoHUD.Frame:FindFirstChild("Info")
	-- panel is first Frame child
	local panel = EchoHUD:FindFirstChildOfClass("Frame")
	local label = panel and panel:FindFirstChild("Info")
	if label then
		label.Text = string.format(
			"%s  |  %s  |  pwr %d  |  %dst",
			LastQBHud.name,
			LastQBHud.route,
			LastQBHud.power,
			LastQBHud.dist
		)
	end
end

----------------------------------------------------------------------
-- Single Heartbeat orchestrator (cheap early-outs)
----------------------------------------------------------------------
local PullActive = false
local SmoothActive = false
local BoostReady = true
local FlyBV, FlyBG = nil, nil
local HitboxAccum = 0
local HudAccum = 0

local function ApplyJumpBoost(root)
	local bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.new(0, Echo.Player.BoostForce, 0)
	bv.MaxForce = Vector3.new(0, math.huge, 0)
	bv.P = 5000
	bv.Parent = root
	Debris:AddItem(bv, 0.2)
end

local function SetupJumpBoostTouch(char)
	local root = char:WaitForChild("HumanoidRootPart")
	Bind("JumpBoost", root.Touched:Connect(function(hit)
		if not Echo.Player.JumpBoost or not BoostReady then
			return
		end
		if root.AssemblyLinearVelocity.Y >= -2 then
			return
		end
		local other = hit:FindFirstAncestorWhichIsA("Model")
		if not (other and other ~= char and other:FindFirstChildOfClass("Humanoid")) then
			return
		end
		local ok = Echo.Player.AlwaysBoost
		if not ok then
			local ball = GetFootball()
			ok = ball and (ball.Position - root.Position).Magnitude <= 10
		end
		if ok then
			BoostReady = false
			ApplyJumpBoost(root)
			task.delay(1, function()
				BoostReady = true
			end)
		end
	end))
end

LocalPlayer.CharacterAdded:Connect(function(char)
	if Echo.Player.JumpBoost then
		SetupJumpBoostTouch(char)
	end
	if Humanoid then
		Bind("Jumping", Humanoid.Jumping:Connect(function()
			if Echo.Player.JumpPower and HumanoidRootPart then
				local v = HumanoidRootPart.AssemblyLinearVelocity
				HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(v.X, 0, v.Z) + Vector3.new(0, Echo.Player.JP, 0)
			end
		end))
	end
end)

Bind("MainHB", RunService.Heartbeat:Connect(function(dt)
	-- Pull held
	if PullActive and Echo.Pull.Enabled then
		TeleportToBall(false)
	elseif SmoothActive and Echo.Pull.Smooth then
		TeleportToBall(true)
	end

	-- Player mods (cheap)
	if Humanoid then
		if Echo.Player.WalkSpeed then
			Humanoid.WalkSpeed = Echo.Player.WS
		end
		if Echo.Player.InfiniteStamina and MechMod then
			pcall(function()
				MechMod.Stamina = 100
			end)
		end
	end

	-- Dive power (throttled)
	if Echo.Player.DiveBoost then
		HitboxAccum += dt
		if HitboxAccum > 0.35 then
			HitboxAccum = 0
			local gameId = LocalPlayer:FindFirstChild("Replicated") and LocalPlayer.Replicated:FindFirstChild("GameID")
			if gameId then
				local function apply(folder)
					local g = folder and folder:FindFirstChild(gameId.Value)
					local dp = g and g:FindFirstChild("GameParams") and g.GameParams:FindFirstChild("DivePower")
					if dp and dp:IsA("NumberValue") then
						dp.Value = Echo.Player.DivePower
					end
				end
				apply(ReplicatedStorage:FindFirstChild("Games"))
				apply(ReplicatedStorage:FindFirstChild("MiniGames"))
			end
		end
	end

	-- Auto follow
	if Echo.Auto.FollowCarrier and Humanoid and HumanoidRootPart then
		local carrier = GetBallCarrier()
		if carrier and carrier.Character then
			local myTeam, theirTeam = GetPlayerTeam(LocalPlayer), GetPlayerTeam(carrier)
			if myTeam and theirTeam and myTeam ~= theirTeam then
				local cr = carrier.Character:FindFirstChild("HumanoidRootPart")
				if cr then
					local dist = (cr.Position - HumanoidRootPart.Position).Magnitude
					local t = dist / math.max(Humanoid.WalkSpeed, 1)
					local pred = cr.Position + cr.AssemblyLinearVelocity * t
					Humanoid:MoveTo(HumanoidRootPart.Position + (pred - HumanoidRootPart.Position) * math.clamp(Echo.Auto.FollowBlatancy, 0, 1))
				end
			end
		end
	end

	-- Auto sack
	if Echo.Auto.AutoSack and HumanoidRootPart then
		local function teamOf(p)
			local rep = p:FindFirstChild("Replicated")
			local t = rep and rep:FindFirstChild("TeamID")
			return t and t.Value
		end
		local mine = teamOf(LocalPlayer)
		for _, enemy in ipairs(Players:GetPlayers()) do
			if enemy ~= LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("Football") then
				local theirs = teamOf(enemy)
				if mine and theirs and mine ~= theirs then
					local hrp = enemy.Character:FindFirstChild("HumanoidRootPart")
					if hrp then
						HumanoidRootPart.CFrame = CFrame.new(hrp.Position)
					end
					break
				end
			end
		end
	end

	-- Anti block
	if Echo.Auto.AntiBlock and Character then
		for _, p in ipairs(Character:GetChildren()) do
			if p:IsA("BasePart") then
				p.CanCollide = false
			end
		end
	end

	-- Fly
	if Echo.Player.Fly and HumanoidRootPart and not IsMobile then
		if not FlyBV then
			FlyBV = Instance.new("BodyVelocity")
			FlyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
			FlyBV.Parent = HumanoidRootPart
			FlyBG = Instance.new("BodyGyro")
			FlyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
			FlyBG.P = 1000
			FlyBG.Parent = HumanoidRootPart
		end
		local cam = Workspace.CurrentCamera
		local move = Vector3.zero
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			move += cam.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			move -= cam.CFrame.LookVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			move -= cam.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			move += cam.CFrame.RightVector
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			move += Vector3.yAxis
		end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
			move -= Vector3.yAxis
		end
		FlyBV.Velocity = move.Magnitude > 0 and move.Unit * Echo.Player.FlySpeed or Vector3.zero
	elseif FlyBV then
		FlyBV:Destroy()
		FlyBV = nil
		if FlyBG then
			FlyBG:Destroy()
			FlyBG = nil
		end
	end

	-- Hitboxes throttled ~10Hz and only when needed
	if Echo.Hitbox.BigHead or Echo.Hitbox.PlayerHitbox or Echo.Hitbox.TackleReach then
		HitboxAccum += dt
		if HitboxAccum >= 0.1 then
			HitboxAccum = 0
			if Echo.Hitbox.BigHead then
				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= LocalPlayer and player.Character then
						local head = player.Character:FindFirstChild("Head")
						if head then
							local s = Echo.Hitbox.HeadSize
							head.Size = Vector3.new(s, s, s)
							head.CanCollide = true
						end
					end
				end
			end
			if Echo.Hitbox.PlayerHitbox then
				local games = Workspace:FindFirstChild("Games")
				local current = games and games:GetChildren()[1]
				local boxes = current and current:FindFirstChild("Replicated") and current.Replicated:FindFirstChild("Hitboxes")
				if boxes then
					local s = Echo.Hitbox.Size
					for _, player in ipairs(Players:GetPlayers()) do
						if player ~= LocalPlayer then
							local hb = boxes:FindFirstChild(player.Name)
							if hb and hb:IsA("BasePart") then
								hb.Size = Vector3.new(s, s, s)
								hb.Transparency = Echo.Hitbox.Transparency
								hb.CanCollide = false
								hb.Material = Enum.Material.Neon
								hb.Color = Color3.fromRGB(255, 0, 0)
							end
						end
					end
				end
			end
			if Echo.Hitbox.TackleReach and HumanoidRootPart then
				local gameId = LocalPlayer:FindFirstChild("Replicated") and LocalPlayer.Replicated:FindFirstChild("GameID")
				if gameId then
					local folder = (Workspace:FindFirstChild("Games") and Workspace.Games:FindFirstChild(gameId.Value))
						or (Workspace:FindFirstChild("MiniGames") and Workspace.MiniGames:FindFirstChild(gameId.Value))
					local boxes = folder and folder:FindFirstChild("Replicated") and folder.Replicated:FindFirstChild("Hitboxes")
					if boxes then
						for _, player in ipairs(Players:GetPlayers()) do
							if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("FootballGrip", true) then
								local hb = boxes:FindFirstChild(player.Name)
								if hb and (hb.Position - HumanoidRootPart.Position).Magnitude <= Echo.Hitbox.ReachDistance then
									hb.Position = HumanoidRootPart.Position
								end
							end
						end
					end
				end
			end
		end
	end

	-- QB HUD / beam: sticky selected receiver; beam follows their catch point
	if Echo.QB.Enabled then
		local selected = GetActiveReceiver()

		local holding = HoldingFootball()
		local solution = nil
		if selected and holding then
			solution = BuildThrowSolution(selected)
		end

		if Echo.QB.BeamMode and solution then
			UpdateTrajectoryBeam(solution)
		else
			DestroyTrajectoryBeam()
		end

		HudAccum += dt
		if HudAccum >= 0.12 then
			HudAccum = 0
			if selected and not holding then
				BuildThrowSolution(selected)
			end
			UpdateQBHud()
		end
	else
		DestroyTrajectoryBeam()
		if EchoHUD.Enabled then
			EchoHUD.Enabled = false
		end
	end
end))

----------------------------------------------------------------------
-- Input
----------------------------------------------------------------------
Bind("InputBegan", UserInputService.InputBegan:Connect(function(input, gp)
	if gp then
		return
	end
	if Echo.Player.TeleportForward and input.KeyCode == Enum.KeyCode.Z and HumanoidRootPart then
		HumanoidRootPart.CFrame += HumanoidRootPart.CFrame.LookVector * 3
	end
	if Echo.QB.Enabled then
		if input.KeyCode == Enum.KeyCode.H then
			SelectReceiver()
		elseif input.KeyCode == Enum.KeyCode.T then
			DoQBThrow()
		end
	end
	local pullInput = input.UserInputType == Enum.UserInputType.MouseButton1
		or (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR2)
	if pullInput then
		-- Auto: click / throw input runs QB aimbot (same as T) — no T needed
		TryAutoThrow()
		if Echo.Pull.Enabled then
			PullActive = true
		end
		if Echo.Pull.Smooth then
			SmoothActive = true
		end
	end
end))

Bind("InputEnded", UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or (input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonR2)
	then
		PullActive = false
		SmoothActive = false
	end
end))

Bind("AntiAFK", LocalPlayer.Idled:Connect(function()
	if Echo.Player.AntiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end))

----------------------------------------------------------------------
-- Scoot UI
----------------------------------------------------------------------
local Watermark = Library:Watermark("Echo | NFL Universe")
local KeybindList = Library:KeybindList()

local MainPage = Window:Page({ Name = "Main", Columns = 2 })
local PlayerPage = Window:Page({ Name = "Player", Columns = 2 })
local HitboxPage = Window:Page({ Name = "Hitbox", Columns = 2 })
local AutoPage = Window:Page({ Name = "Automatics", Columns = 2 })
local QBPage = Window:Page({ Name = "QB Aimbot", Columns = 2 })
local VisualsPage = Window:Page({ Name = "Visuals", Columns = 1 })
Library:CreateSettingsPage(Window, Watermark, KeybindList)

local function AddToggle(Section, Name, Flag, Default, Callback)
	return Section:Toggle({ Name = Name, Flag = Flag, Default = Default, Callback = Callback })
end
local function AddSlider(Section, Name, Flag, Min, Max, Default, Decimals, Suffix, Callback)
	return Section:Slider({
		Name = Name,
		Flag = Flag,
		Min = Min,
		Max = Max,
		Default = Default,
		Decimals = Decimals or 1,
		Suffix = Suffix or "",
		Callback = Callback,
	})
end
local function AddDropdown(Section, Name, Flag, Items, Default, Callback)
	return Section:Dropdown({
		Name = Name,
		Flag = Flag,
		Items = Items,
		Default = Default,
		Multi = false,
		Callback = Callback,
	})
end

local PullSection = MainPage:Section({ Name = "Pull Vector", Side = 1 })
AddToggle(PullSection, "Pull Vector (M1)", "NFLPull", Echo.Pull.Enabled, function(v)
	Echo.Pull.Enabled = v
end)
AddToggle(PullSection, "Legit Pull Vector (M1)", "NFLSmoothPull", Echo.Pull.Smooth, function(v)
	Echo.Pull.Smooth = v
end)
AddToggle(PullSection, "Auto Offset", "NFLAutoOffset", Echo.Pull.AutoOffset, function(v)
	Echo.Pull.AutoOffset = v
end)
AddSlider(PullSection, "Offset Distance", "NFLOffset", 0, 30, Echo.Pull.Offset, 1, " st", function(v)
	Echo.Pull.Offset = v
end)
AddSlider(PullSection, "Max Pull Distance", "NFLMaxPull", 1, 100, Echo.Pull.MaxDistance, 1, " st", function(v)
	Echo.Pull.MaxDistance = v
end)
AddSlider(PullSection, "Vector Smoothing", "NFLSmooth", 0.01, 1, Echo.Pull.Smoothness, 2, "", function(v)
	Echo.Pull.Smoothness = v
end)

local MagSection = MainPage:Section({ Name = "Football Magnet", Side = 2 })
AddToggle(MagSection, "Desync Mags", "NFLMagnet", Echo.Magnet.Enabled, function(v)
	Echo.Magnet.Enabled = v
	if v then
		StartMagnets()
	else
		StopMagnets()
	end
end)
AddSlider(MagSection, "Magnet Distance", "NFLMagDist", 0, 120, Echo.Magnet.Distance, 1, " st", function(v)
	Echo.Magnet.Distance = v
end)
AddToggle(MagSection, "Show Hitbox", "NFLMagHitbox", Echo.Magnet.ShowHitbox, function(v)
	Echo.Magnet.ShowHitbox = v
end)

local MoveSection = PlayerPage:Section({ Name = "Movement", Side = 1 })
AddToggle(MoveSection, "WalkSpeed", "NFLWS", Echo.Player.WalkSpeed, function(v)
	Echo.Player.WalkSpeed = v
	if not v and Humanoid then
		Humanoid.WalkSpeed = 16
	end
end)
AddSlider(MoveSection, "WalkSpeed Value", "NFLWSVal", 16, 35, Echo.Player.WS, 1, "", function(v)
	Echo.Player.WS = v
end)
AddToggle(MoveSection, "JumpPower", "NFLJP", Echo.Player.JumpPower, function(v)
	Echo.Player.JumpPower = v
end)
AddSlider(MoveSection, "JumpPower Value", "NFLJPVal", 10, 200, Echo.Player.JP, 1, "", function(v)
	Echo.Player.JP = v
end)
AddToggle(MoveSection, "Fly", "NFLFly", Echo.Player.Fly, function(v)
	Echo.Player.Fly = v
end)
AddSlider(MoveSection, "Fly Speed", "NFLFlySpeed", 10, 200, Echo.Player.FlySpeed, 1, "", function(v)
	Echo.Player.FlySpeed = v
end)
AddToggle(MoveSection, "Teleport Forward (Z)", "NFLTPFwd", Echo.Player.TeleportForward, function(v)
	Echo.Player.TeleportForward = v
end)

local BoostSection = PlayerPage:Section({ Name = "Boost / Stamina", Side = 2 })
AddToggle(BoostSection, "Infinite Stamina", "NFLInfStam", Echo.Player.InfiniteStamina, function(v)
	Echo.Player.InfiniteStamina = v
end)
AddToggle(BoostSection, "Jump Boost", "NFLJumpBoost", Echo.Player.JumpBoost, function(v)
	Echo.Player.JumpBoost = v
	if v and Character then
		SetupJumpBoostTouch(Character)
	else
		Unbind("JumpBoost")
	end
end)
AddToggle(BoostSection, "Always Boost Mode", "NFLAlwaysBoost", Echo.Player.AlwaysBoost, function(v)
	Echo.Player.AlwaysBoost = v
end)
AddSlider(BoostSection, "Boost Force", "NFLBoostForce", 10, 100, Echo.Player.BoostForce, 1, "", function(v)
	Echo.Player.BoostForce = v
end)
AddToggle(BoostSection, "Dive Boost", "NFLDiveBoost", Echo.Player.DiveBoost, function(v)
	Echo.Player.DiveBoost = v
end)
AddSlider(BoostSection, "Dive Power", "NFLDivePower", 2.2, 10, Echo.Player.DivePower, 1, "", function(v)
	Echo.Player.DivePower = v
end)
AddToggle(BoostSection, "Anti-AFK", "NFLAntiAFK", Echo.Player.AntiAFK, function(v)
	Echo.Player.AntiAFK = v
end)

local HitSection = HitboxPage:Section({ Name = "Hitbox", Side = 1 })
AddToggle(HitSection, "Bighead Collision", "NFLBigHead", Echo.Hitbox.BigHead, function(v)
	Echo.Hitbox.BigHead = v
end)
AddSlider(HitSection, "Head Size", "NFLHeadSize", 1, 10, Echo.Hitbox.HeadSize, 1, "", function(v)
	Echo.Hitbox.HeadSize = v
end)
AddToggle(HitSection, "Player Hitbox Expander", "NFLPlyHB", Echo.Hitbox.PlayerHitbox, function(v)
	Echo.Hitbox.PlayerHitbox = v
end)
AddSlider(HitSection, "Hitbox Size", "NFLPlyHBSize", 2, 50, Echo.Hitbox.Size, 1, "", function(v)
	Echo.Hitbox.Size = v
end)
AddSlider(HitSection, "Hitbox Transparency", "NFLPlyHBTr", 0, 1, Echo.Hitbox.Transparency, 2, "", function(v)
	Echo.Hitbox.Transparency = v
end)

local ReachSection = HitboxPage:Section({ Name = "Tackle Reach", Side = 2 })
AddToggle(ReachSection, "Tackle Reach", "NFLTackle", Echo.Hitbox.TackleReach, function(v)
	Echo.Hitbox.TackleReach = v
end)
AddSlider(ReachSection, "Reach Distance", "NFLTackleDist", 1, 10, Echo.Hitbox.ReachDistance, 1, " st", function(v)
	Echo.Hitbox.ReachDistance = v
end)

local AutoSection = AutoPage:Section({ Name = "Automation", Side = 1 })
AddToggle(AutoSection, "Auto Follow Ball Carrier", "NFLFollow", Echo.Auto.FollowCarrier, function(v)
	Echo.Auto.FollowCarrier = v
end)
AddSlider(AutoSection, "Follow Blatancy", "NFLFollowBlat", 0, 1, Echo.Auto.FollowBlatancy, 2, "", function(v)
	Echo.Auto.FollowBlatancy = v
end)
AddToggle(AutoSection, "Auto Sack", "NFLSack", Echo.Auto.AutoSack, function(v)
	Echo.Auto.AutoSack = v
end)
AddToggle(AutoSection, "Anti Block", "NFLAntiBlock", Echo.Auto.AntiBlock, function(v)
	Echo.Auto.AntiBlock = v
end)

local QBConfig = QBPage:Section({ Name = "Throw Configuration", Side = 1 })
AddToggle(QBConfig, "QB Aimbot", "NFLQB", Echo.QB.Enabled, function(v)
	Echo.QB.Enabled = v
	if v then
		Echo.QB.Auto = true
		Echo.QB.BeamMode = true
	else
		Echo.QB.LockedTarget = nil
		EchoHUD.Enabled = false
		DestroyTrajectoryBeam()
	end
end)
AddToggle(QBConfig, "Auto", "NFLQBAuto", Echo.QB.Auto, function(v)
	Echo.QB.Auto = v
end)
AddToggle(QBConfig, "Auto Power", "NFLQBAutoPwr", Echo.QB.AutoPower, function(v)
	Echo.QB.AutoPower = v
end)
AddSlider(QBConfig, "Normal Power", "NFLQBPwr", 30, 100, Echo.QB.NormalPower, 1, "", function(v)
	Echo.QB.NormalPower = math.clamp(v, 30, 100)
end)
AddSlider(QBConfig, "Custom Lead", "NFLQBLead", 0, 100, Echo.QB.CustomLead, 1, "", function(v)
	Echo.QB.CustomLead = v
end)
AddToggle(QBConfig, "Smooth Throw", "NFLQBSmooth", Echo.QB.SmoothEnabled, function(v)
	Echo.QB.SmoothEnabled = v
end)
AddSlider(QBConfig, "Smooth Factor", "NFLQBSmoothF", 1, 20, Echo.QB.SmoothFactor, 1, "", function(v)
	Echo.QB.SmoothFactor = v
end)
local BeamToggle = AddToggle(QBConfig, "Beam Mode", "NFLQBBeam", Echo.QB.BeamMode, function(v)
	Echo.QB.BeamMode = v
	if not v then
		DestroyTrajectoryBeam()
	end
end)
pcall(function()
	BeamToggle:Colorpicker({
		Flag = "NFLQBBeamColor",
		Default = Echo.QB.PredictionColor,
		Callback = function(c)
			Echo.QB.PredictionColor = c
		end,
	})
end)

local QBTarget = QBPage:Section({ Name = "Targeting", Side = 2 })
AddToggle(QBTarget, "Target Lock", "NFLQBLock", Echo.QB.TargetLock, function(v)
	Echo.QB.TargetLock = v
	if not v then
		Echo.QB.LockedTarget = nil
	end
end)
AddToggle(QBTarget, "Team Check", "NFLQBTeam", Echo.QB.TeamCheck, function(v)
	Echo.QB.TeamCheck = v
	if v and Echo.QB.LockedTarget and not IsTeammate(Echo.QB.LockedTarget) then
		Echo.QB.LockedTarget = nil
	end
end)
AddSlider(QBTarget, "FOV", "NFLQBFOV", 0, 1000, Echo.QB.FOV, 1, "px", function(v)
	Echo.QB.FOV = v
end)
AddDropdown(QBTarget, "Target Priority", "NFLQBPrio", { "Closest To Mouse", "Furthest Downfield" }, Echo.QB.TargetPriority, function(v)
	Echo.QB.TargetPriority = v
end)
AddToggle(QBTarget, "Show HUD", "NFLQBHUD", Echo.QB.ShowHUD, function(v)
	Echo.QB.ShowHUD = v
end)

local ControlsSection = QBPage:Section({ Name = "Controls", Side = 1 })
do
	local ok = pcall(function()
		ControlsSection:Label("H — Select receiver (throws go only to them)")
		ControlsSection:Label("T — Manual QB aimbot throw")
		ControlsSection:Label("Auto — Click throw to selected receiver")
		ControlsSection:Label("Beam Mode — Arc to selected catch point")
	end)
	if not ok then
		pcall(function()
			ControlsSection:Button({ Name = "H — Select nearest receiver", Callback = function() end })
			ControlsSection:Button({ Name = "T — Manual QB aimbot throw", Callback = function() end })
			ControlsSection:Button({ Name = "Auto — Click / throw = aimbot (no T)", Callback = function() end })
			ControlsSection:Button({ Name = "Beam Mode — Accurate throw arc preview", Callback = function() end })
		end)
	end
end

local VisSection = VisualsPage:Section({ Name = "Visuals", Side = 1 })
AddToggle(VisSection, "Potato Graphics", "NFLPotato", Echo.Visuals.Potato, function(v)
	Echo.Visuals.Potato = v
	Lighting.GlobalShadows = not v
	settings().Rendering.QualityLevel = v and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
end)

if IsMobile then
	local gui = Instance.new("ScreenGui")
	gui.Name = "EchoNFLMobile"
	gui.ResetOnSpawn = false
	gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	local function mobBtn(text, y, fn)
		local b = Instance.new("TextButton")
		b.Size = UDim2.fromOffset(70, 70)
		b.Position = UDim2.new(1, -90, 1, y)
		b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		b.Text = text
		b.TextColor3 = Color3.new(1, 1, 1)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 14
		b.Parent = gui
		Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		b.MouseButton1Click:Connect(fn)
		return b
	end
	mobBtn("Select", -240, SelectReceiver)
	mobBtn("Throw", -160, DoQBThrow)
	local pull = mobBtn("Pull", -80, function() end)
	pull.MouseButton1Down:Connect(function()
		if Echo.Pull.Enabled then
			PullActive = true
		end
	end)
	pull.MouseButton1Up:Connect(function()
		PullActive = false
	end)
end

Library:Notification("Loaded!", "Echo | NFL Universe — " .. string.format("%.2fs", os.clock() - LoadTick), 4)

]====], "Echo_NFL_Universe")
	if not EchoChunk then
		error("[Echo] NFL Universe compile failed: " .. tostring(EchoChunkErr), 0)
	end
	EchoChunk()
end

else
	warn("[Echo] Unsupported game PlaceId=" .. PlaceIdStr .. " GameId=" .. GameIdStr)
	local Player = game:GetService("Players").LocalPlayer
	if Player then
		pcall(function()
			Player:Kick("Echo | This game is not supported.")
		end)
	end
end
