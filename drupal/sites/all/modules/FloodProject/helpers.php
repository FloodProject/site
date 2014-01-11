<?php

function modstir_get_nids($node_type, $gid = "all", $pagesize = 5)
{
    $query = db_select('node', 'n')
        ->fields('n', array('nid'))
        ->condition('n.type', $node_type);

    if($gid != "all")
    {
        if(empty($gid)) {
            //Exclude module news
            $query = $query->notExists(
                db_select('og_membership', 'm')
                    ->fields('m', array('etid'))
                    ->where('m.etid = n.nid')
            );
        } else {
            $query = $query->exists(
                db_select('og_membership', 'm')
                    ->fields('m', array('etid'))
                    ->where('m.gid = '. $gid)
                    ->where('m.etid = n.nid')
            );
        }
    }
    $query = $query->extend('PagerDefault')->limit($pagesize);

    return $query->execute()->fetchCol();
}

function modstir_render_nids($nids)
{
    $nodes = node_view_multiple(node_load_multiple($nids));
    $content = array('#markup' => drupal_render($nodes));
    $pager = array(
        '#theme' => 'pager',
        '#weight' => 5,
    );

    return  drupal_render($content) . drupal_render($pager);
}

function starts_with($haystack, $needle)
{
    return $needle === "" || strpos($haystack, $needle) === 0;
}
function ends_with($haystack, $needle)
{
    return $needle === "" || substr($haystack, -strlen($needle)) === $needle;
}
