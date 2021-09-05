$(function() {

    function bookCount() {
        $.get("http://localhost/api/book/count", function(data) {
            console.log(data);
            $("#total").html(data.total)
        });
    }

    function listTable() {
        $.get("http://localhost/api/book/list", function(data) {
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
            $("#BookTable tbody").html(tbl_body);
        });
    }

    function refreshData() {
        listScreen();
        listTable();
        bookCount();        
    }
    
    refreshData();

    function listScreen() {
        $('#headerText').text("Book List!")
        $('#addForm').hide() 
        $('#BookTable').show()
        $('#buttonsRow').show("slow")
        $('#statsRow').show("slow")
    }

    function addScreen() {
        $('#headerText').text("Add Book!")
        $('#BookTable').hide()
        $('#buttonsRow').hide()
        $('#statsRow').hide()
        $('#addForm').show("slow")
    }

    $("#addBookButton").click(function() {
        addScreen()
    });
    
    $("#cancelButton").click(function() {
        listScreen()   
    });
    
    $('#submitButton').click(function() {
        $.ajax({
            type : "POST",
            url : "http://localhost/api/book/create",
            dataType: 'json',
            data: JSON.stringify({
                "title" : $('#titleBook').val(),
                "isbn" : $('#isbnBook').val(),
                "pages" : $('#pagesBook').val(),
                "author" : $('#authorBook').val()
            }),
            headers: {
                'Content-Type':'application/json'
            },
            success: function(data) {
                console.log(data);
                refreshData();
            }
        });
    });

    $("#buttonRemove").click(function() {
        $.ajax({
            type: "DELETE",
            url: "http://localhost/api/book/drop",
            success: function(data) {
                console.log(data)
                refreshData()
            }
          });
    });
});