UserVoice = window.UserVoice || [];
(function() {
  var uv = document.createElement('script');
  uv.type = 'text/javascript';
  uv.async = true;
  uv.src = 'https://widget.uservoice.com/CDL6e6K1fQciGvhFmwEUg.js';
  var s = document.getElementsByTagName('script')[0];
  s.parentNode.insertBefore(uv, s)
})();

UserVoice.push(['identify', {
  email: 'team@augur.net',
  name: 'Augur Team'
}]);

UserVoice.push(['set', {
  accent_color: '#448dd6',
  height: '325px',
  width: '100%',
  strings: {
    post_suggestion_title: 'Have an idea for Augur?',
    post_suggestion_body: 'Submit your thoughts to have the community join in!',
    post_suggestion_message_placeholder: 'Functionality improvements, new feature requests, etc.',
    contact_menu_label: 'Want to send the team a message?', 
    contact_message_placeholder: 'Need help, have a question, or need to contact the team? Let us know here.'
  }
}]);

UserVoice.push(['addTrigger', {
  mode: 'smartvote',
  trigger_color: 'white',
  trigger_background_color: '#448dd6',
  trigger_position: 'bottom-right',
  trigger_style: 'icon'
}]);

UserVoice.push(['autoprompt', {}]);