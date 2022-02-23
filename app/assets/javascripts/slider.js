$(function () {
  $(".slider").slick({
    autoplay: true,
    dots: true,
    slidesToScroll: 3,
    slidesToShow: 3,
    responsive: [
      {
        breakpoint: 768,
        settings: {
          slidesToShow: 1,
          slidesToScroll: 1,
        },
      },
    ],
  });
  $(".jumbotron-carousel").slick({
    autoplay: true,
    fade: true,
    arrows: false,
    dots: false,
    slidesToScroll: 1,
    slidesToShow: 1,
  });
});
