local fs = require("luarocks.fs")
local dir = require("luarocks.dir")

function move_without_overwrite(src, dest)
   local srcmode = lfs.attributes(src, "mode")

   if srcmode == "file" then
      if not fs.exists(dest) then
          local ok = fs.copy(src, dest)
          if not ok then return false end
      end
   elseif srcmode == "directory" then
      if not fs.exists(dest) then
        fs.make_dir(dest)
      end
      for file in lfs.dir(src) do
         if file ~= "." and file ~= ".." then
            local ok = move_without_overwrite(dir.path(src, file), dir.path(dest, file))
            if not ok then return false end
         end
      end
   end
   fs.delete(src)
   return true
end

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local lfs = require "lfs"

function dirtree(dir)
  assert(dir and dir ~= "", "directory parameter is missing or empty")
  if string.sub(dir, -1) == "/" then
    dir=string.sub(dir, 1, -2)
  end

  local function yieldtree(dir)
    for entry in lfs.dir(dir) do
      if entry ~= "." and entry ~= ".." then
        entry=dir.."/"..entry
  local attr=lfs.attributes(entry)
  coroutine.yield(entry,attr)
  if attr.mode == "directory" then
    yieldtree(entry)
  end
      end
    end
  end

  return coroutine.wrap(function() yieldtree(dir) end)
end

function string.split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
   table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function print(s,...)
  if not s then return end
  return io.write(s:format(...))
end

function println(s,...)
  if not s then io.write('\n'); return end
  return io.write(s:format(...) .. '\n')
end

local colors = require 'tools/ansicolors'

function info(s,...)
  print(colors("%{green}info: ") )
  println(s,...)
  return
end

function build(s,...)
  print(colors("%{green}build: ") )
  println(s,...)
  return
end

function error(s,...)
  print(colors("%{red}error: ") )
  println(s,...)
  return
end