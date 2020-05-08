<?php
header("Content-Type: application/json; charset=UTF-8");

try {
    $mongodb = new Mongo("mongodb://mongodb:27017");
    $votesCollection = $mongodb->foolishness->votes;

    $result=array(
        "total" => 0,
        "yes" => 0,
        "no" => 0,
        "maybe" => 0
    );

    if ($votesCollection->count() > 0) {
        $yesCount = $votesCollection->find(["vote" => "Yes"])->count();
        $noCount = $votesCollection->find(["vote" => "No"])->count();
        $maybeCount = $votesCollection->find(["vote" => "Maybe"])->count();

        $result=array(
            "total" => $yesCount + $noCount + $maybeCount,
            "yes" => $yesCount,
            "no" => $noCount,
            "maybe" => $maybeCount
        );        
    }

    echo json_encode($result);

    $mongodb->close();
} catch (\Exception $e) {
    error_log($e->getMessage());
}