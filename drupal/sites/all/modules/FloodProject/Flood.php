<?php

class FloodContentType
{
    const Forum = 0;
    const QA = 1;
    const Issues = 2;
    const Blog = 3;

    static function get_allowed_values()
    {
        $array = array();

        $refl = new ReflectionClass('FloodContentType');
        $consts = $refl->getConstants();

        foreach ($consts as $name => $id)
            $array[$id] = $name;

        return $array;
    }

    /*
     * Checks if a package node has an associated content type.
     */
    static function has_content_type($node, $content_type)
    {
        if($node->type != Flood::PACKAGE_NODE_TYPE)
            return false;

        if(empty($node->{Flood::CONTENT_TYPE_FIELD}))
            return false;

        return in_array($content_type ,$node->{Flood::CONTENT_TYPE_FIELD}['und'][0]);
    }
}

class Flood
{
    const PACKAGE_NODE_TYPE = "flood_package";
    const MODULE_NAME = "FloodProject";
    const CONTENT_TYPE_FIELD = "content_types";
    const PACKAGE_MENU_NAME = "menu_package";
}

