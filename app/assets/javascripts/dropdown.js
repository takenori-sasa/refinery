if ($(window).width() > 992) {
  // ウィンドウ大きいとホバーする
  $(".navbar .dropdown").hover(
    function () {
      $(this)
        .find(".dropdown-menu")
        .first()
        .stop(true, true)
        .delay(250)
        .slideDown();
    },
    function () {
      $(this)
        .find(".dropdown-menu")
        .first()
        .stop(true, true)
        .delay(100)
        .slideUp();
    }
  );

  $(".navbar .dropdown > a").click(function () {
    location.href = this.href;
  });
} else {
  // スマホやタブレットだと二度押しで親リンク踏める
  $(".navbar .dropdown > a").click(function () {
    if (!$(this).hasClass("parent-clicked")) {
      $(this).addClass("parent-clicked");
    } else {
      location.href = this.href;
    }
  });
}
