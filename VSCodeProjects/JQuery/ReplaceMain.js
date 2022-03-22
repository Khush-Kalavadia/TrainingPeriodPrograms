let ReplaceMain = {
  onClick: function () {
    var count = 0;
    $("#main")
      .on("click", "#mainButton", function () {
        count += 1;
        console.log(count);
        //   try out append, after, before to check the result
        $("#content").html(
          "<div id='innerContent'>This is inside innerContent div. Count=<br><input type='button' id='innerButton' value='new button'></div>"
        );
        $("#innerContent br").before(count);
      })
      .on("click", "#innerButton", function () {
        alert("done");
      });
  },
};
