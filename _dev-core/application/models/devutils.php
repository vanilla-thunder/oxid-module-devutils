<?php
class devutils extends oxSuperCfg
{
    public function success($content, $time = false)
    {
        header('Content-Type: application/json; charset=UTF-8');
        if ($time) header('Last-Modified: '.date('r',$time));
        echo json_encode($content);
        exit;
    }
    
    public function error($content)
    {
        header('HTTP/1.1 500 It didnt work... ');
        header('Content-Type: application/json; charset=UTF-8');
        die(json_encode(array('error' => $content)));
    }
    
}