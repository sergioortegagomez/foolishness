<?php
header("Content-Type: application/json; charset=UTF-8");
error_log("/votelist.php");

try {
    $mongodb = new Mongo("mongodb://mongodb:27017");
    $votesCollection = $mongodb->foolishness->votes;

    if ($votesCollection->count() == 0) {
        echo "{}";
    } else {
        $result = array();
        $cursor = $votesCollection->find()->limit(10);
        foreach ($cursor as $doc) {
            $result[] = array(
                'id' => $doc['_id']->{'$id'},
                'vote' => $doc['vote'],
                'createdat' => date('d-m-Y H:i:s', $doc['createdat']->sec)
            );
        }
        echo json_encode($result);
    }

    $mongodb->close();
} catch (\Exception $e) {
    error_log($e->getMessage());
}