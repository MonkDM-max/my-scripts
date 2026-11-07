local url = "https://raw.githubusercontent.com/MonkDM-max/my-scripts/main/main.lua"
local ok, code = pcall(function() return game:HttpGet(url) end)
if not ok then warn("Не удалось загрузить скрипт") return end
local fn, err = loadstring(code)
if not fn then warn("Ошибка: " .. tostring(err)) return end
fn()