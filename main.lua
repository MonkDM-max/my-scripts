local p,u,r,c,L=game.Players.LocalPlayer,game:GetService("UserInputService"),game:GetService("RunService"),workspace.CurrentCamera,game:GetService("Lighting")
local fly,bv,bg,speed,upH,dnH,noclip,fb,ws,save= false,nil,nil,50,false,false,false,false,16,nil
local g=Instance.new("ScreenGui",p:WaitForChild("PlayerGui"));g.Name="FlyGui";g.ResetOnSpawn=false
local m=Instance.new("Frame",g);m.Size=UDim2.fromOffset(230,320);m.Position=UDim2.new(0,15,.5,-160);m.BackgroundColor3=Color3.fromRGB(25,25,30);m.BorderSizePixel=0;m.Active=true
Instance.new("UICorner",m).CornerRadius=UDim.new(0,10);local s=Instance.new("UIStroke",m);s.Color=Color3.fromRGB(80,120,255);s.Thickness=1.5
local t=Instance.new("TextLabel",m);t.Size=UDim2.new(1,-30,0,30);t.BackgroundTransparency=1;t.Text="✈ FLY MENU";t.TextColor3=Color3.new(1,1,1);t.Font=Enum.Font.GothamBold;t.TextSize=15
local mn=Instance.new("TextButton",m);mn.Size=UDim2.fromOffset(24,24);mn.Position=UDim2.new(1,-28,0,3);mn.BackgroundColor3=Color3.fromRGB(60,60,75);mn.Text="−";mn.TextColor3=Color3.new(1,1,1);mn.Font=Enum.Font.GothamBold;mn.TextSize=16;Instance.new("UICorner",mn).CornerRadius=UDim.new(0,6)
local fb2=Instance.new("TextButton",m);fb2.Size=UDim2.new(1,-20,0,40);fb2.Position=UDim2.new(0,10,0,35);fb2.BackgroundColor3=Color3.fromRGB(50,180,90);fb2.Text="ВКЛЮЧИТЬ ПОЛЁТ";fb2.TextColor3=Color3.new(1,1,1);fb2.Font=Enum.Font.GothamBold;fb2.TextSize=14;Instance.new("UICorner",fb2).CornerRadius=UDim.new(0,8)
local sl=Instance.new("TextLabel",m);sl.Size=UDim2.new(1,-20,0,20);sl.Position=UDim2.new(0,10,0,85);sl.BackgroundTransparency=1;sl.Text="Скорость: 50";sl.TextColor3=Color3.fromRGB(200,200,200);sl.Font=Enum.Font.Gotham;sl.TextSize=13;sl.TextXAlignment=Enum.TextXAlignment.Left
local sb=Instance.new("Frame",m);sb.Size=UDim2.new(1,-20,0,12);sb.Position=UDim2.new(0,10,0,110);sb.BackgroundColor3=Color3.fromRGB(50,50,60);sb.BorderSizePixel=0;Instance.new("UICorner",sb).CornerRadius=UDim.new(0,6)
local sf=Instance.new("Frame",sb);sf.Size=UDim2.fromScale(.08,1);sf.BackgroundColor3=Color3.fromRGB(80,120,255);sf.BorderSizePixel=0;Instance.new("UICorner",sf).CornerRadius=UDim.new(0,6)
local sh=Instance.new("Frame",sb);sh.Size=UDim2.fromOffset(20,20);sh.Position=UDim2.new(.08,0,.5,0);sh.AnchorPoint=Vector2.new(.5,.5);sh.BackgroundColor3=Color3.new(1,1,1);Instance.new("UICorner",sh).CornerRadius=UDim.new(1,0)
local function mk(text,px,py)
local b=Instance.new("TextButton",m);b.Size=UDim2.new(.5,-15,0,32);b.Position=UDim2.new(px,py and 5 or 10,0,py or 135);b.BackgroundColor3=Color3.fromRGB(60,60,75);b.Text=text;b.TextColor3=Color3.new(1,1,1);b.Font=Enum.Font.Gotham;b.TextSize=12;Instance.new("UICorner",b).CornerRadius=UDim.new(0,6);return b end
local nc=mk("Noclip: OFF",0,135);local fbB=mk("☀ Ярко: OFF",.5,135);local sv=mk("💾 Сохранить",0,175);local ld=mk("↩ Вернуться",.5,175)
local wl=Instance.new("TextLabel",m);wl.Size=UDim2.new(1,-20,0,20);wl.Position=UDim2.new(0,10,0,215);wl.BackgroundTransparency=1;wl.Text="WalkSpeed: 16";wl.TextColor3=Color3.fromRGB(200,200,200);wl.Font=Enum.Font.Gotham;wl.TextSize=13;wl.TextXAlignment=Enum.TextXAlignment.Left
local wm=mk("− 10",0,240);wm.Size=UDim2.new(.5,-15,0,30);local wp=mk("+ 10",.5,240);wp.Size=UDim2.new(.5,-15,0,30)
local body={fb2,sl,sb,nc,fbB,sv,ld,wl,wm,wp}
local ub=Instance.new("TextButton",g);ub.Size=UDim2.fromOffset(70,70);ub.Position=UDim2.new(1,-90,.5,-80);ub.BackgroundColor3=Color3.fromRGB(80,120,255);ub.BackgroundTransparency=.15;ub.Text="▲";ub.TextColor3=Color3.new(1,1,1);ub.Font=Enum.Font.GothamBold;ub.TextSize=28;ub.Visible=false;Instance.new("UICorner",ub).CornerRadius=UDim.new(0,12)
local db=ub:Clone();db.Position=UDim2.new(1,-90,.5,0);db.Text="▼";db.Parent=g
local function hold(b,f) b.MouseButton1Down:Connect(function()f(true)end);b.MouseButton1Up:Connect(function()f(false)end);b.MouseLeave:Connect(function()f(false)end)end
hold(ub,function(v)upH=v end);hold(db,function(v)dnH=v end)
local sliding=false
local function upS(x)local rel=math.clamp((x-sb.AbsolutePosition.X)/sb.AbsoluteSize.X,0,1);speed=math.floor(10+rel*490);sf.Size=UDim2.fromScale(rel,1);sh.Position=UDim2.new(rel,0,.5,0);sl.Text="Скорость: "..speed end
sb.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=true;upS(i.Position.X)end end)
u.InputChanged:Connect(function(i)if sliding and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then upS(i.Position.X)end end)
u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then sliding=false end end)
local dr,ds,sp
t.InputBegan:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true;ds=i.Position;sp=m.Position end end)
u.InputChanged:Connect(function(i)if dr and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then local d=i.Position-ds;m.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)end end)
u.InputEnded:Connect(function(i)if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
local mini=false
mn.MouseButton1Click:Connect(function()mini=not mini;for _,v in ipairs(body)do v.Visible=not mini end;m.Size=mini and UDim2.fromOffset(230,32)or UDim2.fromOffset(230,320);mn.Text=mini and "+"or"−"end)
fb2.MouseButton1Click:Connect(function()fly=not fly;local hr=p.Character and p.Character:FindFirstChild("HumanoidRootPart");if fly and hr then bv=Instance.new("BodyVelocity",hr);bv.MaxForce=Vector3.new(9e9,9e9,9e9);bg=Instance.new("BodyGyro",hr);bg.MaxTorque=Vector3.new(9e9,9e9,9e9);bg.P=9e4;fb2.Text="ВЫКЛЮЧИТЬ ПОЛЁТ";fb2.BackgroundColor3=Color3.fromRGB(200,60,60);ub.Visible=true;db.Visible=true else if bv then bv:Destroy()bv=nil end;if bg then bg:Destroy()bg=nil end;ub.Visible=false;db.Visible=false;upH,dnH=false,false;fb2.Text="ВКЛЮЧИТЬ ПОЛЁТ";fb2.BackgroundColor3=Color3.fromRGB(50,180,90)end end)
nc.MouseButton1Click:Connect(function()noclip=not noclip;nc.Text="Noclip: "..(noclip and"ON"or"OFF");nc.BackgroundColor3=noclip and Color3.fromRGB(80,160,90)or Color3.fromRGB(60,60,75)end)
r.Stepped:Connect(function()if noclip and p.Character then for _,v in ipairs(p.Character:GetDescendants())do if v:IsA("BasePart")then v.CanCollide=false end end end end)
local oB,oA,oC
fbB.MouseButton1Click:Connect(function()fb=not fb;fbB.Text="☀ Ярко: "..(fb and"ON"or"OFF");fbB.BackgroundColor3=fb and Color3.fromRGB(80,160,90)or Color3.fromRGB(60,60,75);if fb then oB,oA,oC=L.Brightness,L.OutdoorAmbient,L.ClockTime;L.Brightness=3;L.OutdoorAmbient=Color3.new(1,1,1);L.ClockTime=12 else L.Brightness=oB or 2;L.OutdoorAmbient=oA or Color3.fromRGB(128,128,128);L.ClockTime=oC or 14 end end)
sv.MouseButton1Click:Connect(function()local hr=p.Character and p.Character:FindFirstChild("HumanoidRootPart");if hr then save=hr.CFrame;sv.Text="✓ Сохранено";task.delay(1.5,function()sv.Text="💾 Сохранить"end)end end)
ld.MouseButton1Click:Connect(function()if not save then return end;local hr=p.Character and p.Character:FindFirstChild("HumanoidRootPart");if hr then hr.CFrame=save end end)
local function aWS()local h=p.Character and p.Character:FindFirstChild("Humanoid");if h then h.WalkSpeed=ws end;wl.Text="WalkSpeed: "..ws end
wm.MouseButton1Click:Connect(function()ws=math.max(16,ws-10);aWS()end);wp.MouseButton1Click:Connect(function()ws=math.min(300,ws+10);aWS()end)
r.RenderStepped:Connect(function()if not fly or not bv then return end;local h=p.Character and p.Character:FindFirstChild("Humanoid");if not h then return end;local v=h.MoveDirection;if upH then v+=Vector3.yAxis end;if dnH then v-=Vector3.yAxis end;bv.Velocity=v*speed;bg.CFrame=c.CFrame end)