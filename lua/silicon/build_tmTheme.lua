---Returns hex color of the value of the hig group
---@param hl_name string hig group name
---@param value? string foreground/background
---@return string hex value
local hl = function(hl_name, value)
	if value == "fg" then
		value = "foreground"
	end
	if value == "bg" then
		value = "background"
	end
        -- Default to foreground if no value is given
	value = value or "foreground"
	local hl = vim.api.nvim_get_hl_by_name(hl_name, true)
        -- If highlight doesn't exist, default to the value for "Normal"
	if not hl[value] then
		hl[value] = vim.api.nvim_get_hl_by_name("Normal", true)[value] or vim.api.nvim_get_hl_by_name("Cursorline", true)[value]
	end
	local color = string.format("#%06x", hl[value])
	return color
end

return function()
	return [[<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>name</key>
	<string>]] .. vim.g.colors_name .. [[</string>
	<key>settings</key>
	<array>
		<dict>
			<key>settings</key>
			<dict>
				<key>background</key>
				<string>]] .. hl("Normal", "bg") .. [[</string>
				<key>foreground</key>
				<string>]] .. hl("Normal", "fg") .. [[</string>
				<key>lineHighlight</key>
				<string>]] .. hl("NormalFloat", "bg") .. [[</string>
				<key>selection</key>
				<string>]] .. hl("Visual", "bg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Comment</string>
			<key>scope</key>
			<string>comment</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@comment", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>String</string>
			<key>scope</key>
			<string>string</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@string", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Number</string>
			<key>scope</key>
			<string>constant.numeric</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@number", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Built-in constant</string>
			<key>scope</key>
			<string>constant.language</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@constant.builtin", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>User-defined constant</string>
			<key>scope</key>
			<string>constant.character, constant.other</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@constant", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Variable</string>
			<key>scope</key>
			<string>variable</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@variable", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Keyword</string>
			<key>scope</key>
			<string>keyword</string>
			<key>settings</key>
			<dict>
				<key>foreground</key>
				<string>]] .. hl("@keyword", "fg") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Storage</string>
			<key>scope</key>
			<string>storage</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string></string>
				<key>foreground</key>
				<string>]] .. hl("StorageClass") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Storage type</string>
			<key>scope</key>
			<string>storage.type</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string>italic</string>
				<key>foreground</key>
				<string>]] .. hl("Type") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Function name</string>
			<key>scope</key>
			<string>entity.name.function</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string></string>
				<key>foreground</key>
				<string>]] .. hl("@function") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Function argument</string>
			<key>scope</key>
			<string>variable.parameter</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string>italic</string>
				<key>foreground</key>
				<string>]] .. hl("@parameter") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Tag name</string>
			<key>scope</key>
			<string>entity.name.tag</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string></string>
				<key>foreground</key>
				<string>]] .. hl("Tag") .. [[</string>
			</dict>
		</dict>
		<dict>
			<key>name</key>
			<string>Tag attribute</string>
			<key>scope</key>
			<string>entity.other.attribute-name</string>
			<key>settings</key>
			<dict>
				<key>fontStyle</key>
				<string></string>
				<key>foreground</key>
				<string>]] .. hl("Tag") .. [[</string>
			</dict>
		</dict>
	</array>
	<key>uuid</key>
	<string>D8D5E82E-3D5B-46B5-B38E-8C841C21347D</string>
	<key>colorSpaceName</key>
	<string>sRGB</string>
	<key>semanticClass</key>
	<string>theme.]] .. (vim.o.background or "dark") .. "." .. string.lower(vim.g.colors_name) .. [[</string>
</dict>
</plist>]]
end
