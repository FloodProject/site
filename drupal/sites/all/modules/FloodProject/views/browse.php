<?php

$nids = modstir_get_nids(Flood::PACKAGE_NODE_TYPE);

print modstir_render_nids($nids);