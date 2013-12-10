

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