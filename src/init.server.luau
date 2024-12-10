local RunService = game:GetService("RunService")

local container = Instance.new("Part")
container.Name = "CameraLight"
container.Archivable = false
container.Anchored = true
container.Transparency = 1
container.AudioCanCollide = false
container.CanCollide = false
container.CastShadow = false

local light = Instance.new("PointLight")
light.Brightness = 3
light.Range = 60
light.Color = Color3.fromHSV(0, 0, 0.5)
light.Shadows = false
light.Enabled = false
light.Parent = container

local currentCamera = workspace.CurrentCamera
container.Parent = currentCamera

RunService:BindToRenderStep("LocateCameraLight", Enum.RenderPriority.Camera.Value - 1, function()
	container.CFrame = currentCamera.CFrame
end)

local toolbar = plugin:CreateToolbar("Camera Light")
local button = toolbar:CreateButton(
	"dekko-toggle-camera-light",
	"Toggle a light attached to the CurrentCamera",
	"",
	"Toggle Light"
)
button.ClickableWhenViewportHidden = true

local action = plugin:CreatePluginAction(
	"dekko-toggle-camera-light",
	"Toggle Light",
	"Toggle a light attached to the CurrentCamera",
	"",
	true
)

local function toggle()
	light.Enabled = not light.Enabled
	button:SetActive(light.Enabled)
end

button.Click:Connect(toggle)
action.Triggered:Connect(toggle)
