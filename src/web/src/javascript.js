$(function() {

    function voteCount() {
        $.get("http://front-api-node:3000/vote/count", function(data) {
            console.log(data);
            $("#total").html(data.total)
            $("#yesCount").html(data.yes)
            $("#noCount").html(data.no)
            $("#maybeCount").html(data.maybe)
        });
    }

    function listTable() {
        $.get("http://front-api-node:3000/vote/list", function(data) {
            var tbl_body = "";
            var odd_even = false;
            $.each(data, function(data) {
                var tbl_row = "";
                $.each(this, function(k , v) {
                    tbl_row += "<td>"+v+"</td>";
                });
                tbl_body += "<tr scope=\"row\">"+tbl_row+"</tr>";
                odd_even = !odd_even;               
            });
            $("#tableVotes tbody").html(tbl_body);
        });
    }

    function refreshData() {
        listTable();
        voteCount();
    }

    function sendVote(vote) {
        $.post("http://front-api-node:3000/vote/create", { "vote" : vote }, function(data) {
            console.log(data);
            refreshData();
        });
    }

    refreshData();

    $("#buttonYes").click(function() { sendVote("Yes"); });
    $("#buttonNo").click(function() { sendVote("No"); });
    $("#buttonMaybe").click(function() { sendVote("Maybe"); });
    
    $("#buttonRemove").click(function() {
        $.post("http://front-api-node:3000/vote/remove", function(data) {
            console.log(data)
            refreshData()
        });
    });
});