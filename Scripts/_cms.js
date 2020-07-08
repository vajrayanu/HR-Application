$(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();

    $(window).scroll(function () {
        if ($(this).scrollTop() > 50) {
            $('#back-to-top').fadeIn();
        } else {
            $('#back-to-top').fadeOut();
        }
    });
    // scroll body to 0px on click
    $('#back-to-top').click(function () {
        $('body,html').animate({
            scrollTop: 0
        }, 300);
        return false;
    });

    $('.nav-list-desktop').on('click', function (e) {
        $('.side-nav').toggleClass("open");
        $('#wrapper').toggleClass("open");
        e.preventDefault();
    });
});

function openForm() {
    $("#form_Announce").show();
}

function hideForm() {
    $("#form_Announce").hide();
    $('body,html').animate({
        scrollTop: 0
    }, 300);
    return false;
}