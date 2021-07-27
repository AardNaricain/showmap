lfs = require('lfs')
json = require('json')

local table_file = io.open(lfs.currentdir() .. "\\8-Boot-Maps-2021-07-20.json", "r")
local table_maps = json.decode(table_file:read("*all"))
table_file:close()

local page_file = io.open(lfs.currentdir() .. "\\good_export.json", "r")
local page_maps = json.decode(page_file:read("*all"))
page_file:close()

local arids_found = {}
local only_map_data = {}
for i, area_array in ipairs(table_maps.data) do
	if area_array[1] ~= "Area" then
		local arid = area_array[4]
		arids_found[arid] = true
		if not page_maps[arid] then
			print("Couldn't find area '" .. arid .. "' in page data")
		else
			area_array[1] = page_maps[arid].details:gsub('\\n', "\n")
			area_array[2] = page_maps[arid].maps
		end
		table.insert(only_map_data, area_array)
	end
end

local import_file = io.open(lfs.currentdir() .. "\\import.json", "w")
import_file:write(json.encode(table_maps))
import_file:close()

local raw_json_file = io.open(lfs.currentdir() .. "\\maps_json.json", "w")
raw_json_file:write(json.encode(only_map_data))
raw_json_file:close()
