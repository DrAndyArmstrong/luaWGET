--[[

luaWGET example

requires luaCURL http://luaforge.net/projects/luacurl/

takes a URL as a paramerter and an optional flag to return the data as a table rather than a string

]]

require('curl')

function wget(url, asTable)
	local text = {}

	local function processData(s)
		text[#text+1] = s
		return string.len(s)
	end

	local c = curl.easy_init()
	c:setopt(curl.OPT_URL, url)
	c:setopt(curl.OPT_WRITEFUNCTION, processData)
	c:setopt(curl.OPT_USERAGENT, "luacurl-agent/1.0")
	c:perform()

	if asTable then
		return text
	end
	
	return table.concat(text,'')
end

local data = wget("www.google.com", true)
for i,v in pairs(data) do
	print(i,v)
end

local data = wget("www.google.com")
print(data)
