/*!
 * Start Bootstrap - Grayscale Bootstrap Theme (http://startbootstrap.com)
 * Code licensed under the Apache License v2.0.
 * For details, see http://www.apache.org/licenses/LICENSE-2.0.
 */

// jQuery to collapse the navbar on scroll
function collapseNavbar() {
    if ($(".navbar").offset().top > 50) {
        $(".navbar-fixed-top").addClass("top-nav-collapse");
    } else {
        $(".navbar-fixed-top").removeClass("top-nav-collapse");
    }
}

$(window).scroll(collapseNavbar);
$(document).ready(collapseNavbar);

// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('a.page-scroll').bind('click', function(event) {
        var $anchor = $(this);
        $('html, body').stop().animate({
            scrollTop: $($anchor.attr('href')).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });

    handleVideoPlayback();
});

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    if ($(this).attr('class') != 'dropdown-toggle active' && $(this).attr('class') != 'dropdown-toggle') {
        $('.navbar-toggle:visible').click();
    }
});

function mailinglistSignup() {
    new Firebase('https://augur.firebaseio.com').child('mailing-list').push().set({
        handle: $('#email-address').val(),
        timestamp: new Date().getTime()
    }).then(function () {
        $('#signed-up').html('<p>Thanks for signing up!</p>');
    });
}

$('#mailinglist-signup').click(mailinglistSignup);

$('#mailinglist-form').submit(function (event) {
    event.preventDefault();
    mailinglistSignup();
});

/**
 * Takes care of stopping video when modal is closed. This restarts the video every time modal is shown
 *
 * Based on http://www.tutorialrepublic.com/faq/how-to-embed-youtube-video-inside-bootstrap-modal.php
 */
function handleVideoPlayback() {
    var $modal = $("#video-modal");
    var $videoIframe = $modal.find("iframe");
    var originalUrl = $videoIframe.attr('src');

    $modal.on('hide.bs.modal', function() {
        $videoIframe.attr('src', '');
    });

    $modal.on('show.bs.modal', function() {
        $videoIframe.attr('src', originalUrl);
    });
}