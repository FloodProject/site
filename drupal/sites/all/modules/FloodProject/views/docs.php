   <?php

$docs_dir = "C:/Development/flood2/build/vs2012/docs";
$docs_file = isset($_REQUEST['d']) ? $_REQUEST['d'] : "index.html";

$doc_file = realpath ($docs_dir . DIRECTORY_SEPARATOR . $docs_file);
if(starts_with($doc_file, realpath($docs_dir)))
{
    include $doc_file;
}
else
{
    print "No docs found.";
}