
db_user = "root";
db_pswd = "";
db_name = "drupal8";

site_name = "Flood";
site_user = "admin";
site_pswd = "admin";

theme_name = "bootstrap";

--List of modules to download and enable
dl_modules = { 
	"admin_menu",
	"devel",
	"jquery_update",
};

--List of modules to enable
en_modules = {
    "FloodProject"
};

tmp_dir = "drupal_tmp";
out_dir = "drupal";

require "./tools/helpers";
require("luarocks.fs")

--Remove untracked files
os.execute("git clean -fxd");

--Download drupal to temporary folder
os.execute("drush dl drupal --drupal-project-rename=" .. tmp_dir);

--Move temporary folder without overwriting existing files
move_without_overwrite(tmp_dir, out_dir);

--Change current directory
lfs.chdir (out_dir);

--Install drupal
db_link = db_user
if not db_pswd == "" then 
    db_link = db_link .. ":" ..db_user;
end
db_link = db_link .. "@localhost/" .. db_name;

ret = os.execute("drush site-install minimal -y --db-url=mysql://" .. db_link .. " --site-name=" .. site_name .. " --account-name=" .. site_user .. " --account-pass=" .. site_pswd);
if ret ~= 0 then
    print("Could not install drupal. Check database configuration.");
    os.exit(-1)
end

--Download modules
for _, module in ipairs(dl_modules) do
  os.execute("drush dl ".. module);
end

--Enable Modules
for _, module in ipairs(dl_modules) do
  os.execute("drush en -y ".. module);
end

for _, module in ipairs(en_modules) do
  os.execute("drush en -y ".. module);
end

--Enable theme
os.execute("drush vset theme_default " .. theme_name);