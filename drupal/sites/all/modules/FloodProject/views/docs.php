<?php

$docs_dir = "C:\\docs";

if(isset($_REQUEST['d']))
{
    $doc_file = realpath ($docs_dir . DIRECTORY_SEPARATOR . $_REQUEST['d']);
    if(starts_with($doc_file, $docs_dir))
    {
        include $doc_file;
        goto end;
    }
}

print "No docs found.";

end:
