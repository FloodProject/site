
System Requirements:

    -Git
		https://code.google.com/p/msysgit
    -Lua
		https://code.google.com/p/luaforwindows/
	-Drush
		http://drush.ws/drush_windows_installer
    -Mysql
    -Php
    

wamp:
    Add to Environment Variable PATH wamp\bin\mysql\mysql5.6.12\bin
	Add and alias to apache:
	
		Alias /flood "C:/Dev/flood-site/drupal/"
		<Directory "C:/Dev/flood-site/drupal/">
			Options +Indexes +FollowSymLinks +MultiViews
			AllowOverride all
			Order Deny,Allow
			Deny from all
			Allow from 127.0.0.1
			Allow from ::1
			Allow from localhost
		</Directory>
	
	Edit httpd.conf
		LoadModule rewrite_module modules/mod_rewrite.so
		
	Edit drupal/.htaccess
		RewriteBase /flood

Installation:

    -Configure tool/install.lua with your database connection.
    -Run tools.bat option install.
	- Configure Module jQuery Update do use jQuery 1.8
	
Install PHPStorm

File->Settings->Php
    In Interperter click on button "..." 
    Set the php directory.
File->Settings->Php->Debug
	Set XDebug port 9000
	Uncheck "Force break at first line when no path mapping specified."
	Uncheck "Force break at first line when a script is outside the project."
	
When debugging don't use path mapping to index.php.

Locate the [XDebug] section in the php.ini file and update it as follows:

[XDebug]
zend_extension="<path to php_xdebug.dll>"
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.profiler_enable=1
xdebug.profiler_output_dir="<AMP home\tmp>"