require "tools/helpers";

local commands = {
	"./tools/install"
}

print("Tools: \n")

-- List the commands and wait for choice
for i,v in ipairs(commands) do
	println("[%s] %s", i-1, v)
end

println()
print("Choice: ")

