-- Hardcore Mode

local spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"))()

local YELLOW = Color3.fromRGB(255, 255, 0)
local RED = Color3.fromRGB(255, 0, 0)

local CarpetColors = {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255),
    Color3.fromRGB(255, 255, 0),
    Color3.fromRGB(255, 0, 255),
    Color3.fromRGB(0, 255, 255),
    Color3.fromRGB(255, 128, 0),
}

local function recolorCarpet(room)
    local color = CarpetColors[math.random(#CarpetColors)]

    for _, v in ipairs(room:GetDescendants()) do
        local name = string.lower(v.Name)

        if string.find(name, "rug") or string.find(name, "carpet") then
            if v:IsA("BasePart") then
                v.Color = color
            end

            for _, obj in ipairs(v:GetDescendants()) do
                if obj:IsA("BasePart") then
                    obj.Color = color
                end
            end
        end
    end
end

for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
    recolorCarpet(room)
end

workspace.CurrentRooms.ChildAdded:Connect(function(room)
    task.wait(0.1)
    recolorCarpet(room)
end)

   

local function applyColor(model, color)
	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Color = color

		elseif v:IsA("Decal") then
			v.Color3 = color

		elseif v:IsA("Texture") then
			v.Color = color

		elseif v:IsA("ParticleEmitter") then
			v.Color = ColorSequence.new(color)

		elseif v:IsA("Beam") or v:IsA("Trail") then
			v.Color = ColorSequence.new(color)

		elseif v:IsA("Highlight") then
			v.FillColor = color
			v.OutlineColor = color

		elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
			v.ImageColor3 = color
		end
	end
end 
                                                                                                                                                            local function hookEntity(model)

if not model:IsA("Model") then return end



-- Screech → Yellow

if model.Name == "Screech" or model.Name == "_Screech" then

	applyColor(model, YELLOW)



	model.DescendantAdded:Connect(function(v)

		task.wait()

		applyColor(model, YELLOW)

	end)

end



-- Seek → Red (including eyes)
if model.Name == "SeekMoving"
or model.Name == "SeekMovingNewClone"
or model.Name == "Eye"
or model.Name == "Eyes" then

    applyColor(model, RED)

    model.DescendantAdded:Connect(function()
        task.wait()
        applyColor(model, RED)
    end)
end

end

-- existing entities

for _, v in ipairs(workspace:GetChildren()) do

hookEntity(v)

end

-- future spawns

workspace.DescendantAdded:Connect(hookEntity)

local Entities = {

function() -- A90

    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.A90)
    (require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game), 
    workspace.CurrentRooms[game.Players.LocalPlayer:GetAttribute("CurrentRoom")])

    

end,



function() -- Depth Killable

    spawner.Create({

        Entity = {

            Name = "Depth",

            Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/DepthMoving.rbxm",

            HeightOffset = 0

        },

        Lights = {

            Flicker = {Enabled = true, Duration = 1},

            Shatter = true,

            Repair = false

        },

        CameraShake = {

            Enabled = true,

            Range = 100,

            Values = {1.5,20,0.1,1}

        },

        Movement = {

            Speed = 100,

            Delay = 2,

            Reversed = false

        },

        Rebounding = {

            Enabled = false,

            Type = "Ambush",

            Min = 1,

            Max = 1,

            Delay = 2

        },

        Damage = {

            Enabled = true,

            Range = 40,

            Amount = 125

        },

        Crucifixion = {

            Enabled = true,

            Range = 40,

            Resist = false,

            Break = true

        }

    }):Run()

end,



function() -- Stupid Horse Killable

    spawner.Create({

        Entity = {

            Name = "STUPID HORSE",

            Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/Stupid%20Horse.rbxm",

            HeightOffset = 0

        },

        Lights = {

            Flicker = {Enabled = true, Duration = 1},

            Shatter = true,

            Repair = false

        },

        Movement = {

            Speed = 100,

            Delay = 2,

            Reversed = false

        },

        Damage = {

            Enabled = true,

            Range = 40,

            Amount = 125

        }

    }):Run()

end,



function() -- OG Ambush Killable

    spawner.Create({

        Entity = {

            Name = "OG Ambush",

            Asset = "https://github.com/MateiDaBest/Utilities/raw/refs/heads/main/Doors/Other/AmbushMoving.rbxm",

            HeightOffset = 0

        },

        Lights = {

            Flicker = {Enabled = true, Duration = 2},

            Shatter = true,

            Repair = false

        },

        Movement = {

            Speed = 150,

            Delay = 2,

            Reversed = false

        },

        Rebounding = {

            Enabled = true,

            Type = "Ambush",

            Min = 1,

            Max = 5,

            Delay = 2

        },

        Damage = {

            Enabled = true,

            Range = 40,

            Amount = 125

        }

    }):Run()

end,



function() -- Rebound Killable

    local killed = false

	

	local MainEntity = game:GetObjects("rbxassetid://86937268250993")[1]

	MainEntity.Parent = workspace

	MainEntity.Rebound.CanCollide = false



	local Plr = game:GetService("Players").LocalPlayer

	local CameraShaker = require(game:GetService("ReplicatedStorage").CameraShaker)



	local CamShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(cf)

		workspace.CurrentCamera.CFrame *= cf

	end)



	CamShake:Start()

	

	local function canSeeTarget(target,size)

		if killed then

			return

		end



		local origin = MainEntity.Rebound.Position

		local direction = (target.HumanoidRootPart.Position - MainEntity.Rebound.Position).unit * size

		local ray = Ray.new(origin, direction)



		local hit, pos = workspace:FindPartOnRay(ray, MainEntity.Rebound)





		if hit then

			if hit:IsDescendantOf(target) then

				killed = true

				return true

			end

		else

			return false

		end

	end



	task.spawn(function()

		while MainEntity.Rebound ~= nil do wait(0.5)

			local v = game.Players.LocalPlayer

			local parent = script.Parent

			if v.Character ~= nil and not v.Character:GetAttribute("Hiding") then

				if canSeeTarget(v.Character,50) then

					local ReboundJs = Instance.new("ScreenGui")

					local Static = Instance.new("ImageLabel")

					local Rebound = Instance.new("ImageLabel")

					local JSSIZE = Instance.new("ImageLabel")





					ReboundJs.Name = "ReboundJs"

					ReboundJs.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")



					Static.Name = "Static"

					Static.Parent = ReboundJs

					Static.BackgroundColor3 = Color3.fromRGB(0, 63, 139)

					Static.BackgroundTransparency = 1.000

					Static.BorderColor3 = Color3.fromRGB(27, 42, 53)

					Static.BorderSizePixel = 0

					Static.Size = UDim2.new(1, 0, 1, 0)

					Static.Image = "rbxassetid://236543215"

					Static.ImageColor3 = Color3.fromRGB(0, 255, 255)

					Static.ImageTransparency = 1.000



					Rebound.Name = "Rebound"

					Rebound.Parent = ReboundJs

					Rebound.BackgroundColor3 = Color3.fromRGB(0, 63, 139)

					Rebound.BackgroundTransparency = 1.000

					Rebound.BorderSizePixel = 0

					Rebound.Position = UDim2.new(0.486631036, 0, 0.479363143, 0)

					Rebound.Size = UDim2.new(0.0267379656, 0, 0.0387096703, 0)

					Rebound.Image = "rbxassetid://10914800940"



					JSSIZE.Name = "JSSIZE"

					JSSIZE.Parent = ReboundJs

					JSSIZE.BackgroundColor3 = Color3.fromRGB(0, 63, 139)

					JSSIZE.BackgroundTransparency = 1.000

					JSSIZE.BorderSizePixel = 0

					JSSIZE.Position = UDim2.new(-0.586452842, 0, -1.25140607, 0)

					JSSIZE.Size = UDim2.new(2.12834215, 0, 3.08128953, 0)

					JSSIZE.Visible = false

					JSSIZE.Image = "rbxassetid://10914800940"



					local function ODEBL_fake_script()

						local script = Instance.new('LocalScript', Static)



						while true do

							script.Parent.Image = "rbxassetid://236543215"

							wait(0.002)

							script.Parent.Rotation = 0

							wait(0.002)

							script.Parent.Rotation = 180

							wait(0.002)

							script.Parent.Image = "rbxassetid://236777652"

							wait(0.002)

							script.Parent.Rotation = 0

							wait(0.002)

							script.Parent.Rotation = 180

							wait(0.002)

						end

					end

					coroutine.wrap(ODEBL_fake_script)()

					local function KLWZC_fake_script()

						local script = Instance.new('LocalScript', ReboundJs)





						local ReSt = game.ReplicatedStorage

						local Plr = game.Players.LocalPlayer

						local gui = script.Parent

						local static = gui.Static

						local jspos = gui.JSSIZE



						local function Jumpscare()

							game.TweenService:Create(static,TweenInfo.new(0.5),{BackgroundTransparency = 0,ImageTransparency = 0.8}):Play()

							game.TweenService:Create(gui.Rebound,TweenInfo.new(0.5),{Size = jspos.Size,Position = jspos.Position}):Play()

							spawn(function()

								wait(0.3)

								Plr.Character:FindFirstChildWhichIsA("Humanoid"):TakeDamage(100)

								ReSt.GameStats["Player_".. Plr.Name].Total.DeathCause.Value = "Rebound"

								firesignal(game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent, {"You died to who you call Rebound...","He makes his presence known and keeps coming back...","Hide when this happens!"},'Blue')

							end)

							wait(0.5)

							game.TweenService:Create(static,TweenInfo.new(1),{BackgroundTransparency = 1,ImageTransparency = 1}):Play()

							game.TweenService:Create(gui.Rebound,TweenInfo.new(0.3),{ImageTransparency = 1}):Play()

							wait(1)

							gui:Destroy()

						end



						Jumpscare()

					end

					coroutine.wrap(KLWZC_fake_script)()

				end

			end

			if v.Character ~= nil then

				if v.Character:FindFirstChild("HumanoidRootPart") and (MainEntity.Rebound.Position - v.Character:FindFirstChild("HumanoidRootPart").Position).magnitude <= 80 then

					CamShake:ShakeOnce(9,8,0.1,2,1,6)

				end

			end

		end

	end)

	

	local Reboundcolor = Instance.new("ColorCorrectionEffect", game:GetService("Lighting"))

	Reboundcolor.Name = "Warn"

	Reboundcolor.TintColor = Color3.fromRGB(65, 138, 255)

	Reboundcolor.Saturation = -0.7

	Reboundcolor.Contrast = 0.2



	local Tween = game:GetService("TweenService"):Create(Reboundcolor, TweenInfo.new(15), {TintColor = Color3.fromRGB(255, 255, 255), Saturation = 0, Contrast = 0})

	Tween:Play()

	Tween.Completed:Connect(function()

		Reboundcolor:Destroy()

	end)



	CamShake:ShakeOnce(10, 3, 0.1, 6, 2, 0.5)



	task.wait(4)



	MainEntity.Rebound.CFrame = workspace.CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value].RoomExit.CFrame



	for Room = game:GetService("ReplicatedStorage").GameData.LatestRoom.Value, 0, -1 do
        local MainRoom = workspace.CurrentRooms:FindFirstChild(tostring(Room))
    
        if MainRoom then
            local RoomEntrance = MainRoom:FindFirstChild("RoomEntrance")
    
            if RoomEntrance then
                local tween = game:GetService("TweenService"):Create(
                    MainEntity.Rebound,
                    TweenInfo.new(2),
                    {CFrame = RoomEntrance.CFrame + Vector3.new(0, 0.6, 0)}
                )
    
                tween:Play()
                tween.Completed:Wait()
    
                task.wait(2)
            end
        end
    end



	MainEntity:Destroy()

end,



function() -- Ripper

    local TweenService = game:GetService("TweenService")

    local Players = game:GetService("Players")

    local Lighting = game:GetService("Lighting")



    local EFFECT_TIME = 10

    local RED = Color3.fromRGB(255,0,0)



    local player = Players.LocalPlayer

    local currentRoomNumber = game.ReplicatedStorage.GameData.LatestRoom.Value

    local currentRoom = workspace.CurrentRooms:FindFirstChild(tostring(currentRoomNumber))



    if not currentRoom then

        return

    end



    local Sound = Instance.new("Sound")

    Sound.SoundId = "rbxassetid://6963538865"

    Sound.Volume = 10

    Sound.Parent = workspace

    Sound:Play()



    game:GetService("Debris"):AddItem(Sound, 15)



    local Character = player.Character



    if Character then

        local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")



        if Humanoid then

            Humanoid:TakeDamage(5)

        end

    end



    local OldAmbient = Lighting.Ambient

    local OldOutdoorAmbient = Lighting.OutdoorAmbient



    Lighting.Ambient = RED

    Lighting.OutdoorAmbient = RED



    local OriginalColors = {}



    for _, obj in ipairs(currentRoom:GetDescendants()) do

        if obj:IsA("BasePart") then

            OriginalColors[obj] = obj.Color



            obj.Color = RED



            local light = Instance.new("PointLight")

            light.Name = "RedFlashLight"

            light.Color = RED

            light.Range = 25

            light.Brightness = 0

            light.Shadows = true

            light.Parent = obj



            task.spawn(function()

                while light.Parent do

                    TweenService:Create(

                        light,

                        TweenInfo.new(0.4, Enum.EasingStyle.Sine),

                        {Brightness = 5}

                    ):Play()



                    task.wait(0.4)



                    if not light.Parent then

                        break

                    end



                    TweenService:Create(

                        light,

                        TweenInfo.new(0.4, Enum.EasingStyle.Sine),

                        {Brightness = 0}

                    ):Play()



                    task.wait(0.4)

                end

            end)

        end

    end



    task.wait(EFFECT_TIME)



    for Part, Color in pairs(OriginalColors) do

        if Part and Part.Parent then

            Part.Color = Color



            local Flash = Part:FindFirstChild("RedFlashLight")



            if Flash then

                Flash:Destroy()

            end

        end

    end



    Lighting.Ambient = OldAmbient

    Lighting.OutdoorAmbient = OldOutdoorAmbient

end,



function() -- OG A60

    local spawner = loadstring(game:HttpGet(

        "https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Entity%20Spawner/V2/Source.lua"

    ))()



    local entity = spawner.Create({

        Entity = {

            Name = "A-60",

            Asset = "https://github.com/Idk-lol2/a-60aa/blob/main/11379072534.rbxm?raw=true",

            HeightOffset = 0

        },

        Lights = {

            Flicker = {

                Enabled = true,

                Duration = 7

            },

            Shatter = true,

            Repair = false

        },

        Earthquake = {

            Enabled = false

        },

        CameraShake = {

            Enabled = true,

            Range = 100,

            Values = {3, 50, 1, 1}

        },

        Movement = {

            Speed = 135,

            Delay = 11,

            Reversed = false

        },

        Rebounding = {

            Enabled = true,

            Type = "Rush",

            Min = 2,

            Max = 4,

            Delay = 7

        },

        Damage = {

            Enabled = true,

            Range = 40,

            Amount = 125

        }

    })



    entity:Run()

end

}

local LiveCaption = loadstring(game:HttpGet('https://pastebin.com/raw/VJs4yXRm'))()

LiveCaption.Caption({

Text = "Hardcore Activated - made by Matex (@matex_xyz)";

Timer = 13;

})

math.randomseed(tick())

local function SpawnRandomEntity()
    local Pick = Entities[math.random(1,#Entities)]

    local Success, Err = pcall(Pick)

    if not Success then
        warn("Spawn failed:", Err)
    end
end

coroutine.wrap(function()
    while true do
        wait(math.random(20,40))
        SpawnRandomEntity()
    end
end)()
