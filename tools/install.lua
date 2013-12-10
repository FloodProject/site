
require "./tools/helpers";

tmp_dir = "drupal_tmp";
out_dir = "drupal";

db_user = "root";
db_pswd = "root";
db_name = "drupal";
db_link = db_user .. ":" .. db_pswd .. "@localhost/".. db_name;

site_name = "Flood";

os.execute("drush dl drupal --drupal-project-rename=" .. tmp_dir);

move_without_overwrite(tmp_dir, out_dir);

--os.execute("cd " .. out_dir .. "; drush site-install standard --db-url=mysql://" .. db_link .. "--site-name=" .. site_name);