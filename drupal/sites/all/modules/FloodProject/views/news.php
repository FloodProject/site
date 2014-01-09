<?php

$gid = false;
if(active_module())
    $gid = active_module()->gid;

if(true){
?>
    <a href="" class="btn btn-xs btn-success">
        <i class="icon glyphicon glyphicon-plus" aria-hidden="true"></i>
        Add News
    </a>
<?php
}

$nids = modstir_get_nids('blog', $gid);

print modstir_render_nids($nids);