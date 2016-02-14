# require "tools/helpers"
#local colors = require 'tools/ansicolors'

-- Test that Docker is available
function checkDocker()
	return os.capture("docker")
end

--[[
if not checkDocker() then
	error("Docker executable was not found in PATH")
	return
end]]--

-- Gather all the containers
function getContainers()
	local containers = {}
	for file, attr in dirtree("containers") do
		if string.find(file, "Dockerfile") then
			table.insert(containers, file)
		end
	end
	return containers
end

-- Invoke Docker build for each container
function buildContainers()
	local containers = getContainers()
	for i, c in ipairs(containers) do
		local parts = string.split(c, '/')

		local name = parts[#parts-1]
		build(name)

		parts[#parts] = nil
		local path = table.concat(parts, '/')
		local version = "0"
		local tag = string.format("%s-%s", name, version)

		local cmd = string.format("sudo docker build -t %s %s", tag, path)
		println(cmd)

		if not os.capture(cmd) then
			return false
		end

		println()
	end

	return true
end

if not buildContainers() then
	error("could not build the container, aborting...")
	return
end



