<?php

$add_link = url('node/add/blog');
$user = $GLOBALS['user'];

$module = active_module();
if($module){
    $gid = $module->gid;
    $user_can_add = og_user_access_entity('create blog content', 'node', $module, $user);
    $add_link .= '?modid=' . $module->nid;
} else {
    $gid = false;
    $user_can_add = user_access('create blog content', $user);
}

if($user_can_add){
?>
    <a href="<?php print $add_link ?>" class="btn btn-xs btn-success">
        <i class="icon glyphicon glyphicon-plus" aria-hidden="true"></i>
        Add News
    </a>
<?php
}

$nids = modstir_get_nids('blog', $gid);

print modstir_render_nids($nids);