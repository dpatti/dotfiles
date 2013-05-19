$('#user_id').val(localStorage.getItem('username'));
$('#password').val(localStorage.getItem('password'));
$('[name=login]').click();
$('#tree').css('min-height', 300);
