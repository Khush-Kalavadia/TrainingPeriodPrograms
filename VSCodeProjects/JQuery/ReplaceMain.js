let ReplaceMain = {
  onClick: function () {
    var count = 0;
    $("#main").on("click", "#mainButton", function () {
      console.log("yes");

      // see what happens in console when you continuously click on the button
      function sleep(seconds) {
        var e = new Date().getTime() + seconds * 1000;
        while (new Date().getTime() <= e) {}
      }
      sleep(5);

      //   try out append, after, before to check the result
      $("#content").html(
        "<div id='innerContent'>This is inside innerContent div.</div>"
      );
    });
  },
};
