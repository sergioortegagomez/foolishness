<?php
header("Content-Type: application/json; charset=UTF-8");
error_log("/randomnumberslist.php");

try {
    $mongodb = new Mongo("mongodb://mongodb:27017");
    $randomNumbersCollection = $mongodb->foolishness->randomNumbers;

    if ($randomNumbersCollection->count() == 0) {
        echo "{}";
    } else {
        $result=array();
        foreach ($randomNumbersCollection->find() as $doc) {
            $result[] = array(
                'id' => $doc['_id']->{'$id'},
                'number' => $doc['number'],
                'createdat' => date('d-m-Y H:i:s', $doc['createdat']->sec)
            );
        }
        echo json_encode($result);
    }

    $mongodb->close();
} catch (\Exception $e) {
    error_log($e->getMessage());
}