$(function() {
    function listTable() {
        $.get("http://localhost:3000/randomnumbers/list", function(data) {
            var tbl_body = "";
            var odd_even = false;
            $.each(data, function(data) {
                var tbl_row = "";
                $.each(this, function(k , v) {
                    tbl_row += "<td>"+v+"</td>";
                });
                tbl_body += "<tr class=\""+( odd_even ? "odd" : "even")+"\">"+tbl_row+"</tr>";
                odd_even = !odd_even;               
            });
            $("#tableNumbers tbody").html(tbl_body);
        });
    }

    $("#buttonList").click(function() { listTable() });
    $("#buttonCreate").click(function() {
        $.post("http://localhost:3000/randomnumbers/create", function(data) {
            console.log(data)
            alert(data);
        });
    });
    $("#buttonRemove").click(function() {
        $.post("http://localhost:3000/randomnumbers/remove", function(data) {
            console.log(data)
            listTable()
        });
    });
});