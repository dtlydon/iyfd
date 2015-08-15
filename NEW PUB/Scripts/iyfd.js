$(document).ready(function(){
    $('.advanced-checkbox').each(function(){
        var c = $(this).children('input');
        if (c.prop('checked') == true) {
            $(this).removeClass('empty');
            $(this).addClass('checked');
            if ($(this).hasClass('winner')) {
                $(this).removeClass('empty');
                $(this).removeClass('checked');
                $(this).addClass('correct');
            }
            if ($(this).hasClass('loser')) {
                $(this).addClass('incorrect');
                $(this).removeClass('empty');
                $(this).removeClass('checked');
            }
        }
        else {
            $(this).addClass('empty');
            $(this).removeClass('checked');
        }
        c.hide();
    });
    $('.advanced-checkbox').on('click', function () {
        if (!$(this).hasClass('winner') && !$(this).hasClass('loser')) {
            var c = $(this).children('input');
            $(this).toggleClass('empty');
            $(this).toggleClass('checked');
            if (c.prop('checked')) {
                c.prop('checked', false);
            }
            else {
                c.prop('checked', true);
            }

            $(this).siblings('.advanced-checkbox').children('input').prop('checked', false);
            $(this).siblings('.advanced-checkbox').removeClass('checked');
            $(this).siblings('.advanced-checkbox').addClass('empty');
        }
    });
    $('.disabled-checkbox').each(function () {
        var c = $(this).children('input');
        if (c.prop('checked') == true) {
            $(this).removeClass('empty');
            $(this).addClass('checked');
            if ($(this).hasClass('winner')) {
                $(this).removeClass('empty');
                $(this).removeClass('checked');
                $(this).addClass('correct');
            }
            if ($(this).hasClass('loser')) {
                $(this).addClass('incorrect');
                $(this).removeClass('empty');
                $(this).removeClass('checked');
            }
        }
        else {
            $(this).addClass('empty');
            $(this).removeClass('checked');
        }
        c.hide();
    });
});