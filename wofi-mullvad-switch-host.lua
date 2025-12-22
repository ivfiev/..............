local function log(msg)
	os.execute(string.format("logger -t %s '%s'", arg[0], msg))
end

local function run(cmd)
	local pipe = io.popen(cmd, "r")
	if not pipe then
		io.write(string.format("could not execute [%s]", cmd))
		os.exit(1)
	end
	local output = pipe:read("*a")
	local ok, why, code = pipe:close()
	if ok and code == 0 then
		return output
	else
		local msg = string.format("cmd failed with code [%s]", code)
		print(msg)
		log(msg)
		os.exit(code)
	end
end

local by_lines = "[^\n\r]+"
local by_words = "%S+"
local function split(text, regex)
	local list = {}
	for str in text:gmatch(regex) do
		table.insert(list, str)
	end
	return list
end

local status = split(run("mullvad status"), by_words)

local prompt = "Disconnected from VPN!"
if status[1] == "Connected" then
	prompt = string.format("%s - %s, %s %s", status[1], status[3], status[#status - 1], status[#status])
end

local relays = run("mullvad relay list")
local lines = split(relays, by_lines)
local country, city, code = "", "", ""
local wofi = ""

for _, line in ipairs(lines) do
	if not line or line == "" then
		country, city, code = "", "", ""
	elseif not line:match("^\t") then
		country = split(line, by_words)[1]:gsub("%s+", "")
		-- print(line .. ":" .. country)
	elseif line:match("^\t\t") and line:find("-wg-") then
		code = split(line, by_words)[1]:gsub("%s+", "")
		wofi = wofi .. string.format("%s, %s, %s\n", country, city, code)
		-- print(line .. ":" .. code)
	elseif line:match("^\t") then
		city = split(line, "[^%(]+")[1]:gsub("%s+", "")
		-- print(line .. ":" .. city)
	end
end

local file = io.open("/tmp/wofi_mullvad.txt", "w")
if not file then
	log("could not open wofi_mullvad.txt")
	os.exit(1)
end
file:write(wofi)
file:close()

local choice = run(string.format("wofi --show dmenu --prompt '%s' -i -M fuzzy < /tmp/wofi_mullvad.txt", prompt))
local relay = split(choice, by_words)
relay = relay[#relay]

if relay:match("^[0-9a-z%-]+$") and #relay <= 15 then
	if prompt:find("Disconnected") then
		run("mullvad connect")
	end
	log("setting location to " .. relay)
	run("mullvad relay set location " .. relay)
	log("success")
else
	print("invalid relay!")
	log("invalid relay!")
	os.exit(1)
end
