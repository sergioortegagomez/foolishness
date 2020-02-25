$(function() {

    function voteCount() {
        $.get("http://web/api/vote/count", function(data) {
            console.log(data);
            $("#total").html(data.total)
            $("#yesCount").html(data.yes)
            $("#noCount").html(data.no)
            $("#maybeCount").html(data.maybe)
        });
    }

    function listTable() {
        $.get("http://web/api/vote/list", function(data) {
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
        $.post("http://web/api/vote/create", { "vote" : vote }, function(data) {
            console.log(data);
            refreshData();
        });
    }

    refreshData();

    $("#buttonYes").click(function() { sendVote("Yes"); });
    $("#buttonNo").click(function() { sendVote("No"); });
    $("#buttonMaybe").click(function() { sendVote("Maybe"); });
    
    $("#buttonRemove").click(function() {
        $.post("http://web/api/vote/remove", function(data) {
            console.log(data)
            refreshData()
        });
    });
});