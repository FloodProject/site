<?php

require_once "Flood.php";

function delete_package_menu()
{
    menu_delete(Flood::PACKAGE_MENU_NAME);

    db_query("DELETE FROM {menu_links} WHERE menu_name = :menu_name", array(':menu_name' => Flood::PACKAGE_MENU_NAME));
}

function create_package_menu()
{
    $menu = array(
        'menu_name' => Flood::PACKAGE_MENU_NAME,
        'title' => 'Package Menu',
        'description' => 'Menu for accessing package site features.',
    );

    if (!menu_load($menu['menu_name']))
        menu_save($menu);

    $links = array();

    $links['Community'] = array(
        'link_title' => 'Community',
        'link_path' => 'package/%current_package/docs',
        'menu_name' => Flood::PACKAGE_MENU_NAME,
        'weight' => 0,
        'expanded' => 0,
    );

    $links['Contribute'] = array(
        'link_title' => 'Contribute',
        'link_path' => 'node',
        'menu_name' => Flood::PACKAGE_MENU_NAME,
        'weight' => 1,
        'expanded' => 0,
    );

    $links['Repository'] = array(
        'link_title' => 'Repository',
        'link_path' => 'node',
        'menu_name' => Flood::PACKAGE_MENU_NAME,
        'weight' => 0,
        'expanded' => 0,
    );

    links_save($links);

    $sublinks =  array();

    $sublinks['Forums'] = array(
        'link_title' => 'Forums',
        'link_path' => 'node',
        'menu_name' => Flood::PACKAGE_MENU_NAME,
        'plid' => $links['Community']['mlid'],
        'weight' => 0,
        'expanded' => 0,
    );

    links_save($sublinks);
}

function links_save(&$links)
{
    foreach($links as $key => $link){
        $links[$key]['mlid'] = menu_link_save($link);
    }
}

function current_package_load()
{
    return "pac1";
}