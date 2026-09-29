<?
#function getHTMLDestinations(string $source_content, string $source_uri): array|bool
$source = parse_url($source_uri);
$dom = new DOMDocument();
libxml_use_internal_errors(true); // Credit: https://stackoverflow.com/a/9149241
$dom->loadHTML($source_content);
libxml_use_internal_errors(false);
$webmention_section = $dom->getElementById('webmentions');
if ($webmention_section instanceof DomElement) {
    $webmention_section->remove(); // do not include webmentions in the search
}

$xpath = new DOMXpath($dom);
$hrefs = iterator_to_array($xpath->query('//*[@href]'));
array_walk($hrefs, 'stripReference', array('dom'=>$dom, 'uri'=>$source, 'attr'=>'href'));
$srcs = iterator_to_array($xpath->query('//*[@src]'));
array_walk($srcs, 'stripReference', array('dom'=>$dom, 'uri'=>$source, 'attr'=>'src'));
$references = array_merge($hrefs, $srcs);
return $references;
?>
