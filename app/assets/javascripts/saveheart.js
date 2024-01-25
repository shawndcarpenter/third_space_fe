$('.heart').on('click', function() {
  el = $(this);
  if (el.hasClass('liked') ) {
    el.removeClass('liked');
    return
  } else {
    el.addClass('liking');
    el.one('webkitAnimationEnd oanimationend msAnimationEnd animationend', function (e) {
      el.addClass('liked').removeClass('liking');
    });  
  }
});