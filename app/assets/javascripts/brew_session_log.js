function executeRefresh() {
    $( "#log_list" ).load( "/brew_session_logs/index_table", function(){
        setTimeout(executeRefresh, 5000);
    });
}